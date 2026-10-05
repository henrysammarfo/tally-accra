---
name: tally-factcheck
description: Fact-check TALLY claims with Tavily search and TinyFish Fetch before writing memory docs or pitching stats. Use when verifying hackathon rules, dates, APIs, or Accra hospitality claims.
---

# TALLY fact-check

## Instructions

1. Prefer live tools over memory: Tavily `POST https://api.tavily.com/search`, TinyFish `POST https://api.fetch.tinyfish.ai` with `X-API-Key`.
2. TinyFish host is `api.fetch.tinyfish.ai` — not `api.tinyfish.ai`.
3. Write results into `docs/memory/CHALLENGE_FACTS.md` or `SESSION_LOG.md` with source URLs and Verified/UNVERIFIED.
4. Never invent SingStat/MAS/hackathon numbers.
5. Keys via env only (`TAVILY_API_KEY`, `TINYFISH_API_KEY`).
