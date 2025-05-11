"""
The CREATE USER statement in MySQL is an essential command
used to create new user accounts for database access. 
It enables database administrators to define which
users can connect to the MySQL database server and 
specify their login credentials.
"""



'''  create a new user “gfguser1” that connects to the MySQL database server
 from the localhost with the password “abcd”. '''

CREATE USER gfguser1@localhost IDENTIFIED BY 'abcd';

''' Create Multiple User '''

CREATE USER
'gfguser2'@'localhost' IDENTIFIED BY 'efgh',
'gfguser3'@'localhost' IDENTIFIED BY 'uvxy';


''' To allow a user account to connect from any host, 
the percentage (%) wildcard is used in the following way.  '''

CREATE USER gfguser1@'%'
IDENTIFIED BY 'abcd'; 

''' The SHOW GRANTS statement is used to view the permissions of a user account. '''

SHOW GRANTS ;

SHOW GRANTS FOR 'root'@'localhost';

SHOW GRANTS FOR gfguser1@localhost;

"""
In conclusion, 
the CREATE USER statement in MySQL is a fundamental command 
that allows the creation of user accounts with specific login credentials. 
By understanding how to create both single and multiple users, 
as well as allowing connections from specific hosts or wildcard domains,
database administrators can effectively manage user access to the MySQL database server. 
Additionally, using the SHOW GRANTS command enables administrators to view the permissions of user accounts, 
ensuring that proper access control measures are in place.
"""



"""
The DROP USER statement is a powerful tool
 used by database administrators to delete user accounts that are no longer required.
"""

# DROP USER 'username'@'host';

DROP USER 'gfguser3'@'localhost';

DROP USER 'gfguser1'@'localhost' , DROP USER 'gfguser'@'localhost';


"""
The USER() function in MySQL is a useful tool for retrieving information about the current database connection. It provides details about the user name and the hostname from which the connection was established.
"""
# show users
SELECT user();

INSERT into myrestaurant (username, log_time)
VALUES (user(), now());

SELECT CURRENT_USER();

SELECT session_USER();

SELECT User, Host FROM mysql.user;

# change user password

CREATE USER gfguser1@localhost IDENTIFIED BY 'abcd';

SET PASSWORD FOR 'gfguser1'@'localhost' = 'newpass';

ALTER USER 'gfguser1'@'localhost' IDENTIFIED BY 'newpass1';

UPDATE MySQL.user 
SET authentication_string = PASSWORD('newpass2') 
WHERE User = 'gfguser1' AND Host = 'localhost';
FLUSH PRIVILEGES;



