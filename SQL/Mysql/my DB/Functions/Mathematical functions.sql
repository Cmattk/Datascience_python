-- Mathematical functions
-- are built-in functions that perform mathematicaloperations on numerical values
-- they are essential for performing statistical analysis

/*

-- Mathematical functions --
Create table mathematical_functions (
    id int auto_increment primary key,
    functions VARCHAR(20),
    descriptions TEXT,
    example VARCHAR(100),
    result VARCHAR(50)
);

insert into mathematical_functions (functions,descriptions,example,result)
values 
('ABS()', 'Returns the absolute value of a number.', 'SELECT ABS(-10);', '10'),
('CEIL()', 'Rounds a number up to the nearest integer.', 'SELECT CEIL(4.3);', '5'),
('FLOOR()', 'Rounds a number down to the nearest integer.', 'SELECT FLOOR(4.7);', '4'),
('ROUND()', 'Rounds a number to a specified number of decimal places.', 'SELECT ROUND(123.456, 2);', '123.46'),
('POW()', 'Returns the result of a number raised to a specified power.', 'SELECT POW(2, 3);', '8'),
('SQRT()', 'Returns the square root of a number.', 'SELECT SQRT(16);', '4'),
('EXP()', 'Returns the value of e raised to the power of a specified number.', 'SELECT EXP(1);', 'Approximately 2.71828'),
('LOG()', 'Returns the natural logarithm of a number.', 'SELECT LOG(10);', 'Approximately 2.30259'),
('RAND()', 'Returns a random floating-point number between 0 and 1.', 'SELECT RAND();', 'e.g., 0.123456'),
('SIN()', 'Returns the sine of an angle in radians.', 'SELECT SIN(PI()/2);', '1'),
('COS()', 'Returns the cosine of an angle in radians.', 'SELECT COS(0);', '1'),
('TAN()', 'Returns the tangent of an angle in radians.', 'SELECT TAN(PI()/4);', '1');

 SELECT * from mathematical_functions;

-- Export to CSV Using SQL --

-- Check secure_file_priv Value -- 
SHOW VARIABLES LIKE 'secure_file_priv';

SELECT * 
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/mathematical_functions.csv'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
FROM mathematical_functions;

*/
select ABS(-10);
select CEIL(4.3);
select FLOOR(4.7);
SELECT ROUND(123.456, 2);
SELECT POW(2, 3);
select sqrt(16);
select exp(1);
select log(10);
SELECT RAND();
SELECT SIN(PI()/2);
SELECT COS(0);	
SELECT TAN(PI()/4);

/*
Advantages of Mathematical Functions:
Data Analysis: It Enable complex mathematical operations and data analysis directly within SQL queries.
Data Transformation: It Facilitate the transformation of raw data into meaningful insights through calculations and manipulations.
Simplify Queries: It Reduce the need for application-level processing by performing calculations and transformations in SQL.
Enhanced Reporting: It Improve reporting capabilities by allowing dynamic calculations and aggregations based on the data.
*/