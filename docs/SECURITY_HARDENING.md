# Security hardening (honest)

**Do not claim unhackable.** Residual risk always remains. This maps a common “vibe-coded leak” checklist to TALLY’s real stack (Flutter + Serverpod + Vercel marketing — not Supabase).

| Prompt item | TALLY mapping | Status |
|-------------|---------------|--------|
| Move API keys to env | Server secrets via env / Serverpod Cloud passwords; marketing only public URLs in `VITE_*` | Done / ongoing |
| Rotate keys pushed to GitHub | Rotate any key that ever appeared in chat or history; GG tip scrubbed; no history rewrite (Lovable) | Operator action |
| Add `.env` to `.gitignore` | Root `.gitignore` ignores `.env` / `.env.*` (keeps `.env.example`) | Done |
| Turn on RLS in Supabase | N/A — Postgres via Serverpod; **tenant isolation** = `organizationId` from membership on every till row | Done in till endpoints |
| Never trust the client | Validate amounts, phones, rooms, payment methods server-side | Done |
| Auth on every API route | Till / org / insight endpoints `requireLogin => true` | Done |
| Rate-limit login/signup | Serverpod Email IdP built-in attempt limits; document Cloud monitoring | Documented |
| Hash passwords | Serverpod auth stores hashed credentials — never raw | Framework |
| HTTPS everywhere | Vercel + Serverpod Cloud TLS; HSTS on marketing | Done |
| CORS to my domain only | Configure `allowedOrigins` + cookie auth for production web clients when enabling cookies | Documented in yaml comments |
| Sanitize SQL injection | Serverpod ORM / parameterized queries — no string-concat SQL in till code | Done |
| Escape output / XSS | React escapes by default; TanStack Start bumped past XSS advisory | Done |
| CSRF on forms | Marketing merch is client-only interest list; Serverpod auth sessions for till | Partial / honest |
| Lock down file uploads | No user file upload endpoints in till spine | N/A |
| Hide stack traces in prod | Marketing error UI shows no stack; server logs stay server-side | Done |
| Secure httpOnly cookies | Enable `authCookie` + HTTPS when using cookie auth in Cloud | Documented |
| Update outdated packages | Keep TanStack / deps current; run `npm outdated` / `dart pub outdated` before demos | Ongoing |
| Log failed logins | Rely on Serverpod auth logging; review Cloud logs after abuse | Documented |
| Daily DB backup | Starter trial: use Cloud plan backups / export before production money | Operator / plan |
| AI API spending cap | OpenRouter / AgentRouter billing caps in provider dashboards; Jev fail-closed without key | Operator |
| “Make it unhackable” | **Rejected** — honest residual risk only | Policy |

## Residual risks

- Multi-tenant bugs if a future endpoint skips membership scoping.
- Starter Cloud availability / backup SLAs are plan-limited.
- Marketing merch bag is in-memory only — not a payment system; do not treat as PCI scope.
- Keys pasted into chat must be rotated even if not in the latest commit.

See also: `docs/memory/SECRETS_POLICY.md`, `tally/DEPLOY.md`.
