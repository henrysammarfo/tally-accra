import { createContext, useCallback, useContext, useEffect, useMemo, useState, type ReactNode } from "react";
import { initialRooms, initialTransactions, type Room, type Transaction } from "./tally-data";

type DepositInput = Omit<Transaction, "id" | "receptionist" | "time">;

export type StorageStatus = "ok" | "recovered" | "migrated";

type TallyContextValue = {
  rooms: Room[];
  transactions: Transaction[];
  total: number;
  occupied: number;
  storageStatus: StorageStatus;
  addDeposit: (deposit: DepositInput) => Transaction;
  toggleRoom: (roomNumber: string) => void;
  resetData: () => void;
};

const STORAGE_KEY = "tally-live-state";
const CURRENT_VERSION = 2;

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

type Payload = { version: number; rooms: Room[]; transactions: Transaction[] };

/** Brings any older saved shape up to the current version, or returns null when unrecoverable. */
function migrate(raw: unknown): { payload: Payload; migrated: boolean } | null {
  if (!raw || typeof raw !== "object") return null;
  const value = raw as Partial<Payload>;
  const version = typeof value.version === "number" ? value.version : 1;
  const rooms = Array.isArray(value.rooms) ? value.rooms.filter(isStoredRoom) : [];
  const transactions = Array.isArray(value.transactions) ? value.transactions.filter(isStoredTransaction) : [];
  if (rooms.length === 0) return null;

  // v1 saves could omit rooms that were added later — backfill from the seed roster.
  const merged = initialRooms.map((seed) => rooms.find((room) => room.number === seed.number) ?? seed);
  return { payload: { version: CURRENT_VERSION, rooms: merged, transactions }, migrated: version !== CURRENT_VERSION };
}

const TallyContext = createContext<TallyContextValue | null>(null);

export function TallyProvider({ children }: { children: ReactNode }) {
  const [rooms, setRooms] = useState(initialRooms);
  const [transactions, setTransactions] = useState(initialTransactions);
  const [storageStatus, setStorageStatus] = useState<StorageStatus>("ok");

  useEffect(() => {
    const saved = window.localStorage.getItem(STORAGE_KEY);
    if (!saved) return;
    try {
      const result = migrate(JSON.parse(saved));
      if (!result) {
        window.localStorage.removeItem(STORAGE_KEY);
        setStorageStatus("recovered");
        return;
      }
      setRooms(result.payload.rooms);
      setTransactions(result.payload.transactions);
      if (result.migrated) setStorageStatus("migrated");
    } catch {
      window.localStorage.removeItem(STORAGE_KEY);
      setStorageStatus("recovered");
    }
  }, []);

  useEffect(() => {
    window.localStorage.setItem(STORAGE_KEY, JSON.stringify({ version: CURRENT_VERSION, rooms, transactions }));
  }, [rooms, transactions]);

  const resetData = useCallback(() => {
    window.localStorage.removeItem(STORAGE_KEY);
    setRooms(initialRooms);
    setTransactions(initialTransactions);
    setStorageStatus("recovered");
  }, []);

  const value = useMemo<TallyContextValue>(() => ({
    rooms,
    transactions,
    storageStatus,
    resetData,
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
  }), [rooms, transactions, storageStatus, resetData]);

  return <TallyContext.Provider value={value}>{children}</TallyContext.Provider>;
}

export function useTally() {
  const context = useContext(TallyContext);
  if (!context) throw new Error("useTally must be used within TallyProvider");
  return context;
}
