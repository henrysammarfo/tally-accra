import 'dart:convert';
import 'dart:io';

/// Live AgentRouter client. Fail closed — never invents answers.
class AgentRouterClient {
  AgentRouterClient({
    required this.apiKey,
    this.baseUrl = 'https://agentrouter.org/v1',
    this.model = 'deepseek-v4-flash',
    this.useTor = false,
    this.torSocksHost = '127.0.0.1',
    this.torSocksPort = 9050,
    this.relayUrl,
    this.relayKey,
  });

  final String apiKey;
  final String baseUrl;
  final String model;
  final bool useTor;
  final String torSocksHost;
  final int torSocksPort;
  final String? relayUrl;
  final String? relayKey;

  static AgentRouterClient? fromEnvironment() {
    final key = Platform.environment['AGENTROUTER_API_KEY'];
    if (key == null || key.isEmpty) return null;
    final useTor = Platform.environment['AGENTROUTER_USE_TOR'] == '1';
    final model =
        Platform.environment['TALLY_LLM_MODEL'] ?? 'deepseek-v4-flash';
    final base =
        Platform.environment['AGENTROUTER_BASE_URL'] ??
        'https://agentrouter.org/v1';
    final relay = Platform.environment['TALLY_LLM_RELAY_URL'];
    final relayKey = Platform.environment['TALLY_LLM_RELAY_KEY'];
    return AgentRouterClient(
      apiKey: key,
      baseUrl: base,
      model: model,
      useTor: useTor,
      relayUrl: relay,
      relayKey: relayKey,
    );
  }

  Future<String> chatCompletion({
    required String system,
    required String user,
  }) async {
    final targetBase = (relayUrl != null && relayUrl!.isNotEmpty)
        ? relayUrl!
        : baseUrl;
    final uri = Uri.parse(
      targetBase.endsWith('/')
          ? '${targetBase}chat/completions'
          : '$targetBase/chat/completions',
    );

    final body = jsonEncode({
      'model': model,
      'temperature': 0.2,
      'messages': [
        {'role': 'system', 'content': system},
        {'role': 'user', 'content': user},
      ],
    });

    final headers = <String, String>{
      'Authorization': 'Bearer ${relayKey?.isNotEmpty == true ? relayKey! : apiKey}',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'User-Agent': 'QwenCode/0.2.0 (linux; x64)',
      'x-stainless-lang': 'js',
      'x-stainless-package-version': '6.34.0',
      'x-stainless-os': 'Linux',
      'x-stainless-arch': 'x64',
      'x-stainless-runtime': 'dart',
      'x-stainless-runtime-version': 'dart/${Platform.version.split(' ').first}',
      'x-stainless-retry-count': '0',
    };

    final String responseText;
    if (useTor && (relayUrl == null || relayUrl!.isEmpty)) {
      responseText = await _postViaTor(uri, headers, body);
    } else {
      final client = HttpClient();
      try {
        final request = await client.postUrl(uri);
        headers.forEach(request.headers.set);
        request.add(utf8.encode(body));
        final response = await request.close().timeout(
          const Duration(seconds: 60),
        );
        responseText = await response.transform(utf8.decoder).join();
        if (response.statusCode < 200 || response.statusCode >= 300) {
          throw StateError(
            'AgentRouter HTTP ${response.statusCode}: ${_clip(responseText)}',
          );
        }
      } finally {
        client.close(force: true);
      }
    }

    if (responseText.contains('aliyun_waf') ||
        responseText.trimLeft().startsWith('<!doctype') ||
        responseText.trimLeft().startsWith('<html')) {
      throw StateError(
        'AgentRouter WAF_BLOCKED — enable Tor (AGENTROUTER_USE_TOR=1) or TALLY_LLM_RELAY_URL.',
      );
    }

    final decoded = jsonDecode(responseText);
    if (decoded is! Map<String, dynamic>) {
      throw StateError('AgentRouter returned non-JSON object.');
    }
    final choices = decoded['choices'];
    if (choices is! List || choices.isEmpty) {
      throw StateError('AgentRouter response missing choices.');
    }
    final message = choices.first['message'];
    final content = message is Map ? message['content'] : null;
    if (content is! String || content.trim().isEmpty) {
      throw StateError('AgentRouter returned empty content.');
    }
    return content.trim();
  }

  Future<String> _postViaTor(
    Uri uri,
    Map<String, String> headers,
    String body,
  ) async {
    // curl speaks SOCKS5 reliably; dart:io HttpClient has no built-in SOCKS.
    final args = <String>[
      '-sS',
      '--max-time',
      '60',
      '--socks5-hostname',
      '$torSocksHost:$torSocksPort',
      uri.toString(),
      '-X',
      'POST',
      '-d',
      body,
    ];
    for (final entry in headers.entries) {
      args.addAll(['-H', '${entry.key}: ${entry.value}']);
    }
    final result = await Process.run('curl', args);
    if (result.exitCode != 0) {
      throw StateError(
        'Tor curl failed (${result.exitCode}): ${result.stderr}',
      );
    }
    return result.stdout.toString();
  }

  String _clip(String value) =>
      value.length <= 240 ? value : '${value.substring(0, 240)}…';
}
