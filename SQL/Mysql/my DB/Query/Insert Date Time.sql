-- MySQL provides data types for saving date and time values, such as DATE, TIME, DATETIME, and TIMESTAMP
-- DATE: Stores date values in the format "YYYY-MM-DD". example - "2023-12-20".
-- TIME: Stores time values in the format "HH:MM: SS". example - "07:23:30".
-- DATETIME: It combines data and time format "YYYY-MM-DD HH:MM:SS". example - "2023-12-20 07:23:30".
-- TIMESTAMP: Stores the time stamp format "YYYY-MM-DD HH:MM:SS TIMESTAMP". example - "1970-01-01 00:00:00 UTC".

CREATE TABLE DateAndTime 
(DATE DATE);

INSERT INTO DateAndTime VALUES ('2025-05-14');

-- Add other columns 

ALTER TABLE DateAndTime ADD TIME TIME;
ALTER TABLE DateAndTime ADD DATETIME DATETIME; 
ALTER TABLE DateAndTime ADD TIMESTAMP TIMESTAMP;

INSERT INTO DateAndTime (Time) VALUES ('14:30:00');
INSERT INTO DateAndTime (DateTime) VALUES ('2023-12-31 14:30:00');

SELECT * FROM DateAndTime;

-- "DATE_ADD()": This function is use to adds a specified time interval to a date.
-- "DATE_SUB()": This function is use to subtract a specified time interval from a date.
-- "DATE_FORMAT()": This Function helps in format a date as specified.
-- "STR_TO_DATE()": This function is to convert a string to a date.

-- SET time_zone = 'timezone';
SET time_zone = 'GMT';

