# Competitor analysis — Serverpod vs top Flutter backends (fact-checked)

> Verified 2026-10-01 via official Serverpod compare pages, Cloud pricing, Serverpod 4 blog, OpenRouter/Vercel Jev docs, Tavily.  
> **Rule:** no invented latency numbers. Where we lack a public head-to-head benchmark, we say so and use capability truth instead.

## Why this matters for the hackathon

Partiful awards **25%** to “use of the Serverpod stack — real work, not a static page.” Judges know Firebase/Supabase. KEEPR must make Serverpod’s *distinct* capabilities visible: typed generated client, MessageCentral streams, future calls, offline sync story, Dart+Jev on the server.

## Competitor set (relevant to Accra guest-house till)

| Competitor | Why it’s in the set |
| --- | --- |
| **Firebase** (Firestore + Auth + Functions) | Default Flutter BaaS; mature offline + listeners |
| **Supabase** | Postgres + Realtime + Auth; common Flutter choice |
| **Appwrite / PocketBase** | Open-source BaaS alternatives (Flutter SDKs community/official mixed) |
| **Custom Nest/FastAPI + Flutter** | DIY until typed client + sync become expensive |

Out of scope as direct till competitors: Amplify, Convex, InstantDB (different ecosystems), pure REST without realtime.

---

## Capability matrix (official Serverpod claims + verified sources)

Sources: [Serverpod vs Firebase](https://serverpod.dev/compare/serverpod-vs-firebase), [vs Supabase](https://serverpod.dev/compare/serverpod-vs-supabase), [Cloud pricing](https://serverpod.dev/cloud), [Serverpod 4 blog](https://serverpod.dev/blog/serverpod-4).

| Capability | Serverpod 4 | Firebase | Supabase | Who wins for **our** till |
| --- | --- | --- | --- | --- |
| End-to-end **Dart** type safety (compile-time client) | ✓ Generated client from endpoints | ✗ Manual models / TS-Python Functions | ✗ No official Dart codegen | **Serverpod** |
| Relational **Postgres** as first-class | ✓ YAML models + migrations | Firestore docs (SQL Connect separate) | ✓ Postgres (client-side queries + RLS) | **Serverpod / Supabase** (tie on DB; Serverpod wins on Flutter typing) |
| Typed realtime streams of **domain models** | ✓ `Stream<TodayTally>` over managed WS | ✓ Listeners (documents) | ✓ Postgres Changes / Broadcast | **Serverpod** for typed till board |
| Offline → sync with **same models** | ✓ SQLite + experimental offline sync (`database: sync`) | ✓ Firestore offline cache (mature, mobile default) | ✗ Needs PowerSync / third-party | Firebase **maturity**; Serverpod **story for this hackathon** |
| Scheduled server work without second service | ✓ Future calls (persist across restarts) | Cloud Functions + Scheduler | Edge / cron / pg_cron | **Serverpod** (one stack) |
| Auth | Email, social, passkeys, Firebase IdP | Mature Firebase Auth | Very strong (SAML/MFA/Web3) | Supabase/Firebase **breadth**; Serverpod **enough** + owns sessions |
| Self-host / no lock-in | ✓ Docker anywhere + Cloud | ✗ Hosted only | ✓ Self-host or Cloud | **Serverpod / Supabase** |
| Starter hosted price (published) | Cloud Starter **$5/mo capped** | Usage-metered Blaze | Free + Pro **$25/mo** + usage | **Serverpod** predictability |
| Published throughput (Cloud S podlet) | **5K req/min** basic calls, no DB (vendor-tested) | Not published as comparable single number | Not published as comparable | **Serverpod** only published like-for-like here — do **not** claim “faster than Firebase” without our own test |

### Honesty constraints (do not pitch these as wins)

1. **Firebase offline is more mature** today. Serverpod 4 offline sync is **experimental** (stable target 4.1 per blog). Our demo uses an honest **offline queue → `syncOfflineDeposits`** + live stream — not a fake claim of production CRDT parity.
2. **Starter Cloud disables future calls.** Demo `scheduleShiftClose` needs **Growth ($20)** or self-host. State this in the pitch.
3. **No public independent latency bake-off** (Serverpod vs Firebase vs Supabase) with reproducible methodology found on 2026-10-01. Do not invent p99 ms.
4. Third-party blogs (devtoolreviews “500 concurrent users…”) are **UNVERIFIED** for our pitch — exclude from Stage Bible unless we reproduce.

---

## Where Serverpod *can* beat them (true for KEEPR)

These are **capability / DX / architecture** wins judges can see in a live demo — not fake speed charts.

### 1. Delete the API layer (vs all REST/BaaS)

Endpoint → generated Flutter method. No OpenAPI drift. Judges watch `client.till.watchToday()` return `TodayTally` with deposits/rooms/totals — same models as Postgres.

### 2. Typed live board (vs document listeners / untyped rows)

Pixorama pattern: `postMessage` / `createStream`. Owner phone updates when desk syncs. Firebase can do live; Serverpod does it **with our domain types** and zero client parsing.

### 3. Offline honesty + sync idempotency (vs DIY Flutter+Supabase)

Supabase needs PowerSync (third-party) for offline. We ship `SyncedMutation` + `clientMutationId` idempotency in one Serverpod module — Accra MTN drop story.

### 4. Future-call shift close (vs Cloud Scheduler glue)

One Dart method, DB-persisted schedule, auto-close. Firebase/Supabase need Functions + cron wiring. **Requires Growth or self-host.**

### 5. Jev on the **same** Dart server (Starguide pattern)

Typed `choice` / `noul` — not “LLM prose then parse.” Competitors can call Jev too, but Serverpod’s Starguide showcase + our `recommendRoom`/`judgeShift` prove the stack hosts serious AI decisions in Dart.

### 6. Predictable Cloud starter economics

Official: Starter **$5 capped**; S podlet **5K req/min** (basic). Firebase Blaze meters reads/writes ($0.06 / $0.18 per 100k multi-region — Serverpod compare page). For a guest-house till, capped pricing is a clearer pitch than “maybe Blaze surprises.”

---

## Accra till scenario scorecard (product pressure)

| Job | Firebase | Supabase | **Serverpod KEEPR** |
| --- | --- | --- | --- |
| 8s deposit + lock room | Easy | Easy | Easy + typed |
| Owner live tally | Easy (listeners) | Easy (realtime) | Easy + `TodayTally` stream |
| Offline take deposit during outage | Strong (Firestore) | Weak without PowerSync | Demo queue → sync (**honest**) |
| End-of-shift auto-close | Functions + Scheduler | Cron / Edge | Future call (**Growth+**) |
| Room pick as typed AI decision | Separate service | Separate service | Jev in-process |
| Multi-tenant guest-houses | Rules / RLS | RLS | Membership + `requireLogin` |
| One language Flutter↔server | No | No | **Yes** |

**Verdict for judges:** Same usefulness as Firebase/Supabase till; **only Serverpod** makes the demo collapse if you delete the framework (generated client + streams + future calls + Dart Jev). That maximises the **25% stack** axis without lying about offline maturity.

---

## What we should measure ourselves (before claiming speed wins)

If we want **numeric** benchmarks later (optional, after keys + Cloud):

1. **p50/p95** `createDeposit` round-trip (Flutter web → Cloud) vs same flow on a Firebase Function+Firestore clone — same payload, same region if possible.
2. **Stream fan-out latency** desk deposit → owner `watchToday` event.
3. **Idempotent sync** 20 queued offline deposits — wall clock + duplicate rejection rate.
4. **Jev** `recommendRoom` latency vs AgentRouter generative “pick a room” (expect Jev faster — Starguide blog claims half answer time for search path; we must re-measure on our desk payload).

Until those run: pitch **architecture truth**, not invented ms.

---

## Pitch order (Stage Bible)

1. Works — offline → sync → lock → live tally  
2. Serverpod depth — streams, sync markers, future call, Jev  
3. Craft — Accra desk honesty  
4. Useful — flaky connectivity guest-house  
5. Optional slide: capability matrix above (cite serverpod.dev/compare/…)

## Sources

- https://serverpod.dev/compare/serverpod-vs-firebase  
- https://serverpod.dev/compare/serverpod-vs-supabase  
- https://serverpod.dev/cloud  
- https://serverpod.dev/blog/serverpod-4  
- https://docs.serverpod.dev/overview  
- https://openrouter.ai/docs/guides/community/jev-tutorial  
- https://vercel.com/changelog/ai-gateway-now-supports-typesafe-clients-and-http-api-for-jev  
- https://jevwiki.ai/wiki/entities/typesafe-console.md (signup closed 2026-09-24)
