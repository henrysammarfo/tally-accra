# Website launch checklist (marketing site)

Status as of 14 Oct 2026. Track B = React marketing on Vercel. Track A till = Serverpod Cloud.

| # | Task | Status | Notes |
|---|------|--------|-------|
| 1 | Privacy policy | Done | `/privacy` |
| 2 | Terms & conditions | Done | `/terms` |
| 3 | Remove frontend secrets | Done | Only public `VITE_TALLY_FLUTTER_WEB_URL` + optional `VITE_PLAUSIBLE_DOMAIN`; `.env` gitignored |
| 4 | Enforce HTTPS | Done | Vercel HTTPS + `Strict-Transport-Security` header in `vercel.json` |
| 5 | Cookie consent banner | Done | Essential / Accept analytics |
| 6 | Meta titles/descriptions | Done | Per-route `head` meta |
| 7 | Social preview image | Done | `/og-image.svg` |
| 8 | Favicon | Done | `/favicon.ico` |
| 9 | Sitemap and robots.txt | Done | `public/sitemap.xml`, `public/robots.txt` |
| 10 | Image alt text | Done | Merch product alts descriptive |
| 11 | Image compression | Done | Lazy + dimensions; SVG OG; JPEG assets already compressed |
| 12 | Page load speed check | Done | Fonts `display=swap`; lazy images; single primary CTA |
| 13 | Color contrast fixes | Done | Darker `--muted-foreground` for WCAG AA body text |
| 14 | Mobile responsiveness | Done | Sticky header + mobile nav; fluid hero |
| 15 | Custom 404 page | Done | Brand 404 + Open till CTA |
| 16 | Broken link fixes | Done | Footer legal links; live till external |
| 17 | Form validation | Done | Merch name/phone/lines + honeypot |
| 18 | Spam protection | Done | Honeypot field on merch interest form |
| 19 | Analytics setup | Done | Consent-gated Plausible via `VITE_PLAUSIBLE_DOMAIN` |
| 20 | Single clear CTA | Done | Hero primary = Open guest till only |

Live marketing: set after Vercel deploy (project `tally-accra`).
Live till: https://tallyaccra.serverpod.space/
