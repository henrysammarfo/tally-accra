import { Link } from "@tanstack/react-router";
import { Menu, X } from "lucide-react";
import { useState, type ReactNode } from "react";
import { TallyLogo } from "./tally-logo";
import { Button } from "./ui/button";

const navItems = [
  ["Till Dashboard", "/dashboard"],
  ["Deposit Flow", "/deposit"],
  ["Rooms & Nights", "/rooms"],
  ["Daily Ledger", "/ledger"],
  ["Merch & Brand", "/merch"],
] as const;

export function SiteShell({ children }: { children: ReactNode }) {
  const [open, setOpen] = useState(false);
  return (
    <div className="min-h-screen bg-background text-foreground">
      <header className="sticky top-0 z-50 border-b border-border bg-background/95 backdrop-blur">
        <div className="mx-auto flex h-18 max-w-7xl items-center justify-between px-6">
          <Link to="/" aria-label="Tally home"><TallyLogo /></Link>
          <nav className="hidden items-center gap-7 lg:flex">
            {navItems.map(([label, to]) => (
              <Link key={to} to={to} className="text-sm font-medium text-muted-foreground transition-colors hover:text-foreground" activeProps={{ className: "text-foreground" }}>{label}</Link>
            ))}
          </nav>
          <Button asChild className="hidden rounded-full px-5 lg:inline-flex"><Link to="/deposit">Open Guest Till</Link></Button>
          <Button variant="ghost" size="icon" className="lg:hidden" onClick={() => setOpen((value) => !value)} aria-label="Toggle menu">{open ? <X /> : <Menu />}</Button>
        </div>
        {open && <nav className="border-t border-border px-6 py-4 lg:hidden">{navItems.map(([label, to]) => <Link key={to} to={to} onClick={() => setOpen(false)} className="block border-b border-border py-3 text-sm font-medium">{label}</Link>)}</nav>}
      </header>
      <main>{children}</main>
      <footer className="border-t border-border bg-primary py-10 text-primary-foreground">
        <div className="mx-auto flex max-w-7xl flex-col gap-6 px-6 md:flex-row md:items-end md:justify-between">
          <div><TallyLogo /><p className="mt-3 max-w-md text-sm text-primary-foreground/65">Accra Guest-House Till & Night Ledger. Built for the desk, the night shift, and the morning close.</p></div>
          <p className="text-xs uppercase tracking-[0.14em] text-primary-foreground/50">Accra, Ghana · Ledger protocol 01</p>
        </div>
      </footer>
    </div>
  );
}