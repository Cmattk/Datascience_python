/*
Views act like virtual tables, simplifying complex queries. 
Think of them as pre-written queries you can reference easily,
like a shortcut. This saves time and improves code readability,
making database interactions more efficient.

are used to view data from one or more tables.

are very helpful in restricting access to your application's critical data to third-party users

----- Benefit of Using Views ----
Simplicity: Instead of writing complex joins & queries, views provide a way of writing simple SELECT statements.
Enhanced Security: Views expose only the data to the third-party apps and hide the internal details like table structure, attributes, etc, thus adding extra security.
Consistency: By writing views instead of common queries, we can write a view that avoids multiple declarations & definitions of the same queries and eventually provides a centralized way.
*/

/*
--- MySQL Command Line Client --
It is basically a Non-GUI based approach to query and interact with our MySQL database.
permits sending MySQL queries to MySQL database from the command line i.e. shell.

---- connect to the local MySQL database using the command line ---
Open the command prompt/shell.
Run the command mysql -u root -p
Enter the password, then you will be connected to your MySQL database.
*/
 