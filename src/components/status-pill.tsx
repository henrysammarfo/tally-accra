import { cn } from "@/lib/utils";
import type { RoomStatus } from "@/lib/tally-data";

export function StatusPill({ status }: { status: RoomStatus }) {
  return <span className={cn("inline-flex rounded-full border px-2.5 py-1 text-xs font-semibold", status === "Available" && "border-success/30 bg-success/10 text-success", status === "Cleaning" && "border-warning/30 bg-warning/10 text-warning", status === "Locked" && "border-gold/35 bg-gold/10 text-gold-strong", status === "Occupied" && "border-foreground/15 bg-foreground text-background")}>{status}</span>;
}