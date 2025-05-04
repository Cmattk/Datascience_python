use mydb;

create table transactions(
	transaction_id int primary key,
    amount decimal (5,2)
);

insert into transactions
values (1, 570.00), (2, 566.35), (3, 459.85),(4, 570.00), (5, 566.35), (6, 459.85);

select * from transaction;

alter table transactions
add constraint 
primary key (transaction_id);

select amount
from transactions
where transaction_id = 4;



drop table transactions;