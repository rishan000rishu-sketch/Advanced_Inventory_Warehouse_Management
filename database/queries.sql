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

-- ======================== Warehouses Table =========================

create table warehouses(warehouse_id int primary key auto_increment, warehouse_name varchar(100) not null,location varchar(50) not null,
created_at timestamp default current_timestamp);

describe warehouses;

insert into warehouses(warehouse_name,location) values
('Main warehouse','Kochi'),
('North warehouse','Calicut'),
('South warehouse','Trivandrum');
select * from warehouses;

-- ================== Inventory Table =============================

create table inventory(inventory_id int primary key auto_increment, product_id int not null, warehouse_id int not null, quantity int not null default 0,
updated_at timestamp default current_timestamp on update current_timestamp, foreign key(product_id) references products(product_id),
foreign key(warehouse_id) references warehouses(warehouse_id), unique(product_id,warehouse_id));

describe inventory;

insert into inventory(product_id,warehouse_id,quantity) values
(1,1,50),
(1,2,30),
(2,1,100),
(2,3,75),
(3,1,150),
(4,2,40),
(5,3,25);
select * from inventory;

-- ======================== Purchase_orders Table =============================

create table purchase_orders(purchase_order_id int primary key auto_increment,supplier_id int, order_date date not null,status varchar(50) default 'pending',
created_at timestamp default current_timestamp, foreign key(supplier_id) references suppliers(supplier_id));

describe purchase_orders;

insert into purchase_orders(supplier_id,order_date,status) values
(1,'2026-11-16','Pending'),
(2,'2026-11-16','Approved'),
(1,'2026-11-17','Received'),
(3,'2026-11-17','Pending');
select * from purchase_orders;

