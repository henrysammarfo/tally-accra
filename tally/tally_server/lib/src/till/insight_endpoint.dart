import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'agent_router_client.dart';

/// Desk insight endpoint — production AgentRouter only, fail closed.
class InsightEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<String> askDeskInsight(
    Session session, {
    required String question,
    required String context,
  }) async {
    final q = question.trim();
    final ctx = context.trim();
    if (q.length < 3 || q.length > 500) {
      throw TillException(
        message: 'Question must be 3–500 characters.',
        code: 'invalid_question',
      );
    }
    if (ctx.isEmpty || ctx.length > 8000) {
      throw TillException(
        message: 'Context must be 1–8000 characters.',
        code: 'invalid_context',
      );
    }

    final client = AgentRouterClient.fromEnvironment();
    if (client == null) {
      throw TillException(
        message: 'AI is not configured. Set AGENTROUTER_API_KEY on the server.',
        code: 'ai_unconfigured',
      );
    }

    try {
      return await client.chatCompletion(
        system:
            'You are the operations analyst for TALLY, a guest-house till in Accra, Ghana. '
            'Answer strictly from the supplied shift data. Amounts are Ghana Cedis (GH₵). '
            'At most 90 words: one direct answer, then short bullets with numbers.',
        user: 'Shift data:\n$ctx\n\nManager question: $q',
      );
    } catch (e) {
      throw TillException(
        message: 'Desk insight unavailable: $e',
        code: 'ai_unavailable',
      );
    }
  }
}
