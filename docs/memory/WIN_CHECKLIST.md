# Win checklist (maps to Partiful judging)

## 30% Does it work

- [x] Deposit → room night locked → today’s tally updates (live, persisted)
- [x] Offline queue → `syncOfflineDeposits` → owner `watchToday` updates
- [x] Nothing critical faked (no localStorage spine, no mock endpoints)
- [x] Demo URL live on Serverpod Cloud (`tallyaccra`)
- [x] Auth required; anonymous till writes rejected
- [x] Jev fail closed without key; live when OpenRouter/TypeSafe key set

## 25% Serverpod stack

- [x] Models + migrations in Postgres
- [x] Generated client used from Flutter
- [x] Endpoints: `createDeposit`, `assignNight`, `listToday`, `syncOfflineDeposits`
- [x] Streaming `watchToday` (MessageCentral)
- [x] Future call `scheduleShiftClose` → Starter uses honest `free_delay` (FutureCalls off on Starter)
- [x] Jev on server (`recommendRoom` choice, `judgeShift` noul) — fail-closed without key
- [x] Cloud deploy (`scloud` → tallyaccra)

## 25% Craft

- [x] One focused Accra guest-house flow, polished Flutter desk (offline banner + sync)
- [x] Audit trail + clear errors
- [x] Multi-tenant isolation tested
- [x] Marketing site honest (no fake Serverpod claims)

## 20% Usefulness

- [x] Clear user: Accra guest-house receptionist / night manager (+ owner phone)
- [x] Clear problem: flaky connectivity + 8-second deposit + night lock + day’s total
- [x] Pitch order: works → Serverpod depth (sync/streams/future/Jev) → craft → Accra usefulness

## Security (honest — not “unhackable”)

- [x] Input validation on deposits
- [x] Tenant isolation (org from membership)
- [x] Secrets in env only
- [x] LLM + Jev fail closed
- [x] Sessions via Serverpod auth (not till localStorage)
