#!/usr/bin/env bash
# Smoke AgentRouter via Tor. Requires AGENTROUTER_API_KEY in env. Never commit keys.
set -euo pipefail
: "${AGENTROUTER_API_KEY:?Set AGENTROUTER_API_KEY}"
MODEL="${TALLY_LLM_MODEL:-deepseek-v4-flash}"
SOCKS="${AGENTROUTER_TOR_SOCKS:-socks5h://127.0.0.1:9050}"
HOST="${SOCKS#socks5h://}"
HOST="${HOST#socks5://}"

echo "tor check…"
curl -sS --max-time 30 --socks5-hostname "$HOST" https://check.torproject.org/api/ip
echo

echo "chat completions ($MODEL)…"
RESP=$(curl -sS --max-time 60 --socks5-hostname "$HOST" \
  https://agentrouter.org/v1/chat/completions \
  -H "Authorization: Bearer $AGENTROUTER_API_KEY" \
  -H "Content-Type: application/json" \
  -H "Accept: application/json" \
  -H "User-Agent: QwenCode/0.2.0 (linux; x64)" \
  -H "x-stainless-lang: js" \
  -H "x-stainless-package-version: 6.34.0" \
  -H "x-stainless-os: Linux" \
  -H "x-stainless-arch: x64" \
  -H "x-stainless-runtime: node" \
  -H "x-stainless-runtime-version: node/20.0.0" \
  -H "x-stainless-retry-count: 0" \
  -d "{\"model\":\"$MODEL\",\"temperature\":0.1,\"messages\":[{\"role\":\"user\",\"content\":\"ping\"}]}")

echo "$RESP" | head -c 400
echo
echo "$RESP" | grep -q '"choices"' || { echo "FAIL: no choices (WAF or bad response)"; exit 1; }
echo "smoke_llm_tor_ok"
