const BASE_URL = "http://localhost:8000";

export async function fetchVendors() {
  const res = await fetch(`${BASE_URL}/vendors`);
  return res.json();
}

export async function fetchPOs() {
  const res = await fetch(`${BASE_URL}/purchase-orders`);
  return res.json();
}

export async function fetchInvoices() {
  const res = await fetch(`${BASE_URL}/invoices`);
  return res.json();
}