import { Link } from "@tanstack/react-router";
import { ExternalLink } from "lucide-react";
import type { ReactNode } from "react";
import { Button } from "@/components/ui/button";
import { getLiveTillUrl, openLiveTill } from "@/lib/live-till";

export function LiveTillGate({
  title,
  description,
  children,
}: {
  title: string;
  description: string;
  children?: ReactNode;
}) {
  const url = getLiveTillUrl();
  return (
    <div className="mx-auto max-w-3xl px-6 py-16 text-center">
      <p className="text-xs font-semibold uppercase tracking-[0.16em] text-muted-foreground">
        Live Serverpod till
      </p>
      <h1 className="mt-3 text-4xl font-semibold tracking-tight">{title}</h1>
      <p className="mx-auto mt-4 max-w-xl text-muted-foreground">{description}</p>
      <div className="mt-8 flex flex-wrap items-center justify-center gap-3">
        <Button type="button" className="px-6" onClick={openLiveTill}>
          Open live till <ExternalLink className="size-4" />
        </Button>
        <Button asChild variant="outline">
          <Link to="/merch">Brand & merch</Link>
        </Button>
      </div>
      <p className="mt-6 text-sm text-muted-foreground">
        {url
          ? `Configured: ${url}`
          : "Set VITE_TALLY_FLUTTER_WEB_URL after scloud deploy. Deposit → lock night → today’s tally runs on Flutter + Serverpod, not in this marketing site."}
      </p>
      {children}
    </div>
  );
}
