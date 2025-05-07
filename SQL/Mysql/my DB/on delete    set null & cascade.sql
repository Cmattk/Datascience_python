-- on delete set null = when a fk is deleted, replace fk with null
-- on delete cascade  = when a fk is deleted, delete row 

alter table transactions drop foreign key fk_customer_id;

alter table transactions
add constraint fk_customer_id
foreign key (customer_id) references customers (customer_id)
on delete set null;

select * from transactions; 

delete from customers where customer_id = 4;

insert into customers
values (4, 'Poppy', 'Puff', 2, 'poppypuff@bellybottom.com');

alter table transactions drop foreign key fk_customer_id;

alter table transactions
add constraint fk_customer_id
foreign key (customer_id) references customers (customer_id)
on delete cascade;

update transactions
set customer_id = 4
where transaction_id = 1005;

delete from customers where customer_id = 4;

select * from transactions; 

select * from customers;

alter table transactions drop foreign key fk_customer_id;

drop table customers;
drop table transactions;

create table customers (
	customer_id int primary key auto_increment,
    first_name varchar(50),
    last_name varchar(50)
);

insert into customers (first_name, last_name)
values 
	('Leslie', 'Knope'),
	('Tom', 'Haverford'),
	('April', 'Ludgate'),
	('Jerry', 'Gergich'),
	('Donna', 'Meagle'),
    ('Ann', 'Perkins');
    
create table transactions(
	transaction_id int primary key auto_increment,
    amount decimal (5,2),
    customer_id int
);

insert into transactions (amount)
values (4.99), (2.45), (4.85),(1.00), (6.35), (9.85);



select * from transactions;

alter table transactions
add constraint fk_customer_id	
foreign key (customer_id) references customers (customer_id)
on delete set null;

delete from transactions;

alter table transactions
auto_increment = 1000;

insert into transactions (amount, customer_id)
values (4.99, 3), (2.45,2), (4.85,1),(1.00,2), (6.35,4), (9.85,1), (7.00, null);

ALTER TABLE transactions
ADD COLUMN order_date DATE;

UPDATE transactions SET order_date = '2025-05-01' WHERE transaction_id = 1000;
UPDATE transactions SET order_date = '2025-05-01' WHERE transaction_id = 1001;
UPDATE transactions SET order_date = '2025-05-02' WHERE transaction_id = 1002;
UPDATE transactions SET order_date = '2025-05-02' WHERE transaction_id = 1003;
UPDATE transactions SET order_date = '2025-05-02' WHERE transaction_id = 1004;
UPDATE transactions SET order_date = '2025-05-03' WHERE transaction_id = 1005;
UPDATE transactions SET order_date = '2025-05-03' WHERE transaction_id = 1006;

ALTER TABLE customers
ADD COLUMN email varchar(50);


UPDATE customers
SET email = CONCAT(LOWER(first_name), LOWER(last_name), '@bellybottom.com');

UPDATE employees
SET email = CONCAT(LOWER(first_name),LOWER(last_name), '@krubyhotel.com');


select * from transactions;
select * from customers;
select email from employees;

