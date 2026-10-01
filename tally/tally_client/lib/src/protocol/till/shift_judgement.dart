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

abstract class ShiftJudgement
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ShiftJudgement._({
    required this.healthyProbability,
    required this.recommendation,
    required this.expectedTotal,
    required this.depositCount,
  });

  factory ShiftJudgement({
    required double healthyProbability,
    required String recommendation,
    required double expectedTotal,
    required int depositCount,
  }) = _ShiftJudgementImpl;

  factory ShiftJudgement.fromJson(Map<String, dynamic> jsonSerialization) {
    return ShiftJudgement(
      healthyProbability: (jsonSerialization['healthyProbability'] as num)
          .toDouble(),
      recommendation: jsonSerialization['recommendation'] as String,
      expectedTotal: (jsonSerialization['expectedTotal'] as num).toDouble(),
      depositCount: jsonSerialization['depositCount'] as int,
    );
  }

  double healthyProbability;

  String recommendation;

  double expectedTotal;

  int depositCount;

  /// Returns a shallow copy of this [ShiftJudgement]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ShiftJudgement copyWith({
    double? healthyProbability,
    String? recommendation,
    double? expectedTotal,
    int? depositCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ShiftJudgement',
      'healthyProbability': healthyProbability,
      'recommendation': recommendation,
      'expectedTotal': expectedTotal,
      'depositCount': depositCount,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ShiftJudgement',
      'healthyProbability': healthyProbability,
      'recommendation': recommendation,
      'expectedTotal': expectedTotal,
      'depositCount': depositCount,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _ShiftJudgementImpl extends ShiftJudgement {
  _ShiftJudgementImpl({
    required double healthyProbability,
    required String recommendation,
    required double expectedTotal,
    required int depositCount,
  }) : super._(
         healthyProbability: healthyProbability,
         recommendation: recommendation,
         expectedTotal: expectedTotal,
         depositCount: depositCount,
       );

  /// Returns a shallow copy of this [ShiftJudgement]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ShiftJudgement copyWith({
    double? healthyProbability,
    String? recommendation,
    double? expectedTotal,
    int? depositCount,
  }) {
    return ShiftJudgement(
      healthyProbability: healthyProbability ?? this.healthyProbability,
      recommendation: recommendation ?? this.recommendation,
      expectedTotal: expectedTotal ?? this.expectedTotal,
      depositCount: depositCount ?? this.depositCount,
    );
  }
}
