CREATE DATABASE QLBH;
USE QLBH;
CREATE TABLE customer (
    cid INT PRIMARY KEY,
    name VARCHAR(255),
    cage INT
);

CREATE TABLE orders (
    oid INT PRIMARY KEY,
    cid INT,
    odate DATETIME,
    ototalprice INT,
    FOREIGN KEY (cid) REFERENCES customer(cid)
);

CREATE TABLE products (
    pid INT PRIMARY KEY,
    pname VARCHAR(255),
    pprice DOUBLE
);

CREATE TABLE order_detail (
    oid INT,
    pid INT,
    odqty INT,
    PRIMARY KEY (oid, pid),
    FOREIGN KEY (oid) REFERENCES orders(oid),
    FOREIGN KEY (pid) REFERENCES products(pid)
);



INSERT INTO customer (cid, name, cage) VALUES
(1, 'Minh Quan', 10),
(2, 'Ngoc Oanh', 20),
(3, 'Hong Ha', 50);


INSERT INTO orders (oid, cid, odate, ototalprice) VALUES
(1, 1, '2006-03-21', NULL),
(2, 2, '2006-03-23', NULL),
(3, 1, '2006-03-16', NULL);


INSERT INTO products (pid, pname, pprice) VALUES
(1, 'May Giat', 3),
(2, 'Tu Lanh', 5),
(3, 'Dieu Hoa', 7),
(4, 'Quat', 1),
(5, 'Bep Dien', 2);


INSERT INTO order_detail (oid, pid, odqty) VALUES
(1, 1, 3),
(1, 3, 7),
(1, 4, 2),
(2, 1, 1),
(3, 1, 8),
(2, 5, 4),
(2, 3, 3);

-- 2
select oid, cid, odate, ototalprice 
from orders 
order by odate desc;

-- 3
select pname, pprice 
from products 
where pprice = (select max(pprice) from products);

-- 4
select distinct c.name, p.pname
from customer c 
join orders o on c.cid = o.cid
join order_detail od on o.oid = od.oid
join products p on od.pid = p.pid
order by c.name;

-- 5
select name 
from customer 
where cid not in (select cid from orders);

-- 6
select 
    o.oid,
    o.odate,
    od.odqty,
    p.pname,
    p.pprice
from orders o
join order_detail od on o.oid = od.oid  
join products p on od.pid = p.pid
order by o.oid;

-- 7
select 
    o.oid,
    o.odate,
    sum(od.odqty * p.pprice) as total_price
from orders o
join order_detail od on o.oid = od.oid
join products p on od.pid = p.pid
group by o.oid, o.odate
order by o.oid;


-- 8
-- Xóa ràng buộc khóa ngoại
alter table order_detail drop foreign key fk_order_detail_order;
alter table order_detail drop foreign key fk_order_detail_product;
alter table orders drop foreign key fk_orders_customer;

-- Xóa khóa chính
alter table customer drop primary key;
alter table orders drop primary key;
alter table products drop primary key;
alter table order_detail drop primary key;
