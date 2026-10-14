import { createFileRoute } from "@tanstack/react-router";
import { LegalPage } from "@/components/legal-page";

export const Route = createFileRoute("/terms")({
  head: () => ({
    meta: [
      { title: "Terms & Conditions — TALLY" },
      {
        name: "description",
        content: "Terms for using the TALLY marketing site and Serverpod-backed till demo.",
      },
      { property: "og:title", content: "Terms & Conditions — TALLY" },
      { property: "og:image", content: "/og-image.svg" },
    ],
  }),
  component: TermsPage,
});

function TermsPage() {
  return (
    <LegalPage title="Terms & Conditions" updated="14 October 2026">
      <section>
        <h2 className="text-xl font-semibold">Acceptance</h2>
        <p className="mt-2 text-muted-foreground">
          By using the TALLY marketing site or the live till demo, you agree to these terms. If you
          do not agree, do not use the services.
        </p>
      </section>
      <section>
        <h2 className="text-xl font-semibold">What TALLY is</h2>
        <p className="mt-2 text-muted-foreground">
          TALLY is a guest-house till for Accra: deposit → lock night → today’s tally. The marketing
          site is brand and pitch only. The production desk is Flutter + Serverpod under{" "}
          <code className="text-sm">tally/</code>.
        </p>
      </section>
      <section>
        <h2 className="text-xl font-semibold">Accounts and acceptable use</h2>
        <ul className="mt-2 list-disc space-y-1 pl-5 text-muted-foreground">
          <li>Keep login credentials private.</li>
          <li>Do not attempt to access another organisation’s till data.</li>
          <li>Do not abuse auth, spam endpoints, or scrape personal guest data.</li>
          <li>Merch interest lists on this site are not paid orders or inventory commitments.</li>
        </ul>
      </section>
      <section>
        <h2 className="text-xl font-semibold">No warranties</h2>
        <p className="mt-2 text-muted-foreground">
          The demo is provided as-is for evaluation and hackathon use. We do not promise
          uninterrupted service or that the software is free of defects. Do not rely on the demo as
          your only production system of record without your own review.
        </p>
      </section>
      <section>
        <h2 className="text-xl font-semibold">Liability</h2>
        <p className="mt-2 text-muted-foreground">
          To the fullest extent allowed by law, TALLY maintainers are not liable for indirect or
          consequential losses from use of the demo or marketing site.
        </p>
      </section>
      <section>
        <h2 className="text-xl font-semibold">Changes</h2>
        <p className="mt-2 text-muted-foreground">
          We may update these terms. The “Last updated” date at the top will change when we do.
        </p>
      </section>
    </LegalPage>
  );
}
