-- Truncate Function
-- is used to shorten a numerical value by removing the decimal part either by rounding it down to a specified number of decimal places or the nearest integer.
-- It is particularly useful when we need to limit the precision of a number without rounding it

-- syntax: TRUNCATE(number, decimal_places)

-- Example 1 : Truncating a number when Decimal place is 0.
select Truncate (-10.11, 0) as truncatedNumber;
SELECT TRUNCATE(19087.1560, 1) AS Truncated_Number; -- 1
SELECT TRUNCATE(19087.1560, 2) AS Truncated_Number;  -- 2
SELECT TRUNCATE(-7767.1160, 2) AS Truncated_Number;

SELECT TRUNCATE(-19087.1560, -3) AS Truncated_Number;
SELECT TRUNCATE(-19087.1560, -2) AS Truncated_Number;
SELECT TRUNCATE(-19087.1560, -1) AS Truncated_Number;

-- truncate tables data --
create table products (
    product_id int auto_increment primary key,
    product_name varchar(255) not null,
    buying_price decimal(13, 6) not null,
    selling_price decimal(13, 6) not null,
    selling_date date not null
);

insert into products (product_name, buying_price, selling_price, selling_date)
values 
    ('P6', 1060.865460, 1700.675400, '2020-08-26' ),
    ('P2', 2000.154300, 3050.986700, '2020-08-27' ),
    ('P1', 4000.874300, 5070.786500, '2020-08-28' ),
    ('P2', 2090.654300, 3050.896500, '2020-09-01' ),
    ('P3', 5900.543280, 7010.654700, '2020-09-04' ),
    ('P4', 4000.353200, 4500.125400, '2020-09-05' ),
    ('P5', 5010.768900, 6000.873200, '2020-09-08' ),
    ('P6', 1060.865460, 1400.675430, '2020-09-11' );

SELECT * FROM products;


SELECT 
    product_name, 
    buying_price, 
    truncate (buying_price, 2) as truncated_Bprice,
    selling_price,
    truncate (selling_price, 2) as truncated_Sprice
FROM products;

