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

abstract class ShiftClose
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ShiftClose._({
    this.id,
    required this.organizationId,
    bool? closed,
    this.closedAt,
    this.notes,
    this.expectedTotal,
    this.countedTotal,
  }) : closed = closed ?? false;

  factory ShiftClose({
    _isc.UuidValue? id,
    required _isc.UuidValue organizationId,
    bool? closed,
    DateTime? closedAt,
    String? notes,
    double? expectedTotal,
    double? countedTotal,
  }) = _ShiftCloseImpl;

  factory ShiftClose.fromJson(Map<String, dynamic> jsonSerialization) {
    return ShiftClose(
      id: jsonSerialization['id'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      organizationId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['organizationId'],
      ),
      closed: jsonSerialization['closed'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['closed']),
      closedAt: jsonSerialization['closedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['closedAt']),
      notes: jsonSerialization['notes'] as String?,
      expectedTotal: (jsonSerialization['expectedTotal'] as num?)?.toDouble(),
      countedTotal: (jsonSerialization['countedTotal'] as num?)?.toDouble(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _isc.UuidValue? id;

  _isc.UuidValue organizationId;

  bool closed;

  DateTime? closedAt;

  String? notes;

  double? expectedTotal;

  double? countedTotal;

  /// Returns a shallow copy of this [ShiftClose]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ShiftClose copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? organizationId,
    bool? closed,
    DateTime? closedAt,
    String? notes,
    double? expectedTotal,
    double? countedTotal,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ShiftClose',
      if (id != null) 'id': id?.toJson(),
      'organizationId': organizationId.toJson(),
      'closed': closed,
      if (closedAt != null) 'closedAt': closedAt?.toJson(),
      if (notes != null) 'notes': notes,
      if (expectedTotal != null) 'expectedTotal': expectedTotal,
      if (countedTotal != null) 'countedTotal': countedTotal,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ShiftClose',
      if (id != null) 'id': id?.toJson(),
      'organizationId': organizationId.toJson(),
      'closed': closed,
      if (closedAt != null) 'closedAt': closedAt?.toJson(),
      if (notes != null) 'notes': notes,
      if (expectedTotal != null) 'expectedTotal': expectedTotal,
      if (countedTotal != null) 'countedTotal': countedTotal,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ShiftCloseImpl extends ShiftClose {
  _ShiftCloseImpl({
    _isc.UuidValue? id,
    required _isc.UuidValue organizationId,
    bool? closed,
    DateTime? closedAt,
    String? notes,
    double? expectedTotal,
    double? countedTotal,
  }) : super._(
         id: id,
         organizationId: organizationId,
         closed: closed,
         closedAt: closedAt,
         notes: notes,
         expectedTotal: expectedTotal,
         countedTotal: countedTotal,
       );

  /// Returns a shallow copy of this [ShiftClose]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ShiftClose copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? organizationId,
    bool? closed,
    Object? closedAt = _Undefined,
    Object? notes = _Undefined,
    Object? expectedTotal = _Undefined,
    Object? countedTotal = _Undefined,
  }) {
    return ShiftClose(
      id: id is _isc.UuidValue? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      closed: closed ?? this.closed,
      closedAt: closedAt is DateTime? ? closedAt : this.closedAt,
      notes: notes is String? ? notes : this.notes,
      expectedTotal: expectedTotal is double?
          ? expectedTotal
          : this.expectedTotal,
      countedTotal: countedTotal is double? ? countedTotal : this.countedTotal,
    );
  }
}
