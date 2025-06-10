-- IF Statement
-- It allows developers to execute different actions based on specific conditions and enhances the flexibility of database operations.
-- executes certain actions based on whether a specified condition is true or false.
-- It is widely used in stored procedures and functions to control the flow of execution.

-- syntax:
/*
IF condition THEN
    -- statements to execute if condition is true
ELSE
    -- statements to execute if condition is false
END IF;
*/

SELECT employee_id, salary,
    CASE 
    WHEN salary > 50000 THEN 'High',
    WHEN salary BETWEEN 30000 AND 50000 THEN 'Medium',
    ELSE 'Low'
    END AS 'salary level'
FROM employees;

-- ex2
CREATE OR REPLACE FUNCTION check_number(num INT)
RETURNS TEXT AS $$
DECLARE
    result TEXT;
BEGIN
    IF num > 0 THEN
        result := 'Positive';
    ELSIF num < 0 THEN
        result := 'Negative';
    ELSE
        result := 'Zero';
    END IF;
    RETURN result;
END;
$$ LANGUAGE plpgsql;

SELECT check_number(10);
SELECT check_number(-34);
SELECT check_number(0);


-- CASE statement
-- enable us to evaluate conditions and return results based on whether these conditions are true or false.

/*
function named 'get_price_segment' that accepts 'p_film_id' as the argument.
Based on the rental rate of the film, it returns the price segment: mass, mainstream, high end.
In case the price is not 0.99, 2.99 or 4.99, the function returns unspecified.
*/

CREATE OR REPLACE FUNCTION get_price_segment(p_film_id integer)
    RETURNS VARCHAR(50) AS $$
DECLARE
    rate NUMERIC;
    price_segment VARCHAR(50);
BEGIN
    -- get the rate based on film_id
    SELECT INTO rate rental_rate FROM film
    WHERE film_id = p_film_id;

    CASE rate
        WHEN 0.99 THEN price_segment = 'Mass';
        WHEN 2.99 THEN price_segment = 'Mainstream';
        WHEN 4.99 THEN price_segment = 'High End';
        ELSE price_segment = 'Unspecified';
        END CASE;

        RETURN price_segment;
END; $$
LANGUAGE plpgsql;

SELECT get_price_segment(5) as "price segment";

-- loop statement
-- used to create an unconditional loop that executes a block of code repeatedly until a RETURN or EXIT statement terminates it.
/*
<<label>>
loop
    statements/body;
end loop;

Loop Termination
-- To terminate the running of the loop, we can simply include an 'if' statement with an 'exit' statement

<<label>>
loop
  statements;
  if condition then
     exit;
  end if;
end loop;

-- Nested Loops
<<outer>>
loop  
  statements;
  <<inner>>
  loop
    inside statements;
    exit <<inner>>
  end loop;
end loop;
*/

-- use loop to print all numbers from 1 to 5.
do $$
DECLARE
    n INTEGER:= 6;
    cnt INTEGER:=1 ;
BEGIN
LOOP
    exit when cnt = n;
    raise notice '%', cnt;
    cnt := cnt + 1 ;
    end loop;
    end; $$;

do $$
declare
 n integer:= 0;
 cnt integer := 10 ;  
begin
loop  
exit when cnt = n ;
raise notice '%', cnt;  
cnt := cnt - 1 ;  
end loop;  
end; $$;

-- 1. FOR Loop to Iterate Over a Range of Integers, from 1 to 10
DO $$
BEGIN 
    FOR cnt IN 1..10 LOOP
        RAISE NOTICE 'cnt: %', cnt;
    END LOOP;
END; $$

-- 2. FOR Loop to Iterate Over a Result Set

DO $$
DECLARE
    f RECORD;
BEGIN
    FOR f IN SELECT employee_id, full_name
        FROM employees
        ORDER BY employee_id DESC
        LIMIT 10
    LOOP
        RAISE NOTICE '% - %', f.employee_id, f.full_name;
    END LOOP;
END;
$$;

-- Exiting a Block
DO
$$
BEGIN
  RAISE NOTICE '%', 'Before block';
  <<normalblock>>  
  BEGIN
    RAISE NOTICE '%', 'Before exit; inside block';
    EXIT normalblock;
    RAISE NOTICE '%', 'After exit; inside block';
  END;
  RAISE NOTICE '%', 'End of block';
END;
$$;

-- CONTINUE statement in PostgreSQL is used to prematurely skip the current iteration of a loop and proceed directly to the next iteration.
do
$$
declare
  cnt int = 0;
begin
 loop
 -- increment of cnt
    cnt = cnt + 1;
 -- exit the loop if cnt > 10
 exit when cnt > 10;
 -- skip the iteration if cnt is an odd number
 continue when mod(cnt,2) = 1;
 -- print out the cnt
 raise notice '%', cnt;
 end loop;
end;
$$;

do
$$
declare
  cnt int = 0;
begin 
 loop
 -- increment of cnt
    cnt = cnt + 1;
 -- exit the loop if cnt > 10
 exit when cnt > 10;
 -- skip the iteration if cnt is 6
 continue when cnt = 6;
 -- print out the cnt
 raise notice '%', cnt;
 end loop;
end;
$$;

/*
The CONTINUE statement allows you to skip specific iterations based on a condition, helping to manage loop flow efficiently.
*/