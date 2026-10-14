# TALLY demo video scripts

Judges only need the first **2 minutes**. Keep it calm and clear.

## Pitch video (≤2:00) — synced voiceover

| Time | On screen | Say this (slow, clear) |
| --- | --- | --- |
| 0:00–0:12 | Live URL / TALLY title | Hi — this is **TALLY**, a guest-house till for Accra. |
| 0:12–0:25 | Sign-in screen | Built with **Flutter** on the front and **Serverpod 4** on the back, live on Serverpod Cloud. |
| 0:25–0:45 | Bootstrap / rooms | Staff sign in, set up the property, and see rooms ready for the night. |
| 0:45–1:10 | Deposit form → submit | Take a deposit in a few seconds. The night locks on a room. |
| 1:10–1:30 | Today’s tally | Today’s tally updates from real Postgres — not a fake browser store. |
| 1:30–1:50 | Offline → Sync | If the desk drops offline, the deposit queues. Come back online, hit sync, and the owner’s live tally updates. |
| 1:50–2:00 | End card with links | Repo and live link are in the submission. Thanks. |

**End card text**

```
TALLY — Accra Guest-House Till
Live: https://tallyaccra.serverpod.space/
Repo: github.com/henrysammarfo/tally-accra
```

## Technical video (optional, ≤2:00)

| Time | Show | Say |
| --- | --- | --- |
| 0:00–0:20 | `tally/` folder | Submission is Flutter + Serverpod under `tally/`. |
| 0:20–0:45 | Cloud URL + config.json | Hosted on Serverpod Cloud. Flutter loads the live API URL from the server. |
| 0:45–1:15 | Endpoints / stream | `createDeposit`, `assignNight`, `listToday`, `watchToday`, `syncOfflineDeposits`. |
| 1:15–1:40 | Offline banner | Offline queue is real sync — not a mock ledger. |
| 1:40–2:00 | Jev fail-closed | Jev is optional and fails closed without a key. |

## Record tips

- Use https://tallyaccra.serverpod.space/ (already open in Chrome)
- 1280×720 or 1920×1080, mic close, no music over voice
- If sign-in needs email code, finish that **before** you hit record
- Upload unlisted YouTube / Loom / Drive and paste the link in BuilderBase
