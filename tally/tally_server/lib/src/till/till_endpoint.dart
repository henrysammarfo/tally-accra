import 'dart:async';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'tenant_context.dart';

/// Spine till endpoints: createDeposit · assignNight · listToday.
class TillEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  static final _phonePattern = RegExp(r'^\+233\s?\d{2}\s?\d{3}\s?\d{4}$|^\+233\d{9}$|^0\d{9}$');

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

    final receiptCode =
        'TL-${DateTime.now().toUtc().millisecondsSinceEpoch}-${room.number}';

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
      ),
    );

    room.status = RoomStatus.locked;
    room.guestName = name;
    room.depositAmount = amount;
    room.checkInAt = DateTime.now().toUtc();
    room.nights = nights;
    await Room.db.updateRow(session, room);

    await appendAudit(
      session,
      organizationId: tenant.organizationId,
      authUserId: tenant.authUserId,
      action: 'deposit.create',
      detail:
          'Deposit $receiptCode room ${room.number} amount $amount ${currency.name} via ${method.name}',
    );

    final tally = await _buildTodayTally(session, tenant.organizationId);
    unawaited(
      session.messages.postMessage(tallyChannel(tenant.organizationId), tally),
    );

    return deposit;
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
