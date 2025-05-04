use mydb;
insert into products
values 
	(6,'Straw', 0.00),
	(7,'Napkin', 0.00),
    (8,'Folk', 0.00),
    (9,'Spoon', 0.00);
    
 delete from products  
 where product_id >= 6;
 
alter table products
alter price set default 0;

SELECT * FROM products;

insert into products (product_id, product_name)
values 
	(6,'Straw'),
	(7,'Napkin'),
    (8,'Folk'),
    (9,'Spoon');
    
SELECT * FROM products;

create table transactions(
	transaction_id int,
    amount decimal (5,2),
    transaction_date datetime default now()
);

insert into transactions (transaction_id, amount)
values (1, 12.29);

select * from transactions;

drop table transactions;