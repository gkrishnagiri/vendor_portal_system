import React, { useEffect, useState } from "react";
import { fetchVendors, fetchPOs, fetchInvoices } from "./api";

function App() {
  const [activeTab, setActiveTab] = useState("vendors");

  const [vendors, setVendors] = useState([]);
  const [pos, setPOs] = useState([]);
  const [invoices, setInvoices] = useState([]);

  useEffect(() => {
    fetchVendors().then(setVendors);
    fetchPOs().then(setPOs);
    fetchInvoices().then(setInvoices);
  }, []);

  return (
    <div style={{ padding: "20px" }}>
      <h1>Vendor Portal</h1>

      {/* Navigation */}
      <div style={{ marginBottom: "20px" }}>
        <button onClick={() => setActiveTab("vendors")}>Vendors</button>
        <button onClick={() => setActiveTab("pos")}>Purchase Orders</button>
        <button onClick={() => setActiveTab("invoices")}>Invoices</button>
      </div>

      {/* Vendors Table */}
      {activeTab === "vendors" && (
        <>
          <h2>Vendors</h2>
          <table border="1" cellPadding="10">
            <thead>
              <tr>
                <th>ID</th>
                <th>Code</th>
                <th>Name</th>
                <th>Title</th>
              </tr>
            </thead>
            <tbody>
              {vendors.map((v) => (
                <tr key={v.vendor_id}>
                  <td>{v.vendor_id}</td>
                  <td>{v.vendor_code}</td>
                  <td>{v.vendor_name}</td>
                  <td>{v.vendor_title}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </>
      )}

      {/* Purchase Orders Table */}
      {activeTab === "pos" && (
        <>
          <h2>Purchase Orders</h2>
          <table border="1" cellPadding="10">
            <thead>
              <tr>
                <th>ID</th>
                <th>PO Number</th>
                <th>Vendor ID</th>
                <th>Date</th>
                <th>Amount</th>
                <th>Status</th>
              </tr>
            </thead>
            <tbody>
              {pos.map((po) => (
                <tr key={po.po_id}>
                  <td>{po.po_id}</td>
                  <td>{po.po_number}</td>
                  <td>{po.vendor_id}</td>
                  <td>{po.po_date}</td>
                  <td>{po.total_amount}</td>
                  <td>{po.status}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </>
      )}

      {/* Invoices Table */}
      {activeTab === "invoices" && (
        <>
          <h2>Invoices</h2>
          <table border="1" cellPadding="10">
            <thead>
              <tr>
                <th>ID</th>
                <th>Vendor</th>
                <th>Invoice Number</th>
                <th>Date</th>
                <th>Amount</th>
                <th>Currency</th>
                <th>PO</th>
                <th>Status</th>
              </tr>
            </thead>
            <tbody>
              {invoices.map((inv) => (
                <tr key={inv.invoice_txn_id}>
                  <td>{inv.invoice_txn_id}</td>
                  <td>{inv.vendor_id}</td>
                  <td>{inv.invoice_number}</td>
                  <td>{inv.invoice_date}</td>
                  <td>{inv.invoice_amount}</td>
                  <td>{inv.currency_code}</td>
                  <td>{inv.po_number}</td>
                  <td>{inv.validation_status}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </>
      )}
    </div>
  );
}

export default App;