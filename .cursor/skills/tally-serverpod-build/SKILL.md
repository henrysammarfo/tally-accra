---
name: tally-serverpod-build
description: Build and ship the TALLY Flutter+Serverpod spine (createDeposit, assignNight, listToday), multi-tenant auth, tests, and Serverpod Cloud deploy. Use when working under tally/, scaffolding Serverpod, or preparing the hackathon submission.
---

# TALLY Serverpod build

## Instructions

1. Read `docs/memory/BUILD_SPEC.md` and `docs/memory/TALLY_BIBLE.md`.
2. Work only under `tally/` for the submission product.
3. Keep the unique job: deposit → lock night → today’s tally.
4. After model edits: generate + migrate; run `dart test` with tenant isolation cases.
5. Flutter UI must call the generated client — no fake local stores.
6. Deploy with `scloud launch` / `scloud deploy`; record URL in `docs/memory/SESSION_LOG.md`.
7. Never commit secrets.

## Spine checklist

- [x] Organization + Membership
- [x] createDeposit / assignNight / listToday / watchToday
- [x] Streaming live tally (MessageCentral)
- [x] Offline queue → syncOfflineDeposits (idempotent)
- [x] Jev recommendRoom (choice) + judgeShift (noul) — fail closed
- [x] Future call scheduleShiftClose
- [x] Audit events
- [x] Auth required

## KEEPR notes

Read `docs/memory/KEEPR_SCORE_SPEC.md`. Pin `jev_dart: 0.1.1` (newer crimson breaks Flutter analyzer pin).
