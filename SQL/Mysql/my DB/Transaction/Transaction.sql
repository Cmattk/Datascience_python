-- Transacti 
-- a database transaction is a safe way to perform a lot of operations.
-- e.g money transfer in one shot.
-- if everything goes fine, it saves all the changes; otherwise, 
-- in case something goes wrong, the database rolls back to its old state,
-- to make sure that your money doesn't disappear.

-- Transactions allow grouping a set of operations as an inseparable single unit
-- of operations, either all of which succeed or none of which does.
-- This assures validity and reliability in your data, even in cases of failures or system failures.

-- industrial example:
/*
-- online banking:
 tranfering money from one account to another involving debiting the amount in one account and
 simultaneously crediting that amount in the other.
 In this case, transactional techniques allow assurance of either both actions' success or neither, 
 hence avoiding problems like the disappearance of money from one account and its failure to appear in another.
*/

-- start a transaction
-- START TRANSACTION statement can be used to start a transaction. 
-- START TRANSACTION;

-- Execute SQL Statements
/*
UPDATE accounts SET balance = balance - 100 WHERE account_id = 1;
UPDATE accounts SET balance = balance + 100 WHERE account_id = 2;
*/

-- Committing a Transaction
-- The COMMIT statement saves all the changes made during a transaction.
-- COMMIT;

-- Rolling Back a Transaction
-- If something goes wrong "roll back" the changes made during the transaction, 
-- issue the ROLLBACK statement.
-- This statement restores the database to its state before the transaction started.

--- A Complete Transaction --
CREATE TABLE transaction_accounts(
    account_id int primary key,
    account_name varchar(100),
    balance decimal(10, 2)
);

INSERT INTO transaction_accounts () 
VALUES
(1, 'Alice', 1000.00),
(2, 'Bob', 500.00),
(3, 'Bella', 1500.00),
(4, 'Bruce', 600.00);

START TRANSACTION;

UPDATE transaction_accounts 
SET balance = balance - 100 
WHERE account_id = 1;

UPDATE transaction_accounts
SET balance = balance + 100
WHERE account_id = 2;

COMMIT;

SELECT * FROM transaction_accounts;


--- Using Savepoints -- 
-- we establish named intermediate points within a transaction by using savepoints.
-- savepoints is to give a chance for partial transaction rollbacks,
-- which means that parts of a transaction could be cancelled without interfering with the integrity of the whole transaction.

START TRANSACTION;

SAVEPOINT savepoint1;

UPDATE transaction_accounts
SET balance = balance - 100
WHERE account_id = 3;

SAVEPOINT savepoint2;

UPDATE transaction_accounts
SET balance = balance + 100
WHERE account_id = 4;

-- if an error accurs, roll back to a specific savepoint
ROLLBACK TO SAVEPOINT savepoint1;

-- commit the transaction
COMMIT;

SELECT * FROM transaction_accounts;