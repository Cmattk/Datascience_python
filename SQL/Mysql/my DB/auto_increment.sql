use mydb;

create table transactions(
	transaction_id int primary key auto_increment,
    amount decimal (5,2)
);

insert into transactions (amount)
values (4.99), (2.45), (4.85),(1.00), (6.35), (9.85);

select * from transactions;

alter table transactions
auto_increment = 1000;

delete from transactions;
select * from transactions;

insert into transactions (amount)
values (4.99), (2.45), (4.85),(1.00), (6.35), (9.85);
select * from transactions;

drop table transactions;