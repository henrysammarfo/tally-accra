# Serverpod research — what they want (2026-10-01)

> Fact-checked via Tavily + TinyFish Fetch + cloned repos: `serverpod/pixorama`, `serverpod/starguide`, `serverpod/serverpod`.  
> Note: spoken “Singapore” in product discussion = **Serverpod**.

## What organisers are actually selling

From Partiful (word-for-word intent):

> Most vibe-coding tools live in a browser tab… trapped in an app builder.  
> **Serverpod is the other approach** — open-source full-stack you download: backend, database layer, generated client, deploy path. Built for Flutter/Dart and coding agents.

Judging that matters for “show Serverpod”:

| Weight | Criterion (Partiful) |
| --- | --- |
| 30% | Works — core flow completes, nothing critical faked |
| **25%** | **Use of the Serverpod stack — real work, not a static page** |
| 25% | Craft / technical creativity |
| 20% | Useful — clear user, clear problem |

So: a finished app where deleting Serverpod would kill the demo.

## What their own showcases prove (cloned + read)

### Pixorama (`github.com/serverpod/pixorama`)

- Hero: **streaming methods + MessageCentral** (`postMessage` / `createStream`)
- Endpoint ~80 lines: `setPixel` + `imageUpdates` stream (full snapshot then deltas)
- Purpose: prove realtime is trivial in Dart end-to-end — not Firebase glue

### Starguide (`github.com/serverpod/starguide`)

- Hero: **Postgres + pgvector**, ORM, **streaming** LLM answers (`Stream<String> ask`), cache, auth, admin, MCP endpoint
- Purpose: prove Serverpod hosts serious AI backends in Dart (not “Flutter + separate Python API”)

### Serverpod 4 release (blog, TinyFish full read)

Heroes they are pushing **this hackathon cycle**:

1. Full-stack hot reload + agentic MCP/skills  
2. **Client-side DB + experimental offline sync** (SQLite same models as Postgres)  
3. Streams, auth, future calls, Cloud deploy as one stack  

`serverpod_offline_sync`: CRDT merge, same CRUD API online/offline, relational integrity preserved — explicitly positioned as rare vs Firebase/Supabase-style offline.

## Why current TALLY is weak for “true colors”

TALLY as built is a **correct Accra till** but a **weak Serverpod showcase**:

- Core is CRUD + auth + optional stream of totals  
- Same product is easy on Firebase/Supabase/REST  
- Judges will not say “only Serverpod makes this elegant”  
- Does not stress-test: MessageCentral collaboration, offline CRDT, pgvector, future calls, or dual-device conflict

Useful ≠ innovative use of the stack. Partiful wants both (20% + 25%).

## Capability → product pressure test

| Serverpod capability | Demo that forces it | Commodity alternative |
| --- | --- | --- |
| Streams + MessageCentral | Multi-device live board | Socket.io bolted on |
| Offline sync / client DB | Sell/take deposit with no network, merge later | Custom sync hell |
| Shared YAML models | One model → SQLite + Postgres + Flutter | Duplicate DTOs |
| Future calls | Auto shift-close / SLA timers | Cron + another service |
| pgvector + streams | Domain RAG on-device/server | Separate AI microservice |
| Generated client | Delete OpenAPI entirely | Hand-written HTTP |

## Recommendation (primary pivot)

**Keep Accra usefulness. Change the Serverpod story.**

### Working name: **KEEPR** (or TALLY Sync)

**One user:** Accra guest-house / boutique stay **night manager** (and a second device: owner phone).

**One problem:** Power cuts + flaky MTN/Telecel — desk must keep taking deposits and locking rooms **offline**, then merge cleanly when the network returns, while the owner’s phone sees the board **live** when online.

**One finished flow (demo script):**

1. Airplane mode on desk phone → take deposit → lock room (local SQLite / client DB).  
2. Owner phone online → does **not** see it yet (honest).  
3. Desk reconnects → **offline sync** merges deposit + room lock to Postgres.  
4. Owner phone `watchBoard` stream updates **live** (Pixorama pattern).  
5. Future call at configured close time drafts shift close.

**Why this shows Serverpod’s “true colors”:**

- Offline sync is the **Serverpod 4 flagship** they want market proof for  
- Streams are Pixorama-class, not decorative  
- Same YAML models on client + server (their type-safety sales pitch)  
- Accra connectivity is a real usefulness story (field/offline apps in Africa are a known product category — Tavily hits on offline-first field teams)  
- Still small and finished — not mega-POS  

**Non-goals:** inventory mega-system, full accounting, barcode retail.

## Alternate ideas (if you reject hospitality)

1. **Kiosk Sync** — Accra corner-shop two attendants; last-item conflict via CRDT UI. Same Serverpod spine, different skin.  
2. **Field ticket** — plumber/electrician job cards offline + dispatcher live map stream. Broader SME, slightly larger scope.  
3. **Do not clone Starguide/Pixorama skins** — judges already have those demos; use their *patterns*, not their product.

## Explicit non-recommendation

- Pure Flutter UI marketing site pretending Serverpod  
- CRUD till with “Serverpod” badge only  
- Giant multi-module POS  

## Sources

- https://partiful.com/e/dRCiBZVI3Eb2NVtzmbBK  
- https://serverpod.dev/blog/serverpod-4  
- https://serverpod.dev/blog/pixorama  
- https://github.com/serverpod/pixorama (cloned)  
- https://github.com/serverpod/starguide (cloned)  
- https://docs.serverpod.dev/overview  
- https://docs.serverpod.dev/concepts/streams  
- https://pub.dev/packages/serverpod_offline_sync  
