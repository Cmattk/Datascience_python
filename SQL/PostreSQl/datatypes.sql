CREATE TABLE IF NOT EXISTS book_availability(
    book_id int NOT NULL primary KEY,
    available BOOLEAN NOT NULL
);

-- boolean
INSERT INTO book_availability (book_id, available)
VALUES
    (100, TRUE),
    (200, FALSE),
    (300, 't'),
    (400, '1'),
    (500, 'y'),
    (600, 'yes'),
    (700, 'no'),
    (800, '0');

SELECT * FROM book_availability;
SELECT * FROM book_availability
WHERE available = 'yes';
SELECT * FROM book_availability
WHERE available = 'n';

-- char - stores fixed length string
-- CHAR(n) - n for max no of characters
ALTER TABLE book_availability
ADD COLUMN book_title CHAR(30);

UPDATE book_availability
SET book_title = 'Kino'
WHERE book_id = 400;

UPDATE book_availability
SET book_title = 'Kidagaa'
WHERE book_id = 100;
/* -- error too long 
UPDATE book_availability
SET book_title = 'Kina wa mtemi aliye bora dodo lake make'
WHERE book_id = 300;
*/

-- varchar
-- is used to store variable-length character strings.
ALTER TABLE book_availability
ADD COLUMN author VARCHAR(20);

UPDATE book_availability
SET author = 'Ken Walibora'
WHERE book_title = 'Kidagaa';

-- text 
-- store extensive character data without the limitations that accompany other string types like VARCHAR.
/*
CREATE TABLE text_test2 (
    id serial PRIMARY KEY,
    a TEXT,
    b TEXT
);
*/

-- NUMERIC 
-- designed to store numbers with a large number of digits by offering a high degree of precision and accuracy.
-- suitable for financial data and other applications where rounding errors cannot be tolerated.
-- NUMERIC(precision, scale)
-- Precision: Total number of digits.
-- Scale: Number of digits in terms of a fraction or after decimal

ALTER TABLE book_availability
ADD COLUMN book_price NUMERIC(5, 2);

UPDATE book_availability
SET book_price = 17.570
WHERE book_id = 400;

SELECT book_id, book_title, book_price FROM book_availability;

-- SMALLINT
-- store integer values from -32,768 to 32,767, making it suitable for fields like ages, counts, or scores that do not require large storage.
ALTER TABLE book_availability
ADD COLUMN pages SMALLINT CHECk (pages > 0);

SELECT book_id, book_title, pages FROM book_availability;

UPDATE book_availability
SET pages = 600
WHERE book_title = 'Jumanji';

UPDATE book_availability
SET pages = 3000
WHERE book_title = 'Dracula';

-- INTEGER 
-- stores whole numbers , and requires 4 bytes of storage. it can store is between -2,147,483,648 to 2,147,483,647.
-- suitable for various applications, such as: population of a country, Tracking user counts on websites , Representing counts in inventory management.
-- syntax : variable_name INTEGER


-- BIGINT 
-- a signed 64-bit integer that can store a wide range of numerical values.
-- requires 8 bytes of storage and can handle values ranging from -9,223,372,036,854,775,808 to +9,223,372,036,854,775,807.
-- useful for scenarios where we need to store large numerical values that exceed the limits of standard integer types.
-- like scientific constants and galaxies and their respective star counts,
-- syntax: variable_name BIGINT

CREATE TABLE galaxy 
(
    id SERIAL PRIMARY KEY,
    name VARCHAR (255) NOT NULL,
    stars BIGINT NOT NULL CHECK (stars> 0)
);

INSERT INTO galaxy(name, stars)
VALUES
    ('Milky_Way', 2500000000000),
    ('Bodes', 2700000000000), 
    ('Cartwheel', 1300000000000),  
    ('Comet', 5700000000000);

SELECT * FROM galaxy;

-- Date
-- Stores date values without time (e.g., '2024-10-10').
-- e.g birthdates
ALTER TABLE book_availability
ADD COLUMN published_date DATE;

SELECT book_id, book_title, published_date FROM book_availability;

UPDATE book_availability
SET published_date = '2011-04-23'
WHERE book_title = 'Kidagaa';


-- TIMESTAMP
-- This stores date and time without timezone data.
-- The stored value remains the same even if the server's time zone is changed

ALTER TABLE book_availability
ADD COLUMN recorded_on TIMESTAMP;

UPDATE book_availability
SET recorded_on = '2012-02-12'
WHERE book_title = 'Kidagaa';

SELECT book_id, book_title, recorded_on FROM book_availability;

UPDATE book_availability
SET recorded_on = '2020-06-22 19:10:25-07'
WHERE book_title = 'Dracula';

-- TIMESTAMPTZ
-- This stores date and time along with time zone information.
-- PostgreSQL automatically converts the timestamp to UTC for storage and adjusts it back based on the current time zone settings when queried.

CREATE TABLE timestamp_demo (
               ts TIMESTAMP, 
               tstz TIMESTAMPTZ
);

SET timezone = 'Asia/Calcutta';

INSERT INTO timestamp_demo (ts, tstz)
VALUES
    ( '2020-06-22 19:10:25-07', '2020-06-22 19:10:25-07' );

SELECT ts, tstz
FROM timestamp_demo;

INSERT INTO timestamp_demo ( tstz)
VALUES
    ( '2020-06-22 19:10:25-07' );

SELECT timezone('Africa/Nairobi', '2020-06-22 19:10:25');

--  UUID (Universally Unique Identifier)
-- It generates globally unique values using algorithms that ensure no duplication,
-- making it ideal for distributed systems.

-- UUIDs offer a key advantage over the SERIAL data type by ensuring uniqueness not only within a single database but 
-- across multiple databases or systems.
-- This makes UUIDs an optimal choice for applications that require global uniqueness.
-- used in distributed systems and microservices architectures, where identifiers must be unique even across network boundaries.

-- To install the uuid-ossp extension
 -- CREATE EXTENSION IF NOT EXISTS 'uuid-ossp';
 SELECT uuid_generate_v1();
 SELECT uuid_generate_v4();

 CREATE TABLE contacts(
    contact_id UUID DEFAULT uuid_generate_v4 (),
    first_name VARCHAR NOT NULL,
    last_name VARCHAR NOT NULL,
    email VARCHAR NOT NULL UNIQUE,
    phone VARCHAR UNIQUE,
    PRIMARY KEY (contact_id)
 );

INSERT INTO contacts (first_name, last_name, email, phone)
VALUES
    ('Raju', 'Kumar', 'rajukumar@gmail.com', '408-237-2345'),
    ('Nikhil', 'Aggarwal', 'nikhilaggarwal@gmail.com', '408-237-2344'),
    ('Anshul', 'Aggarwal', 'anagg@hotmail.com', '408-237-2343'
);

SELECT * FROM contacts;

/*
UUID versions: PostgreSQL supports multiple versions of UUIDs (v1, v4, etc.), each using different algorithms for generation.
Extensions for UUIDs: PostgreSQL’s core does not natively generate UUIDs; it relies on extensions like 'uuid-ossp' or 'pgcrypto'.
UUID format: UUIDs are represented in a standard textual format (8-4-4-4-12 hexadecimal digits) which can be easily read and parsed by humans and systems.
Client-side vs. server-side generation: UUIDs can be generated on the client-side (in application code) or server-side (in the database). Client-side generation can reduce the load on the database.

 Using UUIDs also helps prevent conflicts across databases, making them ideal for scalable and distributed environments.
*/

--  Interval  --
-- interval data type in PostgreSQL stores time periods using 16 bytes of storage and supports a range from -178,000,000 years to 178,000,000 years.
-- It provides a precision attribute ('p') that allows you to specify the number of fractional digits retained in the seconds field, enhancing the precision of time calculations and results.
-- syntax: interval [ Data_fields ] [ (p) ]

SELECT now(), now() - INTERVAL '1 year 4 hours 25 minutes' AS "4 hrs 25 mins  ago of last year";

SELECT
    TO_CHAR(
        INTERVAL '15h 25m 12s',
        'HH24:MI:SS'
    );

-- User-defined data types
-- CREATE DOMAIN and CREATE TYPE statements.
-- These capabilities allow for the customization and extension of data types to fit specific application needs,
-- providing more flexibility and control over data integrity and consistency. 
-- CREATE DOMAIN: It creates a user-defined data type that can have optional constraints. 
-- CREATE TYPE: It is often applied to create a composite type (data type that are mixes of two or more data types) using stored procedures. 

/* Syntax:
CREATE DOMAIN domain_name AS data_type [CONSTRAINT constraint_name CHECK (expression)];
*/

-- Step 1: Drop the domain and table if they exist (for re-runs)
DROP TABLE IF EXISTS marksheet;
DROP DOMAIN IF EXISTS student_detail;

-- Step 2: Create the domain to validate no whitespace
CREATE DOMAIN student_detail AS
    VARCHAR NOT NULL
    CHECK (VALUE !~ '\s');  -- Disallow any whitespace character

-- Step 3: Create the table using the domain
CREATE TABLE marksheet (
    student_id SERIAL PRIMARY KEY,
    first_name student_detail,
    last_name student_detail,
    email VARCHAR NOT NULL,
    marks_obtained INT NOT NULL
);

-- insert some data to the table 
INSERT INTO marksheet (first_name, last_name,marks_obtained, email)
VALUES
    ( 'Raju K', 'Singh', 95, 'rajukumar@gmail.com' );

INSERT INTO marksheet (first_name, last_name, marks_obtained, email)
VALUES
    ('RajuK', 'Singh', 95, 'rajukumar@gmail.com');

SELECT * FROM marksheet;

-- CREATE TYPE
-- is used to define composite types, which are combinations of two or more data types.
-- Syntax: 
-- CREATE TYPE type_name AS (
--   attribute_name data_type,
--   ... 
-- );

-- Step 1: Create the composite type
DROP TYPE IF EXISTS my_address CASCADE;

CREATE TYPE my_address AS (
    street VARCHAR,
    city VARCHAR,
    state CHAR(2),
    zip_code CHAR(5)
);

-- Step 2: Create the table using the composite type
DROP TABLE IF EXISTS my_employee;

CREATE TABLE my_employee (
    employee_id SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL,
    home_address my_address,
    work_address my_address
);

-- Step 3: Create the function to return home_address
CREATE OR REPLACE FUNCTION get_employee_address(emp_id INT) 
RETURNS my_address AS $$
DECLARE
    emp_address my_address;
BEGIN
    SELECT home_address INTO emp_address
    FROM my_employee
    WHERE employee_id = emp_id;

    RETURN emp_address;
END;
$$ LANGUAGE plpgsql;


INSERT INTO my_employee (name, home_address, work_address)
VALUES(
    'Matt Pico',
    ROW('123 Main St', 'Kathale', 'KY', '35032')::my_address,
    ROW('456 Office Rd', 'Rongai', 'KJ', '60601')::my_address
);

SELECT get_employee_address(1);

SELECT (get_employee_address(1)).city;


SELECT * FROM my_employee;

-- array data type
-- allows us to store multiple values in a single column.
-- can be used with all built-in data types and even user-defined types, enabling a wide range of use cases.

--  it is useful when we need to associate multiple values with a single record.
-- For instance, we might store multiple phone numbers for a single contact in a contacts table.

-- Syntax: variable_name DATA TYPE [];

-- Creating a Table with an Array Column

CREATE TABLE my_contacts (
    id serial PRIMARY KEY,
    name VARCHAR (100),
    phones TEXT []
);

INSERT INTO my_contacts (name, phones)
VALUES 
    (
        'Aj Lee', 
        '{"(254)-589-4323"}'
    ),
    (
        'Tina pritish', 
        '{"(254)-582-9876"}'
    ),
    (
        'Grace Nduta',
        '{"(254)-543-2365","(254)-321-5422"}'
    );

SELECT * FROM my_contacts;

UPDATE my_contacts
SET phones = array_append(phones, '(254)-567-9862')
WHERE name = 'Tina pritish';

INSERT INTO my_contacts (name, phones)
VALUES 
    (
        'Ali Letu', 
        '{"(254)-349-4723"}'
    );

UPDATE my_contacts
SET phones = array_remove(phones, '(254)-349-4723')
WHERE name = 'Ali Letu';

SELECT * FROM my_contacts;

--------------------------------------------
-- hstore data type
-- 'hstore' module in PostgreSQL is designed to implement a data type for storing key-value pairs within a single value. 
-- This feature is particularly useful for handling semi-structured data or cases where attributes are rarely queried individually.
-- Syntax: variable_name hstore;
-- extension: CREATE EXTENSION hstore;

CREATE TABLE books (
    id serial PRIMARY KEY,
    title VARCHAR(255),
    attr hstore
);

INSERT INTO books(title, attr)
VALUES 
    (
        'Kidagaa Kimemwozea',
        '
            "Author" => "Ken Walibora",
            "pages" => "655",
            "publisher" => "Kenya Dim/KE",
            "Language" => "Swahili"
        '
    ),
    (
        'Kigogo',
        '
            "Author" => "Pauline Kea",
            "pages" => "675",
            "publisher" => "Bora PUBL/KE",
            "Language" => "Swahili"
        '
    ),
    (
        'River and The Source',
        '
            "Author" => "Margret Ogola",
            "pages" => "705",
            "publisher" => "DIM PUBL/KE",
            "Language" => "English"
        '
    );

INSERT INTO books (title, attr)
VALUES
    (
        'Winds Of Winter',
        '
            "pages" => "2403",
            "publisher" => "Bantam Spectra/US & Voyager Books/UK",
            "language"  => "English",
            "ISBN-13"   => "978-1449370000",
            "weight"    => "13.2 ounces"
         '
    );   

SELECT * FROM books;

SELECT attr -> 'Author' as authors FROM books;

/*
Ideal for scenarios where the schema may change frequently or where attributes are not uniformly applicable to all rows.
Useful for storing and querying semi-structured data without the need for extensive schema changes.
You can query specific key-value pairs using operators like '->' to extract values and '@>' to check for the presence of specific key-value pairs.
The hstore type is best for relatively small sets of key-value pairs.
*/

----------------------------------------------
-- JSON data type
-- (JavaScript Object Notation) is a widely used format for storing data in the form of key-value pairs
-- PostgreSQL stores and manipulates JSON data efficiently.
-- syntax: variable_name json;
DROP TABLE orders;
CREATE TABLE orders (
    ID SERIAL NOT NULL PRIMARY KEY,
    info json NOT NULL
);

INSERT INTO orders (info)
VALUES 
    ('{"customer": "Eric Wane", "items": {"product": "coffee", "qty": 6}}');
SELECT info FROM orders;

INSERT INTO orders (info)
VALUES
    (
        '{ "customer": "Nikhil Aggarwal", "items": {"product": "Diaper", "qty": 24}}'
    ),
    (
        '{ "customer": "Anshul Aggarwal", "items": {"product": "Tampons", "qty": 1}}'
    ),
    (
        '{ "customer": "Naveen Arora", "items": {"product": "Toy Train", "qty": 2}}'
    );

SELECT info
FROM orders;

-- Extracting Data from JSON
select info ->> 'customer' as customer_name FROM orders;

SELECT info
FROM orders
WHERE info  -> 'items' ->> 'product' = 'Diaper'; 

/*
Extensive Functions: PostgreSQL provides a wide range of functions and operators for parsing, querying, and manipulating JSON data, enabling complex data handling directly within SQL queries.

Indexing Capabilities: JSON data in PostgreSQL can be indexed using GIN (Generalized Inverted Index) or B-tree indexes, significantly improving query performance for JSON data.

Integration with SQL: JSON data types in PostgreSQL integrate seamlessly with SQL, allowing us to combine relational and JSON data in our queries, making it a flexible tool for modern applications.
*/