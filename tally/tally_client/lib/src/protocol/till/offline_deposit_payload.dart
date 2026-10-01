/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import '../till/currency_code.dart' as _i3o61vxh;
import '../till/payment_method.dart' as _ie3b7ann;

abstract class OfflineDepositPayload
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  OfflineDepositPayload._({
    required this.guestName,
    required this.guestPhone,
    required this.roomNumber,
    required this.nights,
    required this.amount,
    required this.currency,
    required this.method,
    required this.clientMutationId,
    required this.capturedAt,
  });

  factory OfflineDepositPayload({
    required String guestName,
    required String guestPhone,
    required String roomNumber,
    required int nights,
    required double amount,
    required _i3o61vxh.CurrencyCode currency,
    required _ie3b7ann.PaymentMethod method,
    required String clientMutationId,
    required DateTime capturedAt,
  }) = _OfflineDepositPayloadImpl;

  factory OfflineDepositPayload.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return OfflineDepositPayload(
      guestName: jsonSerialization['guestName'] as String,
      guestPhone: jsonSerialization['guestPhone'] as String,
      roomNumber: jsonSerialization['roomNumber'] as String,
      nights: jsonSerialization['nights'] as int,
      amount: (jsonSerialization['amount'] as num).toDouble(),
      currency: _i3o61vxh.CurrencyCode.fromJson(
        (jsonSerialization['currency'] as String),
      ),
      method: _ie3b7ann.PaymentMethod.fromJson(
        (jsonSerialization['method'] as String),
      ),
      clientMutationId: jsonSerialization['clientMutationId'] as String,
      capturedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['capturedAt'],
      ),
    );
  }

  String guestName;

  String guestPhone;

  String roomNumber;

  int nights;

  double amount;

  _i3o61vxh.CurrencyCode currency;

  _ie3b7ann.PaymentMethod method;

  String clientMutationId;

  DateTime capturedAt;

  /// Returns a shallow copy of this [OfflineDepositPayload]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  OfflineDepositPayload copyWith({
    String? guestName,
    String? guestPhone,
    String? roomNumber,
    int? nights,
    double? amount,
    _i3o61vxh.CurrencyCode? currency,
    _ie3b7ann.PaymentMethod? method,
    String? clientMutationId,
    DateTime? capturedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OfflineDepositPayload',
      'guestName': guestName,
      'guestPhone': guestPhone,
      'roomNumber': roomNumber,
      'nights': nights,
      'amount': amount,
      'currency': currency.toJson(),
      'method': method.toJson(),
      'clientMutationId': clientMutationId,
      'capturedAt': capturedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OfflineDepositPayload',
      'guestName': guestName,
      'guestPhone': guestPhone,
      'roomNumber': roomNumber,
      'nights': nights,
      'amount': amount,
      'currency': currency.toJson(),
      'method': method.toJson(),
      'clientMutationId': clientMutationId,
      'capturedAt': capturedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _OfflineDepositPayloadImpl extends OfflineDepositPayload {
  _OfflineDepositPayloadImpl({
    required String guestName,
    required String guestPhone,
    required String roomNumber,
    required int nights,
    required double amount,
    required _i3o61vxh.CurrencyCode currency,
    required _ie3b7ann.PaymentMethod method,
    required String clientMutationId,
    required DateTime capturedAt,
  }) : super._(
         guestName: guestName,
         guestPhone: guestPhone,
         roomNumber: roomNumber,
         nights: nights,
         amount: amount,
         currency: currency,
         method: method,
         clientMutationId: clientMutationId,
         capturedAt: capturedAt,
       );

  /// Returns a shallow copy of this [OfflineDepositPayload]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  OfflineDepositPayload copyWith({
    String? guestName,
    String? guestPhone,
    String? roomNumber,
    int? nights,
    double? amount,
    _i3o61vxh.CurrencyCode? currency,
    _ie3b7ann.PaymentMethod? method,
    String? clientMutationId,
    DateTime? capturedAt,
  }) {
    return OfflineDepositPayload(
      guestName: guestName ?? this.guestName,
      guestPhone: guestPhone ?? this.guestPhone,
      roomNumber: roomNumber ?? this.roomNumber,
      nights: nights ?? this.nights,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      method: method ?? this.method,
      clientMutationId: clientMutationId ?? this.clientMutationId,
      capturedAt: capturedAt ?? this.capturedAt,
    );
  }
}
