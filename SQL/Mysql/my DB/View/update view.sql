-- update view

/*
Any changes made in the VIEW will also be reflected in the table.

Not all VIEWS are updatable.
certain things that we need to remember are.

Single Table References: The VIEW must reference exactly one table. i.e. The SELECT statement defining the VIEW can only involve a single base table. No joins or subqueries
involving multiple tables are allowed.

No Aggregates: The VIEWS having aggregate functions like SUM(), COUNT(), and AVG(), are updatable unless and until used with a GROUP BY clause.

No UNION or UNION ALL: UNION and UNION ALL Operations do not apply to the SELECT statements.

No DISTINCT, GROUP BY, HAVING: The SELECT statement defining the VIEW cannot have DISTINCT, GROUP BY, HAVING clause.
*/

-- syntax: --

/*
UPDATE  view_name
SET  column1 = value1, column2 = value2 , . . . . , column_n = value_n
WHERE condition1 , condition2, . . . . , condition_n;
*/

create view view1 as
select w_id, age, salary from workers;


select * from view1;

-- updating view --
update view1
set salary = 10000
where w_id = 2;

select * from view1 where w_id =2;
select w_id, age, salary from workers where w_id =2;

drop table workers;