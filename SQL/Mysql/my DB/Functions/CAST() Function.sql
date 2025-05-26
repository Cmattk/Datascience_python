-- CAST() Function
-- is used for converting a value from one datatype to another specific datatype.

-- Syntax:
-- CAST(input_value AS datatype)

select cast ('2023-04-19' as date); 

select cast (121 as char);

SELECT CAST(2-4 AS SIGNED); 

SELECT CAST(2-4 AS UNSIGNED); 

select * from orders;

select *
from orders
where (order_date) = 2024
order by order_date desc;


