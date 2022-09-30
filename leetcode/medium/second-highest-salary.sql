-- Question 176. Second Highest Salary

-- Table: Employee

-- +-------------+------+
-- | Column Name | Type |
-- +-------------+------+
-- | id          | int  |
-- | salary      | int  |
-- +-------------+------+
-- id is the primary key column for this table.
-- Each row of this table contains information about the salary of an employee.
 

-- Write an SQL query to report the second highest salary from the Employee table. If there is no second highest salary, the query should report null.

-- The query result format is in the following example.

 

-- Example 1:

-- Input: 
-- Employee table:
-- +----+--------+
-- | id | salary |
-- +----+--------+
-- | 1  | 100    |
-- | 2  | 200    |
-- | 3  | 300    |
-- +----+--------+
-- Output: 
-- +---------------------+
-- | SecondHighestSalary |
-- +---------------------+
-- | 200                 |
-- +---------------------+
-- Example 2:

-- Input: 
-- Employee table:
-- +----+--------+
-- | id | salary |
-- +----+--------+
-- | 1  | 100    |
-- +----+--------+
-- Output: 
-- +---------------------+
-- | SecondHighestSalary |
-- +---------------------+
-- | null                |
-- +---------------------+

-- Solution
WITH second_highest_salary_list AS (

    SELECT
        id,
        salary,
        DENSE_RANK() OVER (ORDER BY salary DESC) AS rn
    FROM Employee

)

SELECT DISTINCT
    CASE 
        WHEN (SELECT MAX(rn) FROM second_highest_salary_list) >= 2 THEN (SELECT DISTINCT salary FROM second_highest_salary_list WHERE rn = 2)
        ELSE NULL 
    END AS SecondHighestSalary
FROM Employee;
