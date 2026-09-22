import { createContext, useCallback, useContext, useEffect, useMemo, useState, type ReactNode } from "react";
import { initialRooms, initialTransactions, type PaymentMethod, type Room, type Transaction } from "./tally-data";

type DepositInput = Omit<Transaction, "id" | "receptionist" | "time">;

export type StorageStatus = "ok" | "recovered" | "migrated";

export type ShiftClose = {
  closed: boolean;
  closedAt?: string;
  notes?: string;
  counted?: Partial<Record<PaymentMethod, number>>;
  expected?: number;
  countedTotal?: number;
};

type TallyContextValue = {
  rooms: Room[];
  transactions: Transaction[];
  total: number;
  occupied: number;
  storageStatus: StorageStatus;
  shift: ShiftClose;
  addDeposit: (deposit: DepositInput) => Transaction;
  toggleRoom: (roomNumber: string) => void;
  resetData: () => void;
  closeShift: (input: { notes: string; counted: Partial<Record<PaymentMethod, number>> }) => void;
  reopenShift: () => void;
  exportData: () => string;
  importData: (raw: string) => { ok: true } | { ok: false; error: string };
};

const STORAGE_KEY = "tally-live-state";
const CURRENT_VERSION = 3;

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

function isStoredShift(value: unknown): value is ShiftClose {
  if (!value || typeof value !== "object") return false;
  return typeof (value as ShiftClose).closed === "boolean";
}

type Payload = { version: number; rooms: Room[]; transactions: Transaction[]; shift: ShiftClose };

const emptyShift: ShiftClose = { closed: false };

/** Brings any older saved shape up to the current version, or returns null when unrecoverable. */
function migrate(raw: unknown): { payload: Payload; migrated: boolean } | null {
  if (!raw || typeof raw !== "object") return null;
  const value = raw as Partial<Payload>;
  const version = typeof value.version === "number" ? value.version : 1;
  const rooms = Array.isArray(value.rooms) ? value.rooms.filter(isStoredRoom) : [];
  const transactions = Array.isArray(value.transactions) ? value.transactions.filter(isStoredTransaction) : [];
  if (rooms.length === 0) return null;

  // v1 saves could omit rooms added later — backfill from the seed roster.
  const merged = initialRooms.map((seed) => rooms.find((room) => room.number === seed.number) ?? seed);
  // v2 saves have no shift-close record — start the day open.
  const shift = isStoredShift(value.shift) ? value.shift : emptyShift;
  return { payload: { version: CURRENT_VERSION, rooms: merged, transactions, shift }, migrated: version !== CURRENT_VERSION };
}

const TallyContext = createContext<TallyContextValue | null>(null);

export function TallyProvider({ children }: { children: ReactNode }) {
  const [rooms, setRooms] = useState(initialRooms);
  const [transactions, setTransactions] = useState(initialTransactions);
  const [shift, setShift] = useState<ShiftClose>(emptyShift);
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
      setShift(result.payload.shift);
      if (result.migrated) setStorageStatus("migrated");
    } catch {
      window.localStorage.removeItem(STORAGE_KEY);
      setStorageStatus("recovered");
    }
  }, []);

  useEffect(() => {
    window.localStorage.setItem(STORAGE_KEY, JSON.stringify({ version: CURRENT_VERSION, rooms, transactions, shift }));
  }, [rooms, transactions, shift]);

  const resetData = useCallback(() => {
    window.localStorage.setItem(STORAGE_KEY, JSON.stringify({ version: CURRENT_VERSION, rooms: initialRooms, transactions: initialTransactions, shift: emptyShift }));
    setRooms(initialRooms);
    setTransactions(initialTransactions);
    setShift(emptyShift);
    setStorageStatus("recovered");
  }, []);

  const exportData = useCallback(
    () => JSON.stringify({ version: CURRENT_VERSION, exportedAt: new Date().toISOString(), rooms, transactions, shift }, null, 2),
    [rooms, transactions, shift],
  );

  const importData = useCallback((raw: string): { ok: true } | { ok: false; error: string } => {
    let parsed: unknown;
    try {
      parsed = JSON.parse(raw);
    } catch {
      return { ok: false, error: "That file is not a readable Tally backup." };
    }
    const result = migrate(parsed);
    if (!result) return { ok: false, error: "That backup does not contain valid till data." };
    setRooms(result.payload.rooms);
    setTransactions(result.payload.transactions);
    setShift(result.payload.shift);
    setStorageStatus(result.migrated ? "migrated" : "ok");
    return { ok: true };
  }, []);

  const value = useMemo<TallyContextValue>(() => {
    const total = transactions.filter((item) => item.currency === "GHS").reduce((sum, item) => sum + item.amount, 0);
    return {
      rooms,
      transactions,
      storageStatus,
      shift,
      resetData,
      exportData,
      importData,
      total,
      occupied: rooms.filter((room) => room.status === "Occupied" || room.status === "Locked").length,
      closeShift: ({ notes, counted }) => setShift({
        closed: true,
        closedAt: new Date().toLocaleString("en-GB", { hour: "2-digit", minute: "2-digit", day: "2-digit", month: "short" }),
        notes,
        counted,
        expected: total,
        countedTotal: Object.values(counted).reduce<number>((sum, amount) => sum + (Number(amount) || 0), 0),
      }),
      reopenShift: () => setShift(emptyShift),
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
    };
  }, [rooms, transactions, shift, storageStatus, resetData, exportData, importData]);

  return <TallyContext.Provider value={value}>{children}</TallyContext.Provider>;
}

export function useTally() {
  const context = useContext(TallyContext);
  if (!context) throw new Error("useTally must be used within TallyProvider");
  return context;
}
