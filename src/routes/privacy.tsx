import { createFileRoute } from "@tanstack/react-router";
import { LegalPage } from "@/components/legal-page";

export const Route = createFileRoute("/privacy")({
  head: () => ({
    meta: [
      { title: "Privacy Policy — TALLY" },
      {
        name: "description",
        content: "How TALLY handles personal data on the marketing site and Serverpod till.",
      },
      { property: "og:title", content: "Privacy Policy — TALLY" },
      { property: "og:image", content: "/og-image.svg" },
    ],
  }),
  component: PrivacyPage,
});

function PrivacyPage() {
  return (
    <LegalPage title="Privacy Policy" updated="14 October 2026">
      <section>
        <h2 className="text-xl font-semibold">Who we are</h2>
        <p className="mt-2 text-muted-foreground">
          TALLY is an Accra guest-house till built with Flutter and Serverpod. This marketing site
          explains the product. The live till runs at{" "}
          <a className="underline" href="https://tallyaccra.serverpod.space/">
            tallyaccra.serverpod.space
          </a>
          .
        </p>
      </section>
      <section>
        <h2 className="text-xl font-semibold">What we collect</h2>
        <ul className="mt-2 list-disc space-y-1 pl-5 text-muted-foreground">
          <li>Account email and name when you register on the Serverpod till (auth).</li>
          <li>Guest-house operational data you enter (deposits, phones, rooms) — stored in Postgres.</li>
          <li>Optional analytics cookies on this marketing site only if you accept them.</li>
          <li>Merch interest forms on this site stay in your browser session — not a payment checkout.</li>
        </ul>
      </section>
      <section>
        <h2 className="text-xl font-semibold">How we use data</h2>
        <p className="mt-2 text-muted-foreground">
          Till data runs your guest-house desk (deposits, night locks, today’s tally). We do not sell
          personal data. Marketing analytics, if enabled, measure page views only.
        </p>
      </section>
      <section>
        <h2 className="text-xl font-semibold">Storage and security</h2>
        <p className="mt-2 text-muted-foreground">
          Production till data lives on Serverpod Cloud Postgres with Serverpod auth. Secrets stay in
          server env / Cloud passwords — never in the browser bundle. We harden honestly; no system is
          unhackable.
        </p>
      </section>
      <section>
        <h2 className="text-xl font-semibold">Your choices</h2>
        <p className="mt-2 text-muted-foreground">
          Use Essential only on the cookie banner to skip analytics. Contact the project maintainer
          via the GitHub repository for access or deletion requests tied to a till account you own.
        </p>
      </section>
      <section>
        <h2 className="text-xl font-semibold">Contact</h2>
        <p className="mt-2 text-muted-foreground">
          GitHub:{" "}
          <a className="underline" href="https://github.com/henrysammarfo/tally-accra">
            henrysammarfo/tally-accra
          </a>
        </p>
      </section>
    </LegalPage>
  );
}
