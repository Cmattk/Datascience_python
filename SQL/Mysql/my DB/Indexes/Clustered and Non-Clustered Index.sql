-- Clustered and Non-Clustered Index

/*
Feature	         Clustered Index	                            Non-Clustered Index

Speed	        Faster for range-based queries and sorting.	  Slower for range-based queries but faster for specific lookups.

Memory Usage	Requires less memory for operations.	Requires more memory due to additional index structure.

Data Storage	The clustered index stores data in the table itself.	The non-clustered index stores data separately from the table.

Number of Indexes per Table.	A table can have only one clustered index.	A table can have multiple non-clustered indexes.

Disk Storage	The clustered index can store data on the disk.	The non-clustered index stores the index structure (B-tree) on disk with pointers to the data pages.

Data Order	Defines the physical order of the rows in the table.	Defines the logical order of data in the index, not the table.

Impact on Table	A clustered index directly impacts the table's physical storage order.	A non-clustered index does not affect the physical storage order of the table.

Use Case	Ideal for range queries and sorting.	Suitable for optimizing lookups and queries on non-primary columns.
*/







