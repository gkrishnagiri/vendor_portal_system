SET search_path TO invoicing;

INSERT INTO vendors (vendor_code,vendor_name,vendor_title)
VALUES
('VEND001','Alpha Industrial Supplies','Alpha Industries Pvt Ltd'),
('VEND002','Beta Manufacturing Co','Beta Manufacturing Ltd'),
('VEND003','Gamma IT Solutions','Gamma Technologies'),
('VEND004','Delta Logistics Services','Delta Logistics Pvt Ltd'),
('VEND005','Epsilon Office Equipment','Epsilon Corp');

INSERT INTO vendor_emails (vendor_id,email_address,is_primary)
VALUES
(1,'finance@alpha.com',TRUE),
(1,'sales@alpha.com',FALSE),
(2,'accounts@beta.com',TRUE),
(3,'billing@gamma.com',TRUE),
(4,'invoices@delta.com',TRUE),
(5,'accounts@epsilon.com',TRUE);

INSERT INTO vendor_addresses
(vendor_id,address_type,address_line1,city,state,postal_code,country,is_primary)
VALUES
(1,'Registered','12 Industrial Area','Bangalore','Karnataka','560001','India',TRUE),
(2,'Registered','45 Manufacturing Park','Chennai','Tamil Nadu','600001','India',TRUE),
(3,'Registered','88 IT Hub','Hyderabad','Telangana','500001','India',TRUE),
(4,'Registered','21 Transport Nagar','Mumbai','Maharashtra','400001','India',TRUE),
(5,'Registered','99 Corporate Street','Delhi','Delhi','110001','India',TRUE);

INSERT INTO vendor_contacts
(vendor_id,contact_name,contact_number,contact_type,is_primary)
VALUES
(1,'Ravi Kumar','9876543210','Finance',TRUE),
(2,'Suresh Nair','9123456780','Accounts',TRUE),
(3,'Anita Sharma','9988776655','Billing',TRUE),
(4,'Mohit Verma','9000011111','Logistics',TRUE),
(5,'Priya Mehta','9555512345','Accounts',TRUE);

INSERT INTO po_addresses
(entity_name,address_line1,city,state,postal_code,country)
VALUES
('ABC Manufacturing Ltd','100 Plant Road','Bangalore','Karnataka','560050','India'),
('XYZ Engineering Pvt Ltd','200 Factory Lane','Chennai','Tamil Nadu','600050','India');

INSERT INTO purchase_orders
(po_number,vendor_id,po_date,currency_code,total_amount,status,bill_to_name,bill_to_address_id)
VALUES
('PO1001',1,'2024-01-15','INR',250000,'Open','ABC Manufacturing Ltd',1),
('PO1002',2,'2024-02-01','INR',150000,'Open','XYZ Engineering Pvt Ltd',2),
('PO1003',3,'2024-02-10','INR',500000,'Closed','ABC Manufacturing Ltd',1),
('PO1004',4,'2024-03-05','INR',300000,'Open','ABC Manufacturing Ltd',1),
('PO1005',5,'2024-03-12','INR',100000,'Open','XYZ Engineering Pvt Ltd',2);

INSERT INTO purchase_order_lines
(po_id,line_number,item_description,quantity,unit_price,line_total)
VALUES
(1,1,'Steel Sheets',100,1000,100000),
(1,2,'Industrial Bolts',500,200,100000),
(1,3,'Machine Parts',50,1000,50000),

(2,1,'Gear Assemblies',20,5000,100000),
(2,2,'Hydraulic Pumps',10,5000,50000),

(3,1,'Software Licenses',50,10000,500000),

(4,1,'Freight Charges',1,300000,300000),

(5,1,'Office Chairs',100,1000,100000);

INSERT INTO vendor_invoice_transactions
(vendor_id,invoice_number,invoice_date,invoice_amount,currency_code,po_number,
 bill_to_name,bill_to_address_text,validation_status,failure_reason)
VALUES

-- valid invoice
(1,'INV-ALPHA-001','2024-01-20',200000,'INR','PO1001',
'ABC Manufacturing Ltd','Bangalore Address','Passed',NULL),

-- PO does not exist
(2,'INV-BETA-001','2024-02-05',50000,'INR','PO9999',
'XYZ Engineering Pvt Ltd','Chennai Address','Failed','Referenced PO does not exist'),

-- vendor mismatch
(3,'INV-GAMMA-001','2024-02-15',500000,'INR','PO1001',
'ABC Manufacturing Ltd','Bangalore Address','Failed','Vendor mismatch'),

-- pending validation
(4,'INV-DELTA-001','2024-03-10',300000,'INR','PO1004',
'ABC Manufacturing Ltd','Bangalore Address','Pending',NULL),

-- amount mismatch
(5,'INV-EPS-001','2024-03-15',120000,'INR','PO1005',
'XYZ Engineering Pvt Ltd','Chennai Address','Failed','Invoice amount exceeds PO');

INSERT INTO vendor_invoice_lines
(invoice_txn_id,line_number,description,quantity,unit_price,line_total)
VALUES
(1,1,'Steel Sheets',100,1000,100000),
(1,2,'Industrial Bolts',500,200,100000),

(2,1,'Gear Assemblies',10,5000,50000),

(3,1,'Software Licenses',50,10000,500000),

(4,1,'Freight Charges',1,300000,300000),

(5,1,'Office Chairs',120,1000,120000);

INSERT INTO vendor_invoice_processed
(vendor_id,po_id,invoice_number,invoice_date,invoice_amount,currency_code,processed_by,accounting_doc_number)
VALUES
(1,1,'INV-ALPHA-001','2024-01-20',200000,'INR','System','ACC-0001');

INSERT INTO vendor_invoice_processed_lines
(invoice_id,line_number,description,quantity,unit_price,line_total)
VALUES
(1,1,'Steel Sheets',100,1000,100000),
(1,2,'Industrial Bolts',500,200,100000);