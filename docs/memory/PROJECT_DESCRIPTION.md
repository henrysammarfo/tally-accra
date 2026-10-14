# Project description (BuilderBase — paste this)

Copy everything below the line into the **Project description** field, then click **Save**.

---

## What TALLY is

**TALLY** is a guest-house till for Accra.

Night staff take a deposit, lock a room for the night, and see today’s total in Ghana Cedis. That is the whole job. No inventory. No mega POS. Just the desk flow that has to work when the internet is flaky.

**Live till:** https://tallyaccra.serverpod.space/  
**Code:** https://github.com/henrysammarfo/tally-accra (folder `tally/`)

## What you can do

1. Sign in
2. Set up your guest-house (rooms 101–108)
3. Take a deposit
4. Lock a room night
5. Watch today’s tally update live
6. If the desk goes offline, queue the deposit and sync when you are back online

## How we use Flutter

The desk UI is a **Flutter** app. Receptionists use it on the phone or in the browser. The app talks to the server with Serverpod’s **generated Dart client** — we do not hand-roll till HTTP.

Offline mode keeps pending deposits on the desk, then calls `syncOfflineDeposits` when the network returns.

## How we use Serverpod

The backend is **Serverpod 4** on **Serverpod Cloud** (`tallyaccra`).

- Auth so only signed-in staff write deposits
- Postgres for orgs, rooms, deposits, and audit trail
- Endpoints: `createDeposit`, `assignNight`, `listToday`, `syncOfflineDeposits`
- Live stream: `watchToday` so the owner’s phone updates without refresh
- Delayed shift close that works on the free Starter plan
- Optional Jev room tips — if there is no API key, we fail closed (we never fake scores)

Marketing site (React) is brand only. The real till is Flutter + Serverpod.

## Honesty

Nothing critical is faked. No localStorage till. Missing AI keys show a clear error. We do not claim the system is unhackable.

---
