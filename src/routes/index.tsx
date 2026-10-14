import { createFileRoute, Link } from "@tanstack/react-router";
import { ExternalLink, KeyRound, ShieldCheck, Wallet } from "lucide-react";
import type { ReactNode } from "react";
import { Button } from "@/components/ui/button";
import { openLiveTill } from "@/lib/live-till";

export const Route = createFileRoute("/")({
  head: () => ({
    meta: [
      { title: "TALLY — Take Deposit. Lock The Night." },
      {
        name: "description",
        content:
          "Accra guest-house till: take deposits in 8 seconds, lock room nights, and see today’s tally — Flutter + Serverpod.",
      },
      { property: "og:title", content: "TALLY — Accra Guest-House Till" },
      {
        property: "og:description",
        content: "Deposit → night → today’s tally. One finished Serverpod flow.",
      },
      { property: "og:image", content: "https://tally-accra.vercel.app/og-image.svg" },
      { property: "og:type", content: "website" },
      { name: "twitter:card", content: "summary_large_image" },
      { name: "twitter:image", content: "https://tally-accra.vercel.app/og-image.svg" },
    ],
  }),
  component: Index,
});

function Index() {
  return (
    <div className="bg-background">
      <section className="relative min-h-[88vh] overflow-hidden">
        <div
          className="absolute inset-0 bg-[radial-gradient(ellipse_at_top,_rgba(212,175,55,0.18),_transparent_55%),linear-gradient(180deg,#fafafa_0%,#f0f0f0_100%)]"
          aria-hidden
        />
        <div className="relative mx-auto flex max-w-7xl flex-col items-start px-6 pb-24 pt-20 md:pt-28">
          <p
            className="animate-fade-in-up text-xs font-semibold uppercase tracking-[0.2em] text-muted-foreground opacity-0"
            style={{ animationDelay: "0.1s" }}
          >
            Accra guest-house till
          </p>
          <h1
            className="animate-fade-in-up mt-4 max-w-4xl text-5xl font-semibold leading-[1.05] tracking-tight opacity-0 md:text-7xl"
            style={{ animationDelay: "0.2s" }}
          >
            <span className="block text-[0.55em] font-bold tracking-[0.18em] text-foreground md:text-[0.42em]">
              TALLY
            </span>
            Take deposit. Lock the night.
          </h1>
          <p
            className="animate-fade-in-up mt-5 max-w-xl text-lg text-muted-foreground opacity-0"
            style={{ animationDelay: "0.3s" }}
          >
            One finished flow for Accra reception desks — deposit → room night → today’s tally — on
            Flutter with a real Serverpod backend.
          </p>
          <div
            className="animate-fade-in-up mt-8 flex flex-wrap items-center gap-4 opacity-0"
            style={{ animationDelay: "0.4s" }}
          >
            <Button type="button" className="px-8 py-3 text-base" onClick={openLiveTill}>
              Open guest till <ExternalLink className="size-4" aria-hidden />
            </Button>
            <Link
              to="/merch"
              className="text-sm font-medium text-muted-foreground underline-offset-4 hover:text-foreground hover:underline"
            >
              Merch & brand
            </Link>
          </div>

          <div
            className="animate-fade-in-up mt-16 grid w-full gap-8 border-t border-border pt-10 md:grid-cols-3 opacity-0"
            style={{ animationDelay: "0.55s" }}
          >
            <Feature
              icon={<Wallet className="size-5" aria-hidden />}
              title="Take deposit"
              body="Guest, room, MoMo/cash/card — lock in one desk motion."
            />
            <Feature
              icon={<KeyRound className="size-5" aria-hidden />}
              title="Lock the night"
              body="Rooms 101–108 stay tenant-scoped on Serverpod Postgres."
            />
            <Feature
              icon={<ShieldCheck className="size-5" aria-hidden />}
              title="Today’s tally"
              body="Live listToday / watchToday totals — nothing critical faked."
            />
          </div>
        </div>
      </section>
    </div>
  );
}

function Feature({ icon, title, body }: { icon: ReactNode; title: string; body: string }) {
  return (
    <div className="text-left">
      <div className="mb-3 flex size-10 items-center justify-center border border-border bg-background">
        {icon}
      </div>
      <h2 className="text-lg font-semibold">{title}</h2>
      <p className="mt-2 text-sm text-muted-foreground">{body}</p>
    </div>
  );
}
