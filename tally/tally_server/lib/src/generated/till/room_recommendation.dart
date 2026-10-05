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

abstract class RoomRecommendation
    implements _is.SerializableModel, _is.ProtocolSerialization {
  RoomRecommendation._({
    required this.roomNumber,
    required this.probability,
    required this.rationale,
    required this.allScores,
  });

  factory RoomRecommendation({
    required String roomNumber,
    required double probability,
    required String rationale,
    required Map<String, double> allScores,
  }) = _RoomRecommendationImpl;

  factory RoomRecommendation.fromJson(Map<String, dynamic> jsonSerialization) {
    return RoomRecommendation(
      roomNumber: jsonSerialization['roomNumber'] as String,
      probability: (jsonSerialization['probability'] as num).toDouble(),
      rationale: jsonSerialization['rationale'] as String,
      allScores: _iu45fwud.Protocol().deserialize<Map<String, double>>(
        jsonSerialization['allScores'],
      ),
    );
  }

  String roomNumber;

  double probability;

  String rationale;

  Map<String, double> allScores;

  /// Returns a shallow copy of this [RoomRecommendation]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  RoomRecommendation copyWith({
    String? roomNumber,
    double? probability,
    String? rationale,
    Map<String, double>? allScores,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RoomRecommendation',
      'roomNumber': roomNumber,
      'probability': probability,
      'rationale': rationale,
      'allScores': allScores.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RoomRecommendation',
      'roomNumber': roomNumber,
      'probability': probability,
      'rationale': rationale,
      'allScores': allScores.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _RoomRecommendationImpl extends RoomRecommendation {
  _RoomRecommendationImpl({
    required String roomNumber,
    required double probability,
    required String rationale,
    required Map<String, double> allScores,
  }) : super._(
         roomNumber: roomNumber,
         probability: probability,
         rationale: rationale,
         allScores: allScores,
       );

  /// Returns a shallow copy of this [RoomRecommendation]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  RoomRecommendation copyWith({
    String? roomNumber,
    double? probability,
    String? rationale,
    Map<String, double>? allScores,
  }) {
    return RoomRecommendation(
      roomNumber: roomNumber ?? this.roomNumber,
      probability: probability ?? this.probability,
      rationale: rationale ?? this.rationale,
      allScores:
          allScores ??
          this.allScores.map(
            (
              key0,
              value0,
            ) => MapEntry(
              key0,
              value0,
            ),
          ),
    );
  }
}
