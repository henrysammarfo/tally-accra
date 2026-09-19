import { createContext, useContext, useEffect, useMemo, useState, type ReactNode } from "react";
import { initialRooms, initialTransactions, type Room, type Transaction } from "./tally-data";

type DepositInput = Omit<Transaction, "id" | "receptionist" | "time">;

type TallyContextValue = {
  rooms: Room[];
  transactions: Transaction[];
  total: number;
  occupied: number;
  addDeposit: (deposit: DepositInput) => Transaction;
  toggleRoom: (roomNumber: string) => void;
};

const TallyContext = createContext<TallyContextValue | null>(null);

export function TallyProvider({ children }: { children: ReactNode }) {
  const [rooms, setRooms] = useState(initialRooms);
  const [transactions, setTransactions] = useState(initialTransactions);

  useEffect(() => {
    const saved = window.localStorage.getItem("tally-live-state");
    if (!saved) return;
    try {
      const value = JSON.parse(saved) as { rooms?: Room[]; transactions?: Transaction[] };
      if (value.rooms && value.transactions) {
        setRooms(value.rooms);
        setTransactions(value.transactions);
      }
    } catch {
      window.localStorage.removeItem("tally-live-state");
    }
  }, []);

  useEffect(() => {
    window.localStorage.setItem("tally-live-state", JSON.stringify({ rooms, transactions }));
  }, [rooms, transactions]);

  const value = useMemo<TallyContextValue>(() => ({
    rooms,
    transactions,
    total: transactions.filter((item) => item.currency === "GHS").reduce((sum, item) => sum + item.amount, 0),
    occupied: rooms.filter((room) => room.status === "Occupied" || room.status === "Locked").length,
    addDeposit: (deposit) => {
      const transaction: Transaction = {
        ...deposit,
        id: `TL-${7843 + transactions.length - initialTransactions.length}`,
        receptionist: "Akosua",
        time: new Date().toLocaleTimeString("en-GB", { hour: "2-digit", minute: "2-digit" }),
      };
      setTransactions((current) => [transaction, ...current]);
      setRooms((current) => current.map((room) => room.number === deposit.room ? {
        ...room,
        status: "Locked",
        guest: deposit.guest,
        deposit: deposit.amount,
        checkIn: "Today, now",
        checkOut: `${deposit.nights} night${deposit.nights === 1 ? "" : "s"}`,
      } : room));
      return transaction;
    },
    toggleRoom: (roomNumber) => setRooms((current) => current.map((room) => room.number === roomNumber ? {
      ...room,
      status: room.status === "Available" ? "Locked" : "Available",
    } : room)),
  }), [rooms, transactions]);

  return <TallyContext.Provider value={value}>{children}</TallyContext.Provider>;
}

export function useTally() {
  const context = useContext(TallyContext);
  if (!context) throw new Error("useTally must be used within TallyProvider");
  return context;
}