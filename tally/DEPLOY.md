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

- Use **Starter free trial** (1 month, no card) — locked free plan. See `docs/memory/FREE_PLAN.md`.
- Starter **disables FutureCalls** → `scheduleShiftClose` uses in-process `free_delay` by default.
- **Jev is not free** on Vercel AI Gateway free tier or OpenRouter free models. Need ~$1 OpenRouter credit for live Jev, or leave fail-closed.

## Keys for this agent

Minimum for deploy:

```
SERVERPOD_CLOUD_TOKEN=...
```

Optional for **real** Jev (~$0.00002/call — not free, but cheapest):

```
OPENROUTER_API_KEY=sk-or-...
```

## Agent status (2026-10-03)

- Local spine + Flutter UI + KEEPR sync/Jev/free-delay close: done
- `scloud deploy` to **tallyaccra** (Starter trial → 2026-11-01): **live**
  - Web: https://tallyaccra.serverpod.space/
  - API: https://tallyaccra.api.serverpod.space/
  - Insights: https://tallyaccra.insights.serverpod.space/
- Jev live: fail-closed until OpenRouter key
- AgentRouter Tor smoke on earlier VM: passed (`smoke_llm_tor_ok`)
- CF Worker relay source: `tally/scripts/llm-relay-worker.js` (deploy when Cloud has no Tor)
