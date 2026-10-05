# TALLY Accra

Dual-track product:

| Track | Path | Role |
| --- | --- | --- |
| **A — Hackathon submission** | [`tally/`](tally/) | Flutter + Serverpod 4 till: deposit → lock night → today’s tally |
| **B — Marketing** | [`src/`](src/) | Brand, pitch, merch kit on Lovable/Vercel — **not** the live till |

Canon docs: [`docs/memory/`](docs/memory/) · deploy: [`tally/DEPLOY.md`](tally/DEPLOY.md)

### Brand
- **TALLY** — Accra Guest-House Till & Night Ledger
- Colors: Obsidian `#0A0A0A`, Pure Milk `#FAFAFA`, Cedi Gold `#D4AF37`, Warm Slate `#71717A`

### Live till
Set `VITE_TALLY_FLUTTER_WEB_URL` to the Serverpod Cloud Flutter web URL after `scloud deploy`.

### Development (marketing)
```sh
npm i
npm run dev
```

### Development (Serverpod spine)
```sh
export PATH="$HOME/flutter/bin:$HOME/.pub-cache/bin:$PATH"
cd tally/tally_server && dart test
cd ../tally_flutter && flutter analyze
# full stack:
cd .. && serverpod start --no-docker
```

This marketing project syncs with [Lovable](https://lovable.dev). Do not force-push rewritten history.
