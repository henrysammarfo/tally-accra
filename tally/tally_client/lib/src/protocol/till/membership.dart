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
import '../till/membership_role.dart' as _i71l0f2n;

abstract class Membership
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Membership._({
    this.id,
    required this.organizationId,
    required this.authUserId,
    required this.role,
    required this.displayName,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Membership({
    _isc.UuidValue? id,
    required _isc.UuidValue organizationId,
    required _isc.UuidValue authUserId,
    required _i71l0f2n.MembershipRole role,
    required String displayName,
    DateTime? createdAt,
  }) = _MembershipImpl;

  factory Membership.fromJson(Map<String, dynamic> jsonSerialization) {
    return Membership(
      id: jsonSerialization['id'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      organizationId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['organizationId'],
      ),
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      role: _i71l0f2n.MembershipRole.fromJson(
        (jsonSerialization['role'] as String),
      ),
      displayName: jsonSerialization['displayName'] as String,
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

  _i71l0f2n.MembershipRole role;

  String displayName;

  DateTime createdAt;

  /// Returns a shallow copy of this [Membership]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Membership copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? organizationId,
    _isc.UuidValue? authUserId,
    _i71l0f2n.MembershipRole? role,
    String? displayName,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Membership',
      if (id != null) 'id': id?.toJson(),
      'organizationId': organizationId.toJson(),
      'authUserId': authUserId.toJson(),
      'role': role.toJson(),
      'displayName': displayName,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Membership',
      if (id != null) 'id': id?.toJson(),
      'organizationId': organizationId.toJson(),
      'authUserId': authUserId.toJson(),
      'role': role.toJson(),
      'displayName': displayName,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MembershipImpl extends Membership {
  _MembershipImpl({
    _isc.UuidValue? id,
    required _isc.UuidValue organizationId,
    required _isc.UuidValue authUserId,
    required _i71l0f2n.MembershipRole role,
    required String displayName,
    DateTime? createdAt,
  }) : super._(
         id: id,
         organizationId: organizationId,
         authUserId: authUserId,
         role: role,
         displayName: displayName,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Membership]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Membership copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? organizationId,
    _isc.UuidValue? authUserId,
    _i71l0f2n.MembershipRole? role,
    String? displayName,
    DateTime? createdAt,
  }) {
    return Membership(
      id: id is _isc.UuidValue? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      authUserId: authUserId ?? this.authUserId,
      role: role ?? this.role,
      displayName: displayName ?? this.displayName,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
