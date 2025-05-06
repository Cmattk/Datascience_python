-- group by 
-- aggregate all rows by a specific column e.g sum, max, min , avg , count ()

select sum(amount), order_date
from transactions group by order_date;

select max(amount), order_date
from transactions group by order_date;

select min(amount), order_date
from transactions group by order_date;

select count(amount), order_date
from transactions group by order_date;

select sum(amount), customer_id
from transactions group by customer_id;

select count(amount), customer_id
from transactions group by customer_id;

SELECT * FROM mydb.transactions;