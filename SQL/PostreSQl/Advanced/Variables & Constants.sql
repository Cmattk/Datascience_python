-- Variables
-- allow developers to store temporary data for use within functions and stored procedures, enabling more dynamic and flexible queries and operations.

-- Basic Variable Declaration and Usage
DO $$
DECLARE
    counter INT := 1;
    firstname VARCHAR(50) := 'john';
    lastname VARCHAR(50) := 'doe';
    payment NUMERIC(11,2) := 20.5;
BEGIN
    RAISE NOTICE '%. % % has been paid % USD', counter, firstname,
    lastname, payment;
END
$$;

-- Using System Functions with Variables
DO $$ 
DECLARE
   created_at time := NOW();
BEGIN 
   RAISE NOTICE '%', created_at;
   PERFORM pg_sleep(10);
   RAISE NOTICE '%', created_at;
END $$;

-- Select into
-- select data from the database and assign it to a variable.

/*
Syntax:
select select_list
into variable_name
from table_expression;
*/

DO $$
DECLARE
    actor_count INT;
BEGIN
    SELECT count(*)
    INTO actor_count
    FROM actor;
    RAISE NOTICE 'The number of actors: %', actor_count;
END;
$$;

do $$
declare
   film_count integer; 
begin
   -- select the number of films from the actor table
   select count(*)
   into film_count
   from film;

   -- show the number of films
   raise notice 'The number of films: %', film_count;
end; $$;

-- Row Type Variables
-- row type variables are handy when you need to store a whole row of data returned by a query.
-- allow you to store an entire row from a table or view in a single variable.
-- The row is stored as a composite data type, which includes multiple columns that you can access individually.
-- These variables are declared using the '%ROWTYPE' attribute, which automatically matches the structure of the row to the table or view you reference.

-- Syntax: row_variable table_name/view_name %ROWTYPE;

-- access any field from the row variable.
-- Syntax: row_variable.field_name

-- Selecting a Single Row with All Columns
DO $$
DECLARE
  sel_employee employees%ROWTYPE;
BEGIN
  -- Select employee with ID 6
  SELECT * INTO sel_employee
  FROM employees
  WHERE employee_id = 6;
  
  RAISE NOTICE 'The employee name is % and the manager ID is %',
    sel_employee.full_name,
    sel_employee.manager_id;
END $$;

--  Selecting a Single Row with Specific Columns
DO $$
DECLARE
    sel_employee employees%ROWTYPE;
BEGIN
    SELECT *
    INTO sel_employee
    FROM employees
    WHERE employee_id = 12;

    RAISE NOTICE 'The employee name is %
    and the length of the name is %',
    sel_employee.full_name, length(sel_employee.full_name);
END; $$;

-- Record Type Variable.
-- record-type variables provide a dynamic and flexible way to handle result sets that don't have a predefined structure. 
-- Syntax: variable_name record;

-- Accessing Fields in Record Type Variable
-- Syntax: record_variable.field_name;

--  Using Record Type Variables with SELECT INTO

DO
$$
DECLARE
    rec1 record;
BEGIN
    -- Select the employee
    SELECT *
    INTO rec1
    FROM employees
    WHERE employee_id = 13;

    RAISE NOTICE '% - %(Manager id=%)', 
    rec1.employee_id, rec1.full_name, rec1.manager_id;    
END;
$$ LANGUAGE plpgsql;

-- Using Record Type Variables with FOR Loop
DO
$$
DECLARE
    rec1 record;
BEGIN
    FOR rec1 IN
        SELECT employee_id, full_name
        FROM employees
        WHERE employee_id > 12
        ORDER BY employee_id
    LOOP
        RAISE NOTICE '% - %',
        rec1.employee_id, rec1.full_name;
    END LOOP;
END;
$$;

-- Constants
-- constants are similar to variables but with a crucial difference: once their value is initialized, it cannot be altered.
-- Syntax: constant_name CONSTANT data_type := expression;

-- Calculating with Constants
DO $$
DECLARE 
    vat CONSTANT NUMERIC := 0.1;
    net_price NUMERIC := 20.5;
BEGIN
    RAISE NOTICE 'The selling price is %',
    net_price * (1 + vat);
END; $$;

-- Time-Dependent Constants
DO $$ 
DECLARE
   start_at CONSTANT time := now();
BEGIN
    RAISE NOTICE 'Start executing block at %', start_at;
END $$;

DO $$ 
DECLARE
   start_on CONSTANT DATE := CURRENT_DATE;
BEGIN
    RAISE NOTICE 'Start the work on %', start_on;
    RAISE NOTICE 'End on %', start_on + INTERVAL '5 DAYS';
END $$;

DO $$ 
DECLARE
   start_on CONSTANT DATE := CURRENT_DATE;
BEGIN
    RAISE NOTICE 'Start the work on %', start_on;
    RAISE NOTICE 'End on %', start_on + 5;
END $$;
