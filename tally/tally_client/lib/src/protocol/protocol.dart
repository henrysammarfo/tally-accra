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
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'package:tally_client/src/protocol/till/offline_deposit_payload.dart'
    as _itpuq2bv;
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
export 'client.dart';

class Protocol extends _isc.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

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
      } on _isc.DeserializationClassNameNotFoundException catch (_) {
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
    if (t == _isc.getType<_izw8z7ou.Greeting?>()) {
      return (data != null ? _izw8z7ou.Greeting.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iqbaaylr.AuditEvent?>()) {
      return (data != null ? _iqbaaylr.AuditEvent.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i0m10zoh.CurrencyCode?>()) {
      return (data != null ? _i0m10zoh.CurrencyCode.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_im00e6z9.Deposit?>()) {
      return (data != null ? _im00e6z9.Deposit.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ir2s5cd6.Membership?>()) {
      return (data != null ? _ir2s5cd6.Membership.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i5o1iqnh.MembershipRole?>()) {
      return (data != null ? _i5o1iqnh.MembershipRole.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_idd7hlek.OfflineDepositPayload?>()) {
      return (data != null
              ? _idd7hlek.OfflineDepositPayload.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_itaa86xl.Organization?>()) {
      return (data != null ? _itaa86xl.Organization.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_itkv9ghh.PaymentMethod?>()) {
      return (data != null ? _itkv9ghh.PaymentMethod.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iz3zju01.Room?>()) {
      return (data != null ? _iz3zju01.Room.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ic9hnfei.RoomRecommendation?>()) {
      return (data != null ? _ic9hnfei.RoomRecommendation.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i9ebolaq.RoomStatus?>()) {
      return (data != null ? _i9ebolaq.RoomStatus.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iwm07xqw.ShiftClose?>()) {
      return (data != null ? _iwm07xqw.ShiftClose.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ifz52290.ShiftCloseJob?>()) {
      return (data != null ? _ifz52290.ShiftCloseJob.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ikv292jv.ShiftJudgement?>()) {
      return (data != null ? _ikv292jv.ShiftJudgement.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_irimsbbb.SyncOfflineResult?>()) {
      return (data != null ? _irimsbbb.SyncOfflineResult.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ixhibl8j.SyncedMutation?>()) {
      return (data != null ? _ixhibl8j.SyncedMutation.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i6xfzno2.TillException?>()) {
      return (data != null ? _i6xfzno2.TillException.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i1nd03fb.TodayTally?>()) {
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
    if (t == List<_itpuq2bv.OfflineDepositPayload>) {
      return (data as List)
              .map((e) => deserialize<_itpuq2bv.OfflineDepositPayload>(e))
              .toList()
          as T;
    }
    try {
      return _iaic.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacc.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
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
    className = _iaic.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacc.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
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
      return _iaic.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacc.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iaic.Protocol().registerHostProtocol('tally', this);
    _iacc.Protocol().registerHostProtocol('tally', this);
  }

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
      return _iaic.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacc.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
