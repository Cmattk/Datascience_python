-- String Functions -- 
/*
-- create a table -- 
CREATE TABLE string_functions(
    function_name varchar(50),
    description text
);

-- insert data

INSERT INTO  string_functions (function_name, description)
VALUES
('CONCAT_WS', 'It concatenates strings with a specified separator.'),
('CONCAT', 'It concatenates two or more strings.'),
....
*/
select * from string_functions limit 10;
select * from string_functions limit 10,10;
select * from string_functions limit 20,10;
select * from string_functions limit 30,10;

SELECT CONCAT_WS(', ', 'apple', 'banana', 'orange') AS Concatenated_String;
SELECT CONCAT('Hello', ' ', 'World') AS Concatenated_String;
SELECT CHARACTER_LENGTH('Hello World') AS String_Length;
SELECT ELT(3, 'apple', 'banana', 'orange', 'grape') AS Selected_String;
SELECT FIELD('banana', 'apple', 'banana', 'orange') AS Position;
SELECT FORMAT(1234567.89, 2) AS Formatted_Number;
SELECT FROM_BASE64('SGVsbG8gV29ybGQ=') AS Decoded_String;
SELECT HEX('Hello') AS Hexadecimal_Value;
SELECT INSERT('Hello World', 7, 0, 'Beautiful ') AS Modified_String;
SELECT LOWER('Hello World') AS Lowercase_String;
SELECT REPLACE('Hello World', 'World', 'Universe') AS Modified_String;

