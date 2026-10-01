# Session log

## 2026-09-29 — Dual-track plan execution

- Locked Track C: Flutter+Serverpod submission + React marketing.
- Fact-checked Partiful judging 30/25/25/20; dates 15 Sep–14 Oct 2026; winners 22 Oct.
- Confirmed AgentRouter direct cloud egress → Aliyun WAF; Tor/relay required; host `agentrouter.org`.
- TinyFish works at `api.fetch.tinyfish.ai`; Tavily new key works.
- Created memory docs, Cursor rules, skills.
- Scaffolded `tally/` Serverpod 4.0.3 fullstack; models + createDeposit/assignNight/listToday/watchToday; multi-tenant tests **4/4 passed**.
- Flutter desk UI: auth wrap, bootstrap, dashboard, deposit, rooms, ledger; `flutter analyze` clean.
- AgentRouter Tor smoke: **smoke_llm_tor_ok** (deepseek-v4-flash via socks5h://127.0.0.1:9050).
- `scloud auth login` blocked pending Henry credentials; see `tally/DEPLOY.md`.
- Track B: removed localStorage till; marketing gates + brand merch; CTAs via `VITE_TALLY_FLUTTER_WEB_URL`.
- Marketing `vite build` clean; Stage Bible still pending upload.

## 2026-10-01 — Serverpod “true colors” research

- Cloned + read `serverpod/pixorama`, `serverpod/starguide`; TinyFish/Tavily on Serverpod 4, streams, offline sync, Partiful.
- Verdict: TALLY CRUD till is useful but weak for 25% Serverpod-stack score.
- Recommended pivot: **KEEPR / TALLY Sync** — offline deposit+lock → CRDT sync → live owner stream + future-call shift close.
- Full write-up: `docs/memory/SERVERPOD_TRUE_COLORS_RESEARCH.md`.

## 2026-10-01 — KEEPR pivot shipped (max all axes; judges decide)

- Locked `docs/memory/KEEPR_SCORE_SPEC.md` — leave prize to judges, force yes on every axis.
- Server: `syncOfflineDeposits` (idempotent `SyncedMutation`), Jev `recommendRoom`/`judgeShift` via `jev_dart` 0.1.1, `ShiftCloseFutureCall` + `scheduleShiftClose`.
- Flutter: offline banner, queue, Sync, Jev pick room, judge shift, schedule auto-close.
- `jev_dart` pinned **0.1.1** (0.1.2+ pulls crimson/analyzer conflict with Flutter).
- Fail closed without `TYPESAFE_API_KEY` / `typesafeAPIKey`.
