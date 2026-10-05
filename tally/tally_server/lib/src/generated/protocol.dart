/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/protocol.dart' as _isp;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import 'package:tally_server/src/generated/till/offline_deposit_payload.dart'
    as _i2ijly4n;
import 'greetings/greeting.dart' as _izw8z7ou;
import 'till/audit_event.dart' as _iqbaaylr;
import 'till/currency_code.dart' as _i0m10zoh;
import 'till/deposit.dart' as _im00e6z9;
import 'till/membership.dart' as _ir2s5cd6;
import 'till/membership_role.dart' as _i5o1iqnh;
import 'till/offline_deposit_payload.dart' as _idd7hlek;
import 'till/organization.dart' as _itaa86xl;
import 'till/payment_method.dart' as _itkv9ghh;
import 'till/room.dart' as _iz3zju01;
import 'till/room_recommendation.dart' as _ic9hnfei;
import 'till/room_status.dart' as _i9ebolaq;
import 'till/shift_close.dart' as _iwm07xqw;
import 'till/shift_close_job.dart' as _ifz52290;
import 'till/shift_judgement.dart' as _ikv292jv;
import 'till/sync_offline_result.dart' as _irimsbbb;
import 'till/synced_mutation.dart' as _ixhibl8j;
import 'till/till_exception.dart' as _i6xfzno2;
import 'till/today_tally.dart' as _i1nd03fb;
export 'greetings/greeting.dart';
export 'till/audit_event.dart';
export 'till/currency_code.dart';
export 'till/deposit.dart';
export 'till/membership.dart';
export 'till/membership_role.dart';
export 'till/offline_deposit_payload.dart';
export 'till/organization.dart';
export 'till/payment_method.dart';
export 'till/room.dart';
export 'till/room_recommendation.dart';
export 'till/room_status.dart';
export 'till/shift_close.dart';
export 'till/shift_close_job.dart';
export 'till/shift_judgement.dart';
export 'till/sync_offline_result.dart';
export 'till/synced_mutation.dart';
export 'till/till_exception.dart';
export 'till/today_tally.dart';

class Protocol extends _is.DatabaseSerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static List<_isp.TableDefinition> get targetTableDefinitions => [
    _isp.TableDefinition(
      name: 'audit_event',
      dartName: 'AuditEvent',
      schema: 'public',
      module: 'tally',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isp.ColumnDefinition(
          name: 'organizationId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'authUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'action',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'detail',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'audit_event_fk_0',
          columns: ['organizationId'],
          referenceTable: 'organization',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'audit_org_created_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'organizationId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'deposit',
      dartName: 'Deposit',
      schema: 'public',
      module: 'tally',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isp.ColumnDefinition(
          name: 'organizationId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'roomId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'guestName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'guestPhone',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'nights',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'amount',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'currency',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:CurrencyCode',
        ),
        _isp.ColumnDefinition(
          name: 'method',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:PaymentMethod',
        ),
        _isp.ColumnDefinition(
          name: 'receptionistName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'receiptCode',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'deposit_fk_0',
          columns: ['organizationId'],
          referenceTable: 'organization',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'deposit_fk_1',
          columns: ['roomId'],
          referenceTable: 'room',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.restrict,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'deposit_org_created_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'organizationId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'deposit_receipt_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'receiptCode',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'membership',
      dartName: 'Membership',
      schema: 'public',
      module: 'tally',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isp.ColumnDefinition(
          name: 'organizationId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'authUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'role',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:MembershipRole',
        ),
        _isp.ColumnDefinition(
          name: 'displayName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'membership_fk_0',
          columns: ['organizationId'],
          referenceTable: 'organization',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'membership_org_user_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'organizationId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'authUserId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'membership_auth_user_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'authUserId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'organization',
      dartName: 'Organization',
      schema: 'public',
      module: 'tally',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'slug',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'organization_slug_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'slug',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'room',
      dartName: 'Room',
      schema: 'public',
      module: 'tally',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isp.ColumnDefinition(
          name: 'organizationId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'number',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'type',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'rateGhs',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:RoomStatus',
        ),
        _isp.ColumnDefinition(
          name: 'guestName',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'depositAmount',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _isp.ColumnDefinition(
          name: 'checkInAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'nights',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'room_fk_0',
          columns: ['organizationId'],
          referenceTable: 'organization',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'room_org_number_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'organizationId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'number',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'shift_close',
      dartName: 'ShiftClose',
      schema: 'public',
      module: 'tally',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isp.ColumnDefinition(
          name: 'organizationId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'closed',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _isp.ColumnDefinition(
          name: 'closedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'notes',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'expectedTotal',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _isp.ColumnDefinition(
          name: 'countedTotal',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'shift_close_fk_0',
          columns: ['organizationId'],
          referenceTable: 'organization',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'shift_close_org_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'organizationId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'synced_mutation',
      dartName: 'SyncedMutation',
      schema: 'public',
      module: 'tally',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isp.ColumnDefinition(
          name: 'organizationId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'clientMutationId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'depositId',
          columnType: _isp.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'synced_mutation_fk_0',
          columns: ['organizationId'],
          referenceTable: 'organization',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'synced_mutation_org_client_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'organizationId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'clientMutationId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    ..._iais.Protocol.targetTableDefinitions,
    ..._iacs.Protocol.targetTableDefinitions,
    ..._isp.Protocol.targetTableDefinitions,
  ];

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _is.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _izw8z7ou.Greeting) {
      return _izw8z7ou.Greeting.fromJson(data) as T;
    }
    if (t == _iqbaaylr.AuditEvent) {
      return _iqbaaylr.AuditEvent.fromJson(data) as T;
    }
    if (t == _i0m10zoh.CurrencyCode) {
      return _i0m10zoh.CurrencyCode.fromJson(data) as T;
    }
    if (t == _im00e6z9.Deposit) {
      return _im00e6z9.Deposit.fromJson(data) as T;
    }
    if (t == _ir2s5cd6.Membership) {
      return _ir2s5cd6.Membership.fromJson(data) as T;
    }
    if (t == _i5o1iqnh.MembershipRole) {
      return _i5o1iqnh.MembershipRole.fromJson(data) as T;
    }
    if (t == _idd7hlek.OfflineDepositPayload) {
      return _idd7hlek.OfflineDepositPayload.fromJson(data) as T;
    }
    if (t == _itaa86xl.Organization) {
      return _itaa86xl.Organization.fromJson(data) as T;
    }
    if (t == _itkv9ghh.PaymentMethod) {
      return _itkv9ghh.PaymentMethod.fromJson(data) as T;
    }
    if (t == _iz3zju01.Room) {
      return _iz3zju01.Room.fromJson(data) as T;
    }
    if (t == _ic9hnfei.RoomRecommendation) {
      return _ic9hnfei.RoomRecommendation.fromJson(data) as T;
    }
    if (t == _i9ebolaq.RoomStatus) {
      return _i9ebolaq.RoomStatus.fromJson(data) as T;
    }
    if (t == _iwm07xqw.ShiftClose) {
      return _iwm07xqw.ShiftClose.fromJson(data) as T;
    }
    if (t == _ifz52290.ShiftCloseJob) {
      return _ifz52290.ShiftCloseJob.fromJson(data) as T;
    }
    if (t == _ikv292jv.ShiftJudgement) {
      return _ikv292jv.ShiftJudgement.fromJson(data) as T;
    }
    if (t == _irimsbbb.SyncOfflineResult) {
      return _irimsbbb.SyncOfflineResult.fromJson(data) as T;
    }
    if (t == _ixhibl8j.SyncedMutation) {
      return _ixhibl8j.SyncedMutation.fromJson(data) as T;
    }
    if (t == _i6xfzno2.TillException) {
      return _i6xfzno2.TillException.fromJson(data) as T;
    }
    if (t == _i1nd03fb.TodayTally) {
      return _i1nd03fb.TodayTally.fromJson(data) as T;
    }
    if (t == _is.getType<_izw8z7ou.Greeting?>()) {
      return (data != null ? _izw8z7ou.Greeting.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iqbaaylr.AuditEvent?>()) {
      return (data != null ? _iqbaaylr.AuditEvent.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i0m10zoh.CurrencyCode?>()) {
      return (data != null ? _i0m10zoh.CurrencyCode.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_im00e6z9.Deposit?>()) {
      return (data != null ? _im00e6z9.Deposit.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ir2s5cd6.Membership?>()) {
      return (data != null ? _ir2s5cd6.Membership.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i5o1iqnh.MembershipRole?>()) {
      return (data != null ? _i5o1iqnh.MembershipRole.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_idd7hlek.OfflineDepositPayload?>()) {
      return (data != null
              ? _idd7hlek.OfflineDepositPayload.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_itaa86xl.Organization?>()) {
      return (data != null ? _itaa86xl.Organization.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_itkv9ghh.PaymentMethod?>()) {
      return (data != null ? _itkv9ghh.PaymentMethod.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iz3zju01.Room?>()) {
      return (data != null ? _iz3zju01.Room.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ic9hnfei.RoomRecommendation?>()) {
      return (data != null ? _ic9hnfei.RoomRecommendation.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i9ebolaq.RoomStatus?>()) {
      return (data != null ? _i9ebolaq.RoomStatus.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iwm07xqw.ShiftClose?>()) {
      return (data != null ? _iwm07xqw.ShiftClose.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ifz52290.ShiftCloseJob?>()) {
      return (data != null ? _ifz52290.ShiftCloseJob.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ikv292jv.ShiftJudgement?>()) {
      return (data != null ? _ikv292jv.ShiftJudgement.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_irimsbbb.SyncOfflineResult?>()) {
      return (data != null ? _irimsbbb.SyncOfflineResult.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ixhibl8j.SyncedMutation?>()) {
      return (data != null ? _ixhibl8j.SyncedMutation.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i6xfzno2.TillException?>()) {
      return (data != null ? _i6xfzno2.TillException.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i1nd03fb.TodayTally?>()) {
      return (data != null ? _i1nd03fb.TodayTally.fromJson(data) : null) as T;
    }
    if (t == Map<String, double>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<double>(v)),
          )
          as T;
    }
    if (t == List<_im00e6z9.Deposit>) {
      return (data as List)
              .map((e) => deserialize<_im00e6z9.Deposit>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_iz3zju01.Room>) {
      return (data as List).map((e) => deserialize<_iz3zju01.Room>(e)).toList()
          as T;
    }
    if (t == List<_iqbaaylr.AuditEvent>) {
      return (data as List)
              .map((e) => deserialize<_iqbaaylr.AuditEvent>(e))
              .toList()
          as T;
    }
    if (t == List<_i2ijly4n.OfflineDepositPayload>) {
      return (data as List)
              .map((e) => deserialize<_i2ijly4n.OfflineDepositPayload>(e))
              .toList()
          as T;
    }
    try {
      return _iais.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacs.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _isp.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _izw8z7ou.Greeting => 'Greeting',
      _iqbaaylr.AuditEvent => 'AuditEvent',
      _i0m10zoh.CurrencyCode => 'CurrencyCode',
      _im00e6z9.Deposit => 'Deposit',
      _ir2s5cd6.Membership => 'Membership',
      _i5o1iqnh.MembershipRole => 'MembershipRole',
      _idd7hlek.OfflineDepositPayload => 'OfflineDepositPayload',
      _itaa86xl.Organization => 'Organization',
      _itkv9ghh.PaymentMethod => 'PaymentMethod',
      _iz3zju01.Room => 'Room',
      _ic9hnfei.RoomRecommendation => 'RoomRecommendation',
      _i9ebolaq.RoomStatus => 'RoomStatus',
      _iwm07xqw.ShiftClose => 'ShiftClose',
      _ifz52290.ShiftCloseJob => 'ShiftCloseJob',
      _ikv292jv.ShiftJudgement => 'ShiftJudgement',
      _irimsbbb.SyncOfflineResult => 'SyncOfflineResult',
      _ixhibl8j.SyncedMutation => 'SyncedMutation',
      _i6xfzno2.TillException => 'TillException',
      _i1nd03fb.TodayTally => 'TodayTally',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('tally.', '');
    }

    switch (data) {
      case _izw8z7ou.Greeting():
        return 'Greeting';
      case _iqbaaylr.AuditEvent():
        return 'AuditEvent';
      case _i0m10zoh.CurrencyCode():
        return 'CurrencyCode';
      case _im00e6z9.Deposit():
        return 'Deposit';
      case _ir2s5cd6.Membership():
        return 'Membership';
      case _i5o1iqnh.MembershipRole():
        return 'MembershipRole';
      case _idd7hlek.OfflineDepositPayload():
        return 'OfflineDepositPayload';
      case _itaa86xl.Organization():
        return 'Organization';
      case _itkv9ghh.PaymentMethod():
        return 'PaymentMethod';
      case _iz3zju01.Room():
        return 'Room';
      case _ic9hnfei.RoomRecommendation():
        return 'RoomRecommendation';
      case _i9ebolaq.RoomStatus():
        return 'RoomStatus';
      case _iwm07xqw.ShiftClose():
        return 'ShiftClose';
      case _ifz52290.ShiftCloseJob():
        return 'ShiftCloseJob';
      case _ikv292jv.ShiftJudgement():
        return 'ShiftJudgement';
      case _irimsbbb.SyncOfflineResult():
        return 'SyncOfflineResult';
      case _ixhibl8j.SyncedMutation():
        return 'SyncedMutation';
      case _i6xfzno2.TillException():
        return 'TillException';
      case _i1nd03fb.TodayTally():
        return 'TodayTally';
    }
    className = _iais.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacs.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    className = _isp.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.') ? className : 'serverpod.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_izw8z7ou.Greeting>(data['data']);
    }
    if (dataClassName == 'AuditEvent') {
      return deserialize<_iqbaaylr.AuditEvent>(data['data']);
    }
    if (dataClassName == 'CurrencyCode') {
      return deserialize<_i0m10zoh.CurrencyCode>(data['data']);
    }
    if (dataClassName == 'Deposit') {
      return deserialize<_im00e6z9.Deposit>(data['data']);
    }
    if (dataClassName == 'Membership') {
      return deserialize<_ir2s5cd6.Membership>(data['data']);
    }
    if (dataClassName == 'MembershipRole') {
      return deserialize<_i5o1iqnh.MembershipRole>(data['data']);
    }
    if (dataClassName == 'OfflineDepositPayload') {
      return deserialize<_idd7hlek.OfflineDepositPayload>(data['data']);
    }
    if (dataClassName == 'Organization') {
      return deserialize<_itaa86xl.Organization>(data['data']);
    }
    if (dataClassName == 'PaymentMethod') {
      return deserialize<_itkv9ghh.PaymentMethod>(data['data']);
    }
    if (dataClassName == 'Room') {
      return deserialize<_iz3zju01.Room>(data['data']);
    }
    if (dataClassName == 'RoomRecommendation') {
      return deserialize<_ic9hnfei.RoomRecommendation>(data['data']);
    }
    if (dataClassName == 'RoomStatus') {
      return deserialize<_i9ebolaq.RoomStatus>(data['data']);
    }
    if (dataClassName == 'ShiftClose') {
      return deserialize<_iwm07xqw.ShiftClose>(data['data']);
    }
    if (dataClassName == 'ShiftCloseJob') {
      return deserialize<_ifz52290.ShiftCloseJob>(data['data']);
    }
    if (dataClassName == 'ShiftJudgement') {
      return deserialize<_ikv292jv.ShiftJudgement>(data['data']);
    }
    if (dataClassName == 'SyncOfflineResult') {
      return deserialize<_irimsbbb.SyncOfflineResult>(data['data']);
    }
    if (dataClassName == 'SyncedMutation') {
      return deserialize<_ixhibl8j.SyncedMutation>(data['data']);
    }
    if (dataClassName == 'TillException') {
      return deserialize<_i6xfzno2.TillException>(data['data']);
    }
    if (dataClassName == 'TodayTally') {
      return deserialize<_i1nd03fb.TodayTally>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _iais.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacs.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _isp.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iais.Protocol().registerHostProtocol('tally', this);
    _iacs.Protocol().registerHostProtocol('tally', this);
  }

  @override
  _is.Table? getTableForType(Type t) {
    {
      var table = _iais.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _iacs.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _isp.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _iqbaaylr.AuditEvent:
        return _iqbaaylr.AuditEvent.t;
      case _im00e6z9.Deposit:
        return _im00e6z9.Deposit.t;
      case _ir2s5cd6.Membership:
        return _ir2s5cd6.Membership.t;
      case _itaa86xl.Organization:
        return _itaa86xl.Organization.t;
      case _iz3zju01.Room:
        return _iz3zju01.Room.t;
      case _iwm07xqw.ShiftClose:
        return _iwm07xqw.ShiftClose.t;
      case _ixhibl8j.SyncedMutation:
        return _ixhibl8j.SyncedMutation.t;
    }
    return null;
  }

  @override
  List<_isp.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'tally';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _iais.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacs.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
