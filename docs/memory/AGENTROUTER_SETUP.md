# AgentRouter — perfect setup (TALLY)

> Adapted from operator setup (VIGIL pattern). Never put real API keys in git.
> Prefer host `https://agentrouter.org`. Direct cloud egress often returns Aliyun WAF captcha HTML — not always a bad key.

## Goal

Make AgentRouter return JSON chat completions from cloud VMs and serverless.
Fix = Tor SOCKS (workers / Cursor VM) or clean-egress relay (Vercel / Serverpod Cloud hosts without Tor).

## Non-negotiables

1. Prefer host **`https://agentrouter.org`** (OpenAI base `…/v1`). `co.agentrouter.org` may reject this key pool.
2. Always send **stainless / QwenCode-style headers**.
3. From cloud IPs: **`AGENTROUTER_USE_TOR=1`** + Tor on `socks5h://127.0.0.1:9050`.
4. Do **not** use undici+SocksProxyAgent for Tor on Bun — tunnel with Node `https` + `SocksProxyAgent`, or `curl --socks5-hostname`.
5. Default model: **`deepseek-v4-flash`**.
6. Never put `AGENTROUTER_API_KEY` in `VITE_*` or client bundles.
7. Fail closed: WAF/HTML or missing key → clear error, never fake LLM text.

## Env (canonical)

```bash
AGENTROUTER_API_KEY=sk-...
AGENTROUTER_BASE_URL=https://agentrouter.org/v1
AGENTROUTER_ANTHROPIC_BASE=https://agentrouter.org
AGENTROUTER_USE_TOR=1
AGENTROUTER_TOR_SOCKS=socks5h://127.0.0.1:9050
TALLY_LLM_MODEL=deepseek-v4-flash
# Optional relay for hosts without Tor:
# TALLY_LLM_RELAY_URL=https://YOUR_RELAY/v1
# TALLY_LLM_RELAY_KEY=...
```

## Path A — Cursor VM / GCP worker (Tor)

```bash
sudo apt-get update && sudo apt-get install -y tor
# start SOCKS (see scripts under tally/ or system tor)
curl -sS --max-time 15 --socks5-hostname 127.0.0.1:9050 https://api.ipify.org && echo
export AGENTROUTER_API_KEY=...
export AGENTROUTER_USE_TOR=1
# smoke: must return JSON choices[0].message.content
```

## Path C — Serverless / Serverpod Cloud without Tor

Deploy a Cloudflare Worker (or cool-IP host) that forwards to `https://agentrouter.org/v1/chat/completions` with stainless headers.
Set `TALLY_LLM_RELAY_URL` on the server. Prefer relay first; never leak key to Flutter/React clients.

## Headers

```
Authorization: Bearer <key>
Content-Type: application/json
Accept: application/json
User-Agent: QwenCode/0.2.0 (linux; x64)
x-stainless-lang: js
x-stainless-package-version: 6.34.0
x-stainless-os: Linux
x-stainless-arch: x64
x-stainless-runtime: node
x-stainless-runtime-version: node/20.0.0
x-stainless-retry-count: 0
```

## Minimal curl via Tor

```bash
curl -sS --socks5-hostname 127.0.0.1:9050 \
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
  -d '{"model":"deepseek-v4-flash","temperature":0.1,"messages":[{"role":"user","content":"ping"}]}'
```

Must return JSON. HTML = still WAF’d.

## Acceptance

- [ ] Tor Bootstrapped 100% / SOCKS works
- [ ] `curl --socks5-hostname` ipify returns an IP
- [ ] chat/completions returns JSON via Tor
- [ ] Server insight fails closed without key/relay
- [ ] Key never in frontend / git
