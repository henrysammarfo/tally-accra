export type PaymentMethod = "MTN MoMo" | "Telecel Cash" | "Cash Till" | "Visa / Mastercard";
export type RoomStatus = "Occupied" | "Locked" | "Available" | "Cleaning";

export type Room = {
  number: string;
  type: string;
  rate: number;
  status: RoomStatus;
  guest?: string;
  deposit?: number;
  checkIn?: string;
  checkOut?: string;
};

export type Transaction = {
  id: string;
  guest: string;
  phone: string;
  room: string;
  nights: number;
  amount: number;
  currency: "GHS" | "USD";
  method: PaymentMethod;
  receptionist: string;
  time: string;
};

export const initialRooms: Room[] = [
  {
    number: "101",
    type: "Executive Suite",
    rate: 920,
    status: "Occupied",
    guest: "Nana Mensah",
    deposit: 920,
    checkIn: "18 Sep, 14:10",
    checkOut: "20 Sep, 11:00",
  },
  {
    number: "102",
    type: "Deluxe King",
    rate: 680,
    status: "Locked",
    guest: "Ama Owusu",
    deposit: 680,
    checkIn: "19 Sep, 16:25",
    checkOut: "21 Sep, 11:00",
  },
  {
    number: "103",
    type: "Standard Studio",
    rate: 490,
    status: "Occupied",
    guest: "Kojo Asare",
    deposit: 490,
    checkIn: "19 Sep, 12:40",
    checkOut: "20 Sep, 11:00",
  },
  { number: "104", type: "Deluxe King", rate: 680, status: "Cleaning" },
  {
    number: "105",
    type: "Executive Suite",
    rate: 920,
    status: "Locked",
    guest: "Efua Addo",
    deposit: 1200,
    checkIn: "19 Sep, 19:05",
    checkOut: "22 Sep, 11:00",
  },
  { number: "106", type: "Standard Studio", rate: 490, status: "Available" },
  {
    number: "107",
    type: "Deluxe King",
    rate: 680,
    status: "Occupied",
    guest: "Kwame Boateng",
    deposit: 680,
    checkIn: "18 Sep, 21:30",
    checkOut: "20 Sep, 11:00",
  },
  { number: "108", type: "Standard Studio", rate: 490, status: "Available" },
];

export const initialTransactions: Transaction[] = [
  {
    id: "TL-7842",
    guest: "Efua Addo",
    phone: "+233 24 611 8042",
    room: "105",
    nights: 3,
    amount: 1200,
    currency: "GHS",
    method: "MTN MoMo",
    receptionist: "Akosua",
    time: "19:05",
  },
  {
    id: "TL-7841",
    guest: "Ama Owusu",
    phone: "+233 55 031 4470",
    room: "102",
    nights: 2,
    amount: 680,
    currency: "GHS",
    method: "Telecel Cash",
    receptionist: "Akosua",
    time: "16:25",
  },
  {
    id: "TL-7840",
    guest: "Kojo Asare",
    phone: "+233 20 942 1003",
    room: "103",
    nights: 1,
    amount: 490,
    currency: "GHS",
    method: "Cash Till",
    receptionist: "Michael",
    time: "12:40",
  },
  {
    id: "TL-7839",
    guest: "Nana Mensah",
    phone: "+233 27 745 2201",
    room: "101",
    nights: 2,
    amount: 920,
    currency: "GHS",
    method: "Visa / Mastercard",
    receptionist: "Michael",
    time: "09:18",
  },
];

export const formatGHS = (value: number) =>
  `GH₵${value.toLocaleString("en-GH", { minimumFractionDigits: 2 })}`;
