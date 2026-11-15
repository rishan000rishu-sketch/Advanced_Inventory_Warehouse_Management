-- ======================DATABASE Creation=============================

create database inventory_management;
use inventory_management;

-- =========================== Suppliers table =================================

create table suppliers(supplier_id int PRIMARY KEY auto_increment, supplier_name varchar(100) not null,
email varchar(100), phone varchar(20), created_at timestamp default current_timestamp);

describe suppliers;

insert into suppliers(supplier_name,email,phone) values
('ABC Technologies','abc@gmail.com','9876543210'),
('XYZ Electronics','xyz@gmail.com','9123456780'),
('Global Traders','global@gmail.com','9988776655');
select * from suppliers;

-- ======================== Products Table ===============================

create table products(product_id int primary key auto_increment, product_name varchar(100)not null,
sku varchar(50) unique not null, category varchar(50), price decimal(10,2) not null, created_at timestamp default current_timestamp);

describe products;

insert into products(product_name,sku,category,price) values
('Dell Laptop','LAP001','Electronics',55000.00),
('HP Keyboard','KEY001','Accessories',1200.50),
('Logitech Mouse','MOU001','Accessories',750.00),
('Samsung Monitor','MON001','Electronics',12500.00),
('Canon Printer','PRI001','Electronics',8500.00);
select * from products;