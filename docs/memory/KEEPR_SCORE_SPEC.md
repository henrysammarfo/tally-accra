# KEEPR / TALLY Sync — max-score build (binding)

Judges decide the prize. We build so every Partiful axis is demonstrably hit.

| Axis | Weight | How we force a yes |
| --- | --- | --- |
| Works | 30% | Offline deposit → sync → lock night → live owner tally; nothing faked |
| Serverpod stack | 25% | Generated client, Postgres, streams (MessageCentral), future calls, auth, **Jev on server** (typed decisions like Starguide) |
| Craft | 25% | One Accra night-desk flow, polished Flutter, sync/offline honesty |
| Useful | 20% | Flaky Accra connectivity + real guest-house till job |

## Spine (must all be live)

1. `createDeposit` / `assignNight` / `listToday` / `watchToday` (existing)
2. **Offline queue** on Flutter → `syncOfflineDeposits` when back online
3. **Jev** `recommendRoom` (choice among open rooms) + `judgeShift` (noul: is shift healthy?)
4. **Future call** `scheduleShiftClose` → auto-close draft
5. Multi-tenant auth (existing)

## Jev (TypeSafe System One)

- Package: `jev_dart`
- Password/env: `typesafeAPIKey` / `TYPESAFE_API_KEY` / `JEV_API_KEY`
- Fail closed if missing — no fake scores
- Pattern mirrors Starguide: typed `choice` / `noul`, software branches on probabilities

## Demo script (judges)

1. Sign in → bootstrap guest-house  
2. Airplane / Offline mode → take deposit (queued)  
3. Owner online does not see it yet  
4. Go online → Sync → room locks + tally updates on `watchToday`  
5. Tap “Jev pick room” → typed recommendation with probability  
6. Schedule shift close → future call fires  

## Non-goals

Mega-POS, inventory, HR, cloning Starguide/Pixorama product skins.
