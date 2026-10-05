# TALLY — Extreme Win Bible (FINAL · Serverpod Hackathon)

> **Status:** FINAL uniqueness **2026-09-12** · [`UNIQUENESS_RELOCK_ALL_2026-09-12.md`](memory/research-raw/hackathons/UNIQUENESS_RELOCK_ALL_2026-09-12.md)  
> **Kickoff:** 15 Sep 2026 · **Submit:** 14 Oct 2026 · Winners 22 Oct Full Stack Flutter  
> **Rule:** One full-stack app · **Serverpod = backend** · Flutter/Dart  
> **Judging:** 30% works · 25% Serverpod · 25% craft · 20% useful

---

## Soft

TALLY is the till for an Accra guest-house — take a deposit, lock the night, see today’s total.

## Unique job (not mega-POS)

**Deposit → night → today’s tally** — one finished flow.

**≠** LinkedIn “Serverpod POS + inventory” default · barcode mega-retail · three half services.

**Organiser hero:** Serverpod endpoints + generated client + persistence (delete → score dies).

## 8-second

Take deposit → room night saved → today’s tally updates live.

## Pitch order

1. Works end-to-end · 2. Serverpod depth · 3. Craft of one flow · 4. Accra usefulness

## Architecture

```
Flutter → Serverpod client → createDeposit · listToday · assignNight → Postgres → Cloud deploy
```

## Mandatory spine

Serverpod models/endpoints · Flutter UI · Cloud deploy · persistence demo · Discord checkpoints.

## Honesty

Scope creep kills — no inventory/HR. Small and finished wins.

## Identity

Henry Sam Marfo · @henrysammarfo · github.com/henrysammarfo

## Dual-track note (2026-09-29)

- **Track A (submission):** Flutter + Serverpod 4 under `tally/` — only eligible hackathon entry.
- **Track B (marketing):** Lovable React under `src/` — brand/pitch/merch; must not fake Serverpod or till persistence.
- **Stage Bible:** pending upload — do not invent Stage Bible content.
