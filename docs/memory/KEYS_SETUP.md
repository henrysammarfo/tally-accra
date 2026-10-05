# How to get keys into this agent (Henry)

> Never paste live keys into git, PR bodies, or chat that will be committed.
> Prefer: Cursor Cloud secrets / this VM env / Serverpod Cloud passwords / a one-line paste in a private agent follow-up that we set into env then rotate after the hackathon.

## A. Jev (TypeSafe System One) — free status first

**Verified 2026-10-01: there is no $0 public API for Jev right now.**

- Vercel AI Gateway free-tier catalog = models with `free` tag / $0 price. `typesafe-ai/jev` is **$0.042/1M input** and is **not** free-tier (needs purchased Gateway credits; card verification for free credits does not unlock Jev).
- OpenRouter free models do **not** include Jev; empty balance → HTTP 402.
- TypeSafe console signup closed; no published free API tier.
- Cost of real Jev is tiny (~$0.00002/call on OpenRouter). See `docs/memory/FREE_PLAN.md`.

### Path A1 — OpenRouter (cheapest real Jev — not free)

1. Open https://openrouter.ai/settings/keys
2. Add ~$1 credits at https://openrouter.ai/credits (only if you can)
3. Create key `sk-or-…` → paste `OPENROUTER_API_KEY=…` to the agent
4. Model: `typesafe/jev-1.13`

### Path A2 — Vercel AI Gateway (also not free for Jev)

Needs **purchased** AI Gateway credits for `typesafe-ai/jev`. Free monthly credit does **not** cover it. Only use if you already have Gateway credits.

### Path A3 — Stay $0

Leave Jev fail-closed. Demo still wins on sync + streams + free delayed auto-close. Do **not** fake Jev.

### Path A4 — Direct TypeSafe (only if you already have console access)

1. https://console.typesafe.ai/keys
2. `TYPESAFE_API_KEY=…`

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

1. Sign up / log in: **https://console.serverpod.dev/**  
   New Starter trial (no card): https://console.serverpod.dev/project/create?planName=starter
2. On your laptop (browser login cannot run in this headless agent):

```bash
dart pub global activate serverpod_cloud_cli
scloud auth login          # browser opens — complete once
scloud auth create-token   # prints token ONCE — copy it
```

3. Paste to the agent (private follow-up):

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
