-- HAVING clause allows you to apply conditions to the groups created by the GROUP BY clause.
-- useful when you want to filter data based on aggregate values such as sums, averages, counts, etc.
-- HAVING clause filters groups after the aggregation has been performed.

use geeks4geeks;

create table if not exists sales(
    id int auto_increment primary key,
    product varchar(50),
    quantity int,
    price decimal (10,2)
);

insert ignore into sales (product, quantity, price) 
values
    ('Laptop', 2, 1000),
    ('Mouse', 10, 20),
    ('Laptop', 3, 1000),
    ('Mouse', 6, 20),
    ('Keyboard', 5, 50),
    ('Headphones', 5, 800),
    ('Mouse', 6, 20);

select * from sales

select product, count(*)
from sales
GROUP by product
HAVING count(*) > 1;

select product, sum(quantity)
from sales
group by product
having sum(quantity) > 10;

