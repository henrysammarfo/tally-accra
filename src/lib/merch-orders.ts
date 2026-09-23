import { useCallback, useEffect, useState } from "react";

export type OrderLine = { productId: string; name: string; size: string; quantity: number; price: number };

export type MerchOrder = {
  id: string;
  customer: string;
  phone: string;
  pickup: string;
  note: string;
  lines: OrderLine[];
  total: number;
  placedAt: string;
};

const ORDERS_KEY = "tally-merch-orders";

function isOrder(value: unknown): value is MerchOrder {
  if (!value || typeof value !== "object") return false;
  const order = value as Partial<MerchOrder>;
  return typeof order.id === "string" && typeof order.customer === "string" && Array.isArray(order.lines) && typeof order.total === "number";
}

export function useMerchOrders() {
  const [orders, setOrders] = useState<MerchOrder[]>([]);
  const [loaded, setLoaded] = useState(false);

  useEffect(() => {
    try {
      const saved = window.localStorage.getItem(ORDERS_KEY);
      const parsed: unknown = saved ? JSON.parse(saved) : [];
      setOrders(Array.isArray(parsed) ? parsed.filter(isOrder) : []);
    } catch {
      window.localStorage.removeItem(ORDERS_KEY);
    }
    setLoaded(true);
  }, []);

  useEffect(() => {
    if (loaded) window.localStorage.setItem(ORDERS_KEY, JSON.stringify(orders));
  }, [orders, loaded]);

  const placeOrder = useCallback((order: Omit<MerchOrder, "id" | "placedAt">) => {
    const record: MerchOrder = {
      ...order,
      id: `TM-${Math.floor(1000 + Math.random() * 9000)}`,
      placedAt: new Date().toLocaleString("en-GB", { hour: "2-digit", minute: "2-digit", day: "2-digit", month: "short" }),
    };
    setOrders((current) => [record, ...current]);
    return record;
  }, []);

  const removeOrder = useCallback((id: string) => setOrders((current) => current.filter((order) => order.id !== id)), []);

  return { orders, placeOrder, removeOrder };
}
