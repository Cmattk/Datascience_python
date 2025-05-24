-- Convert() Function
-- is used for converting a value from one datatype to a different datatype.
-- syntax: CONVERT( input_value, data_type )

select convert(198, char);

select convert('2025-02-19', datetime);

SELECT CONVERT(2-5, SIGNED); 

SELECT CONVERT(2-5, UNSIGNED); 

SELECT CONVERT('geeksforgeeks' USING utf8); 

-- Datatype functions

-- are peculiar functions that work on MySQL data types for handling and transforming them where required.
/*
These functions include functions on string, numeric, date and binary data that help improve data manipulation and quality 
and aid database query and maintenance.
*/

-- 1. String Functions
-- concat() - concatenates 2 or more strings.
select concat('i am',' ','a great',' ', 'writer');

-- length() - returns the length of a string in bytes
select length('mathias');

-- 2. Numeric Functions
-- abs() - returns absolute value of a number
select abs(-10) as absolute_value;

-- round()- rounds a number to a specified decimal places
select round(10.23,1);

-- 3. Date and Time Functions
-- curdate() - it returns current date.
select curdate();

-- datediff() - it returns the difference in days between 2 dates.
select datediff(curdate(),curdate() - 5);
SELECT DATEDIFF('2024-07-01', '2024-06-01') AS days_difference;

-- 4. Binary Functions
-- Bins(): it returns a  string representation of the argument as a binary number.
select bin(12) as binary_rep; 

-- hex() - it returns   a string representation of the argument as a hexadecimal number
select hex(255);


-- LTRIM() Function in MySQL --
-- This function in MySQL is used to remove leading spaces from a string. 
-- Syntax : ltrim(str)

SELECT  
 employee_id,  employee_name,
 LTRIM( employee_name) AS  TrimmedEname  
 FROM  employees ;

-- UCASE() or UPPER() Function --
-- 1. UCASE() - converts a string to upper case.
select ucase('my name is maximus decimus meridis') as upperText;

-- 2. UPPER() 
select upper('my name is jeff');

-- RTRIM() Function in MySQL --
-- This function in MySQL is used to remove trailing spaces from a string. 
-- Syntax : rtrim(str)

SELECT  
 employee_id,  employee_name,
 RTRIM( employee_name) AS  TrimmedEname  
 FROM  employees ;

