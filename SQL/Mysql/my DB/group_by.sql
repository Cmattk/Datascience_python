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


-- rollup, extension of the group by clause
-- produces another row and shows the GRAND TOTAL (super-aggregate value)

select sum(amount), order_date
from transactions
group by order_date with rollup ;

select count(transaction_id), order_date
from transactions
group by order_date with rollup ;

select count(transaction_id) as 'order of customers', customer_id
from transactions
group by customer_id with rollup ;

select sum(hourly_pay), employee_id
from employees
group by employee_id with rollup ;