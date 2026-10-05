import { createFileRoute } from "@tanstack/react-router";
import { Download, Minus, Plus, Scissors, ShoppingBag, Trash2 } from "lucide-react";
import { useState } from "react";
import { PageHeading } from "@/components/page-heading";
import { TallyMark } from "@/components/tally-logo";
import { Button } from "@/components/ui/button";
import { products } from "@/lib/merch-data";
import { useMerchOrders, type OrderLine } from "@/lib/merch-orders";
import { formatGHS } from "@/lib/tally-data";

export const Route = createFileRoute("/merch")({
  head: () => ({
    meta: [
      { title: "Brand & Merch — TALLY" },
      {
        name: "description",
        content: "TALLY brand kit, logo downloads, and apparel previews for Accra hospitality.",
      },
      { property: "og:title", content: "Brand & Merch — TALLY" },
      {
        property: "og:description",
        content:
          "Streetwear-grade guest-house brand system. Interest list only — not a live payment checkout.",
      },
      { property: "og:type", content: "website" },
      { name: "twitter:card", content: "summary_large_image" },
    ],
  }),
  component: MerchPage,
});

const logoSvg = `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 48 48"><path d="M8 9h7v22H8zM19 9h7v22h-7zM30 9h7v22h-7zM7 35 39 7l4 5L11 40zM19 29h18v12H19z"/><circle cx="28" cy="35" r="2.6" fill="white"/></svg>`;

function MerchPage() {
  const { orders, placeOrder, removeOrder } = useMerchOrders();
  const [lines, setLines] = useState<OrderLine[]>([]);
  const [sizes, setSizes] = useState<Record<string, string>>({});
  const [customer, setCustomer] = useState("");
  const [phone, setPhone] = useState("+233 ");
  const [pickup, setPickup] = useState("Desk pickup — Osu");
  const [note, setNote] = useState("");
  const [confirmation, setConfirmation] = useState<string | null>(null);
  const [error, setError] = useState<string | null>(null);

  const total = lines.reduce((sum, line) => sum + line.price * line.quantity, 0);

  const addLine = (productId: string) => {
    const product = products.find((item) => item.id === productId);
    if (!product) return;
    const size = sizes[product.id] ?? product.sizes[0] ?? "One size";
    setConfirmation(null);
    setLines((current) => {
      const existing = current.find((line) => line.productId === product.id && line.size === size);
      if (existing)
        return current.map((line) =>
          line === existing ? { ...line, quantity: line.quantity + 1 } : line,
        );
      return [
        ...current,
        { productId: product.id, name: product.name, size, quantity: 1, price: product.price },
      ];
    });
  };

  const changeQuantity = (index: number, delta: number) =>
    setLines((current) =>
      current.flatMap((line, position) => {
        if (position !== index) return [line];
        const quantity = line.quantity + delta;
        return quantity < 1 ? [] : [{ ...line, quantity }];
      }),
    );

  const submit = () => {
    if (lines.length === 0) return setError("Add at least one item to the bag.");
    if (customer.trim().length < 2) return setError("Enter the customer name.");
    if (phone.replace(/\D/g, "").length < 9) return setError("Enter a valid phone number.");
    const order = placeOrder({
      customer: customer.trim(),
      phone: phone.trim(),
      pickup,
      note: note.trim(),
      lines,
      total,
    });
    setLines([]);
    setCustomer("");
    setPhone("+233 ");
    setNote("");
    setError(null);
    setConfirmation(`Order ${order.id} placed — ${formatGHS(order.total)}, payable on pickup.`);
  };

  const downloadLogo = () => {
    const url = URL.createObjectURL(new Blob([logoSvg], { type: "image/svg+xml" }));
    const anchor = document.createElement("a");
    anchor.href = url;
    anchor.download = "tally-mark.svg";
    anchor.click();
    URL.revokeObjectURL(url);
  };

  return (
    <>
      <PageHeading
        eyebrow="Brand kit · not a live checkout"
        title="Merch & brand"
        description="Logo downloads and apparel previews for Accra hospitality. Interest list stays in this browser session only — no payments, no localStorage till."
        action={
          <Button onClick={downloadLogo} variant="outline" className="rounded-full">
            <Download />
            Download SVG
          </Button>
        }
      />
      <div className="mx-auto max-w-7xl px-6 py-12">
        <div className="grid gap-10 lg:grid-cols-[1.4fr_1fr]">
          <section className="grid gap-4 sm:grid-cols-2">
            {products.map((product) => (
              <article key={product.id} className="flex flex-col border border-border">
                <img
                  src={product.image}
                  alt={product.name}
                  loading="lazy"
                  width={816}
                  height={816}
                  className="aspect-square w-full object-cover"
                />
                <div className="flex flex-1 flex-col border-t border-border p-5">
                  <b>{product.name}</b>
                  <p className="mt-1 text-xs text-muted-foreground">{product.blurb}</p>
                  <strong className="mt-4 block text-xl">{formatGHS(product.price)}</strong>
                  <div className="mt-4 flex items-center gap-2">
                    <select
                      aria-label={`Size for ${product.name}`}
                      value={sizes[product.id] ?? product.sizes[0]}
                      onChange={(event) =>
                        setSizes((current) => ({ ...current, [product.id]: event.target.value }))
                      }
                      className="rounded-full border border-input bg-background px-4 py-2 text-sm"
                    >
                      {product.sizes.map((size) => (
                        <option key={size}>{size}</option>
                      ))}
                    </select>
                    <Button className="flex-1 rounded-full" onClick={() => addLine(product.id)}>
                      <Plus />
                      Add
                    </Button>
                  </div>
                </div>
              </article>
            ))}
          </section>

          <section className="h-fit border border-border lg:sticky lg:top-24">
            <div className="flex items-center gap-3 border-b border-border bg-secondary p-5">
              <ShoppingBag className="size-5" />
              <b className="text-sm">Order bag</b>
            </div>
            <div className="p-5">
              {lines.length === 0 ? (
                <p className="text-sm text-muted-foreground">
                  Nothing in the bag yet. Add a hoodie, cap or pin to start an order.
                </p>
              ) : (
                <ul className="divide-y divide-border border border-border">
                  {lines.map((line, index) => (
                    <li
                      key={`${line.productId}-${line.size}`}
                      className="flex items-center justify-between gap-3 p-3 text-sm"
                    >
                      <span>
                        <b>{line.name}</b>
                        <span className="block text-xs text-muted-foreground">
                          {line.size} · {formatGHS(line.price)}
                        </span>
                      </span>
                      <span className="flex items-center gap-2">
                        <Button
                          variant="ghost"
                          size="icon"
                          aria-label={`Remove one ${line.name}`}
                          onClick={() => changeQuantity(index, -1)}
                        >
                          <Minus />
                        </Button>
                        <b>{line.quantity}</b>
                        <Button
                          variant="ghost"
                          size="icon"
                          aria-label={`Add one ${line.name}`}
                          onClick={() => changeQuantity(index, 1)}
                        >
                          <Plus />
                        </Button>
                      </span>
                    </li>
                  ))}
                </ul>
              )}
              <p className="mt-5 flex justify-between text-sm">
                <span>Order total</span>
                <strong className="text-lg">{formatGHS(total)}</strong>
              </p>

              <div className="mt-5 space-y-3">
                <input
                  value={customer}
                  onChange={(event) => setCustomer(event.target.value)}
                  placeholder="Customer name"
                  className="w-full rounded-full border border-input bg-background px-4 py-2 text-sm"
                />
                <input
                  value={phone}
                  onChange={(event) => setPhone(event.target.value)}
                  placeholder="+233 55 000 0000"
                  className="w-full rounded-full border border-input bg-background px-4 py-2 text-sm"
                />
                <select
                  value={pickup}
                  onChange={(event) => setPickup(event.target.value)}
                  className="w-full rounded-full border border-input bg-background px-4 py-2 text-sm"
                >
                  <option>Desk pickup — Osu</option>
                  <option>Desk pickup — Labadi</option>
                  <option>Courier within Accra</option>
                </select>
                <textarea
                  value={note}
                  onChange={(event) => setNote(event.target.value)}
                  rows={2}
                  placeholder="Note for the desk (optional)"
                  className="w-full border border-input bg-background p-3 text-sm"
                />
              </div>
              {error && (
                <p className="mt-4 border border-border bg-secondary p-3 text-sm">{error}</p>
              )}
              {confirmation && (
                <p className="mt-4 border border-border bg-secondary p-3 text-sm">{confirmation}</p>
              )}
              <Button className="mt-5 w-full rounded-full" onClick={submit}>
                Place order · pay on pickup
              </Button>
            </div>
          </section>
        </div>

        <section className="mt-16 border-t border-border pt-12">
          <h2 className="text-xl font-semibold">Orders at the desk</h2>
          {orders.length === 0 ? (
            <p className="mt-3 text-sm text-muted-foreground">No merch orders recorded yet.</p>
          ) : (
            <div className="mt-5 overflow-x-auto border border-border">
              <table className="w-full min-w-160 text-left text-sm">
                <thead className="bg-secondary text-xs text-muted-foreground">
                  <tr>
                    <th className="p-4">Order</th>
                    <th>Customer</th>
                    <th>Items</th>
                    <th>Fulfilment</th>
                    <th>Total</th>
                    <th></th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-border">
                  {orders.map((order) => (
                    <tr key={order.id}>
                      <td className="p-4">
                        <b>{order.id}</b>
                        <span className="block text-xs text-muted-foreground">
                          {order.placedAt}
                        </span>
                      </td>
                      <td>
                        {order.customer}
                        <span className="block text-xs text-muted-foreground">{order.phone}</span>
                      </td>
                      <td className="py-3">
                        {order.lines.map((line) => (
                          <span key={`${line.productId}-${line.size}`} className="block text-xs">
                            {line.quantity}× {line.name} ({line.size})
                          </span>
                        ))}
                      </td>
                      <td className="text-xs">
                        {order.pickup}
                        {order.note && (
                          <span className="block text-muted-foreground">{order.note}</span>
                        )}
                      </td>
                      <td className="font-semibold">{formatGHS(order.total)}</td>
                      <td>
                        <Button
                          variant="ghost"
                          size="icon"
                          aria-label={`Delete order ${order.id}`}
                          onClick={() => removeOrder(order.id)}
                        >
                          <Trash2 />
                        </Button>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          )}
        </section>

        <section className="mt-16 border-t border-border pt-12">
          <div className="grid gap-10 lg:grid-cols-2">
            <div>
              <p className="text-xs font-bold uppercase tracking-[0.16em] text-muted-foreground">
                Logo anatomy
              </p>
              <div className="mt-5 flex aspect-video items-center justify-center border border-border bg-secondary">
                <TallyMark className="size-40" />
              </div>
              <div className="mt-4 flex gap-6 text-sm">
                <span>Four-bar tally geometry</span>
                <span>Accra room keyhole</span>
              </div>
            </div>
            <div>
              <p className="text-xs font-bold uppercase tracking-[0.16em] text-muted-foreground">
                Color tokens
              </p>
              <div className="mt-5 grid grid-cols-2">
                {[
                  ["Obsidian", "#0A0A0A", "bg-obsidian", "text-pure-milk"],
                  ["Pure Milk", "#FAFAFA", "bg-pure-milk", "text-obsidian"],
                  ["Cedi Gold", "#D4AF37", "bg-gold", "text-obsidian"],
                  ["Warm Slate", "#71717A", "bg-warm-slate", "text-pure-milk"],
                ].map(([name, hex, bg, text]) => (
                  <div key={name} className={`aspect-square p-5 ${bg} ${text}`}>
                    <b>{name}</b>
                    <span className="mt-1 block text-xs opacity-70">{hex}</span>
                  </div>
                ))}
              </div>
            </div>
          </div>
        </section>

        <section className="mt-16 grid gap-8 border-t border-border pt-12 lg:grid-cols-2">
          <div>
            <p className="text-xs font-bold uppercase tracking-[0.16em] text-muted-foreground">
              Typography
            </p>
            <h2 className="mt-5 text-6xl font-bold">Inter</h2>
            <p className="mt-4 text-muted-foreground">
              400 Regular · 500 Medium · 600 Semibold · 700 Bold
            </p>
            <p className="mt-8 text-3xl">
              GH₵ 8,420.00
              <br />
              Room 108 — Locked
            </p>
          </div>
          <div className="border border-dashed border-border p-6">
            <Scissors />
            <p className="mt-12 text-xs font-bold uppercase tracking-[0.16em]">Production note</p>
            <h3 className="mt-3 text-2xl font-semibold">Keep the keyhole open.</h3>
            <p className="mt-3 text-sm leading-6 text-muted-foreground">
              For embroidery below 35mm, use a minimum 2.5mm keyhole aperture and no less than 1.8mm
              between tally bars.
            </p>
          </div>
        </section>
      </div>
    </>
  );
}
