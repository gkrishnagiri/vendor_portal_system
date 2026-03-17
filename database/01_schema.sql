CREATE SCHEMA IF NOT EXISTS invoicing;

SET search_path TO invoicing;

-- =========================================
-- VENDOR MASTER TABLES
-- =========================================

CREATE TABLE vendors (
    vendor_id BIGSERIAL PRIMARY KEY,
    vendor_code VARCHAR(50) UNIQUE NOT NULL,
    vendor_name VARCHAR(255) NOT NULL,
    vendor_title VARCHAR(255),
    tax_registration_number VARCHAR(100),
    is_active BOOLEAN DEFAULT TRUE,
    is_deleted BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE vendor_emails (
    vendor_email_id BIGSERIAL PRIMARY KEY,
    vendor_id BIGINT REFERENCES vendors(vendor_id),
    email_address VARCHAR(255),
    is_primary BOOLEAN DEFAULT FALSE,
    is_active BOOLEAN DEFAULT TRUE,
    is_deleted BOOLEAN DEFAULT FALSE
);

CREATE TABLE vendor_addresses (
    vendor_address_id BIGSERIAL PRIMARY KEY,
    vendor_id BIGINT REFERENCES vendors(vendor_id),
    address_type VARCHAR(50),
    address_line1 VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    postal_code VARCHAR(20),
    country VARCHAR(100),
    is_primary BOOLEAN DEFAULT FALSE,
    is_active BOOLEAN DEFAULT TRUE,
    is_deleted BOOLEAN DEFAULT FALSE
);

CREATE TABLE vendor_contacts (
    vendor_contact_id BIGSERIAL PRIMARY KEY,
    vendor_id BIGINT REFERENCES vendors(vendor_id),
    contact_name VARCHAR(255),
    contact_number VARCHAR(50),
    contact_type VARCHAR(50),
    is_primary BOOLEAN DEFAULT FALSE,
    is_active BOOLEAN DEFAULT TRUE,
    is_deleted BOOLEAN DEFAULT FALSE
);

-- =========================================
-- PURCHASE ORDERS
-- =========================================

CREATE TABLE po_addresses (
    po_address_id BIGSERIAL PRIMARY KEY,
    entity_name VARCHAR(255),
    address_line1 VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    postal_code VARCHAR(20),
    country VARCHAR(100)
);

CREATE TABLE purchase_orders (
    po_id BIGSERIAL PRIMARY KEY,
    po_number VARCHAR(50) UNIQUE NOT NULL,
    vendor_id BIGINT REFERENCES vendors(vendor_id),
    po_date DATE,
    currency_code VARCHAR(10),
    total_amount NUMERIC(15,2),
    status VARCHAR(50),
    bill_to_name VARCHAR(255),
    bill_to_address_id BIGINT REFERENCES po_addresses(po_address_id),
    is_deleted BOOLEAN DEFAULT FALSE
);

CREATE TABLE purchase_order_lines (
    po_line_id BIGSERIAL PRIMARY KEY,
    po_id BIGINT REFERENCES purchase_orders(po_id),
    line_number INT,
    item_description VARCHAR(255),
    quantity NUMERIC(15,2),
    unit_price NUMERIC(15,2),
    line_total NUMERIC(15,2),
    is_deleted BOOLEAN DEFAULT FALSE
);

-- =========================================
-- INVOICE TRANSACTIONS
-- =========================================

CREATE TABLE vendor_invoice_transactions (
    invoice_txn_id BIGSERIAL PRIMARY KEY,
    vendor_id BIGINT REFERENCES vendors(vendor_id),
    invoice_number VARCHAR(100) NOT NULL,
    invoice_date DATE,
    invoice_amount NUMERIC(15,2),
    currency_code VARCHAR(10),
    po_number VARCHAR(50),
    bill_to_name VARCHAR(255),
    bill_to_address_text TEXT,
    validation_status VARCHAR(50),
    failure_reason TEXT,
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_deleted BOOLEAN DEFAULT FALSE
);

CREATE TABLE vendor_invoice_lines (
    invoice_line_txn_id BIGSERIAL PRIMARY KEY,
    invoice_txn_id BIGINT REFERENCES vendor_invoice_transactions(invoice_txn_id),
    line_number INT,
    description VARCHAR(255),
    quantity NUMERIC(15,2),
    unit_price NUMERIC(15,2),
    line_total NUMERIC(15,2)
);

-- =========================================
-- PROCESSED INVOICES
-- =========================================

CREATE TABLE vendor_invoice_processed (
    invoice_id BIGSERIAL PRIMARY KEY,
    vendor_id BIGINT REFERENCES vendors(vendor_id),
    po_id BIGINT REFERENCES purchase_orders(po_id),
    invoice_number VARCHAR(100),
    invoice_date DATE,
    invoice_amount NUMERIC(15,2),
    currency_code VARCHAR(10),
    validated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    processed_by VARCHAR(255),
    accounting_doc_number VARCHAR(100)
);

CREATE TABLE vendor_invoice_processed_lines (
    invoice_line_id BIGSERIAL PRIMARY KEY,
    invoice_id BIGINT REFERENCES vendor_invoice_processed(invoice_id),
    line_number INT,
    description VARCHAR(255),
    quantity NUMERIC(15,2),
    unit_price NUMERIC(15,2),
    line_total NUMERIC(15,2)
);