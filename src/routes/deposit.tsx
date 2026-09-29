import { createFileRoute } from "@tanstack/react-router";
import { LiveTillGate } from "@/components/live-till-gate";

export const Route = createFileRoute("/deposit")({
  head: () => ({
    meta: [
      { title: "Take Deposit — TALLY" },
      {
        name: "description",
        content: "8-second deposit flow on the live Flutter + Serverpod till.",
      },
    ],
  }),
  component: DepositGate,
});

function DepositGate() {
  return (
    <LiveTillGate
      title="Take deposit. Lock the night."
      description="The production 8-second flow runs in the Flutter desk app against real Serverpod endpoints. No browser localStorage till."
    />
  );
}
