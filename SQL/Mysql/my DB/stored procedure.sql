-- stored procedure = is prepared sql code that you can save 
--                    great if there's a query that you write often

delimiter $$
create procedure get_customers()
begin
	select * from customers;
end $$
delimiter ;

call get_customers();

drop procedure get_customers;

delimiter $$
create procedure find_customer(in id int)
begin 
	select *
    from customers
    where customer_id = id;
end $$
delimiter ;

call find_customer(4);

drop procedure find_customer;

delimiter $$
create procedure find_customer(in f_name varchar(50), in l_name varchar(50))
begin 
	select *
    from customers
    where first_name = f_name and last_name = l_name;
end $$
delimiter ;

call find_customer('Ann','Perkins');

    
