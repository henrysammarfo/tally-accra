import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';
import 'package:tally_server/src/generated/protocol.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given Till spine', (sessionBuilder, endpoints) {
    final userA = const Uuid().v4();
    final userB = const Uuid().v4();

    TestSessionBuilder authed(String userId) => sessionBuilder.copyWith(
          authentication: AuthenticationOverride.authenticationInfo(
            userId,
            {},
          ),
        );

    Future<Organization> bootstrap(String userId, String slug) {
      return endpoints.organization.bootstrapGuestHouse(
        authed(userId),
        name: 'Accra Lodge $slug',
        slug: slug,
        displayName: 'Akosua',
      );
    }

    test('unauthenticated createDeposit is rejected', () async {
      expect(
        () => endpoints.till.createDeposit(
          sessionBuilder,
          guestName: 'Nana',
          guestPhone: '+233246118042',
          roomNumber: '101',
          nights: 1,
          amount: 490,
          currency: CurrencyCode.ghs,
          method: PaymentMethod.cashTill,
        ),
        throwsA(isA<ServerpodUnauthenticatedException>()),
      );
    });

    test('createDeposit locks night and listToday totals GHS', () async {
      await bootstrap(userA, 'osu-heritage');

      final deposit = await endpoints.till.createDeposit(
        authed(userA),
        guestName: 'Efua Addo',
        guestPhone: '+233246118042',
        roomNumber: '106',
        nights: 2,
        amount: 980,
        currency: CurrencyCode.ghs,
        method: PaymentMethod.mtnMomo,
      );

      expect(deposit.amount, 980);
      expect(deposit.receiptCode, startsWith('TL-'));

      final today = await endpoints.till.listToday(authed(userA));
      expect(today.totalGhs, 980);
      expect(today.deposits.length, 1);
      final room106 = today.rooms.firstWhere((r) => r.number == '106');
      expect(room106.status, RoomStatus.locked);
      expect(room106.guestName, 'Efua Addo');
      expect(today.auditTrail.any((a) => a.action == 'deposit.create'), isTrue);
    });

    test('tenant isolation blocks cross-org room access', () async {
      await bootstrap(userA, 'labone-a');
      await bootstrap(userB, 'labone-b');

      await endpoints.till.createDeposit(
        authed(userA),
        guestName: 'Guest A',
        guestPhone: '+233209421003',
        roomNumber: '101',
        nights: 1,
        amount: 920,
        currency: CurrencyCode.ghs,
        method: PaymentMethod.card,
      );

      final todayB = await endpoints.till.listToday(authed(userB));
      expect(todayB.totalGhs, 0);
      expect(todayB.deposits, isEmpty);
      expect(
        todayB.rooms.every((r) => r.status != RoomStatus.locked || r.number != '101' || r.guestName != 'Guest A'),
        isTrue,
      );

      // user B cannot see A's deposit total
      final todayA = await endpoints.till.listToday(authed(userA));
      expect(todayA.totalGhs, 920);
    });

    test('assignNight lock and unlock', () async {
      await bootstrap(userA, 'cantonments');

      final locked = await endpoints.till.assignNight(
        authed(userA),
        roomNumber: '108',
        lock: true,
      );
      expect(locked.status, RoomStatus.locked);

      final freed = await endpoints.till.assignNight(
        authed(userA),
        roomNumber: '108',
        lock: false,
      );
      expect(freed.status, RoomStatus.available);
      expect(freed.guestName, isNull);
    });

    test('syncOfflineDeposits is idempotent on clientMutationId', () async {
      await bootstrap(userA, 'osu-sync');

      final payload = OfflineDepositPayload(
        guestName: 'Ama Serwaa',
        guestPhone: '+233246118042',
        roomNumber: '103',
        nights: 1,
        amount: 490,
        currency: CurrencyCode.ghs,
        method: PaymentMethod.cashTill,
        clientMutationId: 'off-test-103-ama',
        capturedAt: DateTime.now().toUtc(),
      );

      final first = await endpoints.till.syncOfflineDeposits(
        authed(userA),
        payloads: [payload],
      );
      expect(first.accepted.length, 1);
      expect(first.skippedMutationIds, isEmpty);
      expect(first.tally.totalGhs, 490);
      expect(
        first.tally.rooms.firstWhere((r) => r.number == '103').status,
        RoomStatus.locked,
      );

      final second = await endpoints.till.syncOfflineDeposits(
        authed(userA),
        payloads: [payload],
      );
      expect(second.accepted, isEmpty);
      expect(second.skippedMutationIds, ['off-test-103-ama']);
      expect(second.tally.totalGhs, 490);
    });

    test('recommendRoom fails closed without Jev key', () async {
      await bootstrap(userA, 'osu-jev-room');

      await expectLater(
        () => endpoints.till.recommendRoom(
          authed(userA),
          guestHint: '',
          nights: 1,
        ),
        throwsA(
          predicate(
            (e) => e is TillException && e.code == 'jev_unconfigured',
          ),
        ),
      );
    });

    test('judgeShift fails closed without Jev key', () async {
      await bootstrap(userA, 'osu-jev-shift');

      await expectLater(
        () => endpoints.till.judgeShift(authed(userA)),
        throwsA(
          predicate(
            (e) => e is TillException && e.code == 'jev_unconfigured',
          ),
        ),
      );
    });

    test('scheduleShiftClose returns free_delay identifier on free plan', () async {
      await bootstrap(userA, 'osu-future');
      final id = await endpoints.till.scheduleShiftClose(
        authed(userA),
        delaySeconds: 30,
        notes: 'test auto-close',
      );
      expect(id, contains('shift-close-'));
      expect(id, contains('free_delay'));
    });
  });
}
