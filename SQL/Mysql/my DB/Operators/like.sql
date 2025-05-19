-- Like operator helps us search for specified patterns in a columns
-- e.g names sstarting with a certain letter or containing a specific letters.

-- it is used in WHERE clause to look for a pattern in a column
-- %: matches zero or more characters
-- _: matches exactly one character.

use geeks4geeks;

-- name starting with 'A'
select * from employees
where employee_name like 'A%'; 


-- names ending with 'H'
select * from employees
where employee_name like '%h';

-- names containing 'at'
select * from employees
where employee_name like '%at%';

-- names with 'a' as second character
select * from employees where employee_name like '_a%';
-- 3rd
select * from employees where employee_name like '__b%';

select * from employees;

