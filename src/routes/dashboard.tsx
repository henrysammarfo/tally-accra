import { createFileRoute } from "@tanstack/react-router";
import { LiveTillGate } from "@/components/live-till-gate";

export const Route = createFileRoute("/dashboard")({
  head: () => ({
    meta: [
      { title: "Till Desk — TALLY" },
      {
        name: "description",
        content: "Open the live Accra guest-house till powered by Serverpod.",
      },
    ],
  }),
  component: DashboardGate,
});

function DashboardGate() {
  return (
    <LiveTillGate
      title="Reception desk lives on Serverpod"
      description="Today’s total, room matrix, and deposits persist in Postgres through createDeposit, assignNight, and listToday. This marketing site does not store till data."
    />
  );
}
