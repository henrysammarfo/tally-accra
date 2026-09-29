# Tools stack (TALLY)

## Hosting (locked)

| Surface                       | Host                                                | Notes                                    |
| ----------------------------- | --------------------------------------------------- | ---------------------------------------- |
| Track A backend + Flutter web | Serverpod Cloud (`scloud launch` / `scloud deploy`) | Primary for hackathon                    |
| Track B marketing             | Vercel via Lovable                                  | Do not bind to VIGIL `cyber-ronin-nexus` |
| GCP                           | Backup only if Serverpod Cloud blocked              | Not Railway                              |

## LLM

| Item          | Value                                                      |
| ------------- | ---------------------------------------------------------- |
| Gateway       | AgentRouter `https://agentrouter.org/v1`                   |
| Model default | `deepseek-v4-flash`                                        |
| Cloud egress  | Tor SOCKS `socks5h://127.0.0.1:9050` or clean-egress relay |
| Headers       | Stainless / QwenCode-style (see AGENTROUTER_SETUP.md)      |
| OpenAI direct | Not used (no OpenAI key)                                   |

## Fact-check

| Tool     | Endpoint                                                |
| -------- | ------------------------------------------------------- |
| Tavily   | `POST https://api.tavily.com/search`                    |
| TinyFish | `POST https://api.fetch.tinyfish.ai` header `X-API-Key` |

## Env names (values never in git)

```
AGENTROUTER_API_KEY
AGENTROUTER_BASE_URL=https://agentrouter.org/v1
AGENTROUTER_USE_TOR=1
AGENTROUTER_TOR_SOCKS=socks5h://127.0.0.1:9050
TALLY_LLM_MODEL=deepseek-v4-flash
TALLY_LLM_RELAY_URL   # optional CF Worker
TALLY_LLM_RELAY_KEY
TINYFISH_API_KEY
TAVILY_API_KEY
TALLY_FLUTTER_WEB_URL # public Track A URL for marketing CTAs
```
