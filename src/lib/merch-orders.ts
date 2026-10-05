import { useCallback, useState } from "react";

export type OrderLine = {
  productId: string;
  name: string;
  size: string;
  quantity: number;
  price: number;
};

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

/** In-memory brand interest list only — not a live storefront checkout. No localStorage. */
export function useMerchOrders() {
  const [orders, setOrders] = useState<MerchOrder[]>([]);

  const placeOrder = useCallback((order: Omit<MerchOrder, "id" | "placedAt">) => {
    const record: MerchOrder = {
      ...order,
      id: `TM-${Math.floor(1000 + Math.random() * 9000)}`,
      placedAt: new Date().toLocaleString("en-GB", {
        hour: "2-digit",
        minute: "2-digit",
        day: "2-digit",
        month: "short",
      }),
    };
    setOrders((current) => [record, ...current]);
    return record;
  }, []);

  const removeOrder = useCallback(
    (id: string) => setOrders((current) => current.filter((order) => order.id !== id)),
    [],
  );

  return { orders, placeOrder, removeOrder };
}
