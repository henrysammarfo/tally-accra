# Secrets policy

1. **Never commit API keys, tokens, or passwords** to git (including chat-pasted keys).
2. Keys are rotated after the hackathon — treat every chat key as ephemeral.
3. Use environment variables / Serverpod Cloud password manager / Vercel server-only envs.
4. Never put secrets in `VITE_*`, client bundles, screenshots, or PR bodies.
5. Document **env names** in memory docs; never document live values.
6. On WAF/HTML from AgentRouter: treat as egress block, not necessarily bad key — use Tor or relay.
7. Fail closed: if LLM key missing or blocked, return a clear error — never invent answers.
