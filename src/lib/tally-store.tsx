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

const roomStatuses = new Set(["Occupied", "Locked", "Available", "Cleaning"]);
const paymentMethods = new Set(["MTN MoMo", "Telecel Cash", "Cash Till", "Visa / Mastercard"]);

function isStoredRoom(value: unknown): value is Room {
  if (!value || typeof value !== "object") return false;
  const room = value as Partial<Room>;
  return typeof room.number === "string" && typeof room.type === "string" && typeof room.rate === "number" && typeof room.status === "string" && roomStatuses.has(room.status);
}

function isStoredTransaction(value: unknown): value is Transaction {
  if (!value || typeof value !== "object") return false;
  const transaction = value as Partial<Transaction>;
  return typeof transaction.id === "string" && typeof transaction.guest === "string" && typeof transaction.room === "string" && typeof transaction.amount === "number" && Number.isFinite(transaction.amount) && typeof transaction.method === "string" && paymentMethods.has(transaction.method) && (transaction.currency === "GHS" || transaction.currency === "USD");
}

const TallyContext = createContext<TallyContextValue | null>(null);

export function TallyProvider({ children }: { children: ReactNode }) {
  const [rooms, setRooms] = useState(initialRooms);
  const [transactions, setTransactions] = useState(initialTransactions);

  useEffect(() => {
    const saved = window.localStorage.getItem("tally-live-state");
    if (!saved) return;
    try {
      const value = JSON.parse(saved) as { rooms?: Room[]; transactions?: Transaction[] };
      if (Array.isArray(value.rooms) && value.rooms.length === initialRooms.length && value.rooms.every(isStoredRoom) && Array.isArray(value.transactions) && value.transactions.every(isStoredTransaction)) {
        setRooms(value.rooms);
        setTransactions(value.transactions);
      } else {
        window.localStorage.removeItem("tally-live-state");
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