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
    
select * from customers;

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
foreign key (customer_id) references customers (customer_id);

delete from transactions;

alter table transactions
auto_increment = 1000;

insert into transactions (amount, customer_id)
values (4.99, 3), (2.45,2), (4.85,1),(1.00,2), (6.35,4), (9.85,1), (7.00, null);
select * from transactions;

delete from customers
where customer_id = 3; 

select transaction_id, amount, first_name, last_name
from transactions inner join customers
on transactions.customer_id = customers.customer_id;

select *
from transactions left join customers
on transactions.customer_id = customers.customer_id;

select *
from transactions right join customers
on transactions.customer_id = customers.customer_id;



alter table transactions
drop foreign key fk_customer_id;

drop table customers;
drop table transactions;