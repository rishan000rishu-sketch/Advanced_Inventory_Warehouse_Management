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