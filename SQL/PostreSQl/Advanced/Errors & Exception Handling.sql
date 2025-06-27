-- handling errors effectively is important for ensuring the stability and reliability of databse operations.
-- PostgreSQL provides a strong error-handling mechanism, allowing developers to diagnose and resolve issues efficiently.
-- we will explore PostgreSQL error-handling mechanisms, including the RAISE statement and ASSERT statement, to help us manage and debug our database operations.

-- errors may arise due to various reasons, including syntax errors, invalid data operations, or constraint violations.
-- These errors can disrupt normal database operations if not managed correctly
-- PostgreSQL offers a range of tools and statements for error handling, allowing developers to log, debug, and resolve issues with ease.

-- Key error-handling tools
-- RAISE Statement: For generating custom error messages.
-- ASSERT Statement: For debugging and validating conditions during development.

-- RAISE Statement ---
-- used to generate messages or errors during the execution of PL/pgSQL code blocks.

-- Syntax:
-- RAISE level format;

-- level
-- PostgreSQL provides the following levels:
/*
DEBUG: For detailed debugging information.
LOG: For logging purposes, typically used for recording events.
NOTICE: For messages that inform the user of something non-critical.
INFO: For informational messages that are typically less severe than warnings.
WARNING: For messages that indicate potential issues that do not halt execution.
EXCEPTION: For critical errors that stop the current transaction. This is the default level if none is specified.
*/

-- format
-- The format is a string that specifies the message.
-- uses percentage ( %) placeholders that will be substituted by the next arguments.
-- expression: Values that replace placeholders in the format string.

-- Basic RAISE Statement
DO $$
BEGIN
    RAISE INFO 'information massage %', now();
    RAISE LOG 'log message %', now();
    RAISE DEBUG 'debug message %', now();
    RAISE WARNING 'warning message %', now();
    RAISE NOTICE 'notice message %', now();
END $$;

-- INFO, WARNING, and NOTICE level messages are reported back to the client.
-- DEBUG and LOG level messages are generally written to the server log and not sent to the client.
-- This behavior can be controlled using the 'client_min_messages' and 'log_min_messages' configuration parameters, 
-- allowing us to fine-tune the verbosity of the messages sent to the client versus those logged by the server.

-- Raising Errors Using the EXCEPTION Level
-- we can add more detailed information by using the following clause with the RAISE statement:
-- USING option = expression

-- options:
/*
message: set error message text
hint: provide the hint message so that the root cause of the error is easier to be discovered
detail: give detailed information about the error.
errcode: identify the error code, which can be either by condition name or directly five-character SQLSTATE code.
*/
-- Raising Errors with Additional Details
DO $$
DECLARE 
    email VARCHAR(255) := 'mattck@g4g.org';
BEGIN
    -- CHECK EMAIL FOR DUPLICATE

    --- REPORT DUPLICATE EMAIL
    RAISE EXCEPTION 'Duplicate email: %', email
        USING HINT = 'Check the email again';
END $$;


-- Raising Specific SQLSTATE Errors
-- how to raise an SQLSTATE and its corresponding condition:
DO $$
BEGIN 
    RAISE SQLSTATE '2201B';
END $$;

DO $$
BEGIN
    RAISE invalid_regular_expression;
END $$;

-- Using the ASSERT Statement for Debugging --
-- allows us to insert debugging checks into our PL/pgSQL blocks. This is particularly useful during development to ensure that certain conditions hold true at specific points in our code.
-- syntax:
-- ASSERT condition[,'message'];

-- condition: A boolean expression that we expect to be true.
-- message: (Optional) A custom error message displayed if the condition is false.

-- raise an error with the specified message, aiding in identifying logical issues during development.
DO $$
BEGIN
    ASSERT 1+1 = 2, 'Math is Broken!';
    ASSERT (SELECT COUNT(*) FROM users) > 0, 'No users found in the database';
END $$;

DO $$
BEGIN
    ASSERT 2+1 = 2, 'Math is Broken!';
    ASSERT (SELECT COUNT(*) FROM users) > 0, 'No users found in the database';
END $$;

DO $$
BEGIN
    ASSERT 1+1 = 2, 'Math is Broken!';
    ASSERT (SELECT COUNT(*) FROM schools) > 0, 'No users found in the database';
END $$;

-- Exception Handling in PL/SQL
-- An exception is an error which disrupts the normal flow of program instructions.
-- PL/SQL provides us the exception block which raises the exception thus helping the programmer to find out the fault and resolve it.

-- two types of exceptions defined in PL/SQL
-- User defined exception.
-- System defined exceptions.

-- Syntax
-- WHEN exception THEN 
--     statement;
/*
DECLARE 
   declarations section;

BEGIN 
   executable command(s);

EXCEPTION 
    WHEN exception1 THEN
       statement1;
    WHEN exception2 THEN    
       statement2;
    [WHEN others THEN]
    // default exception handling code //  
END;
*/

-- System defined exceptions: These exceptions are predefined in PL/SQL which get raised WHEN certain database rule is violated.
-- divided into two categories:
-- Named system exceptions: Named system exceptions: They have a predefined name by the system like ACCESS_INTO_NULL, DUP_VAL_ON_INDEX...
-- Unnamed system exceptions:

CREATE TABLE IF NOT EXISTS geeks(
    g_id int,
    g_name VARCHAR(20),
    marks int);

INSERT INTO geeks
VALUES
    (1, 'Suraj',100),
    (2, 'Praveen',97), 
    (3, 'Jessie', 99);

-- NO_DATA_FOUND: It is raised WHEN a SELECT INTO statement returns no rows
DO $$
DECLARE
   temp VARCHAR(20);
BEGIN
   BEGIN
      SELECT g_id INTO temp FROM geeks WHERE g_name = 'GeeksforGeeks';
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         RAISE NOTICE 'ERROR';
         RAISE NOTICE 'There is no name as';
         RAISE NOTICE 'GeeksforGeeks in geeks table';
   END;
END;
$$ LANGUAGE plpgsql;


-- User defined exceptions: This type of users can create their own exceptions according to the need and to raise these exceptions explicitly raise command is used.
-- Example:Divide non-negative integer x by y such that the result is greater than or equal to 1.

-- we can conclude that there exist two exceptions
-- Division be zero.
-- If result is greater than or equal to 1 means y is less than or equal to x.

DO $$
DECLARE
   x INT := 10;  -- set your value
   y INT := 0;   -- set your value
   div_r FLOAT;
BEGIN
   IF y = 0 THEN
      RAISE EXCEPTION 'Division by zero not allowed';

   ELSIF y > x THEN
      RAISE EXCEPTION 'y is greater than x, please check the input';

   ELSE
      div_r := x::FLOAT / y;
      RAISE NOTICE 'The result is %', div_r;
   END IF;

EXCEPTION
   WHEN OTHERS THEN
      RAISE NOTICE 'Error: %', SQLERRM;

END;
$$ LANGUAGE plpgsql;

-- Assert
-- ASSERT statement as a vital tool for inserting debugging checks in PL/pgSQL code.
-- This statement is crucial for identifying logical errors, making it easier to catch problems in your code early on.

-- Syntax
-- assert condition [, message]; 


-- Checking for Records in the Table
DO $$
DECLARE  
  employee_count INTEGER;
BEGIN
  SELECT COUNT(*)
  INTO employee_count
  FROM employees;

  ASSERT employee_count > 0, 'Check for Empty Employee Table';
END $$;

-- Checking for More Than 100 Records

DO $$
DECLARE  
  employee_count INTEGER;
BEGIN
  SELECT COUNT(*)
  INTO employee_count
  FROM employees;
  
  ASSERT employee_count > 100, '100 employee count found';
END $$;

-- The ASSERT statement is designed to detect program bugs, not for regular error handling.
-- Use RAISE for handling known error conditions instead of ASSERT.



