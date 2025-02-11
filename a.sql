create database shop;
use shop;

create table tbl_users(
	user_id int primary key auto_increment,
    user_name varchar(50) unique not null,
    user_fullname varchar(100)  not null,
    email  varchar(100) unique not null,
    user_address text,
    user_phone varchar(20) not null unique
    
);

create table tbl_employees(
	emp_id char(5) primary key,
    user_id int not null unique,
    emp_position varchar(50),
    emp_hire_date date,
    salary int not null check(salary>0),
    status bit default(1),
	foreign key (user_id) references tbl_users (user_id)
);

create table tbl_orders(
	order_id int primary key auto_increment,
    user_id int not null unique,
    order_date date default(curdate()),
    order_total_amount int,
    foreign key (user_id) references tbl_users (user_id)
);

create table tbl_products(
	pro_id char(5) primary key,
    pro_name varchar(100) unique not null,
    pro_price int not null check(pro_price >0),
    pro_quantity int,
    pro_status bit default(1)
);


create table tbl_order_detail(
	order_detail_id int primary key auto_increment,
    order_id int,
    pro_id char(5),
    order_detail_quantity int check(order_detail_quantity>0),
    order_detail_price int not null,
	foreign key (order_id) references tbl_orders (order_id),
    foreign key (pro_id) references tbl_products (pro_id)
);


alter table tbl_orders
add column order_status enum('Pending','Processing','Completed','Cancelled') not null;


alter table tbl_users
modify user_phone char(11);

alter table tbl_users
drop column email;


INSERT INTO tbl_users (user_name, user_fullname, user_address, user_phone)
VALUES 
('user1', 'John Doe', '123 Main St', '01234567890'),
('user2', 'Jane Smith', '456 Elm St', '09876543210'),
('user3', 'Alice Brown', '789 Oak St', '03456789012'),
('user4', 'Alice Brown`12', '789 Oak St323', '03456789052');


INSERT INTO tbl_employees (emp_id, user_id, emp_position, emp_hire_date, salary, status)
VALUES 
('E0001', 1, 'Manager', '2023-06-15', 50000, 1),
('E0002', 2, 'Sales', '2022-08-20', 30000, 1),
('E0003', 3, 'Cashier', '2021-05-10', 25000, 1);


INSERT INTO tbl_orders (user_id, order_date, order_total_amount, order_status)
VALUES 
(1, '2024-02-01', 1200, 'Pending'),
(2, '2024-02-02', 2500, 'Completed'),
(3, '2024-02-03', 3200, 'Processing');

INSERT INTO tbl_products (pro_id, pro_name, pro_price, pro_quantity, pro_status)
VALUES 
('P0001', 'Laptop', 1500, 10, 1),
('P0002', 'Smartphone', 800, 20, 1),
('P0003', 'Tablet', 600, 15, 1),
('P0004', 'Tablet2', 700, 125, 1);


INSERT INTO tbl_order_detail (order_id, pro_id, order_detail_quantity, order_detail_price)
VALUES 
(1, 'P0001', 1, 1500),
(2, 'P0002', 2, 1600),
(3, 'P0003', 3, 1800);

--  4
select o.order_id, o.order_date, o.order_total_amount,o.order_status from tbl_orders o;

select distinct u.user_name from tbl_orders o join tbl_users u on o.user_id = u.user_id group by o.user_id;
-- 5
select p.pro_name, sum(p.pro_quantity) as total from tbl_products p join tbl_order_detail od on p.pro_id = od.pro_id group by p.pro_name having total>0;

select p.pro_name,p.pro_price, p.pro_quantity, sum(p.pro_quantity*pro_price) as total_revenue
from tbl_products p join tbl_order_detail od on p.pro_id = od.pro_id group by p.pro_name order by (p.pro_quantity*pro_price) desc;

-- 6
select u.user_fullname, count(o.order_id) as total_orders from tbl_users u join tbl_orders o on u.user_id = o.user_id
						  group by u.user_id; 

select u.user_fullname, count(o.order_id) as total_orders from tbl_users u join tbl_orders o on u.user_id = o.user_id
						  group by u.user_id having count(o.order_id)>2; 

-- 7
select u.user_fullname, sum(od.order_detail_price*od.order_detail_quantity) as total_spent from tbl_users u join tbl_orders o on u.user_id = o.user_id
						  join tbl_order_detail od on o.order_id = od.order_id
                          group by u.user_id
                          order by total_spent desc
                          limit 5;
                          
-- 8
select u.user_fullname,e.emp_position from tbl_employees e join tbl_users u on u.user_id = e.user_id;

-- 9
select u.user_fullname,od.order_detail_quantity*od.order_detail_price as total_spent from tbl_users u join tbl_orders o on u.user_id = o.user_id
						  join tbl_order_detail od on o.order_id = od.order_id where
                          (select max(od.order_detail_quantity*od.order_detail_price) as result from tbl_order_detail od)
                           = od.order_detail_quantity*od.order_detail_price;
-- 10                          
select * from tbl_products p where p.pro_id not in (select od.pro_id from tbl_products  p join tbl_order_detail od on p.pro_id = od.pro_id);

