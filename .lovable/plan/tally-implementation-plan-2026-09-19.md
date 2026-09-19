# Tally — implementation plan

## Product shape
Build a six-route, responsive guest-house till experience with a shared header and a strict high-contrast white, black, gray, and cedi-gold visual system. The landing page will lead with TALLY’s geometric key-and-tally identity, then provide an interactive four-mode product demo and merch preview.

## Core experience
- Create shared live state for deposits, room locks, occupancy, payment-method totals, and the current-day ledger.
- Make the deposit flow a focused four-step interaction that updates every operational view immediately.
- Build the reception dashboard with key totals, room matrix, quick deposit action, filters, and printable receipts.
- Build room management, daily closing/audit reporting, CSV export, and print-friendly output.
- Build the brand page with dark/light apparel mockups, logo anatomy, typography, color tokens, and downloadable SVG marks.

## Routes
- `/` — product overview, interactive tabs, hospitality badges, and merch teaser
- `/dashboard` — live till metrics, room matrix, transaction ledger, and receipt dialog
- `/deposit` — four-step deposit and room-lock flow
- `/rooms` — room roster and manual night locking
- `/ledger` — daily close, shift breakdown, audit trail, CSV and print controls
- `/merch` — logo system, apparel previews, SVG exports, and brand guidelines

## Technical details
- Use React context with browser persistence so interactions survive navigation and refreshes without requiring account setup.
- Use TanStack Router links and a route-specific metadata block for every page.
- Use semantic Tailwind v4 tokens in the global stylesheet and load Inter through document-head links.
- Use Lucide icons only; author the logo as reusable inline vector geometry and downloadable SVG files.
- Add the requested custom entrance keyframes with reduced-motion handling and restrained staggered timing.
- Validate the main workflows and responsive layouts in the live preview.
