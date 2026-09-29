import { createFileRoute } from "@tanstack/react-router";
import { LiveTillGate } from "@/components/live-till-gate";

export const Route = createFileRoute("/ledger")({
  head: () => ({
    meta: [
      { title: "Daily Ledger — TALLY" },
      {
        name: "description",
        content: "Daily close and audit trail from the live Serverpod ledger.",
      },
    ],
  }),
  component: LedgerGate,
});

function LedgerGate() {
  return (
    <LiveTillGate
      title="Daily ledger & audit"
      description="listToday streams deposits, GHS totals, and an append-only audit trail from Postgres. Built on Serverpod — not a static marketing mock."
    >
      <ul className="mx-auto mt-10 max-w-md space-y-2 text-left text-sm text-muted-foreground">
        <li>createDeposit → verify → lock room → audit</li>
        <li>assignNight → lock/free room in tenant</li>
        <li>listToday / watchToday → live desk tally</li>
      </ul>
    </LiveTillGate>
  );
}
