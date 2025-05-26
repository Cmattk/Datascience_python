-- create index
-- By creating indexes, MySQL can quickly locate and retrieve relevant data, reducing the need for full table scans and minimizing response times.
-- create index is DDL used to create indexes on tables.
drop table p_index;

create table p_index (
    col1 int primary key,
    col2 int not null,
    col3 int not null,
    col4 varchar(20),
    index (col2,col3)
);

-- Adding an Index to an Existing Table --
create index index_1
on p_index (col4);
 
desc p_index;

drop table products_index;

create table if not exists products_index(
    product_id int auto_increment primary key,
    product_name varchar(50),
    category varchar(50),
    price decimal(10,2)
);

insert ignore into products_index (product_name, category, price)
values
('Laptop','Electronics', 1200.00), 
('Smartphone', 'Electronics', 800.00), 
('Coffe maker', 'Appliances', 100.00), 
('Running Shoes', 'Clothing', 80.00), 
('Digital Camera', 'Electronics', 500.00);

select * from products_index;

/*
Before creating a Index, we will analyze the query execution plan for a query filtering by the category column.
*/

explain select * from products_index where category = 'Electronics';

create index idx_category on products_index(category);

explain select * from products_index where category = 'Eletronics';

-- drop index -- 
DROP INDEX idx_category ON products_index;


