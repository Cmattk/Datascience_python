-- rename a view
-- Renaming a VIEW in MySQL will not change the data in the underlying tables it will only change the name by which the view is referenced.
-- syntax: RENAME TABLE old_view_name TO new_view_name;

CREATE VIEW view2 AS
  SELECT w_id, salary
  FROM workers;

CREATE VIEW view3 AS
SELECT w_id, age, salary
FROM workers
WHERE SALARY=14000;

select * from view2;
select * from view3;

-- renaming -- 
rename table view2 to worker_details;

select * from worker_details;




