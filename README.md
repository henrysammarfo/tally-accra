# Tally Accra

Create Tally: The guest-house till and deposit management platform for Accra hospitality, built with a streetwear-grade brand system designed for future hoodies and apparel, styled strictly using the attached Stellar.ai high-contrast design system.

### Brand & Logo Design (Merch & Hoodie Ready)
- Brand Name: **TALLY** (Subtitle: *Accra Guest-House Till & Night Ledger*)
- Logo Mark: Iconic, minimalist geometric brand mark featuring sharp, brutalist tally tick-geometry fused with an architectural room key / lock monogram (looks stunning embroidered on heavyweight streetwear hoodies, caps, woven tags, and receipts). Provide an interactive Brand & Merch page with hoodie mockups, vector SVG export, color tokens (Obsidian #0A0A0A, Pure Milk #FAFAFA, Ghana Cedi Gold accents #D4AF37, Warm Slate #71717A), and typography guidelines.

### Design System (Strictly matching the Stellar.ai template prompt)
- Typography: Inter font imported from Google Fonts (weights 400, 500, 600, 700) on body.
- Color Palette: Clean `bg-white`, crisp borders (`border-gray-200` / `border-gray-300`), deep black buttons (`bg-black text-white hover:bg-gray-800 rounded-full`), subtle gray texts (`text-gray-600`, `text-gray-700`).
- Custom CSS Keyframe Animations:
  - `@keyframes fadeInUp` (0.6s ease-out forwards)
  - `@keyframes fadeInOverlay` (0.4s ease-out forwards)
  - `@keyframes fadeInDialog` / `animate-slide-up-overlay` (0.5s ease-out)
  - Staggered `animationDelay` (0.1s increments) across hero elements and navigation.
- Icons: Lucide React icons exclusively.
- Max width container: `max-w-7xl mx-auto px-6`.

### Core Pages & Navigation Routes
1. **Landing Page (`/`)**:
   - Navigation: Tally custom geometric brand logo + "TALLY" mark, links to "Till Dashboard", "Deposit Flow", "Rooms & Nights", "Daily Ledger", "Merch & Brand", and CTA button "Open Guest Till".
   - Hero Section:
     - Reviews Badge: Bordered square with Star icon + "4.95 rating across 140+ Accra guest-houses & boutique stays".
     - Main Heading: "Take Deposit. Lock The Night." with second line "Tally Accra Live." in gradient text (`bg-gradient-to-r from-black via-gray-600 to-gray-400 bg-clip-text text-transparent`).
     - Subheading: "The ultra-focused till for Accra guest-houses. Record deposits in 8 seconds, lock room nights, and balance today’s ledger without the mega-POS bloat."
     - CTA Buttons: "Launch Till Demo" & "Take Instant Deposit".
     - Interactive Tab Bar with 4 auto-cycling/clickable operational tabs:
       1. "Take Deposit" (Coins/Wallet icon): Quick guest deposit wizard with MoMo (MTN / Telecel), Cash, and Card.
       2. "Lock Room Night" (KeyRound icon): Room assignment & lock status (Rooms 101–108).
       3. "Live Daily Tally" (BarChart3 icon): Real-time daily revenue counter in GHS (Ghanaian Cedis) & USD.
       4. "Audit & Proof" (ShieldCheck icon): Serverpod backend architecture & immutable log trail.
     - Interactive Mockup / Video section container with live interactive overlays matching each tab.
     - Partner / Hospitality badges: "Osu Heritage Suites", "Airport Residential Villas", "Labone Haven", "Cantonments Lodge", "East Legon Courtyard".
     - Merch Teaser section showing heavy cotton hoodies, dad caps, and till receipt enamel pins with the Tally logo mark.

2. **Reception Desk Dashboard (`/dashboard`)**:
   - Live metrics bar: Today's Total Tally (GH₵), Total Room Deposits Collected, Occupancy Rate (e.g. 7/8 Rooms Locked), MoMo vs Cash breakdown.
   - Quick "New Deposit" action button triggering instant drawer/modal.
   - Live Room Matrix (visual interactive grid of rooms 101-108: Occupied, Locked, Available, Cleaning).
   - Recent Transactions ledger with instant receipt generation, filter by payment method (MTN Mobile Money, Telecel Cash, Physical Cash, Visa/Mastercard).

3. **Take Deposit Fast Flow (`/deposit`)**:
   - Ultra-clean 8-second till flow tailored for receptionists and night managers:
     - Step 1: Guest Full Name & Phone number (with Ghana +233 prefix helper)
     - Step 2: Select Room (101–108) and Nights count
     - Step 3: Enter Deposit amount (GH₵ / $) & Select Payment Gateway (MTN MoMo, Telecel Cash, Cash Till, Card)
     - Step 4: One-click "Lock Night & Print Receipt" -> Live updates the global state & today's tally ledger!

4. **Rooms & Nights Management (`/rooms`)**:
   - Full room roster (Executive Suite, Deluxe King, Standard Studio) with rates per night, current guest, deposit status, check-in/out timestamps, and manual "Lock Night" toggle.

5. **Daily Ledger & Audit (`/ledger`)**:
   - End-of-day closing tally report.
   - Breakdown by shift / receptionist.
   - Export report button (CSV / Printable receipt format).
   - Serverpod architecture badge & protocol log explaining the endpoint pipeline (`createDeposit`, `listToday`, `assignNight`).

6. **Brand, Logo & Merch Store (`/merch` or `/brand`)**:
   - Vector logo showcase (Dark & Light hoodie colorways, high-density embroidery preview, boxy tee mockup, embroidered strapback cap).
   - Downloadable SVG logo asset cards.
   - Brand guidelines: Logo anatomy (the Tally 4-bar hash mark + Accra keyhole), typography specimen (Inter), color codes.

Include realistic Accra guest-house sample data in Ghanaian Cedis (GH₵) with functional state management so deposits immediately increment the dashboard totals and room occupancy.

This project was built with [Lovable](https://lovable.dev).

## Build with Lovable

Continue developing this project in the [Lovable editor](https://lovable.dev/projects/a72e0685-cf27-4efe-8278-559c12527b7e).

- **Ship faster**: describe what you want to build and Lovable handles the code.
- **Stay in sync**: every change made in Lovable is committed straight to this repository.
- **Full ownership**: this code is yours. Push to `main` on GitHub and your changes sync back into Lovable, ready for your next prompt.

## Development

Prefer working locally? You need Node.js and npm — [install with nvm](https://github.com/nvm-sh/nvm#installing-and-updating).

```sh
git clone <this-repository-url>
cd <repository-name>
npm i
npm run dev
```
