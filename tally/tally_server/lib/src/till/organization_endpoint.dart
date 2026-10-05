import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'tenant_context.dart';

/// Bootstrap guest-house org + Accra default rooms for a signed-in owner.
class OrganizationEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Creates an organization and owner membership with rooms 101–108.
  Future<Organization> bootstrapGuestHouse(
    Session session, {
    required String name,
    required String slug,
    required String displayName,
  }) async {
    final auth = session.authenticated!;
    final authUserId = UuidValue.withValidation(auth.userIdentifier);

    final cleanName = name.trim();
    final cleanSlug = slug.trim().toLowerCase().replaceAll(
      RegExp(r'[^a-z0-9-]'),
      '-',
    );
    final cleanDisplay = displayName.trim();

    if (cleanName.isEmpty || cleanName.length > 120) {
      throw TillException(
        message: 'Guest-house name must be 1–120 characters.',
        code: 'invalid_name',
      );
    }
    if (cleanSlug.isEmpty || cleanSlug.length > 64) {
      throw TillException(
        message: 'Slug must be 1–64 characters (a-z, 0-9, -).',
        code: 'invalid_slug',
      );
    }
    if (cleanDisplay.isEmpty || cleanDisplay.length > 80) {
      throw TillException(
        message: 'Display name must be 1–80 characters.',
        code: 'invalid_display_name',
      );
    }

    final existingSlug = await Organization.db.findFirstRow(
      session,
      where: (t) => t.slug.equals(cleanSlug),
    );
    if (existingSlug != null) {
      throw TillException(
        message: 'That slug is already taken.',
        code: 'slug_taken',
      );
    }

    final existingMembership = await Membership.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    if (existingMembership != null) {
      throw TillException(
        message: 'This account already belongs to a guest-house.',
        code: 'already_member',
      );
    }

    final org = await Organization.db.insertRow(
      session,
      Organization(name: cleanName, slug: cleanSlug),
    );

    await Membership.db.insertRow(
      session,
      Membership(
        organizationId: org.id!,
        authUserId: authUserId,
        role: MembershipRole.owner,
        displayName: cleanDisplay,
      ),
    );

    await ShiftClose.db.insertRow(
      session,
      ShiftClose(organizationId: org.id!, closed: false),
    );

    final seeds = <Room>[
      Room(
        organizationId: org.id!,
        number: '101',
        type: 'Executive Suite',
        rateGhs: 920,
        status: RoomStatus.available,
      ),
      Room(
        organizationId: org.id!,
        number: '102',
        type: 'Deluxe King',
        rateGhs: 680,
        status: RoomStatus.available,
      ),
      Room(
        organizationId: org.id!,
        number: '103',
        type: 'Standard Studio',
        rateGhs: 490,
        status: RoomStatus.available,
      ),
      Room(
        organizationId: org.id!,
        number: '104',
        type: 'Deluxe King',
        rateGhs: 680,
        status: RoomStatus.cleaning,
      ),
      Room(
        organizationId: org.id!,
        number: '105',
        type: 'Executive Suite',
        rateGhs: 920,
        status: RoomStatus.available,
      ),
      Room(
        organizationId: org.id!,
        number: '106',
        type: 'Standard Studio',
        rateGhs: 490,
        status: RoomStatus.available,
      ),
      Room(
        organizationId: org.id!,
        number: '107',
        type: 'Deluxe King',
        rateGhs: 680,
        status: RoomStatus.available,
      ),
      Room(
        organizationId: org.id!,
        number: '108',
        type: 'Standard Studio',
        rateGhs: 490,
        status: RoomStatus.available,
      ),
    ];
    await Room.db.insert(session, seeds);

    await appendAudit(
      session,
      organizationId: org.id!,
      authUserId: authUserId,
      action: 'org.bootstrap',
      detail: 'Created guest-house $cleanName ($cleanSlug) with rooms 101–108',
    );

    return org;
  }

  /// Returns the caller's organization, or null if not bootstrapped yet.
  Future<Organization?> myOrganization(Session session) async {
    try {
      final tenant = await requireTenant(session);
      return tenant.organization;
    } on TillException catch (e) {
      if (e.code == 'no_membership') return null;
      rethrow;
    }
  }
}
