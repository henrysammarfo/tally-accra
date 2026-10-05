# TALLY / KEEPR build spec (binding)

## Product

Accra guest-house till: **deposit → lock night → today’s tally**, plus **offline queue → sync → live owner watch**, **Jev room/shift decisions**, and **future-call shift close**.

Judges decide the prize. We max every Partiful axis (see `KEEPR_SCORE_SPEC.md`).

## Dual-track

| Track | Path                         | Host            | Role                      |
| ----- | ---------------------------- | --------------- | ------------------------- |
| A     | `tally/` Serverpod + Flutter | Serverpod Cloud | Hackathon submission      |
| B     | `src/` React (Lovable)       | Vercel          | Marketing / brand / merch |

## Non-goals (scope creep kills)

No inventory, HR, barcode mega-retail, three half-services, fake Serverpod badges over localStorage, cloning Starguide/Pixorama product skins.

## Track A models (all tenant-scoped via `organizationId`)

- `Organization` — guest-house tenant
- `Membership` — authUser ↔ org, role owner|manager|receptionist
- `Room` — number, type, rateGhs, status
- `Deposit` — guest, phone, room, nights, amount, currency, method, receptionist, createdAt
- `NightLock` / room status update on deposit
- `ShiftClose` — end-of-day close
- `AuditEvent` — immutable append-only trail
- `SyncedMutation` — idempotent offline mutation ledger
- `OfflineDepositPayload` / `SyncOfflineResult` — sync DTOs
- `RoomRecommendation` / `ShiftJudgement` — Jev typed results
- `ShiftCloseJob` — future-call payload

## Track A endpoints (spine)

- `createDeposit` — validate → persist → lock room → audit → broadcast
- `assignNight` — lock/unlock room in org
- `listToday` / `watchToday` — today’s deposits + GHS total + occupancy (stream)
- `syncOfflineDeposits` — idempotent offline replay → MessageCentral broadcast
- `recommendRoom` — Jev `choice` among open rooms (fail closed)
- `judgeShift` — Jev `noul` shift health (fail closed)
- `scheduleShiftClose` — Serverpod future call auto-close
- Auth: `serverpod_auth_idp` (email)
- Org bootstrap for signed-in owner

## Security contracts

- No localStorage for till source-of-truth (offline queue is a pending sync buffer only)
- Multi-tenant: `organizationId` from membership, never trusted from client alone
- `requireLogin` on till endpoints
- Secrets in env / Serverpod Cloud passwords — never git
- LLM + Jev fail closed (no fake insight / probabilities)

## Track B contracts

- Brand, pitch, merch, CTA to live Track A URL
- No fake live till; strip localStorage operational state
- Honest “Built on Serverpod” copy only when linking to real app
