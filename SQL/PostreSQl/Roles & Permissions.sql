-- ROLE
-- a role represents an entity with specific privileges within a database.
-- Roles can act as users (with login capabilities), groups (aggregating users for permissions), or a combination of both.
-- Using roles, administrators can set user privileges, manage data access, and define restrictions, 
-- making PostgreSQL role management crucial for effective database administration.

-- Syntax: create role role_name;
CREATE ROLE kasina;

-- Retreving All Roles: SELECT rolname from pg_roles;
 SELECT rolname from pg_roles;

-- psql tool: \du

-- Role attributes
-- role attributes define specific privileges and permissions for a role.
-- These attributes control what the role can do within the database, 
-- including the ability to log in, manage databases, create new roles, or gain superuser privileges.

/*
SUPERUSER: Grants the role superuser privileges, allowing it to bypass all access restrictions.
CREATEDB: Enables the role to create databases.
CREATEROLE: Allows the role to create, alter, and drop other roles.
LOGIN: Enables the role to log into the database (making it function as a user).
PASSWORD: Sets a password for roles with LOGIN capability.
*/

-- Create login roles
CREATE ROLE celestine
LOGIN 
PASSWORD 'cele123#';

-- Create superuser roles
CREATE ROLE matt 
SUPERUSER
LOGIN 
PASSWORD 'matt123';

-- Create roles that can create databases

CREATE ROLE myadmin
CREATEDB 
LOGIN 
PASSWORD 'admin123';

-- Create roles with validity period
-- To set a date and time after which the role’s password is no longer valid

CREATE ROLE dev_api WITH
LOGIN
PASSWORD 'securePass1'
VALID UNTIL '2030-01-01';

-- Create roles with connection limit
-- To specify the number of concurrent connections a role can make,
-- creates a new role called API that can make 1000 concurrent connections.

CREATE ROLE api 
LOGIN 
PASSWORD 'api123'
CONNECTION LIMIT 1000;

/*
Global Scope: Roles are valid across the entire PostgreSQL server, so they don’t need to be recreated for each database.
Inheritance: Roles inherit privileges from other roles they belong to by default, controlled by the INHERIT attribute.
Password Management: Specifying PASSWORD NULL removes the password, preventing login for roles with the LOGIN attribute.
Connection Limits: Use the CONNECTION LIMIT attribute to control the number of concurrent connections for each role.
*/

------------------------------------------------------------------

-- ALTER ROLE ---
-- used to manage and modify roles.
-- It allows administrators to change a role's name, attributes, and session defaults for configuration variables.

-- Syntax: ALTER ROLE role_name [WITH] option;
/*
SUPERUSER | NOSUPERUSER: Determines if the role is a superuser.
VALID UNTIL 'timestamp': Specifies the expiry date and time of a role’s password.
CREATEDB | NOCREATEDB: Grants or revokes permissions for creating new databases.
REPLICATION | NOREPLICATION: Indicates if a role is a replication role.
CREATEROLE | NOCREATEROLE: Grants or revokes permissions for creating or modifying roles.
PASSWORD 'password' | PASSWORD NULL: Changes the role’s password.
INHERIT | NOINHERIT: Determines if the role inherits privileges from parent roles.
BYPASSRLS | NOBYPASSRLS: Checks if a role can bypass row-level security (RLS) policies.
LOGIN | NOLOGIN: Allows or disallows the role to log in.
CONNECTION LIMIT limit: Sets the number of concurrent connections a role can make (-1 means unlimited connections).
*/

-- Superusers can modify the attributes for any role.
-- Non-superusers and no-replication roles can be modified if a role has the CREATE ROLE attribute.
-- Ordinary roles can only change their passwords.

CREATE ROLE ravi LOGIN PASSWORD 'geeks12345';
ALTER ROLE ravi SUPERUSER;
ALTER ROLE ravi VALID UNTIL '2026-12-31';
ALTER ROLE ravi CREATEDB;

-- You can combine multiple options in a single ALTER ROLE statement, 
-- which helps in consolidating role modifications into one command for efficiency.


-- DROP Role --
-- used to remove a role from the database.
-- syntax: DROP ROLE [IF EXISTS] target_role;

-- To remove a superuser role, one needs to be a superuser.
-- To remove non-superuser roles, you will need the privilege to create a role using the CREATE ROLE statement.

-- steps to remove a role:
-- 1. Remove the database objects owned by that particular role using the DROP OWNED statement or
-- reassign the ownership of the database objects to another role using the REASSIGN OWNED statement.

-- 2. revoke all other permissions granted to the role.

/*
REASSIGN OWNED BY target_role TO another_role;
DROP OWNED BY target_role;
DROP ROLE target_role;
*/

CREATE ROLE geeksforgeeks WITH LOGIN PASSWORD 'geeks12345';
ALTER ROLE geeksforgeeks CREATEDB;
SELECT rolname from pg_roles;
DROP ROLE geeksforgeeks;
SELECT rolname from pg_roles;


-- GRANT --
-- GRANT statement is a powerful tool used to assign privileges to a role, allowing it to alter database objects like tables, views, functions, and more.

-- Syntax: 
-- GRANT privilege_list | ALL
-- ON table_name
-- role_name;

-- privilege_list: Some elements of the 'privilege_list' are SELECT, INSERT, UPDATE, DELETE, TRUNCATE, etc
--                 The ALL option grants all available privileges to a role.
-- table_name: It is required to mention the name of the table after the ON keyword.
-- role_name: The next step is to mention the name of the role to be granted the privileges.

CREATE ROLE mathias
LOGIN 
PASSWORD 'matt123';

CREATE TABLE players(
    player_id INT GENERATED ALWAYS AS IDENTITY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(25) NOT NULL UNIQUE,
    PRIMARY KEY(player_id)
);

-- Granting SELECT Privilege
GRANT SELECT 
ON players
TO mathias; 

-- Selecting Data Again
SELECT * FROM players;

-- Granting INSERT, UPDATE, and DELETE Privileges
GRANT INSERT, UPDATE, DELETE
ON players
TO mathias;
/*
The GRANT statement is not limited to tables. You can grant privileges on other object types such as sequences, functions, schemas, and databases.
Privileges granted can also be revoked using the REVOKE statement.
You can also grant privileges on schemas to control the creation of objects within the schema.*/

-- REVOKE
-- REVOKE statement plays a crucial role in managing database security by removing previously granted privileges from roles or users.
-- syntax:
/*
REVOKE priviledge | ALL
ON TABLE tbl_name | ALL TABLES IN SCHEMA schema_name
FROM role_name
*/

DROP ROLE namu;

CREATE ROLE namu
LOGIN 
PASSWORD 'namu123';

GRANT ALL ON film TO  namu;
GRANT SELECT ON actor to namu;
-- revoke specific privileges
REVOKE SELECT ON actor FROM namu;
-- revoke all privileges
REVOKE all ON film FROM namu;

-- Revoking privileges does not affect existing data in the database but prevents the role from performing actions 
-- The REVOKE command can only remove privileges that were previously granted to the role.
-- If a role has been granted privileges through other roles (i.e., role hierarchies),
--  revoking privileges from the parent role may affect child roles as well.


--- Role Membership ---
-- Group roles are a powerful feature that can significantly simplify the process of granting or revoking privileges,
--  However, it is important to note that, by convention, a group role does not have the 'LOGIN' privilege.

--  Creating and Managing Group Roles  --
--  Syntax: CREATE ROLE group_role_name;


--  Adding a Role to a Group Role --
--  Syntax: GRANT group_role TO user_role;


--  Removing a Role from a Group Role --
--  Syntax: REVOKE group_role FROM user_role;


-- Using Group Role Privileges
-- A role can use the privileges of the group role in the following ways:
-- INHERIT Attribute: If we use the INHERIT attribute, the members of group role gets all the privileges of the group automatically.
-- SET ROLE Statement: To create a temporary role use the SET ROLE statement.

