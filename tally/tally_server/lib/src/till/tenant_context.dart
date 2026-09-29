import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Resolves the authenticated user's membership and organization.
class TenantContext {
  TenantContext({
    required this.authUserId,
    required this.membership,
    required this.organization,
  });

  final UuidValue authUserId;
  final Membership membership;
  final Organization organization;

  UuidValue get organizationId => organization.id!;
}

/// Loads tenant context from the session. Throws [TillException] if unauthenticated
/// or not a member of any organization (when [organizationId] is null and multiple
/// memberships exist, prefers the first membership ordered by createdAt).
Future<TenantContext> requireTenant(
  Session session, {
  UuidValue? organizationId,
}) async {
  final auth = session.authenticated;
  if (auth == null) {
    throw TillException(
      message: 'Sign in required to use the till.',
      code: 'unauthenticated',
    );
  }

  final authUserId = UuidValue.withValidation(auth.userIdentifier);

  Membership? membership;
  if (organizationId != null) {
    membership = await Membership.db.findFirstRow(
      session,
      where: (t) =>
          t.authUserId.equals(authUserId) &
          t.organizationId.equals(organizationId),
    );
  } else {
    membership = await Membership.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
      orderBy: (t) => t.createdAt,
    );
  }

  if (membership == null) {
    throw TillException(
      message: 'No guest-house membership found for this account.',
      code: 'no_membership',
    );
  }

  final organization = await Organization.db.findById(
    session,
    membership.organizationId,
  );
  if (organization == null) {
    throw TillException(
      message: 'Organization missing for membership.',
      code: 'org_missing',
    );
  }

  return TenantContext(
    authUserId: authUserId,
    membership: membership,
    organization: organization,
  );
}

Future<void> appendAudit(
  Session session, {
  required UuidValue organizationId,
  required UuidValue authUserId,
  required String action,
  required String detail,
}) async {
  await AuditEvent.db.insertRow(
    session,
    AuditEvent(
      organizationId: organizationId,
      authUserId: authUserId,
      action: action,
      detail: detail,
    ),
  );
}

/// Accra-facing “today” window in UTC for demo consistency (00:00–24:00 UTC).
DateTime startOfUtcDay([DateTime? now]) {
  final n = now ?? DateTime.now().toUtc();
  return DateTime.utc(n.year, n.month, n.day);
}

String tallyChannel(UuidValue organizationId) =>
    'tally-today-${organizationId.uuid}';
