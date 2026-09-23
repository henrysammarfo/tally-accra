import { createFileRoute } from "@tanstack/react-router";
import { Download, Lock, Printer, RotateCcw, Server, ShieldCheck, Sparkles, Upload } from "lucide-react";
import { useRef, useState } from "react";
import { PageHeading } from "@/components/page-heading";
import { Button } from "@/components/ui/button";
import { useTally } from "@/lib/tally-store";
import { formatGHS, type PaymentMethod } from "@/lib/tally-data";
import { askTallyInsight } from "@/lib/tally-insight.functions";

export const Route = createFileRoute("/ledger")({
  head: () => ({
    meta: [
      { title: "Daily Ledger & Audit — TALLY" },
      { name: "description", content: "Close the day with shift totals, exports, and a clear audit trail." },
      { property: "og:title", content: "Daily Ledger & Audit — TALLY" },
      { property: "og:description", content: "End-of-day reporting, backup and restore, and immutable deposit proof." },
      { property: "og:type", content: "website" },
      { name: "twitter:card", content: "summary_large_image" },
    ],
  }),
  component: LedgerPage,
});

const methods: PaymentMethod[] = ["MTN MoMo", "Telecel Cash", "Cash Till", "Visa / Mastercard"];

function LedgerPage() {
  const { transactions, total, shift, closeShift, reopenShift, exportData, importData } = useTally();
  const [counted, setCounted] = useState<Partial<Record<PaymentMethod, string>>>({});
  const [notes, setNotes] = useState("");
  const [step, setStep] = useState(0);
  const [restoreMessage, setRestoreMessage] = useState<string | null>(null);
  const [question, setQuestion] = useState("");
  const [answer, setAnswer] = useState<string | null>(null);
  const [insightError, setInsightError] = useState<string | null>(null);
  const [asking, setAsking] = useState(false);
  const fileInput = useRef<HTMLInputElement>(null);

  const expectedByMethod = methods.map((method) => ({
    method,
    expected: transactions.filter((item) => item.method === method && item.currency === "GHS").reduce((sum, item) => sum + item.amount, 0),
  }));
  const countedTotal = methods.reduce((sum, method) => sum + (Number(counted[method]) || 0), 0);
  const variance = countedTotal - total;

  const exportCsv = () => {
    const rows = [["Receipt", "Guest", "Room", "Method", "Amount", "Currency", "Receptionist", "Time"], ...transactions.map((t) => [t.id, t.guest, t.room, t.method, String(t.amount), t.currency, t.receptionist, t.time])];
    downloadFile(rows.map((r) => r.map((v) => `"${v}"`).join(",")).join("\n"), "text/csv", "tally-daily-ledger.csv");
  };

  const downloadBackup = () => downloadFile(exportData(), "application/json", "tally-backup.json");

  const onRestore = async (file: File) => {
    const result = importData(await file.text());
    setRestoreMessage(result.ok ? "Till data restored from backup." : result.error);
  };

  const ask = async () => {
    if (question.trim().length < 3) return;
    setAsking(true);
    setAnswer(null);
    setInsightError(null);
    try {
      const context = [
        `Closing total: ${formatGHS(total)} across ${transactions.length} deposits.`,
        ...expectedByMethod.map((row) => `${row.method}: ${formatGHS(row.expected)}`),
        ...transactions.map((t) => `${t.id} | ${t.guest} | Room ${t.room} | ${t.method} | ${t.currency} ${t.amount} | ${t.receptionist} | ${t.time}`),
        shift.closed ? `Shift closed at ${shift.closedAt}. Counted ${formatGHS(shift.countedTotal ?? 0)} vs expected ${formatGHS(shift.expected ?? 0)}. Notes: ${shift.notes || "none"}.` : "Shift is still open.",
      ].join("\n");
      const result = await askTallyInsight({ data: { question: question.trim(), context: context.slice(0, 8000) } });
      if ("error" in result) setInsightError(result.error);
      else setAnswer(result.text);
    } catch {
      setInsightError("The insight could not be generated. Please try again.");
    } finally {
      setAsking(false);
    }
  };

  const shifts = ["Akosua", "Michael"].map((name) => ({ name, rows: transactions.filter((t) => t.receptionist === name) }));

  return (
    <>
      <PageHeading
        eyebrow="Close protocol · 19 Sep 2026"
        title="Daily Ledger & Audit"
        description="Count every cedi, review every handover, and close without ambiguity."
        action={
          <div className="flex flex-wrap gap-2">
            <Button variant="outline" className="rounded-full" onClick={downloadBackup}><Download />Backup</Button>
            <Button variant="outline" className="rounded-full" onClick={() => fileInput.current?.click()}><Upload />Restore</Button>
            <Button variant="outline" className="rounded-full" onClick={() => window.print()}><Printer />Print</Button>
            <Button className="rounded-full" onClick={exportCsv}><Download />Export CSV</Button>
            <input ref={fileInput} type="file" accept="application/json" className="hidden" onChange={(event) => { const file = event.target.files?.[0]; if (file) void onRestore(file); event.target.value = ""; }} />
          </div>
        }
      />
      <div className="mx-auto max-w-7xl px-6 py-10">
        {restoreMessage && <p className="mb-8 border border-border bg-secondary p-4 text-sm">{restoreMessage}</p>}
        <div className="grid gap-4 md:grid-cols-3">
          <div className="border border-border p-5 md:col-span-2">
            <span className="text-xs text-muted-foreground">Closing tally</span>
            <strong className="mt-3 block text-5xl md:text-7xl">{formatGHS(total)}</strong>
            <p className="mt-6 text-sm text-muted-foreground">{transactions.length} verified deposits across {new Set(transactions.map((t) => t.room)).size} rooms.</p>
          </div>
          <div className="border border-border bg-primary p-5 text-primary-foreground">
            <ShieldCheck className="size-6 text-gold" />
            <p className="mt-14 text-xs uppercase tracking-[0.14em] text-primary-foreground/55">Audit state</p>
            <b className="mt-2 block text-2xl">{shift.closed ? "Day locked" : "Balanced"}</b>
            <span className="mt-1 block text-xs text-primary-foreground/55">{shift.closed ? `Closed ${shift.closedAt}` : "All receipts accounted for"}</span>
          </div>
        </div>

        <section className="mt-10 border border-border">
          <div className="flex flex-wrap items-center justify-between gap-3 border-b border-border bg-secondary p-5">
            <div className="flex items-center gap-3"><Lock className="size-5" /><b className="text-sm">Guided shift close</b></div>
            {shift.closed ? (
              <Button variant="outline" className="rounded-full" onClick={() => { reopenShift(); setStep(0); }}><RotateCcw />Reopen day</Button>
            ) : (
              <span className="text-xs text-muted-foreground">Step {step + 1} of 3</span>
            )}
          </div>
          {shift.closed ? (
            <div className="grid gap-px bg-border md:grid-cols-3">
              <div className="bg-background p-5"><span className="text-xs text-muted-foreground">Expected</span><b className="mt-2 block text-2xl">{formatGHS(shift.expected ?? 0)}</b></div>
              <div className="bg-background p-5"><span className="text-xs text-muted-foreground">Counted</span><b className="mt-2 block text-2xl">{formatGHS(shift.countedTotal ?? 0)}</b></div>
              <div className="bg-background p-5"><span className="text-xs text-muted-foreground">Handover notes</span><p className="mt-2 text-sm">{shift.notes || "No notes recorded."}</p></div>
            </div>
          ) : (
            <div className="p-5">
              {step === 0 && (
                <div>
                  <h3 className="text-lg font-semibold">1. Review deposits</h3>
                  <div className="mt-4 max-h-64 overflow-y-auto border border-border">
                    <table className="w-full text-left text-sm">
                      <tbody className="divide-y divide-border">
                        {transactions.map((item) => (
                          <tr key={item.id}><td className="p-3"><b>{item.guest}</b><span className="block text-xs text-muted-foreground">{item.id} · Room {item.room}</span></td><td className="p-3">{item.method}</td><td className="p-3 text-right font-semibold">{item.currency === "GHS" ? formatGHS(item.amount) : `$${item.amount}`}</td></tr>
                        ))}
                      </tbody>
                    </table>
                  </div>
                  <Button className="mt-5 rounded-full" onClick={() => setStep(1)}>Deposits reviewed</Button>
                </div>
              )}
              {step === 1 && (
                <div>
                  <h3 className="text-lg font-semibold">2. Reconcile payment methods</h3>
                  <div className="mt-4 grid gap-4 md:grid-cols-2">
                    {expectedByMethod.map((row) => (
                      <label key={row.method} className="block border border-border p-4 text-sm">
                        <span className="flex justify-between"><b>{row.method}</b><span className="text-muted-foreground">Expected {formatGHS(row.expected)}</span></span>
                        <input type="number" inputMode="decimal" value={counted[row.method] ?? ""} onChange={(event) => setCounted((current) => ({ ...current, [row.method]: event.target.value }))} placeholder="Counted amount" className="mt-3 w-full rounded-full border border-input bg-background px-4 py-2" />
                      </label>
                    ))}
                  </div>
                  <p className="mt-4 text-sm text-muted-foreground">Counted {formatGHS(countedTotal)} · Variance {variance === 0 ? "none" : `${variance > 0 ? "+" : "−"}${formatGHS(Math.abs(variance))}`}</p>
                  <div className="mt-5 flex gap-3"><Button variant="outline" className="rounded-full" onClick={() => setStep(0)}>Back</Button><Button className="rounded-full" onClick={() => setStep(2)}>Continue</Button></div>
                </div>
              )}
              {step === 2 && (
                <div>
                  <h3 className="text-lg font-semibold">3. Handover notes & lock</h3>
                  <textarea value={notes} onChange={(event) => setNotes(event.target.value)} rows={4} placeholder="Anything the morning desk should know…" className="mt-4 w-full border border-input bg-background p-4 text-sm" />
                  <div className="mt-5 flex gap-3"><Button variant="outline" className="rounded-full" onClick={() => setStep(1)}>Back</Button><Button className="rounded-full" onClick={() => closeShift({ notes, counted: Object.fromEntries(methods.map((method) => [method, Number(counted[method]) || 0])) })}><Lock />Lock the day</Button></div>
                </div>
              )}
            </div>
          )}
        </section>

        <section className="mt-10 border border-border">
          <div className="flex items-center gap-3 border-b border-border bg-secondary p-5"><Sparkles className="size-5" /><b className="text-sm">Ask about this shift</b></div>
          <div className="p-5">
            <div className="flex flex-col gap-3 md:flex-row">
              <input value={question} onChange={(event) => setQuestion(event.target.value)} placeholder="e.g. Which payment method carried the most deposits tonight?" className="flex-1 rounded-full border border-input bg-background px-5 py-3 text-sm" />
              <Button className="rounded-full" disabled={asking || question.trim().length < 3} onClick={() => void ask()}>{asking ? "Thinking…" : "Get insight"}</Button>
            </div>
            {insightError && <p className="mt-4 border border-border bg-secondary p-4 text-sm">{insightError}</p>}
            {answer && <p className="mt-4 whitespace-pre-wrap border border-border p-4 text-sm">{answer}</p>}
          </div>
        </section>

        <div className="mt-10 grid gap-8 lg:grid-cols-2">
          <section>
            <h2 className="text-xl font-semibold">Shift breakdown</h2>
            <div className="mt-4 divide-y divide-border border border-border">
              {shifts.map((entry) => (
                <div key={entry.name} className="flex items-center justify-between p-5"><div><b>{entry.name}</b><span className="mt-1 block text-xs text-muted-foreground">{entry.rows.length} deposits</span></div><strong>{formatGHS(entry.rows.reduce((sum, t) => sum + t.amount, 0))}</strong></div>
              ))}
            </div>
          </section>
          <section>
            <h2 className="text-xl font-semibold">Protocol log</h2>
            <div className="mt-4 border border-border">
              <div className="flex items-center gap-3 border-b border-border bg-secondary p-4"><Server className="size-5" /><b className="text-sm">Serverpod architecture</b></div>
              {["createDeposit → verifyPayment → issueReceipt", "listToday → reconcileShift → closeLedger", "assignNight → lockRoom → appendAudit"].map((line, index) => (
                <div key={line} className="flex justify-between border-b border-border p-4 font-mono text-xs last:border-0"><span>{line}</span><span className="text-success">#{String(index + 1).padStart(3, "0")}</span></div>
              ))}
            </div>
          </section>
        </div>
      </div>
    </>
  );
}

function downloadFile(content: string, type: string, filename: string) {
  const url = URL.createObjectURL(new Blob([content], { type }));
  const anchor = document.createElement("a");
  anchor.href = url;
  anchor.download = filename;
  anchor.click();
  URL.revokeObjectURL(url);
}
