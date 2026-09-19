import { useState } from "react";
import { Check, ChevronLeft, ChevronRight, Printer } from "lucide-react";
import { useNavigate } from "@tanstack/react-router";
import { Button } from "./ui/button";
import { useTally } from "@/lib/tally-store";
import type { PaymentMethod } from "@/lib/tally-data";

const methods: PaymentMethod[] = ["MTN MoMo", "Telecel Cash", "Cash Till", "Visa / Mastercard"];

export function DepositForm({ compact = false, onComplete }: { compact?: boolean; onComplete?: () => void }) {
  const { rooms, addDeposit } = useTally();
  const navigate = useNavigate();
  const [step, setStep] = useState(1);
  const [guest, setGuest] = useState("");
  const [phone, setPhone] = useState("");
  const [room, setRoom] = useState(rooms.find((item) => item.status === "Available")?.number ?? "106");
  const [nights, setNights] = useState(1);
  const [amount, setAmount] = useState(490);
  const [currency, setCurrency] = useState<"GHS" | "USD">("GHS");
  const [method, setMethod] = useState<PaymentMethod>("MTN MoMo");
  const [complete, setComplete] = useState(false);

  function finish() {
    if (!guest.trim()) return;
    addDeposit({ guest, phone: `+233 ${phone.replace(/^0/, "")}`, room, nights, amount, currency, method });
    setComplete(true);
    onComplete?.();
  }

  if (complete) return <div className="animate-fade-in-up py-10 text-center"><span className="mx-auto flex size-14 items-center justify-center rounded-full bg-success text-background"><Check /></span><h2 className="mt-5 text-2xl font-semibold">Night locked. Tally updated.</h2><p className="mt-2 text-sm text-muted-foreground">Room {room} is secured for {guest}. The receipt is ready.</p><div className="mt-6 flex justify-center gap-3"><Button variant="outline" className="rounded-full" onClick={() => window.print()}><Printer />Print receipt</Button><Button className="rounded-full" onClick={() => navigate({ to: "/dashboard" })}>View dashboard</Button></div></div>;

  return (
    <div className={compact ? "" : "mx-auto max-w-3xl"}>
      <div className="mb-8 flex gap-2" aria-label={`Step ${step} of 4`}>{[1,2,3,4].map((item) => <span key={item} className={`h-1.5 flex-1 rounded-full ${item <= step ? "bg-primary" : "bg-border"}`} />)}</div>
      {step === 1 && <section className="animate-fade-in-up"><p className="text-xs font-bold uppercase tracking-[0.14em] text-muted-foreground">01 — Guest</p><h2 className="mt-2 text-2xl font-semibold">Who is checking in?</h2><div className="mt-6 grid gap-5 md:grid-cols-2"><label className="text-sm font-medium">Full name<input autoFocus value={guest} onChange={(e) => setGuest(e.target.value)} placeholder="e.g. Adwoa Nyarko" className="mt-2 w-full rounded-md border border-input bg-background px-4 py-3 outline-none focus:ring-2 focus:ring-ring" /></label><label className="text-sm font-medium">Ghana phone<input value={phone} onChange={(e) => setPhone(e.target.value)} placeholder="024 000 0000" className="mt-2 w-full rounded-md border border-input bg-background px-4 py-3 outline-none focus:ring-2 focus:ring-ring" /><span className="mt-2 block text-xs text-muted-foreground">Saved with +233 country prefix</span></label></div></section>}
      {step === 2 && <section className="animate-fade-in-up"><p className="text-xs font-bold uppercase tracking-[0.14em] text-muted-foreground">02 — Stay</p><h2 className="mt-2 text-2xl font-semibold">Choose a room and nights</h2><div className="mt-6 grid grid-cols-2 gap-3 md:grid-cols-4">{rooms.map((item) => <button key={item.number} disabled={item.status !== "Available" && item.number !== room} onClick={() => { setRoom(item.number); setAmount(item.rate); }} className={`rounded-md border p-4 text-left transition-colors disabled:cursor-not-allowed disabled:opacity-35 ${room === item.number ? "border-primary bg-primary text-primary-foreground" : "border-border bg-background hover:border-foreground"}`}><b className="text-lg">{item.number}</b><span className="mt-1 block text-xs opacity-70">{item.type}</span></button>)}</div><label className="mt-6 block text-sm font-medium">Nights<input type="number" min="1" max="30" value={nights} onChange={(e) => setNights(Number(e.target.value))} className="mt-2 w-32 rounded-md border border-input px-4 py-3" /></label></section>}
      {step === 3 && <section className="animate-fade-in-up"><p className="text-xs font-bold uppercase tracking-[0.14em] text-muted-foreground">03 — Payment</p><h2 className="mt-2 text-2xl font-semibold">Take the deposit</h2><div className="mt-6 flex max-w-sm gap-2"><button onClick={() => setCurrency("GHS")} className={`rounded-full px-4 py-2 text-sm font-semibold ${currency === "GHS" ? "bg-primary text-primary-foreground" : "border border-border"}`}>GH₵</button><button onClick={() => setCurrency("USD")} className={`rounded-full px-4 py-2 text-sm font-semibold ${currency === "USD" ? "bg-primary text-primary-foreground" : "border border-border"}`}>USD</button></div><label className="mt-5 block text-sm font-medium">Deposit amount<input type="number" value={amount} onChange={(e) => setAmount(Number(e.target.value))} className="mt-2 w-full rounded-md border border-input px-4 py-3 text-2xl font-semibold" /></label><div className="mt-5 grid gap-3 md:grid-cols-2">{methods.map((item) => <button key={item} onClick={() => setMethod(item)} className={`rounded-md border px-4 py-3 text-left text-sm font-medium ${method === item ? "border-primary bg-secondary" : "border-border"}`}>{item}</button>)}</div></section>}
      {step === 4 && <section className="animate-fade-in-up"><p className="text-xs font-bold uppercase tracking-[0.14em] text-muted-foreground">04 — Confirm</p><h2 className="mt-2 text-2xl font-semibold">Lock night and issue proof</h2><div className="mt-6 divide-y divide-border rounded-md border border-border bg-secondary p-5">{[["Guest",guest],["Room / stay",`${room} · ${nights} night${nights === 1 ? "" : "s"}`],["Deposit",`${currency === "GHS" ? "GH₵" : "$"}${amount.toLocaleString()}`],["Payment",method]].map(([label,value]) => <div key={label} className="flex justify-between gap-4 py-3 text-sm"><span className="text-muted-foreground">{label}</span><b className="text-right">{value}</b></div>)}</div></section>}
      <div className="mt-10 flex justify-between"><Button variant="outline" className="rounded-full" disabled={step === 1} onClick={() => setStep((value) => value - 1)}><ChevronLeft />Back</Button>{step < 4 ? <Button className="rounded-full" disabled={step === 1 && !guest.trim()} onClick={() => setStep((value) => value + 1)}>Continue<ChevronRight /></Button> : <Button className="rounded-full" onClick={finish}><Printer />Lock Night & Print Receipt</Button>}</div>
    </div>
  );
}