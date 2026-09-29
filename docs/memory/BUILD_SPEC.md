# TALLY build spec (binding)

## Product

Accra guest-house till: **deposit → lock night → today’s tally**. One finished flow.

## Dual-track

| Track | Path                         | Host            | Role                      |
| ----- | ---------------------------- | --------------- | ------------------------- |
| A     | `tally/` Serverpod + Flutter | Serverpod Cloud | Hackathon submission      |
| B     | `src/` React (Lovable)       | Vercel          | Marketing / brand / merch |

## Non-goals (scope creep kills)

No inventory, HR, barcode mega-retail, three half-services, fake Serverpod badges over localStorage.

## Track A models (all tenant-scoped via `organizationId`)

- `Organization` — guest-house tenant
- `Membership` — authUser ↔ org, role owner|manager|receptionist
- `Room` — number, type, rateGhs, status
- `Deposit` — guest, phone, room, nights, amount, currency, method, receptionist, createdAt
- `NightLock` / room status update on deposit
- `ShiftClose` — optional end-of-day close
- `AuditEvent` — immutable append-only trail

## Track A endpoints (spine)

- `createDeposit` — validate → persist → lock room → audit → broadcast
- `assignNight` — lock/unlock room in org
- `listToday` — today’s deposits + GHS total + occupancy (stream)
- Auth: `serverpod_auth_idp` (email)
- Org bootstrap for signed-in owner

## Security contracts

- No localStorage for till/operational data
- Multi-tenant: `organizationId` from membership, never trusted from client alone
- `requireLogin` on till endpoints
- Secrets in env / Serverpod Cloud passwords — never git
- LLM fail closed (no fake insight text)

## Track B contracts

- Brand, pitch, merch, CTA to live Track A URL
- No fake live till; strip localStorage operational state
- Honest “Built on Serverpod” copy only when linking to real app
