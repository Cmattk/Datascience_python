ALTER TABLE expenses
ADD loan int(20);

UPDATE expenses SET loan = 13500 WHERE expense_id = 2;

ALTER TABLE expenses
CHANGE loan deficiet int; 

UPDATE expenses SET expense_total = 2434500 WHERE expense_id = 2;

SELECT * FROM `mydb`.`expenses` LIMIT 1000;