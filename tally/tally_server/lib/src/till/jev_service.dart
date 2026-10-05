import 'dart:io';

import 'package:jev_dart/jev_dart.dart';
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// TypeSafe Jev (System One) decisions for the Accra night desk.
/// Fail closed — never invents probabilities when the key is missing.
///
/// Key resolution order (first hit wins):
/// 1. Serverpod password `typesafeAPIKey`
/// 2. `TYPESAFE_API_KEY` / `JEV_API_KEY` → api.typesafe.ai
/// 3. `OPENROUTER_API_KEY` → openrouter.ai/api (model typesafe/jev-1.13)
/// 4. `AI_GATEWAY_API_KEY` → ai-gateway.vercel.sh/typesafe
class JevService {
  JevService._(this._client);

  final TypeSafeClient _client;

  /// Resolves API key + gateway from Serverpod passwords, then env.
  static JevService? fromSession(Session session) {
    final passwords = session.passwords;
    final cfg = _resolveConfig(
      passwordKey: passwords['typesafeAPIKey']?.trim(),
      openRouterPassword: passwords['openRouterAPIKey']?.trim(),
      aiGatewayPassword: passwords['aiGatewayAPIKey']?.trim(),
      typesafeBasePassword: passwords['typesafeBaseUrl']?.trim(),
    );
    if (cfg == null) return null;
    return JevService._(
      TypeSafeClient(
        apiKey: cfg.apiKey,
        baseUrl: cfg.baseUrl,
        defaultModel: cfg.model,
      ),
    );
  }

  static JevService? fromEnvironment() {
    final cfg = _resolveConfig();
    if (cfg == null) return null;
    return JevService._(
      TypeSafeClient(
        apiKey: cfg.apiKey,
        baseUrl: cfg.baseUrl,
        defaultModel: cfg.model,
      ),
    );
  }

  void close() => _client.close();

  /// Pick the best open room for a walk-in (typed `choice`).
  Future<RoomRecommendation> recommendRoom({
    required List<Room> openRooms,
    required String guestHint,
    required int nights,
  }) async {
    if (openRooms.isEmpty) {
      throw TillException(
        message: 'No open rooms for Jev to choose from.',
        code: 'no_open_rooms',
      );
    }

    final options = <String, Object?>{};
    for (final room in openRooms) {
      options[room.number] =
          'Room ${room.number} · ${room.type} · GH₵${room.rateGhs.toStringAsFixed(0)}/night · status ${room.status.name}';
    }

    final state = {
      'desk': 'Accra guest-house night reception',
      'guest_hint': guestHint.trim().isEmpty ? 'walk-in guest' : guestHint.trim(),
      'nights': nights,
      'open_rooms': openRooms
          .map(
            (r) => {
              'number': r.number,
              'type': r.type,
              'rate_ghs': r.rateGhs,
              'status': r.status.name,
            },
          )
          .toList(),
      'policy':
          'Prefer available over cleaning. Match suite for longer stays. '
          'Keep standard studios for short 1-night cash walk-ins when possible.',
    };

    try {
      final result = await _client.systemOne(
        state: state,
        questions: {
          'room': choice(
            'Which open room should reception assign for this guest?',
            options,
          ),
        },
      );
      final answer = result.choice('room');
      final roomNumber = answer.choice;
      final picked = openRooms.firstWhere(
        (r) => r.number == roomNumber,
        orElse: () => openRooms.first,
      );
      return RoomRecommendation(
        roomNumber: picked.number,
        probability: answer.confidence,
        rationale:
            'Jev chose ${picked.number} (${picked.type}) at '
            '${(answer.confidence * 100).toStringAsFixed(0)}% confidence '
            'for $nights night(s).',
        allScores: answer.probabilities,
      );
    } catch (e) {
      throw TillException(
        message: 'Jev room recommendation unavailable: $e',
        code: 'jev_unavailable',
      );
    }
  }

  /// Is this shift healthy enough to close? Typed `noul`.
  Future<ShiftJudgement> judgeShift({
    required double expectedTotal,
    required int depositCount,
    required int occupiedCount,
    required int roomCount,
    required bool shiftClosed,
  }) async {
    final state = {
      'desk': 'Accra guest-house end-of-shift review',
      'expected_total_ghs': expectedTotal,
      'deposit_count': depositCount,
      'occupied_rooms': occupiedCount,
      'room_count': roomCount,
      'shift_already_closed': shiftClosed,
      'policy':
          'A healthy open shift has coherent deposits vs occupancy. '
          'Empty night with zero deposits can still be healthy. '
          'Already-closed shifts are not healthy to re-judge as open.',
    };

    try {
      final result = await _client.systemOne(
        state: state,
        questions: {
          'healthy': noul(
            'This night shift is healthy and ready for manager close.',
          ),
        },
      );
      final healthy = result.noul('healthy');
      final p = healthy.noul;
      final pct = (p * 100).toStringAsFixed(0);
      final recommendation = p >= 0.55
          ? 'Shift looks healthy ($pct%). Safe to close after a cash count.'
          : 'Shift needs a second look ($pct%). Recheck deposits vs locked rooms before close.';
      return ShiftJudgement(
        healthyProbability: p,
        recommendation: recommendation,
        expectedTotal: expectedTotal,
        depositCount: depositCount,
      );
    } catch (e) {
      throw TillException(
        message: 'Jev shift judgement unavailable: $e',
        code: 'jev_unavailable',
      );
    }
  }

  static _JevConfig? _resolveConfig({
    String? passwordKey,
    String? openRouterPassword,
    String? aiGatewayPassword,
    String? typesafeBasePassword,
  }) {
    final direct = _nonEmpty(passwordKey) ??
        resolveApiKey(null) ??
        _env('TYPESAFE_API_KEY') ??
        _env('JEV_API_KEY');
    if (direct != null) {
      return _JevConfig(
        apiKey: direct,
        baseUrl: _nonEmpty(typesafeBasePassword) ??
            _env('TYPESAFE_BASE_URL') ??
            kDefaultBaseUrl,
        model: _env('TYPESAFE_DEFAULT_MODEL') ?? kDefaultModel,
      );
    }

    final openRouter =
        _nonEmpty(openRouterPassword) ?? _env('OPENROUTER_API_KEY');
    if (openRouter != null) {
      return _JevConfig(
        apiKey: openRouter,
        baseUrl: _env('TYPESAFE_BASE_URL') ?? 'https://openrouter.ai/api',
        model: _env('TYPESAFE_DEFAULT_MODEL') ?? 'typesafe/jev-1.13',
      );
    }

    final gateway =
        _nonEmpty(aiGatewayPassword) ?? _env('AI_GATEWAY_API_KEY');
    if (gateway != null) {
      return _JevConfig(
        apiKey: gateway,
        baseUrl:
            _env('TYPESAFE_BASE_URL') ?? 'https://ai-gateway.vercel.sh/typesafe',
        model: _env('TYPESAFE_DEFAULT_MODEL') ?? 'typesafe-ai/jev',
      );
    }

    return null;
  }

  static String? _env(String name) {
    final v = Platform.environment[name]?.trim();
    if (v == null || v.isEmpty) return null;
    return v;
  }

  static String? _nonEmpty(String? v) {
    if (v == null || v.isEmpty) return null;
    return v;
  }
}

class _JevConfig {
  const _JevConfig({
    required this.apiKey,
    required this.baseUrl,
    required this.model,
  });

  final String apiKey;
  final String baseUrl;
  final String model;
}
