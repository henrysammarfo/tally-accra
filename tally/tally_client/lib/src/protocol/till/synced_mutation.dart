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

/// Idempotent ledger of client offline mutations already accepted.
abstract class SyncedMutation
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  SyncedMutation._({
    this.id,
    required this.organizationId,
    required this.clientMutationId,
    this.depositId,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory SyncedMutation({
    _isc.UuidValue? id,
    required _isc.UuidValue organizationId,
    required String clientMutationId,
    _isc.UuidValue? depositId,
    DateTime? createdAt,
  }) = _SyncedMutationImpl;

  factory SyncedMutation.fromJson(Map<String, dynamic> jsonSerialization) {
    return SyncedMutation(
      id: jsonSerialization['id'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      organizationId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['organizationId'],
      ),
      clientMutationId: jsonSerialization['clientMutationId'] as String,
      depositId: jsonSerialization['depositId'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(
              jsonSerialization['depositId'],
            ),
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

  String clientMutationId;

  _isc.UuidValue? depositId;

  DateTime createdAt;

  /// Returns a shallow copy of this [SyncedMutation]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  SyncedMutation copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? organizationId,
    String? clientMutationId,
    _isc.UuidValue? depositId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SyncedMutation',
      if (id != null) 'id': id?.toJson(),
      'organizationId': organizationId.toJson(),
      'clientMutationId': clientMutationId,
      if (depositId != null) 'depositId': depositId?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SyncedMutation',
      if (id != null) 'id': id?.toJson(),
      'organizationId': organizationId.toJson(),
      'clientMutationId': clientMutationId,
      if (depositId != null) 'depositId': depositId?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SyncedMutationImpl extends SyncedMutation {
  _SyncedMutationImpl({
    _isc.UuidValue? id,
    required _isc.UuidValue organizationId,
    required String clientMutationId,
    _isc.UuidValue? depositId,
    DateTime? createdAt,
  }) : super._(
         id: id,
         organizationId: organizationId,
         clientMutationId: clientMutationId,
         depositId: depositId,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [SyncedMutation]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  SyncedMutation copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? organizationId,
    String? clientMutationId,
    Object? depositId = _Undefined,
    DateTime? createdAt,
  }) {
    return SyncedMutation(
      id: id is _isc.UuidValue? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      clientMutationId: clientMutationId ?? this.clientMutationId,
      depositId: depositId is _isc.UuidValue? ? depositId : this.depositId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
