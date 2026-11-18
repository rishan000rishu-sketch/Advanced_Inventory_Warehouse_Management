-- ======================DATABASE Creation=============================

create database inventory_management;
use inventory_management;

--                       =====================================
--                                   Tables Creation
--                       =====================================


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

-- =========================== Purchase_order_item Table ====================================

create table purchase_order_items(po_item_id int primary key auto_increment,purchase_order_id int,product_id int,quantity int default 0 not null,unit_price decimal(10,2),
foreign key(purchase_order_id) references purchase_orders(purchase_order_id), foreign key(product_id) references products(product_id));

describe purchase_order_items;

INSERT INTO purchase_order_items(purchase_order_id, product_id, quantity, unit_price)
VALUES
(1, 1, 10, 55000.00),
(1, 2, 20, 1200.50),
(1, 3, 15, 750.00),
(2, 4, 5, 12500.00),
(2, 5, 3, 8500.00);
select * from purchase_order_items;

-- ============================= Sales_orders Table ==========================

create table sales_orders(sales_order_id int primary key auto_increment,customer_name varchar(80),order_date date,status varchar(20) default 'pending',
created_at timestamp default current_timestamp);

describe sales_orders;

INSERT INTO sales_orders (customer_name, order_date, status)
VALUES
('Arun Kumar', '2026-11-16', 'Pending'),
('Rahul Nair', '2026-11-16', 'Approved'),
('Meera Thomas', '2026-11-17', 'Shipped'),
('Anjali Menon', '2026-11-17', 'Pending'),
('Vishnu Raj', '2026-11-17', 'Delivered');
select * from sales_orders;

-- ================================ Sales_order_items Table ============================

create table sales_order_items(sales_item_id int primary key auto_increment,sales_order_id int,product_id int,quantity int default 0 not null,unit_price decimal(10,2),
foreign key(sales_order_id) references sales_orders(sales_order_id),foreign key(product_id) references products(product_id));

desc sales_order_items;

INSERT INTO sales_order_items
(sales_order_id, product_id, quantity, unit_price)
VALUES
(1, 1, 2, 58000.00),
(1, 2, 5, 1300.00),
(2, 3, 3, 850.00),
(2, 4, 2, 13000.00),
(3, 5, 1, 9000.00),
(4, 1, 1, 58000.00),
(5, 2, 10, 1300.00);
select * from sales_order_items;

-- =============================== Stock_movements =============================

create table stock_movements(movement_id int primary key auto_increment,product_id int not null,warehouse_id int not null,
movement_type varchar(20) not null,quantity int not null,movement_date timestamp default current_timestamp,reference_type varchar(30),reference_id int,
foreign key(product_id) references products(product_id), foreign key(warehouse_id) references warehouses(warehouse_id));

desc stock_movements;

INSERT INTO stock_movements(product_id, warehouse_id, movement_type, quantity, reference_type, reference_id) VALUES
(1, 1, 'IN', 20, 'Purchase', 1),
(2, 1, 'IN', 30, 'Purchase', 1),
(3, 1, 'IN', 15, 'Purchase', 1),
(1, 1, 'OUT', 5, 'Sale', 1),
(2, 1, 'OUT', 10, 'Sale', 1),
(4, 2, 'IN', 10, 'Purchase', 2),
(5, 3, 'OUT', 2, 'Sale', 3);
select * from stock_movements;

-- ================================== Users Table ========================================

CREATE TABLE users (user_id INT PRIMARY KEY AUTO_INCREMENT,username VARCHAR(50) NOT NULL UNIQUE,email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,role VARCHAR(30) NOT NULL DEFAULT 'Staff',created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);

desc users;

INSERT INTO users(username, email, password_hash, role) VALUES
('admin', 'admin@example.com', 'temporary_hash_1', 'Admin'),
('manager1', 'manager@example.com', 'temporary_hash_2', 'Warehouse Manager'),
('staff1', 'staff@example.com', 'temporary_hash_3', 'Staff');
select * from users;

