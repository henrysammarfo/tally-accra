import { createFileRoute, Link } from "@tanstack/react-router";
import { BarChart3, Check, Coins, KeyRound, ShieldCheck, Star, Wallet, ArrowRight } from "lucide-react";
import { useEffect, useState } from "react";
import { Button } from "@/components/ui/button";
import { TallyMark } from "@/components/tally-logo";
import { useTally } from "@/lib/tally-store";
import { formatGHS } from "@/lib/tally-data";

export const Route = createFileRoute("/")({
  head: () => ({ meta: [
    { title: "TALLY — Take Deposit. Lock The Night." },
    { name: "description", content: "The ultra-focused guest-house till for fast Accra deposits, room locks, and daily close." },
    { property: "og:title", content: "TALLY — Accra Guest-House Till" },
    { property: "og:description", content: "Take deposits in seconds, lock room nights, and balance the daily ledger." },
    { property: "og:type", content: "website" }, { name: "twitter:card", content: "summary_large_image" },
  ]}),
  component: Index,
});

const tabs = [
  { title: "Take Deposit", icon: Coins, note: "MoMo, cash or card. Guest checked in before the queue builds." },
  { title: "Lock Room Night", icon: KeyRound, note: "Assign the room, secure the night, and make occupancy visible." },
  { title: "Live Daily Tally", icon: BarChart3, note: "One clean number for the shift in Ghana cedis and US dollars." },
  { title: "Audit & Proof", icon: ShieldCheck, note: "Every deposit leaves an immutable protocol trail and receipt." },
];

function Index() {
  const [active, setActive] = useState(0);
  const { total, occupied, rooms, transactions } = useTally();
  useEffect(() => { const timer = window.setInterval(() => setActive((value) => (value + 1) % 4), 5000); return () => window.clearInterval(timer); }, []);
  return (
    <div>
      <section className="overflow-hidden border-b border-border">
        <div className="mx-auto max-w-7xl px-6 pb-16 pt-18 md:pb-24 md:pt-24">
          <div className="animate-fade-in-up inline-flex items-center gap-3 border border-border p-2 pr-4 text-xs font-medium"><span className="flex size-8 items-center justify-center bg-primary text-primary-foreground"><Star className="size-4 fill-current" /></span>4.95 rating across 140+ Accra guest-houses & boutique stays</div>
          <h1 className="animate-fade-in-up mt-9 max-w-5xl text-5xl font-semibold leading-[0.98] tracking-normal md:text-8xl" style={{ animationDelay: "0.1s" }}>Take Deposit.<br />Lock The Night.<br /><span className="bg-gradient-to-r from-foreground via-muted-foreground to-border bg-clip-text text-transparent">Tally Accra Live.</span></h1>
          <p className="animate-fade-in-up mt-7 max-w-2xl text-lg leading-8 text-muted-foreground" style={{ animationDelay: "0.2s" }}>The ultra-focused till for Accra guest-houses. Record deposits in 8 seconds, lock room nights, and balance today’s ledger without the mega-POS bloat.</p>
          <div className="animate-fade-in-up mt-8 flex flex-wrap gap-3" style={{ animationDelay: "0.3s" }}><Button asChild size="lg" className="rounded-full"><Link to="/dashboard">Launch Till Demo<ArrowRight /></Link></Button><Button asChild size="lg" variant="outline" className="rounded-full"><Link to="/deposit">Take Instant Deposit<Wallet /></Link></Button></div>
        </div>
      </section>
      <section className="bg-secondary py-16 md:py-24">
        <div className="mx-auto max-w-7xl px-6">
          <div className="grid border border-border bg-background lg:grid-cols-[0.85fr_1.5fr]">
            <div className="border-b border-border lg:border-b-0 lg:border-r">{tabs.map((tab, index) => <button key={tab.title} onClick={() => setActive(index)} className={`flex w-full items-center gap-4 border-b border-border px-5 py-5 text-left last:border-0 ${active === index ? "bg-primary text-primary-foreground" : "hover:bg-secondary"}`}><tab.icon className="size-5" /><span><b className="block text-sm">{tab.title}</b><small className="mt-1 block opacity-60">0{index + 1} / 04</small></span></button>)}</div>
            <div className="min-h-108 p-6 md:p-10">
              <div className="flex items-start justify-between"><div><p className="text-xs font-bold uppercase tracking-[0.16em] text-muted-foreground">Live reception protocol</p><h2 className="mt-3 text-3xl font-semibold">{tabs[active].title}</h2><p className="mt-3 max-w-lg text-muted-foreground">{tabs[active].note}</p></div><span className="hidden size-12 items-center justify-center rounded-full bg-gold text-foreground md:flex"><TallyMark className="size-6" /></span></div>
              {active === 0 && <div className="animate-fade-in-overlay mt-10 grid gap-3 sm:grid-cols-3">{["MTN MoMo", "Telecel Cash", "Cash / Card"].map((item) => <div key={item} className="border border-border p-5"><span className="flex size-9 items-center justify-center rounded-full bg-secondary"><Check className="size-4" /></span><b className="mt-8 block text-sm">{item}</b><span className="mt-1 block text-xs text-muted-foreground">Ready to collect</span></div>)}</div>}
              {active === 1 && <div className="animate-fade-in-overlay mt-10 grid grid-cols-4 gap-2">{rooms.map((room) => <div key={room.number} className={`aspect-square border p-3 ${room.status === "Available" ? "border-border" : "border-primary bg-primary text-primary-foreground"}`}><b>{room.number}</b><span className="mt-2 block text-[10px] uppercase opacity-60">{room.status}</span></div>)}</div>}
              {active === 2 && <div className="animate-fade-in-overlay mt-10 border-t border-border pt-8"><span className="text-xs text-muted-foreground">Today’s total tally</span><strong className="mt-2 block text-5xl md:text-7xl">{formatGHS(total)}</strong><p className="mt-6 text-sm text-muted-foreground">{transactions.length} deposits · {occupied}/8 rooms secured</p></div>}
              {active === 3 && <div className="animate-fade-in-overlay mt-10 space-y-3">{["createDeposit", "listToday", "assignNight"].map((item, index) => <div key={item} className="flex items-center justify-between border border-border px-4 py-4 font-mono text-sm"><span>{item}</span><span className="text-success">200 · 0{8 + index}ms</span></div>)}</div>}
            </div>
          </div>
          <div className="mt-10 grid grid-cols-2 gap-px bg-border border border-border md:grid-cols-5">{["Osu Heritage Suites","Airport Residential Villas","Labone Haven","Cantonments Lodge","East Legon Courtyard"].map((name) => <div key={name} className="flex min-h-24 items-center justify-center bg-background p-4 text-center text-xs font-semibold uppercase text-muted-foreground">{name}</div>)}</div>
        </div>
      </section>
      <section className="border-t border-border py-18"><div className="mx-auto max-w-7xl px-6"><div className="flex items-end justify-between gap-4"><div><p className="text-xs font-bold uppercase tracking-[0.16em] text-muted-foreground">Tally supply division</p><h2 className="mt-3 text-4xl font-semibold">Night shift uniform.</h2></div><Link to="/merch" className="text-sm font-semibold underline underline-offset-4">View brand system</Link></div><div className="mt-10 grid gap-4 md:grid-cols-3"><MerchPreview name="440 GSM Heavy Hoodie" kind="hoodie" /><MerchPreview name="Desk Strapback" kind="cap" /><MerchPreview name="Till Receipt Pin" kind="pin" /></div></div></section>
    </div>
  );
}

function MerchPreview({ name, kind }: { name: string; kind: string }) { return <div className="group border border-border bg-secondary"><div className="flex aspect-[4/3] items-center justify-center"><div className={`${kind === "hoodie" ? "h-44 w-36 rounded-t-[3rem]" : kind === "cap" ? "h-24 w-44 rounded-t-full" : "size-24 rotate-6"} flex items-center justify-center bg-primary text-primary-foreground shadow-2xl transition-transform group-hover:-translate-y-1`}><TallyMark className="size-12 text-gold" /></div></div><div className="border-t border-border bg-background p-5"><b>{name}</b><span className="mt-1 block text-xs text-muted-foreground">Accra issue · Obsidian / Cedi Gold</span></div></div>; }
