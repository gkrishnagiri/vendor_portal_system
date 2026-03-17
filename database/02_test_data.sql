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