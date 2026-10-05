import 'dart:async';
import 'dart:io';

import 'package:serverpod/serverpod.dart';

import '../generated/future_calls.dart';
import '../generated/protocol.dart';
import 'jev_service.dart';
import 'shift_close_future_call.dart';
import 'tenant_context.dart';

/// Spine till endpoints: createDeposit · assignNight · listToday ·
/// syncOfflineDeposits · recommendRoom · judgeShift · scheduleShiftClose.
class TillEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  static final _phonePattern = RegExp(
    r'^\+233\s?\d{2}\s?\d{3}\s?\d{4}$|^\+233\d{9}$|^0\d{9}$',
  );

  /// Take deposit, lock the room night, append audit, broadcast today's tally.
  Future<Deposit> createDeposit(
    Session session, {
    required String guestName,
    required String guestPhone,
    required String roomNumber,
    required int nights,
    required double amount,
    required CurrencyCode currency,
    required PaymentMethod method,
  }) async {
    final tenant = await requireTenant(session);
    return _createDepositForTenant(
      session,
      tenant: tenant,
      guestName: guestName,
      guestPhone: guestPhone,
      roomNumber: roomNumber,
      nights: nights,
      amount: amount,
      currency: currency,
      method: method,
      clientMutationId: null,
      capturedAt: null,
    );
  }

  /// Replay offline desk deposits with idempotent [clientMutationId]s.
  Future<SyncOfflineResult> syncOfflineDeposits(
    Session session, {
    required List<OfflineDepositPayload> payloads,
  }) async {
    final tenant = await requireTenant(session);
    if (payloads.isEmpty) {
      final tally = await _buildTodayTally(session, tenant.organizationId);
      return SyncOfflineResult(
        accepted: [],
        skippedMutationIds: [],
        tally: tally,
      );
    }
    if (payloads.length > 40) {
      throw TillException(
        message: 'Sync at most 40 offline deposits per batch.',
        code: 'sync_batch_too_large',
      );
    }

    final accepted = <Deposit>[];
    final skipped = <String>[];

    for (final payload in payloads) {
      final mutationId = payload.clientMutationId.trim();
      if (mutationId.isEmpty || mutationId.length > 120) {
        throw TillException(
          message: 'Each offline deposit needs a clientMutationId (1–120 chars).',
          code: 'invalid_mutation_id',
        );
      }

      final existing = await SyncedMutation.db.findFirstRow(
        session,
        where: (t) =>
            t.organizationId.equals(tenant.organizationId) &
            t.clientMutationId.equals(mutationId),
      );
      if (existing != null) {
        skipped.add(mutationId);
        continue;
      }

      final deposit = await _createDepositForTenant(
        session,
        tenant: tenant,
        guestName: payload.guestName,
        guestPhone: payload.guestPhone,
        roomNumber: payload.roomNumber,
        nights: payload.nights,
        amount: payload.amount,
        currency: payload.currency,
        method: payload.method,
        clientMutationId: mutationId,
        capturedAt: payload.capturedAt,
      );
      accepted.add(deposit);
    }

    final tally = await _buildTodayTally(session, tenant.organizationId);
    unawaited(
      session.messages.postMessage(tallyChannel(tenant.organizationId), tally),
    );

    await appendAudit(
      session,
      organizationId: tenant.organizationId,
      authUserId: tenant.authUserId,
      action: 'deposit.sync_offline',
      detail:
          'Synced ${accepted.length} offline deposit(s), skipped ${skipped.length}',
    );

    return SyncOfflineResult(
      accepted: accepted,
      skippedMutationIds: skipped,
      tally: tally,
    );
  }

  /// Jev `choice`: pick the best open room for a walk-in.
  Future<RoomRecommendation> recommendRoom(
    Session session, {
    String guestHint = '',
    int nights = 1,
  }) async {
    final tenant = await requireTenant(session);
    final jev = JevService.fromSession(session);
    if (jev == null) {
      throw TillException(
        message:
            'Jev is not configured. Set typesafeAPIKey / TYPESAFE_API_KEY / JEV_API_KEY.',
        code: 'jev_unconfigured',
      );
    }

    try {
      final rooms = await Room.db.find(
        session,
        where: (t) => t.organizationId.equals(tenant.organizationId),
        orderBy: (t) => t.number,
      );
      final open = rooms
          .where(
            (r) =>
                r.status == RoomStatus.available ||
                r.status == RoomStatus.cleaning,
          )
          .toList();

      final recommendation = await jev.recommendRoom(
        openRooms: open,
        guestHint: guestHint,
        nights: nights.clamp(1, 30),
      );

      await appendAudit(
        session,
        organizationId: tenant.organizationId,
        authUserId: tenant.authUserId,
        action: 'jev.recommend_room',
        detail:
            'Jev picked ${recommendation.roomNumber} '
            'p=${recommendation.probability.toStringAsFixed(3)}',
      );

      return recommendation;
    } finally {
      jev.close();
    }
  }

  /// Jev `noul`: is this shift healthy to close?
  Future<ShiftJudgement> judgeShift(Session session) async {
    final tenant = await requireTenant(session);
    final jev = JevService.fromSession(session);
    if (jev == null) {
      throw TillException(
        message:
            'Jev is not configured. Set typesafeAPIKey / TYPESAFE_API_KEY / JEV_API_KEY.',
        code: 'jev_unconfigured',
      );
    }

    try {
      final tally = await _buildTodayTally(session, tenant.organizationId);
      final judgement = await jev.judgeShift(
        expectedTotal: tally.totalGhs,
        depositCount: tally.deposits.length,
        occupiedCount: tally.occupiedCount,
        roomCount: tally.roomCount,
        shiftClosed: tally.shiftClosed,
      );

      await appendAudit(
        session,
        organizationId: tenant.organizationId,
        authUserId: tenant.authUserId,
        action: 'jev.judge_shift',
        detail:
            'healthy=${judgement.healthyProbability.toStringAsFixed(3)} '
            'deposits=${judgement.depositCount}',
      );

      return judgement;
    } finally {
      jev.close();
    }
  }

  /// Schedule auto-close. Free/Starter: in-process delay (FutureCalls disabled
  /// on Serverpod Cloud Starter). Set `TALLY_USE_FUTURE_CALLS=1` on Growth/self-host.
  Future<String> scheduleShiftClose(
    Session session, {
    int delaySeconds = 30,
    String notes = 'Auto-closed by scheduled shift close.',
  }) async {
    final tenant = await requireTenant(session);
    if (tenant.membership.role == MembershipRole.receptionist) {
      throw TillException(
        message: 'Only managers or owners can schedule shift close.',
        code: 'forbidden',
      );
    }
    if (delaySeconds < 5 || delaySeconds > 86400) {
      throw TillException(
        message: 'delaySeconds must be between 5 and 86400.',
        code: 'invalid_delay',
      );
    }

    final identifier = 'shift-close-${tenant.organizationId.uuid}';
    final job = ShiftCloseJob(
      organizationId: tenant.organizationId,
      notes: notes.trim().isEmpty
          ? 'Auto-closed by scheduled shift close.'
          : notes.trim(),
    );

    final mode = await _scheduleAutoClose(
      session,
      identifier: identifier,
      delaySeconds: delaySeconds,
      job: job,
    );

    await appendAudit(
      session,
      organizationId: tenant.organizationId,
      authUserId: tenant.authUserId,
      action: 'shift.schedule_close',
      detail:
          'Scheduled auto-close in ${delaySeconds}s id=$identifier mode=$mode',
    );

    return '$identifier:$mode';
  }

  /// Schedules auto-close via FutureCall (Growth) or free in-process delay (Starter).
  Future<String> _scheduleAutoClose(
    Session session, {
    required String identifier,
    required int delaySeconds,
    required ShiftCloseJob job,
  }) async {
    final useFutureCalls =
        Platform.environment['TALLY_USE_FUTURE_CALLS'] == '1';

    if (useFutureCalls) {
      await session.serverpod.futureCalls.cancel(identifier);
      await session.serverpod.futureCalls
          .callWithDelay(
            Duration(seconds: delaySeconds),
            identifier: identifier,
          )
          .shiftClose
          .autoClose(job);
      return 'future_call';
    }

    // Free / Starter path: FutureCalls are disabled on Cloud Starter.
    // In-process delay works for the live demo; does not survive process restart.
    final pod = session.serverpod;
    unawaited(() async {
      await Future<void>.delayed(Duration(seconds: delaySeconds));
      final bg = await pod.createSession(enableLogging: true);
      try {
        await ShiftCloseFutureCall().autoClose(bg, job);
      } catch (e, st) {
        bg.log(
          'Free-plan delayed shift close failed: $e',
          level: LogLevel.error,
          exception: e,
          stackTrace: st,
        );
      } finally {
        await bg.close();
      }
    }());
    return 'free_delay';
  }

  /// Lock or free a room night for the caller's organization.
  Future<Room> assignNight(
    Session session, {
    required String roomNumber,
    required bool lock,
  }) async {
    final tenant = await requireTenant(session);
    await _ensureShiftOpen(session, tenant.organizationId);

    final room = await Room.db.findFirstRow(
      session,
      where: (t) =>
          t.organizationId.equals(tenant.organizationId) &
          t.number.equals(roomNumber.trim()),
    );
    if (room == null) {
      throw TillException(
        message: 'Room $roomNumber not found for this guest-house.',
        code: 'room_missing',
      );
    }

    if (lock) {
      if (room.status == RoomStatus.occupied || room.status == RoomStatus.locked) {
        throw TillException(
          message: 'Room ${room.number} is already locked/occupied.',
          code: 'room_busy',
        );
      }
      room.status = RoomStatus.locked;
      room.checkInAt ??= DateTime.now().toUtc();
    } else {
      room.status = RoomStatus.available;
      room.guestName = null;
      room.depositAmount = null;
      room.checkInAt = null;
      room.nights = null;
    }

    await Room.db.updateRow(session, room);

    await appendAudit(
      session,
      organizationId: tenant.organizationId,
      authUserId: tenant.authUserId,
      action: lock ? 'night.lock' : 'night.unlock',
      detail: 'Room ${room.number} ${lock ? 'locked' : 'freed'}',
    );

    final tally = await _buildTodayTally(session, tenant.organizationId);
    unawaited(
      session.messages.postMessage(tallyChannel(tenant.organizationId), tally),
    );

    return room;
  }

  /// Today's deposits, rooms, and totals for the caller's organization.
  Future<TodayTally> listToday(Session session) async {
    final tenant = await requireTenant(session);
    return _buildTodayTally(session, tenant.organizationId);
  }

  /// Live stream: first event is current tally, then updates after deposits/locks.
  Stream<TodayTally> watchToday(Session session) async* {
    final tenant = await requireTenant(session);
    final channel = tallyChannel(tenant.organizationId);
    final updates = session.messages.createStream<TodayTally>(channel);

    yield await _buildTodayTally(session, tenant.organizationId);
    await for (final update in updates) {
      yield update;
    }
  }

  Future<ShiftClose> closeShift(
    Session session, {
    required String notes,
    required double countedTotal,
  }) async {
    final tenant = await requireTenant(session);
    if (tenant.membership.role == MembershipRole.receptionist) {
      throw TillException(
        message: 'Only managers or owners can close the shift.',
        code: 'forbidden',
      );
    }

    final tally = await _buildTodayTally(session, tenant.organizationId);
    var shift = await ShiftClose.db.findFirstRow(
      session,
      where: (t) => t.organizationId.equals(tenant.organizationId),
    );
    shift ??= await ShiftClose.db.insertRow(
      session,
      ShiftClose(organizationId: tenant.organizationId, closed: false),
    );

    shift.closed = true;
    shift.closedAt = DateTime.now().toUtc();
    shift.notes = notes.trim();
    shift.expectedTotal = tally.totalGhs;
    shift.countedTotal = countedTotal;
    await ShiftClose.db.updateRow(session, shift);

    await appendAudit(
      session,
      organizationId: tenant.organizationId,
      authUserId: tenant.authUserId,
      action: 'shift.close',
      detail: 'Closed shift expected=${tally.totalGhs} counted=$countedTotal',
    );

    final next = await _buildTodayTally(session, tenant.organizationId);
    unawaited(
      session.messages.postMessage(tallyChannel(tenant.organizationId), next),
    );
    return shift;
  }

  Future<ShiftClose> reopenShift(Session session) async {
    final tenant = await requireTenant(session);
    if (tenant.membership.role == MembershipRole.receptionist) {
      throw TillException(
        message: 'Only managers or owners can reopen the shift.',
        code: 'forbidden',
      );
    }

    var shift = await ShiftClose.db.findFirstRow(
      session,
      where: (t) => t.organizationId.equals(tenant.organizationId),
    );
    shift ??= await ShiftClose.db.insertRow(
      session,
      ShiftClose(organizationId: tenant.organizationId, closed: false),
    );
    shift.closed = false;
    shift.closedAt = null;
    shift.notes = null;
    shift.expectedTotal = null;
    shift.countedTotal = null;
    await ShiftClose.db.updateRow(session, shift);

    await appendAudit(
      session,
      organizationId: tenant.organizationId,
      authUserId: tenant.authUserId,
      action: 'shift.reopen',
      detail: 'Shift reopened',
    );

    final next = await _buildTodayTally(session, tenant.organizationId);
    unawaited(
      session.messages.postMessage(tallyChannel(tenant.organizationId), next),
    );
    return shift;
  }

  Future<Deposit> _createDepositForTenant(
    Session session, {
    required TenantContext tenant,
    required String guestName,
    required String guestPhone,
    required String roomNumber,
    required int nights,
    required double amount,
    required CurrencyCode currency,
    required PaymentMethod method,
    required String? clientMutationId,
    required DateTime? capturedAt,
  }) async {
    await _ensureShiftOpen(session, tenant.organizationId);

    final name = guestName.trim();
    final phone = guestPhone.trim();
    if (name.isEmpty || name.length > 120) {
      throw TillException(
        message: 'Guest name must be 1–120 characters.',
        code: 'invalid_guest',
      );
    }
    if (!_phonePattern.hasMatch(phone)) {
      throw TillException(
        message: 'Use a Ghana phone (+233… or 0xxxxxxxxx).',
        code: 'invalid_phone',
      );
    }
    if (nights < 1 || nights > 30) {
      throw TillException(
        message: 'Nights must be between 1 and 30.',
        code: 'invalid_nights',
      );
    }
    if (!amount.isFinite || amount <= 0 || amount > 1000000) {
      throw TillException(
        message: 'Deposit amount must be a positive amount.',
        code: 'invalid_amount',
      );
    }

    final room = await Room.db.findFirstRow(
      session,
      where: (t) =>
          t.organizationId.equals(tenant.organizationId) &
          t.number.equals(roomNumber.trim()),
    );
    if (room == null) {
      throw TillException(
        message: 'Room $roomNumber not found for this guest-house.',
        code: 'room_missing',
      );
    }
    if (room.status == RoomStatus.occupied || room.status == RoomStatus.locked) {
      throw TillException(
        message: 'Room ${room.number} is already ${room.status.name}.',
        code: 'room_busy',
      );
    }

    final stamp = (capturedAt ?? DateTime.now().toUtc()).millisecondsSinceEpoch;
    final receiptCode = 'TL-$stamp-${room.number}';

    final deposit = await Deposit.db.insertRow(
      session,
      Deposit(
        organizationId: tenant.organizationId,
        roomId: room.id!,
        guestName: name,
        guestPhone: phone,
        nights: nights,
        amount: amount,
        currency: currency,
        method: method,
        receptionistName: tenant.membership.displayName,
        receiptCode: receiptCode,
        createdAt: capturedAt?.toUtc() ?? DateTime.now().toUtc(),
      ),
    );

    room.status = RoomStatus.locked;
    room.guestName = name;
    room.depositAmount = amount;
    room.checkInAt = capturedAt?.toUtc() ?? DateTime.now().toUtc();
    room.nights = nights;
    await Room.db.updateRow(session, room);

    if (clientMutationId != null) {
      await SyncedMutation.db.insertRow(
        session,
        SyncedMutation(
          organizationId: tenant.organizationId,
          clientMutationId: clientMutationId,
          depositId: deposit.id,
        ),
      );
    }

    await appendAudit(
      session,
      organizationId: tenant.organizationId,
      authUserId: tenant.authUserId,
      action: clientMutationId == null ? 'deposit.create' : 'deposit.create_offline',
      detail:
          'Deposit $receiptCode room ${room.number} amount $amount ${currency.name} via ${method.name}'
          '${clientMutationId == null ? '' : ' mutation=$clientMutationId'}',
    );

    // Skip broadcast when batching offline sync — caller posts once.
    if (clientMutationId == null) {
      final tally = await _buildTodayTally(session, tenant.organizationId);
      unawaited(
        session.messages.postMessage(tallyChannel(tenant.organizationId), tally),
      );
    }

    return deposit;
  }

  Future<void> _ensureShiftOpen(Session session, UuidValue organizationId) async {
    final shift = await ShiftClose.db.findFirstRow(
      session,
      where: (t) => t.organizationId.equals(organizationId),
    );
    if (shift != null && shift.closed) {
      throw TillException(
        message: 'Shift is closed. Reopen before taking deposits.',
        code: 'shift_closed',
      );
    }
  }

  Future<TodayTally> _buildTodayTally(
    Session session,
    UuidValue organizationId,
  ) async {
    final start = startOfUtcDay();
    final end = start.add(const Duration(days: 1));

    final deposits = await Deposit.db.find(
      session,
      where: (t) =>
          t.organizationId.equals(organizationId) &
          (t.createdAt >= start) &
          (t.createdAt < end),
      orderBy: (t) => t.createdAt.desc(),
    );

    final rooms = await Room.db.find(
      session,
      where: (t) => t.organizationId.equals(organizationId),
      orderBy: (t) => t.number,
    );

    final audits = await AuditEvent.db.find(
      session,
      where: (t) =>
          t.organizationId.equals(organizationId) &
          (t.createdAt >= start) &
          (t.createdAt < end),
      orderBy: (t) => t.createdAt.desc(),
      limit: 40,
    );

    final shift = await ShiftClose.db.findFirstRow(
      session,
      where: (t) => t.organizationId.equals(organizationId),
    );

    final totalGhs = deposits
        .where((d) => d.currency == CurrencyCode.ghs)
        .fold<double>(0, (sum, d) => sum + d.amount);

    final occupied = rooms
        .where(
          (r) =>
              r.status == RoomStatus.locked || r.status == RoomStatus.occupied,
        )
        .length;

    return TodayTally(
      deposits: deposits,
      rooms: rooms,
      totalGhs: totalGhs,
      occupiedCount: occupied,
      roomCount: rooms.length,
      shiftClosed: shift?.closed ?? false,
      auditTrail: audits,
    );
  }
}
