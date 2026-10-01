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
import 'package:tally_server/src/generated/protocol.dart' as _iu45fwud;
import '../till/deposit.dart' as _iiwxip82;
import '../till/today_tally.dart' as _if09tww2;

abstract class SyncOfflineResult
    implements _is.SerializableModel, _is.ProtocolSerialization {
  SyncOfflineResult._({
    required this.accepted,
    required this.skippedMutationIds,
    required this.tally,
  });

  factory SyncOfflineResult({
    required List<_iiwxip82.Deposit> accepted,
    required List<String> skippedMutationIds,
    required _if09tww2.TodayTally tally,
  }) = _SyncOfflineResultImpl;

  factory SyncOfflineResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return SyncOfflineResult(
      accepted: _iu45fwud.Protocol().deserialize<List<_iiwxip82.Deposit>>(
        jsonSerialization['accepted'],
      ),
      skippedMutationIds: _iu45fwud.Protocol().deserialize<List<String>>(
        jsonSerialization['skippedMutationIds'],
      ),
      tally: _iu45fwud.Protocol().deserialize<_if09tww2.TodayTally>(
        jsonSerialization['tally'],
      ),
    );
  }

  List<_iiwxip82.Deposit> accepted;

  List<String> skippedMutationIds;

  _if09tww2.TodayTally tally;

  /// Returns a shallow copy of this [SyncOfflineResult]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SyncOfflineResult copyWith({
    List<_iiwxip82.Deposit>? accepted,
    List<String>? skippedMutationIds,
    _if09tww2.TodayTally? tally,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SyncOfflineResult',
      'accepted': accepted.toJson(valueToJson: (v) => v.toJson()),
      'skippedMutationIds': skippedMutationIds.toJson(),
      'tally': tally.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SyncOfflineResult',
      'accepted': accepted.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'skippedMutationIds': skippedMutationIds.toJson(),
      'tally': tally.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _SyncOfflineResultImpl extends SyncOfflineResult {
  _SyncOfflineResultImpl({
    required List<_iiwxip82.Deposit> accepted,
    required List<String> skippedMutationIds,
    required _if09tww2.TodayTally tally,
  }) : super._(
         accepted: accepted,
         skippedMutationIds: skippedMutationIds,
         tally: tally,
       );

  /// Returns a shallow copy of this [SyncOfflineResult]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SyncOfflineResult copyWith({
    List<_iiwxip82.Deposit>? accepted,
    List<String>? skippedMutationIds,
    _if09tww2.TodayTally? tally,
  }) {
    return SyncOfflineResult(
      accepted: accepted ?? this.accepted.map((e0) => e0.copyWith()).toList(),
      skippedMutationIds:
          skippedMutationIds ??
          this.skippedMutationIds.map((e0) => e0).toList(),
      tally: tally ?? this.tally.copyWith(),
    );
  }
}
