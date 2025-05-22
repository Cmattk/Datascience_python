-- Recursive CTE (Common Table Expressions)
-- it is defined using WITH  clause 
-- more than one CTEs can be defined in a single statement.

-- A recursive CTE is a subquery which refer to itself using its own name.
-- The recursive CTEs are used for series generation and traversal of hierarchical or tree-structured data.

-- The recursive CTE consist of a non-recursive subquery followed by a recursive subquery

-- example - 

WITH Recursive odd_no (sr_no, n) as (
    -- non-recursive --
    -- produce initial rows which consist of two columns named as "sr_no" and "n" and single row.
    select 1, 1
    union all
    -- recursive -- 
    -- It will add rows to previous output till the terminating condition i.e ( sr_no < 5 ) is satisfied.
    select sr_no+1, n+2 from odd_no where sr_no < 5
)
select * from odd_no;


