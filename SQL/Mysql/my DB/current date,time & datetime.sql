CREATE TABLE test(
	my_date DATE,
    my_time TIME,
    my_datetime DATETIME
 );   
 
 INSERT INTO test VALUES (CURRENT_DATE(),CURRENT_TIME(),NOW());
 
 INSERT INTO test VALUES (CURRENT_DATE() + 1, null, null);
 
 SELECT * FROM test;
 
 DROP TABLE test
 