import hoodie from "@/assets/merch-hoodie.jpg";
import tee from "@/assets/merch-tee.jpg";
import cap from "@/assets/merch-cap.jpg";
import pin from "@/assets/merch-pin.jpg";

export type MerchProduct = {
  id: string;
  name: string;
  blurb: string;
  price: number;
  image: string;
  sizes: string[];
};

export const products: MerchProduct[] = [
  {
    id: "hoodie",
    name: "Obsidian 440 GSM Hoodie",
    blurb: "Heavyweight cotton, gold tally embroidery on the chest.",
    price: 680,
    image: hoodie,
    sizes: ["S", "M", "L", "XL", "2XL"],
  },
  {
    id: "tee",
    name: "Pure Milk Boxy Tee",
    blurb: "Boxy heavyweight tee with the tally mark printed small.",
    price: 260,
    image: tee,
    sizes: ["S", "M", "L", "XL"],
  },
  {
    id: "cap",
    name: "High-density Strapback",
    blurb: "Six-panel strapback, gold keyhole emblem front panel.",
    price: 190,
    image: cap,
    sizes: ["One size"],
  },
  {
    id: "pin",
    name: "Till Receipt Enamel Pin",
    blurb: "Hard enamel, gold plated, butterfly clutch backing.",
    price: 65,
    image: pin,
    sizes: ["One size"],
  },
];

export const guestHouses = [
  { name: "Labadi Rest House", area: "La, Accra" },
  { name: "Osu Courtyard Lodge", area: "Osu, Accra" },
  { name: "Adabraka Key House", area: "Adabraka, Accra" },
  { name: "East Legon Palm Lodge", area: "East Legon, Accra" },
];
