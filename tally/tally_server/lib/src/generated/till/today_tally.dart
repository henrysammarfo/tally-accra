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
import '../till/audit_event.dart' as _invswqc7;
import '../till/deposit.dart' as _iiwxip82;
import '../till/room.dart' as _ic5w7qlr;

/// Aggregated desk view for the current Accra calendar day (UTC+0 window used server-side).
abstract class TodayTally
    implements _is.SerializableModel, _is.ProtocolSerialization {
  TodayTally._({
    required this.deposits,
    required this.rooms,
    required this.totalGhs,
    required this.occupiedCount,
    required this.roomCount,
    required this.shiftClosed,
    required this.auditTrail,
  });

  factory TodayTally({
    required List<_iiwxip82.Deposit> deposits,
    required List<_ic5w7qlr.Room> rooms,
    required double totalGhs,
    required int occupiedCount,
    required int roomCount,
    required bool shiftClosed,
    required List<_invswqc7.AuditEvent> auditTrail,
  }) = _TodayTallyImpl;

  factory TodayTally.fromJson(Map<String, dynamic> jsonSerialization) {
    return TodayTally(
      deposits: _iu45fwud.Protocol().deserialize<List<_iiwxip82.Deposit>>(
        jsonSerialization['deposits'],
      ),
      rooms: _iu45fwud.Protocol().deserialize<List<_ic5w7qlr.Room>>(
        jsonSerialization['rooms'],
      ),
      totalGhs: (jsonSerialization['totalGhs'] as num).toDouble(),
      occupiedCount: jsonSerialization['occupiedCount'] as int,
      roomCount: jsonSerialization['roomCount'] as int,
      shiftClosed: _is.BoolJsonExtension.fromJson(
        jsonSerialization['shiftClosed'],
      ),
      auditTrail: _iu45fwud.Protocol().deserialize<List<_invswqc7.AuditEvent>>(
        jsonSerialization['auditTrail'],
      ),
    );
  }

  List<_iiwxip82.Deposit> deposits;

  List<_ic5w7qlr.Room> rooms;

  double totalGhs;

  int occupiedCount;

  int roomCount;

  bool shiftClosed;

  List<_invswqc7.AuditEvent> auditTrail;

  /// Returns a shallow copy of this [TodayTally]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  TodayTally copyWith({
    List<_iiwxip82.Deposit>? deposits,
    List<_ic5w7qlr.Room>? rooms,
    double? totalGhs,
    int? occupiedCount,
    int? roomCount,
    bool? shiftClosed,
    List<_invswqc7.AuditEvent>? auditTrail,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TodayTally',
      'deposits': deposits.toJson(valueToJson: (v) => v.toJson()),
      'rooms': rooms.toJson(valueToJson: (v) => v.toJson()),
      'totalGhs': totalGhs,
      'occupiedCount': occupiedCount,
      'roomCount': roomCount,
      'shiftClosed': shiftClosed,
      'auditTrail': auditTrail.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TodayTally',
      'deposits': deposits.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'rooms': rooms.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'totalGhs': totalGhs,
      'occupiedCount': occupiedCount,
      'roomCount': roomCount,
      'shiftClosed': shiftClosed,
      'auditTrail': auditTrail.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _TodayTallyImpl extends TodayTally {
  _TodayTallyImpl({
    required List<_iiwxip82.Deposit> deposits,
    required List<_ic5w7qlr.Room> rooms,
    required double totalGhs,
    required int occupiedCount,
    required int roomCount,
    required bool shiftClosed,
    required List<_invswqc7.AuditEvent> auditTrail,
  }) : super._(
         deposits: deposits,
         rooms: rooms,
         totalGhs: totalGhs,
         occupiedCount: occupiedCount,
         roomCount: roomCount,
         shiftClosed: shiftClosed,
         auditTrail: auditTrail,
       );

  /// Returns a shallow copy of this [TodayTally]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  TodayTally copyWith({
    List<_iiwxip82.Deposit>? deposits,
    List<_ic5w7qlr.Room>? rooms,
    double? totalGhs,
    int? occupiedCount,
    int? roomCount,
    bool? shiftClosed,
    List<_invswqc7.AuditEvent>? auditTrail,
  }) {
    return TodayTally(
      deposits: deposits ?? this.deposits.map((e0) => e0.copyWith()).toList(),
      rooms: rooms ?? this.rooms.map((e0) => e0.copyWith()).toList(),
      totalGhs: totalGhs ?? this.totalGhs,
      occupiedCount: occupiedCount ?? this.occupiedCount,
      roomCount: roomCount ?? this.roomCount,
      shiftClosed: shiftClosed ?? this.shiftClosed,
      auditTrail:
          auditTrail ?? this.auditTrail.map((e0) => e0.copyWith()).toList(),
    );
  }
}
