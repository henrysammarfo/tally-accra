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

abstract class Deposit
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Deposit._({
    this.id,
    required this.organizationId,
    required this.roomId,
    required this.guestName,
    required this.guestPhone,
    required this.nights,
    required this.amount,
    required this.currency,
    required this.method,
    required this.receptionistName,
    required this.receiptCode,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Deposit({
    _isc.UuidValue? id,
    required _isc.UuidValue organizationId,
    required _isc.UuidValue roomId,
    required String guestName,
    required String guestPhone,
    required int nights,
    required double amount,
    required _i3o61vxh.CurrencyCode currency,
    required _ie3b7ann.PaymentMethod method,
    required String receptionistName,
    required String receiptCode,
    DateTime? createdAt,
  }) = _DepositImpl;

  factory Deposit.fromJson(Map<String, dynamic> jsonSerialization) {
    return Deposit(
      id: jsonSerialization['id'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      organizationId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['organizationId'],
      ),
      roomId: _isc.UuidValueJsonExtension.fromJson(jsonSerialization['roomId']),
      guestName: jsonSerialization['guestName'] as String,
      guestPhone: jsonSerialization['guestPhone'] as String,
      nights: jsonSerialization['nights'] as int,
      amount: (jsonSerialization['amount'] as num).toDouble(),
      currency: _i3o61vxh.CurrencyCode.fromJson(
        (jsonSerialization['currency'] as String),
      ),
      method: _ie3b7ann.PaymentMethod.fromJson(
        (jsonSerialization['method'] as String),
      ),
      receptionistName: jsonSerialization['receptionistName'] as String,
      receiptCode: jsonSerialization['receiptCode'] as String,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _isc.UuidValue? id;

  _isc.UuidValue organizationId;

  _isc.UuidValue roomId;

  String guestName;

  String guestPhone;

  int nights;

  double amount;

  _i3o61vxh.CurrencyCode currency;

  _ie3b7ann.PaymentMethod method;

  String receptionistName;

  String receiptCode;

  DateTime createdAt;

  /// Returns a shallow copy of this [Deposit]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Deposit copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? organizationId,
    _isc.UuidValue? roomId,
    String? guestName,
    String? guestPhone,
    int? nights,
    double? amount,
    _i3o61vxh.CurrencyCode? currency,
    _ie3b7ann.PaymentMethod? method,
    String? receptionistName,
    String? receiptCode,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Deposit',
      if (id != null) 'id': id?.toJson(),
      'organizationId': organizationId.toJson(),
      'roomId': roomId.toJson(),
      'guestName': guestName,
      'guestPhone': guestPhone,
      'nights': nights,
      'amount': amount,
      'currency': currency.toJson(),
      'method': method.toJson(),
      'receptionistName': receptionistName,
      'receiptCode': receiptCode,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Deposit',
      if (id != null) 'id': id?.toJson(),
      'organizationId': organizationId.toJson(),
      'roomId': roomId.toJson(),
      'guestName': guestName,
      'guestPhone': guestPhone,
      'nights': nights,
      'amount': amount,
      'currency': currency.toJson(),
      'method': method.toJson(),
      'receptionistName': receptionistName,
      'receiptCode': receiptCode,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DepositImpl extends Deposit {
  _DepositImpl({
    _isc.UuidValue? id,
    required _isc.UuidValue organizationId,
    required _isc.UuidValue roomId,
    required String guestName,
    required String guestPhone,
    required int nights,
    required double amount,
    required _i3o61vxh.CurrencyCode currency,
    required _ie3b7ann.PaymentMethod method,
    required String receptionistName,
    required String receiptCode,
    DateTime? createdAt,
  }) : super._(
         id: id,
         organizationId: organizationId,
         roomId: roomId,
         guestName: guestName,
         guestPhone: guestPhone,
         nights: nights,
         amount: amount,
         currency: currency,
         method: method,
         receptionistName: receptionistName,
         receiptCode: receiptCode,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Deposit]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Deposit copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? organizationId,
    _isc.UuidValue? roomId,
    String? guestName,
    String? guestPhone,
    int? nights,
    double? amount,
    _i3o61vxh.CurrencyCode? currency,
    _ie3b7ann.PaymentMethod? method,
    String? receptionistName,
    String? receiptCode,
    DateTime? createdAt,
  }) {
    return Deposit(
      id: id is _isc.UuidValue? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      roomId: roomId ?? this.roomId,
      guestName: guestName ?? this.guestName,
      guestPhone: guestPhone ?? this.guestPhone,
      nights: nights ?? this.nights,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      method: method ?? this.method,
      receptionistName: receptionistName ?? this.receptionistName,
      receiptCode: receiptCode ?? this.receiptCode,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
