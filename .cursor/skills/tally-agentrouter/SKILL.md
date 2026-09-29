---
name: tally-agentrouter
description: Configure AgentRouter for TALLY via agentrouter.org with Tor SOCKS or a clean-egress relay, stainless headers, and deepseek-v4-flash smoke tests. Use when LLM insight fails, WAF/captcha HTML appears, or setting AGENTROUTER_* env.
---

# TALLY AgentRouter

## Instructions

1. Read `docs/memory/AGENTROUTER_SETUP.md`.
2. Use `https://agentrouter.org/v1` — not `co.agentrouter.org` for this key pool.
3. On cloud VMs: install/start Tor; `AGENTROUTER_USE_TOR=1`; prove with `curl --socks5-hostname 127.0.0.1:9050 https://api.ipify.org`.
4. Smoke chat/completions with model `deepseek-v4-flash` and stainless headers until JSON returns.
5. HTML/aliyun_waf = egress problem — enable Tor or relay; do not assume bad key first.
6. Serverless / Serverpod Cloud without Tor: set `TALLY_LLM_RELAY_URL`.
7. Fail closed; never put keys in client code.

## Success

`choices[0].message.content` present in JSON response.
