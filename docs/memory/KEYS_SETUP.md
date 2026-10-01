# How to get keys into this agent (Henry)

> Never paste live keys into git, PR bodies, or chat that will be committed.
> Prefer: Cursor Cloud secrets / this VM env / Serverpod Cloud passwords / a one-line paste in a private agent follow-up that we set into env then rotate after the hackathon.

## A. Jev (TypeSafe System One) — pick ONE path

TypeSafe **direct console signup is closed** as of 2026-09-24 (TypeSafe on X / jevwiki). Existing TypeSafe accounts can still mint keys. Everyone else uses a gateway.

### Path A1 — OpenRouter (recommended if no TypeSafe account)

1. Open https://openrouter.ai/settings/keys
2. Create an API key (`sk-or-…`)
3. Optional: confirm model https://openrouter.ai/typesafe (use `typesafe/jev-1.13`)
4. Give the agent **one** of:
   - Follow-up message: `OPENROUTER_API_KEY=sk-or-…` (we export in the VM + `scloud password set`)
   - Or set yourself:

```bash
export OPENROUTER_API_KEY=sk-or-...
# optional pin:
export TYPESAFE_BASE_URL=https://openrouter.ai/api
export TYPESAFE_DEFAULT_MODEL=typesafe/jev-1.13
```

Smoke (from docs — Decisions API):

```bash
curl https://openrouter.ai/api/alpha/decisions \
  -H "Authorization: Bearer $OPENROUTER_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"model":"typesafe/jev-1.13","state":{"ticket":"Room 103 walk-in, 1 night cash"},"questions":{"ok":{"type":"noul","instructions":"Is this a valid guest-house desk event?"}}}'
```

Billing: OpenRouter bills Jev on **input tokens**; output free. Cost appears in `usage.cost` on each response.

### Path A2 — Vercel AI Gateway (you already have Vercel)

1. Vercel dashboard → AI Gateway → create / copy `AI_GATEWAY_API_KEY`
2. Docs: https://vercel.com/changelog/ai-gateway-now-supports-typesafe-clients-and-http-api-for-jev
3. Give the agent: `AI_GATEWAY_API_KEY=…`

```bash
export AI_GATEWAY_API_KEY=...
export TYPESAFE_BASE_URL=https://ai-gateway.vercel.sh/typesafe
# model default in our server: typesafe-ai/jev
```

### Path A3 — Direct TypeSafe (only if you already have console access)

1. https://console.typesafe.ai → log in (Google or email code)
2. Keys: https://console.typesafe.ai/keys
3. Give the agent: `TYPESAFE_API_KEY=…` (or `JEV_API_KEY=…`)
4. Default host: `https://api.typesafe.ai` · model `jev-latest`

### What our server accepts (order)

See `tally/tally_server/lib/src/till/jev_service.dart`:

1. Serverpod password `typesafeAPIKey`
2. `TYPESAFE_API_KEY` / `JEV_API_KEY`
3. `OPENROUTER_API_KEY` (+ OpenRouter base)
4. `AI_GATEWAY_API_KEY` (+ Vercel TypeSafe base)

Also password aliases: `openRouterAPIKey`, `aiGatewayAPIKey`, `typesafeBaseUrl`.

---

## B. Serverpod Cloud (`scloud`) — deploy Track A

Browser login does **not** work inside this headless agent. You must either log in on your laptop and create a **personal access token**, or run deploy locally.

### Option B1 — Token for the agent (preferred)

1. Create Cloud account: https://console.serverpod.cloud (or “Sign up for Cloud” from docs.serverpod.dev/cloud)
2. On your machine:

```bash
dart pub global activate serverpod_cloud_cli
scloud auth login          # browser opens — complete once
scloud auth create-token   # prints token ONCE — copy it
```

3. Give the agent (private follow-up):

```
SERVERPOD_CLOUD_TOKEN=<paste token once>
```

4. Agent will:

```bash
export SERVERPOD_CLOUD_TOKEN=...
cd tally/tally_flutter && flutter build web --base-href / --output ../tally_server/web/app
cd ../tally_server
scloud launch   # first time
# later: scloud deploy
scloud password set typesafeAPIKey   # or openRouterAPIKey / AGENTROUTER_API_KEY
```

Docs: https://docs.serverpod.dev/cloud/concepts/personal-access-tokens  
Auth CLI: https://docs.serverpod.dev/cloud/reference/cli/commands/auth

### Option B2 — You deploy locally

Follow `tally/DEPLOY.md`. After deploy, paste the public Flutter URL as:

```
TALLY_FLUTTER_WEB_URL=https://….serverpod.space
VITE_TALLY_FLUTTER_WEB_URL=…   # marketing CTA
```

### Cloud plan note (pricing page, verified)

- **Starter $5/mo** — capped; **future calls disabled** on Starter
- **Growth $20/mo** — future calls available; autoscaling
- S podlet published max ≈ **5K req/min** (basic calls, no DB) — see serverpod.dev/cloud

**Implication for KEEPR demo:** `scheduleShiftClose` needs Growth (or self-host), not Starter. Live streams / sync / Jev work on Starter.

---

## C. Already present on this VM (do not re-send unless rotated)

| Env | Status |
| --- | --- |
| `AGENTROUTER_API_KEY` | set |
| `TAVILY_API_KEY` | set |
| `TINYFISH_API_KEY` | set |
| `TYPESAFE_API_KEY` / `JEV_API_KEY` / `OPENROUTER_API_KEY` / `AI_GATEWAY_API_KEY` | **missing** |
| `SERVERPOD_CLOUD_TOKEN` | **missing** |

---

## D. Minimum paste checklist for next agent turn

Send **only** what you have (one line each):

```
OPENROUTER_API_KEY=sk-or-...
SERVERPOD_CLOUD_TOKEN=...
```

Optional if using Vercel gateway instead of OpenRouter:

```
AI_GATEWAY_API_KEY=...
```

Optional AgentRouter relay if Cloud has no Tor:

```
TALLY_LLM_RELAY_URL=https://…/v1
TALLY_LLM_RELAY_KEY=...
```
