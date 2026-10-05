# Free-plan lock (binding) — no paid upgrades

Henry: **no money for paid tiers.** Everything below is the free path only.

## Serverpod Cloud — FREE

| Item | Fact | Source |
| --- | --- | --- |
| Plan | **Starter** via **1-month free trial** | docs.serverpod.dev — “no credit card required” |
| After trial | Starter is $5/mo — leave idle / self-host / decide later | serverpod.dev/cloud |
| Future calls on Starter | **Disabled** | serverpod.dev/cloud Starter row |
| Our workaround | `scheduleShiftClose` defaults to **in-process free delay** (`free_delay`). Set `TALLY_USE_FUTURE_CALLS=1` only on Growth/self-host | `till_endpoint.dart` |
| What still works free | Auth, Postgres, streams, sync, Jev *when keyed*, Flutter web | — |

Deploy: `scloud launch` → pick **starter** → trial. Give agent `SERVERPOD_CLOUD_TOKEN`.

## Jev — NOT free on any public API (verified 2026-10-01)

| Channel | Free? | Evidence |
| --- | --- | --- |
| **Vercel AI Gateway free tier** | **No for Jev** | Free-tier models carry `free` tag + $0 price. `typesafe-ai/jev` is **$0.042/1M input**, Free Tier column empty on provider page. FAQ: non–free-tier models need **purchased** credits (`403` free-tier message). |
| **Vercel free monthly credit** | Does **not** cover Jev | Free credit applies only to free-tier model subset |
| **OpenRouter free models** | **No** | Jev not in `:free` set; needs account credits; 402 if empty |
| **TypeSafe direct** | Signup **closed** (2026-09-24); no published free API tier | jevwiki / TypeSafe |
| Expired promo | Vercel listed Jev free until **2026-09-25** — **ended** | third-party guides; treat as expired |

### Cost reality (still almost free)

OpenRouter example response: **~$0.00002** per decision (`usage.cost`). **$1** ≈ tens of thousands of room picks. That is the cheapest *real* Jev — not $0, but demo-cheap.

### What MCP could not do

- No `AI_GATEWAY_API_KEY` in this environment → cannot live-call Jev through Vercel MCP.
- Listing models via public `GET https://ai-gateway.vercel.sh/v1/models` confirms `typesafe-ai/jev` exists and is **priced**, not free.

### Honest options (pick one)

1. **Best demos:** put **$1** on OpenRouter → paste `OPENROUTER_API_KEY` (real Jev).  
2. **Stay $0:** keep Jev **fail-closed**; judges still see offline sync + streams + free delayed auto-close; desk insight can use existing **AgentRouter** key (generative, **not** Jev — never label it Jev).  
3. **Do not** fake Jev probabilities locally — violates fail-closed / honesty rules.

## AgentRouter (already free for us)

`AGENTROUTER_API_KEY` is set on this VM — use for `InsightEndpoint` only. **Not a substitute for Jev.**

## Pitch on free plan

“Runs on Serverpod Cloud Starter free trial. Offline sync + live `watchToday`. Auto-close uses free-plan delay because Starter disables FutureCalls. Jev wires live when a low-cost gateway key is present; fail closed otherwise.”
