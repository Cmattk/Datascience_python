-- order by clause is used to sort the result set either in ascending order or descending order

select * from g4g order by courses_enrolled  asc;

SELECT * FROM g4g ORDER BY courses_enrolled DESC;

--  ORDER BY CLAUSE With Multiple Columns
-- First, Sorting by rank in ascending order.
-- For rows with equal rank, sorting by name in descending order.

select * from g4g  order by contest_rank, name desc; 

-- ORDER BY CLAUSE With NULL VALUES
update g4g
set contest_rank = NULL
where id = 'vish3001' or id = 'Sumit65';

select * from g4g order by contest_rank;