# How TALLY hits every judging weight

| Criterion | Weight | Our proof in the live demo |
| --- | --- | --- |
| **Does it work** | 30% | Sign in → bootstrap → `createDeposit` → room locked → Desk tally up. Offline queue → Sync → tally updates. Nothing faked. |
| **Serverpod stack** | 25% | Serverpod 4 + generated client + Postgres + auth + `watchToday` stream + `syncOfflineDeposits` + Cloud `tallyaccra`. Not a static page. |
| **Craft** | 25% | One Accra night-desk flow. Offline banner. Honest Jev fail-closed. Starter-safe delayed auto-close. |
| **Usefulness** | 20% | User = Accra receptionist / night manager. Problem = flaky net + need today’s total. App does that job. |

Live: https://tallyaccra.serverpod.space/  
Repo: https://github.com/henrysammarfo/tally-accra (`tally/`)  
Record script: [`docs/DEMO_RECORDING_SCRIPT.md`](../DEMO_RECORDING_SCRIPT.md)
