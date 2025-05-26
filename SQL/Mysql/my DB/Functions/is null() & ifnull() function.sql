-- is null() function
-- is used forr checking whether an expression is null or not.
-- returns 1 if is null, otherwise 0.

-- syntax: isnull(expression)
select isnull(null);

select isnull('g4g');

-- ifnull
-- if a table entry is null replace it with a new entry.
select
ifnull(
    select employee_id where id = 2), null as NAME;





