import { createFileRoute, Link } from "@tanstack/react-router";
import { BarChart3, BookOpen, Check, CircleCheck, Rocket, Star, Users } from "lucide-react";
import { useEffect, useState } from "react";
import { Button } from "@/components/ui/button";

export const Route = createFileRoute("/")({
  head: () => ({ meta: [
    { title: "TALLY — Take Deposit. Lock The Night." },
    { name: "description", content: "The ultra-focused guest-house till for fast Accra deposits, room locks, and daily close." },
    { property: "og:title", content: "TALLY — Accra Guest-House Till" },
    { property: "og:description", content: "Take deposits in seconds, lock room nights, and balance the daily ledger." },
    { property: "og:type", content: "website" },
    { name: "twitter:card", content: "summary_large_image" },
  ] }),
  component: Index,
});

const tabs = [
  { id: "analyse", label: "Analyse", icon: BarChart3 },
  { id: "train", label: "Train", icon: BookOpen },
  { id: "testing", label: "Testing", icon: Users },
  { id: "deploy", label: "Deploy", icon: Rocket },
] as const;

type TabId = (typeof tabs)[number]["id"];

function Index() {
  const [active, setActive] = useState<TabId>("analyse");

  useEffect(() => {
    const timer = window.setInterval(() => {
      setActive((current) => {
        const index = tabs.findIndex((tab) => tab.id === current);
        return tabs[(index + 1) % tabs.length]?.id ?? "analyse";
      });
    }, 4000);
    return () => window.clearInterval(timer);
  }, []);

  return (
    <div className="bg-background">
      <section className="mx-auto max-w-7xl px-6 pb-32 pt-24 text-center">
        <div className="animate-fade-in-up mb-8 inline-flex items-center gap-2 opacity-0" style={{ animationDelay: "0.2s" }}>
          <span className="flex size-6 items-center justify-center rounded border border-input"><Star className="size-3.5 fill-current" /></span>
          <span className="text-sm font-medium">4.9 rating from 18.3K+ users</span>
        </div>

        <h1 className="animate-fade-in-up mb-5 text-6xl font-normal leading-[1.1] tracking-tight opacity-0 md:text-7xl lg:text-[80px]" style={{ animationDelay: "0.3s" }}>
          Take Deposit. Lock The Night.<br />
          <span className="bg-gradient-to-r from-foreground via-muted-foreground to-input bg-clip-text text-transparent">Tally Accra Live.</span>
        </h1>
        <p className="animate-fade-in-up mx-auto mb-8 max-w-2xl text-lg text-muted-foreground opacity-0 md:text-xl" style={{ animationDelay: "0.4s" }}>
          Take deposits in 8 seconds, lock room nights, and balance today’s ledger without the mega-POS bloat.
        </p>
        <div className="animate-fade-in-up mb-12 opacity-0" style={{ animationDelay: "0.5s" }}>
          <Button asChild className="px-8 py-3 text-base"><Link to="/deposit">Open Guest Till</Link></Button>
        </div>

        <div className="animate-fade-in-up mb-8 flex justify-center opacity-0" style={{ animationDelay: "0.6s" }}>
          <div className="grid w-full max-w-xl grid-cols-2 gap-1 rounded-lg bg-secondary p-1 md:hidden">
            {tabs.map((tab) => <TabButton key={tab.id} tab={tab} active={active === tab.id} onClick={() => setActive(tab.id)} />)}
          </div>
          <div className="hidden items-center rounded-lg bg-secondary p-1 md:flex">
            {tabs.map((tab, index) => <div key={tab.id} className="flex items-center">{index > 0 && <span className="h-5 w-px bg-input" />}<TabButton tab={tab} active={active === tab.id} onClick={() => setActive(tab.id)} /></div>)}
          </div>
        </div>

        <div className="animate-fade-in-up relative h-[400px] overflow-hidden rounded-3xl bg-primary opacity-0 md:h-[500px]" style={{ animationDelay: "0.7s" }}>
          <video src="https://d8j0ntlcm91z4.cloudfront.net/user_38xzZboKViGWJOttwIXH07lWA1P/hf_20260319_165750_358b1e72-c921-48b7-aaac-f200994f32fb.mp4" autoPlay loop muted playsInline className="h-full w-full object-cover" />
          <div key={active} className="animate-fade-in-overlay absolute inset-0 bg-overlay">
            <Overlay active={active} />
          </div>
        </div>

        <div className="animate-fade-in-up mt-24 flex flex-wrap items-center justify-center gap-10 text-muted-foreground opacity-0 md:gap-12" style={{ animationDelay: "0.8s" }}>
          <span className="text-sm font-bold tracking-[0.16em]">INTERSCOPE</span>
          <span className="flex items-center gap-2 text-base font-bold"><span className="size-5 rounded-full bg-foreground" />SPOTIFY</span>
          <span className="flex items-center gap-2 text-lg font-semibold"><DotGrid />Nexera</span>
          <span className="font-serif text-2xl italic">M3</span>
          <span className="flex items-center gap-2 text-xs font-semibold tracking-[0.12em]"><span className="flex size-8 items-center justify-center rounded-full border border-current">LC</span>LAURA COLE</span>
          <span className="flex items-center gap-2 text-lg font-medium"><span className="grid grid-cols-2 gap-1">{[0,1,2,3].map((dot) => <i key={dot} className="size-1.5 rounded-full bg-current" />)}</span>vertex</span>
        </div>
      </section>
    </div>
  );
}

function TabButton({ tab, active, onClick }: { tab: (typeof tabs)[number]; active: boolean; onClick: () => void }) {
  const Icon = tab.icon;
  return <Button type="button" variant="ghost" onClick={onClick} className={`min-w-32 rounded-md px-5 ${active ? "bg-background text-foreground shadow-sm hover:bg-background" : "text-muted-foreground"}`}><Icon className="size-4" />{tab.label}</Button>;
}

function Overlay({ active }: { active: TabId }) {
  const content = {
    analyse: { title: "Set Up Your AI Workspace", subtitle: "Workspace configuration", progress: "25%", tone: "bg-chart-4", items: ["Connect your data", "Choose automations", "Invite your team", "Review workspace"] },
    train: { title: "AI Model Training", subtitle: "67% complete · 8m remaining", progress: "67%", tone: "bg-chart-1", items: ["Accuracy 94.8%", "Loss 0.042", "12.4K samples", "Epoch 18 / 27"] },
    testing: { title: "Test Suite Results", subtitle: "127 / 127 tests passed", progress: "100%", tone: "bg-success", items: ["Unit tests passed", "Integrations passed", "Security checks passed", "Ready to deploy"] },
    deploy: { title: "Deploy to Production", subtitle: "All systems are ready", progress: "100%", tone: "bg-foreground", items: ["Environment verified", "Database migrated", "Tests approved", "Rollback prepared"] },
  }[active];

  return (
    <div className="animate-slide-up-overlay absolute left-1/2 top-1/2 w-[calc(100%-3rem)] max-w-lg -translate-x-1/2 -translate-y-1/2 rounded-2xl bg-background p-6 text-left shadow-2xl md:p-8">
      <div className="mb-6 flex items-start justify-between gap-4"><div><p className="text-xs font-medium uppercase text-muted-foreground">Tally intelligent workflow</p><h2 className="mt-2 text-2xl font-semibold">{content.title}</h2><p className="mt-1 text-sm text-muted-foreground">{content.subtitle}</p></div>{active === "testing" && <CircleCheck className="size-8 text-success" />}</div>
      <div className="mb-6 h-2 overflow-hidden rounded-full bg-secondary"><div className={`h-full rounded-full ${content.tone}`} style={{ width: content.progress }} /></div>
      <div className="grid gap-2 sm:grid-cols-2">{content.items.map((item, index) => <div key={item} className="flex items-center gap-2 rounded-lg border border-border px-3 py-3 text-sm"><span className="flex size-5 shrink-0 items-center justify-center rounded-full bg-secondary text-[10px]">{active === "deploy" || active === "testing" ? <Check className="size-3" /> : index + 1}</span>{item}</div>)}</div>
      {active === "deploy" && <Button className="mt-6 w-full">Deploy Now</Button>}
    </div>
  );
}

function DotGrid() { return <span className="grid grid-cols-3 gap-0.5">{[0,1,2,3,4,5,6,7,8].map((dot) => <i key={dot} className="size-1 rounded-full bg-current" />)}</span>; }