# Serverpod Cloud deploy (Track A)

## Prerequisites (operator)

1. Serverpod Cloud account + CLI: `dart pub global activate serverpod_cloud_cli`
2. Login: `scloud auth login` (interactive — blocked in this agent run without your credentials)
3. From `tally/`:

```bash
cd tally_flutter && flutter build web --base-href / --output ../tally_server/web/app
cd ../tally_server
scloud launch   # first time
# later:
scloud deploy
scloud password set AGENTROUTER_API_KEY
# optional if no Tor on Cloud:
scloud password set TALLY_LLM_RELAY_URL
```

4. Set marketing env `TALLY_FLUTTER_WEB_URL` to the public Cloud URL.
5. Discord checkpoints: register on Partiful → BuilderBase.

## Plan constraint (verified serverpod.dev/cloud)

- **Starter ($5):** future calls **disabled** — sync/streams/Jev OK; `scheduleShiftClose` needs **Growth ($20)** or self-host.
- S podlet published max ≈ 5K req/min (basic calls, no DB).

## Keys for this agent

Paste into a private follow-up (see `docs/memory/KEYS_SETUP.md`):

```
OPENROUTER_API_KEY=sk-or-...
SERVERPOD_CLOUD_TOKEN=...
```

## Agent status (2026-10-01)

- Local spine + Flutter UI + KEEPR sync/Jev/future-call: done
- `scloud launch`: **blocked pending Henry's Cloud login / token**
- Jev live: **blocked pending OpenRouter or TypeSafe or AI Gateway key**
- AgentRouter Tor smoke on this VM: **passed** (`smoke_llm_tor_ok`)
- CF Worker relay source: `tally/scripts/llm-relay-worker.js` (deploy when Cloud has no Tor)
