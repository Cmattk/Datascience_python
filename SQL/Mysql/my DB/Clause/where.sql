create table if not exists customers(
    customer_id int primary key,
    name varchar(50),
    city varchar(50),
    age int
);

insert ignore into customers
values 
    (1, 'John Doe', 'New York', 30),
    (2, 'Jane Smith', 'Los Angeles', 25),
    (3, 'Robert Johnson', 'New York', 35),
    (4, 'Alice Brown', 'Chicago', 28),
    (5, 'Charlie Wilson', 'Los Angeles',40);



select * from customers where city = 'New York';

select * from customers where city = 'Los Angeles' and age < 30;

SELECT * FROM customers WHERE city = 'New York' OR age > 35;

-- names start with the "J" letter. % is pattern matching starting with J.
SELECT * FROM customers WHERE name LIKE 'J%';

SELECT * FROM customers WHERE city IN ('New York', 'Chicago');

SELECT * FROM customers WHERE city = 'New York' ORDER BY age DESC;

