import { createFileRoute } from "@tanstack/react-router";
import { LiveTillGate } from "@/components/live-till-gate";

export const Route = createFileRoute("/rooms")({
  head: () => ({
    meta: [
      { title: "Rooms & Nights — TALLY" },
      {
        name: "description",
        content: "Lock and free Accra guest-house rooms on the live Serverpod till.",
      },
    ],
  }),
  component: RoomsGate,
});

function RoomsGate() {
  return (
    <LiveTillGate
      title="Rooms & nights"
      description="Room locks are written by assignNight on Serverpod and scoped per guest-house tenant."
    />
  );
}
