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

abstract class AuditEvent
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  AuditEvent._({
    this.id,
    required this.organizationId,
    required this.authUserId,
    required this.action,
    required this.detail,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory AuditEvent({
    _isc.UuidValue? id,
    required _isc.UuidValue organizationId,
    required _isc.UuidValue authUserId,
    required String action,
    required String detail,
    DateTime? createdAt,
  }) = _AuditEventImpl;

  factory AuditEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return AuditEvent(
      id: jsonSerialization['id'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      organizationId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['organizationId'],
      ),
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      action: jsonSerialization['action'] as String,
      detail: jsonSerialization['detail'] as String,
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

  _isc.UuidValue authUserId;

  String action;

  String detail;

  DateTime createdAt;

  /// Returns a shallow copy of this [AuditEvent]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AuditEvent copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? organizationId,
    _isc.UuidValue? authUserId,
    String? action,
    String? detail,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AuditEvent',
      if (id != null) 'id': id?.toJson(),
      'organizationId': organizationId.toJson(),
      'authUserId': authUserId.toJson(),
      'action': action,
      'detail': detail,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AuditEvent',
      if (id != null) 'id': id?.toJson(),
      'organizationId': organizationId.toJson(),
      'authUserId': authUserId.toJson(),
      'action': action,
      'detail': detail,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AuditEventImpl extends AuditEvent {
  _AuditEventImpl({
    _isc.UuidValue? id,
    required _isc.UuidValue organizationId,
    required _isc.UuidValue authUserId,
    required String action,
    required String detail,
    DateTime? createdAt,
  }) : super._(
         id: id,
         organizationId: organizationId,
         authUserId: authUserId,
         action: action,
         detail: detail,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [AuditEvent]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  AuditEvent copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? organizationId,
    _isc.UuidValue? authUserId,
    String? action,
    String? detail,
    DateTime? createdAt,
  }) {
    return AuditEvent(
      id: id is _isc.UuidValue? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      authUserId: authUserId ?? this.authUserId,
      action: action ?? this.action,
      detail: detail ?? this.detail,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
