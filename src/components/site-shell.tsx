import { Link } from "@tanstack/react-router";
import { Menu, Star, X } from "lucide-react";
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
        <div className="animate-fade-in-up mx-auto flex max-w-7xl items-center justify-between px-6 py-4 opacity-0" style={{ animationDelay: "0.1s" }}>
          <Link to="/" aria-label="Tally home" className="flex items-center gap-2 text-lg font-semibold"><Star className="size-5 fill-current" />TALLY</Link>
          <nav className="hidden items-center gap-8 md:flex">
            {navItems.map(([label, to]) => (
              <Link key={to} to={to} className="text-sm text-muted-foreground transition-colors hover:text-foreground" activeProps={{ className: "text-foreground" }}>{label}</Link>
            ))}
          </nav>
          <div className="hidden items-center gap-5 md:flex"><Link to="/dashboard" className="text-sm text-muted-foreground">Login</Link><Button asChild className="px-5 py-2.5"><Link to="/deposit">Open Till</Link></Button></div>
          <Button variant="ghost" size="icon" className="md:hidden" onClick={() => setOpen((value) => !value)} aria-label="Toggle menu">{open ? <X /> : <Menu />}</Button>
        </div>
        {open && <nav className="border-t border-border px-6 py-4 md:hidden">{navItems.map(([label, to]) => <Link key={to} to={to} onClick={() => setOpen(false)} className="block border-b border-border py-3 text-sm font-medium">{label}</Link>)}<Button asChild className="mt-4 w-full"><Link to="/deposit" onClick={() => setOpen(false)}>Open Till</Link></Button></nav>}
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