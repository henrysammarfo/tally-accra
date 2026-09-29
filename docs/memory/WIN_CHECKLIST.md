# Win checklist (maps to Partiful judging)

## 30% Does it work

- [ ] Deposit → room night locked → today’s tally updates (live, persisted)
- [ ] Nothing critical faked (no localStorage spine, no mock endpoints)
- [ ] Demo URL live on Serverpod Cloud
- [ ] Auth required; anonymous till writes rejected

## 25% Serverpod stack

- [ ] Models + migrations in Postgres
- [ ] Generated client used from Flutter
- [ ] Endpoints: `createDeposit`, `assignNight`, `listToday`
- [ ] Streaming or live refresh of today’s tally
- [ ] Cloud deploy (`scloud`)

## 25% Craft

- [ ] One focused Accra guest-house flow, polished UI
- [ ] Audit trail + clear errors
- [ ] Multi-tenant isolation tested
- [ ] Marketing site honest (no fake Serverpod claims)

## 20% Usefulness

- [ ] Clear user: Accra guest-house receptionist / night manager
- [ ] Clear problem: 8-second deposit + night lock + day’s total
- [ ] Pitch order: works → Serverpod depth → craft → Accra usefulness

## Security (honest — not “unhackable”)

- [ ] Input validation on deposits
- [ ] Tenant isolation (org from membership)
- [ ] Secrets in env only
- [ ] LLM fail closed
- [ ] Sessions via Serverpod auth (not till localStorage)
