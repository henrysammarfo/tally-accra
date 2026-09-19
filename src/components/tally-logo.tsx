import { cn } from "@/lib/utils";

export function TallyMark({ className = "" }: { className?: string }) {
  return (
    <svg viewBox="0 0 48 48" aria-hidden="true" className={cn("size-9", className)} fill="none">
      <path d="M8 9h7v22H8zM19 9h7v22h-7zM30 9h7v22h-7z" fill="currentColor" />
      <path d="M7 35 39 7l4 5L11 40z" fill="currentColor" />
      <path d="M19 29h18v12H19z" fill="currentColor" />
      <circle cx="28" cy="35" r="2.6" className="fill-background" />
    </svg>
  );
}

export function TallyLogo({ compact = false }: { compact?: boolean }) {
  return (
    <span className="inline-flex items-center gap-2.5">
      <TallyMark />
      {!compact && <span className="text-lg font-bold tracking-[0.08em]">TALLY</span>}
    </span>
  );
}