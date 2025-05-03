SET AUTOCOMMIT = OFF;

COMMIT;
SELECT * FROM mydb.employees;

DELETE FROM employees;
SELECT * FROM employees;

ROLLBACK;

