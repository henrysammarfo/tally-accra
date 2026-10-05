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
import '../till/room_status.dart' as _irudt0dv;

abstract class Room
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Room._({
    this.id,
    required this.organizationId,
    required this.number,
    required this.type,
    required this.rateGhs,
    required this.status,
    this.guestName,
    this.depositAmount,
    this.checkInAt,
    this.nights,
  });

  factory Room({
    _isc.UuidValue? id,
    required _isc.UuidValue organizationId,
    required String number,
    required String type,
    required double rateGhs,
    required _irudt0dv.RoomStatus status,
    String? guestName,
    double? depositAmount,
    DateTime? checkInAt,
    int? nights,
  }) = _RoomImpl;

  factory Room.fromJson(Map<String, dynamic> jsonSerialization) {
    return Room(
      id: jsonSerialization['id'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      organizationId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['organizationId'],
      ),
      number: jsonSerialization['number'] as String,
      type: jsonSerialization['type'] as String,
      rateGhs: (jsonSerialization['rateGhs'] as num).toDouble(),
      status: _irudt0dv.RoomStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      guestName: jsonSerialization['guestName'] as String?,
      depositAmount: (jsonSerialization['depositAmount'] as num?)?.toDouble(),
      checkInAt: jsonSerialization['checkInAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['checkInAt']),
      nights: jsonSerialization['nights'] as int?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _isc.UuidValue? id;

  _isc.UuidValue organizationId;

  String number;

  String type;

  double rateGhs;

  _irudt0dv.RoomStatus status;

  String? guestName;

  double? depositAmount;

  DateTime? checkInAt;

  int? nights;

  /// Returns a shallow copy of this [Room]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Room copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? organizationId,
    String? number,
    String? type,
    double? rateGhs,
    _irudt0dv.RoomStatus? status,
    String? guestName,
    double? depositAmount,
    DateTime? checkInAt,
    int? nights,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Room',
      if (id != null) 'id': id?.toJson(),
      'organizationId': organizationId.toJson(),
      'number': number,
      'type': type,
      'rateGhs': rateGhs,
      'status': status.toJson(),
      if (guestName != null) 'guestName': guestName,
      if (depositAmount != null) 'depositAmount': depositAmount,
      if (checkInAt != null) 'checkInAt': checkInAt?.toJson(),
      if (nights != null) 'nights': nights,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Room',
      if (id != null) 'id': id?.toJson(),
      'organizationId': organizationId.toJson(),
      'number': number,
      'type': type,
      'rateGhs': rateGhs,
      'status': status.toJson(),
      if (guestName != null) 'guestName': guestName,
      if (depositAmount != null) 'depositAmount': depositAmount,
      if (checkInAt != null) 'checkInAt': checkInAt?.toJson(),
      if (nights != null) 'nights': nights,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RoomImpl extends Room {
  _RoomImpl({
    _isc.UuidValue? id,
    required _isc.UuidValue organizationId,
    required String number,
    required String type,
    required double rateGhs,
    required _irudt0dv.RoomStatus status,
    String? guestName,
    double? depositAmount,
    DateTime? checkInAt,
    int? nights,
  }) : super._(
         id: id,
         organizationId: organizationId,
         number: number,
         type: type,
         rateGhs: rateGhs,
         status: status,
         guestName: guestName,
         depositAmount: depositAmount,
         checkInAt: checkInAt,
         nights: nights,
       );

  /// Returns a shallow copy of this [Room]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Room copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? organizationId,
    String? number,
    String? type,
    double? rateGhs,
    _irudt0dv.RoomStatus? status,
    Object? guestName = _Undefined,
    Object? depositAmount = _Undefined,
    Object? checkInAt = _Undefined,
    Object? nights = _Undefined,
  }) {
    return Room(
      id: id is _isc.UuidValue? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      number: number ?? this.number,
      type: type ?? this.type,
      rateGhs: rateGhs ?? this.rateGhs,
      status: status ?? this.status,
      guestName: guestName is String? ? guestName : this.guestName,
      depositAmount: depositAmount is double?
          ? depositAmount
          : this.depositAmount,
      checkInAt: checkInAt is DateTime? ? checkInAt : this.checkInAt,
      nights: nights is int? ? nights : this.nights,
    );
  }
}
