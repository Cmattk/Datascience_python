-- EXCEPT Operator
-- is used to compare 2 results sets and 
-- returning the rows available in first result sets and not in 2nd.
-- i.e the difference b2n the 2 datasets

-- MySQL does not have native support for it. Instead, 
-- other methods can be applied to achieve similar results and thus help MYSQL users, 
-- for example, LEFT JOIN or NOT IN.

-- Left Join
select s.student_id, s.student_name, t.teacher_id
from students as s
Left Join  teachers as t on s.student_id = t.teacher_id
where t.teacher_id is null;

select * from employees;

select * from custo;

-- NOT IN
-- selects staff whose IDs do not show in the list of customers IDs
select employee_id, employee_name
from employees as e
where not exists (select * from custo as c where e.employee_id=c.customer_id);


-- create orders table
create table if not exists orders(
    order_id int primary key,
    customer_name varchar(100),
    order_date date 
);

-- create shipped orders table
create table if not exists shipped_orders(
    order_id int primary key,
    ship_date date
);

-- insert values to the tables
insert ignore into orders (order_id, customer_name, order_date)
values
(101, 'Alice', '2024-07-01'),
(102, 'Bob', '2024-07-02'),
(103, 'Charlie', '2024-07-03'),
(104, 'David', '2024-07-04');

INSERT ignore INTO shipped_orders (order_id, ship_date) VALUES
(101, '2024-07-05'),
(103, '2024-07-06');

-- find all orders that have not been shipped yet.
-- left join
select o.order_id, o.customer_name, o.order_date
from orders as o
left join
shipped_orders as s on o.order_id = s.order_id
where s.order_id is null;

-- NOT IN
select order_id, customer_name, order_date
from orders 
where order_id NOT IN (select order_id from shipped_orders);

-- NOT EXISTS
select order_id, customer_name, order_date
from orders as o 
where NOT EXISTS (select 1 from shipped_orders as s
where o.order_id=s.order_id
);

