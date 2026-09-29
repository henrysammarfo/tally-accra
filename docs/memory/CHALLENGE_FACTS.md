# Challenge facts (fact-checked live)

> Last verified: 2026-09-29 via Tavily + TinyFish Fetch + Partiful/BuilderBase/Serverpod sources.
> Rule: never invent stats, dates, or APIs. If unverified, mark **UNVERIFIED**.

## Event

| Fact         | Value                                         | Source                                       | Status   |
| ------------ | --------------------------------------------- | -------------------------------------------- | -------- |
| Name         | Build Something Real: The Serverpod Hackathon | Partiful, BuilderBase, serverpod.dev         | Verified |
| Kickoff      | 15 Sep 2026, 09:00 CEST                       | Partiful                                     | Verified |
| Submit       | 14 Oct 2026 (BuilderBase end 21:59 UTC)       | Partiful + BuilderBase schema                | Verified |
| Winners      | 22 Oct 2026, Full Stack Flutter conference    | Partiful                                     | Verified |
| Prizes       | $20,000 total (cash + Cloud credits)          | serverpod.dev / Partiful                     | Verified |
| Backend rule | Serverpod required                            | LinkedIn organisers + Partiful               | Verified |
| Client rule  | Flutter / Dart full-stack                     | Partiful (“Dart and Flutter under the hood”) | Verified |
| Scope advice | Small and finished > huge and broken          | Partiful                                     | Verified |
| AI coding    | Allowed; no penalty                           | Partiful                                     | Verified |

## Judging (Partiful — verified 2026-09-29)

| Weight | Criterion                                                        |
| ------ | ---------------------------------------------------------------- |
| 30%    | Does it work — runs, core flow completes, nothing critical faked |
| 25%    | Use of the Serverpod stack — real work, not a static page        |
| 25%    | Craft and technical creativity — rough OK, careless not          |
| 20%    | Usefulness — clear user, clear problem, this helps               |

AI first-pass checks eligibility only; humans score winners.

## Registration / venue

- Register on Partiful; BuilderBase invite within ~24h
- Discord: serverpod.dev/discord for mentors/checkpoints
- Solo or up to 4

## This repo status (2026-09-29)

- Lovable React + localStorage till = **marketing only**, not submission
- Submission lives in `tally/` (Flutter + Serverpod)
- Stage Bible: **not uploaded yet** — pending

## External tool endpoints (verified)

| Tool           | Working host                                  | Notes                                                                                 |
| -------------- | --------------------------------------------- | ------------------------------------------------------------------------------------- |
| TinyFish Fetch | `https://api.fetch.tinyfish.ai` + `X-API-Key` | `api.tinyfish.ai` DNS fails                                                           |
| Tavily         | `https://api.tavily.com/search`               | Prior key hit plan limit; new key worked                                              |
| AgentRouter    | `https://agentrouter.org/v1`                  | Direct cloud IP → Aliyun WAF HTML; use Tor or relay. Prefer over `co.agentrouter.org` |
