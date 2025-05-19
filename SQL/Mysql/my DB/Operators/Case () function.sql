--  Case () function 
-- is a conditional statement that returns a value when the first condition is met.

CREATE TABLE float01001
(  
user_id int NOT NULL AUTO_INCREMENT,
float_val float,
PRIMARY KEY(user_id)
);
INSERT float01001(float_val)  
VALUES (1.9);

INSERT float01001(float_val)  
VALUES (1.1);

INSERT float01001(float_val)  
VALUES (3.9);

INSERT float01001(float_val)  
VALUES (5.0);

INSERT float01001(float_val)  
VALUES (10.9);


-- Using the CASE() function and getting the output.

select float_val,
case 
    when float_val > 5 then 'the value is greater than 5'
    when float_val = 5 then  'the value is 5'
    else 'the value is under 5'
end as float_txt
from float01001;

-- Using the CASE() function and checking if the length of the stated float value is greater than, or less than, or equal to 4.
SELECT float_val,
CASE
    WHEN LENGTH(float_val) > 4 THEN "The length is greater than 4"
    WHEN LENGTH(float_val) = 4 THEN "The length is 4"
    ELSE "The length is less than 4"
END as float_txt
FROM float01001;


