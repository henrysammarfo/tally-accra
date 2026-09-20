import type { ReactNode } from "react";

export function PageHeading({ eyebrow, title, description, action }: { eyebrow: string; title: string; description: string; action?: ReactNode }) {
  return (
    <div className="border-b border-border bg-background">
      <div className="mx-auto flex max-w-7xl flex-col gap-6 px-6 py-12 md:flex-row md:items-end md:justify-between">
        <div><p className="mb-3 text-xs font-bold uppercase tracking-[0.16em] text-muted-foreground">{eyebrow}</p><h1 className="text-4xl font-semibold md:text-5xl">{title}</h1><p className="mt-4 max-w-2xl text-muted-foreground">{description}</p></div>
        {action}
      </div>
    </div>
  );
}