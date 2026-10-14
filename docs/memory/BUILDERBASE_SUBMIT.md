# BuilderBase submission paste (deadline 14 Oct 2026, 21:59 UTC)

Paste into BuilderBase **support chat (bottom right)** if the form glitches, and into the official submit fields.

## Team

| Field | Value |
| --- | --- |
| **Team name** | TALLY Accra *(or your Partiful team name if different)* |
| **Project name** | TALLY — Accra Guest-House Till |
| **Members** | Henry Sam Marfo *(add teammates if any)* |

## Required links

| Field | Value |
| --- | --- |
| **Code repository** | https://github.com/henrysammarfo/tally-accra |
| **Submission path** | `tally/` (Flutter + Serverpod 4). React `src/` is marketing only. |
| **Live Flutter till (web)** | https://tallyaccra.serverpod.space/ |
| **Live API** | https://tallyaccra.api.serverpod.space/ |
| **Insights** | https://tallyaccra.insights.serverpod.space/ |
| **Marketing site** | Vercel project `tally-accra` (CTA → Cloud till) |
| **Demo video** | Local narrated file: `docs/demo/TALLY-demo.mp4` — upload to YouTube/Loom/Drive and paste link |

## Project description (paste)

**TALLY** is a Flutter + Serverpod 4 night desk for Accra guest-houses: take a deposit in seconds, lock a room night, and show today’s tally — even when the desk briefly goes offline.

**Core flow:** sign in → bootstrap property → `createDeposit` → `assignNight` → `listToday` / live `watchToday` stream. Offline deposits queue on the desk and sync via `syncOfflineDeposits` when online. Shift auto-close uses a Starter-safe delayed close (`free_delay`; FutureCalls are disabled on Serverpod Cloud Starter). Optional TypeSafe Jev room/shift decisions fail closed without a key (honest — no fake scores).

**Built with:** Serverpod 4 auth + multi-tenant Postgres, generated Dart client, MessageCentral streams, Serverpod Cloud (`tallyaccra` Starter). Marketing React site is brand-only and does not fake the till.

**Repo:** https://github.com/henrysammarfo/tally-accra  
**Live demo:** https://tallyaccra.serverpod.space/

## Demo video script (≤2 min)

1. Open https://tallyaccra.serverpod.space/ — sign in / register  
2. Bootstrap guest-house (rooms 101–108)  
3. Take a deposit → lock a night → show today’s tally  
4. Toggle **Simulate offline** → queue a deposit → go online → **Sync** → tally updates  
5. (Optional) Schedule shift close — show delayed auto-close  
6. Say clearly: real Serverpod Cloud + Postgres; Jev fail-closed if no key  

## Support chat one-liner (if submit UI fails)

```
Hi BuilderBase — team TALLY Accra submitting for Build Something Real (Serverpod Hackathon).
Repo: https://github.com/henrysammarfo/tally-accra (submission in tally/)
Live Flutter+Serverpod: https://tallyaccra.serverpod.space/
API: https://tallyaccra.api.serverpod.space/
Demo video: [paste YouTube/Drive/Loom link once uploaded]
Project description: Accra guest-house till — deposit → lock night → today’s tally; offline sync + live watchToday on Serverpod Cloud.
Please confirm this is registered before 21:59 UTC 14 Oct 2026. Thanks!
```

## Checklist before you hit submit

- [ ] Partiful registered → BuilderBase access  
- [ ] Demo video uploaded (public or unlisted link)  
- [ ] Repo public (or grant read access if private)  
- [ ] Live till opens and core flow works  
- [ ] Description + links pasted  
- [ ] Support chat ping if the form errors  
