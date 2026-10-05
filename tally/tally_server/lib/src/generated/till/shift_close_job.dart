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
import 'package:serverpod/serverpod.dart' as _is;

abstract class ShiftCloseJob
    implements _is.SerializableModel, _is.ProtocolSerialization {
  ShiftCloseJob._({
    required this.organizationId,
    required this.notes,
  });

  factory ShiftCloseJob({
    required _is.UuidValue organizationId,
    required String notes,
  }) = _ShiftCloseJobImpl;

  factory ShiftCloseJob.fromJson(Map<String, dynamic> jsonSerialization) {
    return ShiftCloseJob(
      organizationId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['organizationId'],
      ),
      notes: jsonSerialization['notes'] as String,
    );
  }

  _is.UuidValue organizationId;

  String notes;

  /// Returns a shallow copy of this [ShiftCloseJob]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ShiftCloseJob copyWith({
    _is.UuidValue? organizationId,
    String? notes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ShiftCloseJob',
      'organizationId': organizationId.toJson(),
      'notes': notes,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ShiftCloseJob',
      'organizationId': organizationId.toJson(),
      'notes': notes,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _ShiftCloseJobImpl extends ShiftCloseJob {
  _ShiftCloseJobImpl({
    required _is.UuidValue organizationId,
    required String notes,
  }) : super._(
         organizationId: organizationId,
         notes: notes,
       );

  /// Returns a shallow copy of this [ShiftCloseJob]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ShiftCloseJob copyWith({
    _is.UuidValue? organizationId,
    String? notes,
  }) {
    return ShiftCloseJob(
      organizationId: organizationId ?? this.organizationId,
      notes: notes ?? this.notes,
    );
  }
}
