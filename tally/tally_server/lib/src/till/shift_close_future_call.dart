import 'dart:async';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'tenant_context.dart';

/// Serverpod future call: auto-draft close an Accra night shift.
class ShiftCloseFutureCall extends FutureCall {
  /// Closes (or drafts-close) the org shift when the scheduled time fires.
  Future<void> autoClose(Session session, ShiftCloseJob job) async {
    final orgId = job.organizationId;

    var shift = await ShiftClose.db.findFirstRow(
      session,
      where: (t) => t.organizationId.equals(orgId),
    );
    shift ??= await ShiftClose.db.insertRow(
      session,
      ShiftClose(organizationId: orgId, closed: false),
    );

    if (shift.closed) {
      session.log(
        'Shift already closed for $orgId — future call no-op.',
        level: LogLevel.info,
      );
      return;
    }

    final start = startOfUtcDay();
    final end = start.add(const Duration(days: 1));
    final deposits = await Deposit.db.find(
      session,
      where: (t) =>
          t.organizationId.equals(orgId) &
          (t.createdAt >= start) &
          (t.createdAt < end),
    );
    final totalGhs = deposits
        .where((d) => d.currency == CurrencyCode.ghs)
        .fold<double>(0, (sum, d) => sum + d.amount);

    shift.closed = true;
    shift.closedAt = DateTime.now().toUtc();
    shift.notes = job.notes.trim().isEmpty
        ? 'Auto-closed by Serverpod future call.'
        : job.notes.trim();
    shift.expectedTotal = totalGhs;
    shift.countedTotal = totalGhs;
    await ShiftClose.db.updateRow(session, shift);

    await AuditEvent.db.insertRow(
      session,
      AuditEvent(
        organizationId: orgId,
        authUserId: UuidValue.withValidation(
          '00000000-0000-0000-0000-000000000000',
        ),
        action: 'shift.auto_close',
        detail:
            'Future call closed shift expected=$totalGhs notes=${shift.notes}',
      ),
    );

    final rooms = await Room.db.find(
      session,
      where: (t) => t.organizationId.equals(orgId),
      orderBy: (t) => t.number,
    );
    final occupied = rooms
        .where(
          (r) =>
              r.status == RoomStatus.locked || r.status == RoomStatus.occupied,
        )
        .length;
    final audits = await AuditEvent.db.find(
      session,
      where: (t) =>
          t.organizationId.equals(orgId) &
          (t.createdAt >= start) &
          (t.createdAt < end),
      orderBy: (t) => t.createdAt.desc(),
      limit: 40,
    );

    final tally = TodayTally(
      deposits: deposits,
      rooms: rooms,
      totalGhs: totalGhs,
      occupiedCount: occupied,
      roomCount: rooms.length,
      shiftClosed: true,
      auditTrail: audits,
    );
    unawaited(session.messages.postMessage(tallyChannel(orgId), tally));

    session.log(
      'Future call auto-closed shift for $orgId (total=$totalGhs).',
      level: LogLevel.info,
    );
  }
}
