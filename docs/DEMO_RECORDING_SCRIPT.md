# TALLY — record this for judges (≤2 minutes)

Open this URL in **Chrome** (not the IDE browser):  
**https://tallyaccra.serverpod.space/**

Record screen + mic. Speak the **SAY** lines slowly. Do the **CLICK** / **TYPE** lines exactly.

Before you hit record: finish email sign-up once so you land on the desk.

---

## Before record (30–60 sec, off camera)

1. Open https://tallyaccra.serverpod.space/
2. Wait until you see the Serverpod **Sign in** / **Create account** UI (not a black screen).
3. **Create account** with your real email → enter the code from email → set password → sign in.
4. If you see **Open your guest-house till**:
   - Leave name: `Osu Heritage Suites` (or type your own)
   - Leave slug: `osu-heritage` (must be unique — if “slug taken”, change to `osu-heritage-2`)
   - Desk name: `Akosua` (or your name)
   - Click the create / open button
5. You should see the **Desk** tab with today’s totals.
6. **Now start recording.**

---

## Minute-by-minute (say + click)

### 0:00–0:12 — Hook

**SHOW:** Full Chrome window with the TALLY desk (Desk tab).

**SAY:**  
“Hi. This is TALLY — a guest-house till for Accra. One job: take a deposit, lock the night, see today’s tally.”

---

### 0:12–0:25 — Stack (Serverpod score)

**SHOW:** Stay on Desk. Point cursor at the gold guest-house name in the top bar.

**SAY:**  
“It runs on Flutter with a Serverpod four backend — real Postgres, generated client, live on Serverpod Cloud.”

---

### 0:25–0:55 — Online deposit (Works 30%)

**CLICK:** Bottom nav → **Deposit**

**TYPE:**
| Field | Value |
| --- | --- |
| Guest full name | `Ama Mensah` |
| Phone | `+233241234567` |
| Room | Pick first open room, e.g. `101` |
| Nights | `1` |
| Deposit amount | `500` |
| Payment | leave `mtnMomo` |
| Currency | leave `GHS` |

**CLICK:** **Lock night & print receipt**

**SAY (while it saves):**  
“Name, room, money — lock. That write hits Serverpod and Postgres. Not a browser fake.”

**SHOW:** Green receipt text `Locked. Receipt …`

---

### 0:55–1:10 — Live tally (Serverpod streams)

**CLICK:** Bottom nav → **Desk**

**SHOW:** Today’s total / deposit count went up.

**SAY:**  
“Desk updates from listToday and the live watchToday stream — the owner sees the same numbers without refresh.”

Optional: **CLICK** **Ledger** once, scroll once, then back to **Desk**.

---

### 1:10–1:40 — Offline sync (Works + Craft)

**CLICK (Desk):** **Simulate offline**  
→ Title becomes `TALLY · OFFLINE`, orange/brown banner.

**CLICK:** Bottom nav → **Deposit**

**TYPE:**
| Field | Value |
| --- | --- |
| Guest full name | `Kojo Boateng` |
| Phone | `+233201112233` |
| Room | Next open room, e.g. `102` |
| Amount | `350` |

**CLICK:** **Queue offline deposit**  
→ See `QUEUED offline · room …`

**SAY:**  
“Desk drops offline. Deposit queues on the phone — owner does not see it yet.”

**CLICK:** Bottom nav → **Desk**  
**CLICK:** **Go online** (same button, now says Go online)  
**CLICK:** **Sync queue (1)** or banner **Sync now**

**SAY:**  
“Back online — syncOfflineDeposits pushes the queue. Room locks. Tally updates for real.”

**SHOW:** Banner like `Synced 1 deposit(s)…` and tally up.

---

### 1:40–1:55 — Extra Serverpod craft (optional if time)

Still on **Desk**, online:

**CLICK:** **Schedule auto-close**  
**SAY:**  
“Starter Cloud has no FutureCalls, so we use an honest delayed auto-close — still scheduled from the desk.”

If you see an error on **Jev judge shift** / **Jev pick**:  
**SAY once:**  
“Jev is optional and fail-closed without a key — we never invent scores.”  
Do **not** hide the error; honesty scores craft.

---

### 1:55–2:00 — Close

**SHOW:** Desk with totals.

**SAY:**  
“TALLY — Accra till on Flutter and Serverpod. Live link and GitHub are in the submission. Thanks.”

End card (type in notepad if you want a freeze frame):

```
TALLY — Accra Guest-House Till
https://tallyaccra.serverpod.space/
github.com/henrysammarfo/tally-accra
```

---

## Exact button names (so you don’t hunt)

| Where | Label |
| --- | --- |
| Bottom nav | `Desk` · `Deposit` · `Rooms` · `Ledger` |
| Desk | `Simulate offline` / `Go online` |
| Desk | `Sync queue (N)` |
| Desk | `Jev judge shift` |
| Desk | `Schedule auto-close` |
| Deposit | `Jev pick` |
| Deposit (online) | `Lock night & print receipt` |
| Deposit (offline) | `Queue offline deposit` |
| Banner | `Sync now` |
| App bar | logout icon |

---

## If something breaks while recording

| Problem | Fix |
| --- | --- |
| Black screen | Hard refresh; wait 10s; use Chrome |
| Email code | Pause record; check inbox/spam; resume |
| Slug taken | Change slug to `osu-heritage-henry` |
| Phone invalid | Must look like `+233` + digits |
| No open rooms | Use Rooms tab or new account / new night |
| Jev error | Leave it — say fail-closed; keep going |

---

## How this hits every score

| Criterion | Weight | What this demo proves |
| --- | --- | --- |
| Does it work | 30% | Deposit → lock → tally; offline queue → sync |
| Serverpod stack | 25% | Auth, Postgres, generated client, streams, sync, Cloud host |
| Craft | 25% | One Accra flow, offline banner, honest Jev fail-closed |
| Usefulness | 20% | Clear user (night desk) + problem (flaky net + day’s total) |

---

## Upload

1. Save video ≤2 min  
2. Upload YouTube **Unlisted** or Loom  
3. Paste link in BuilderBase **and** support chat **before 21:59 UTC**
