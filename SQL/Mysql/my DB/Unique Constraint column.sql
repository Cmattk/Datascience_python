CREATE TABLE products(
	product_id int,
    product_name varchar(25) unique,
    price decimal(4,2)
);

# alter table products add constraint unique(product_name);

insert into products values 
	(1, 'Hamburger', 3.99), 
    (2,'Fries', 1.89),
    (3,'Soda', 1.00),
    (4,'Ice Cream', 1.75);

select * from products