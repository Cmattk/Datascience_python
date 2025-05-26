-- CASE() Function
-- is a conditional statement that returns a value when the first condition is met.

/*
syntax:
CASE 
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    WHEN conditionN THEN resultN
    ELSE result
END;
*/

select * from float01001;

-- case() function on getting output
select float_val,
CASE
    WHEN float_val > 5 THEN 'The value is grater than 5'
    WHEN float_val = 5 THEN 'The value is 5'
    ELSE 'The value is under 5'
END as float_txt
from float01001;

select float_val,
case 
    when float_val > 4 then 'greater than 4'
    when float_val = 4 then 'the value is 4'
    else 'less than 4'
end as float_txt
from float01001;

/*
The CASE function can be used in various SQL statements like SELECT, WHERE, and ORDER BY to introduce conditional logic.
It allows for the implementation of if-then-else logic within queries efficiently.
The CASE function enhances query flexibility by enabling different result outputs based on specified conditions.
*/





