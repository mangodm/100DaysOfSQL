-- Question 177. Nth Highest Salary

-- Table: Employee

-- +-------------+------+
-- | Column Name | Type |
-- +-------------+------+
-- | id          | int  |
-- | salary      | int  |
-- +-------------+------+
-- id is the primary key column for this table.
-- Each row of this table contains information about the salary of an employee.
 

-- Write an SQL query to report the nth highest salary from the Employee table. If there is no nth highest salary, the query should report null.

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
-- n = 2
-- Output: 
-- +------------------------+
-- | getNthHighestSalary(2) |
-- +------------------------+
-- | 200                    |
-- +------------------------+
-- Example 2:

-- Input: 
-- Employee table:
-- +----+--------+
-- | id | salary |
-- +----+--------+
-- | 1  | 100    |
-- +----+--------+
-- n = 2
-- Output: 
-- +------------------------+
-- | getNthHighestSalary(2) |
-- +------------------------+
-- | null                   |
-- +------------------------+

-- Solution
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
      WITH nth_highest_salary_list AS (
      
          SELECT
              id,
              salary,
              DENSE_RANK() OVER (ORDER BY salary DESC) AS rn
          FROM Employee      
      
      )

      SELECT DISTINCT
             CASE 
                 WHEN (SELECT MAX(rn) 
                       FROM nth_highest_salary_list) >= N THEN (SELECT DISTINCT salary 
                                                                FROM nth_highest_salary_list 
                                                                WHERE rn = N)
                 ELSE NULL 
             END AS nth_highest_salary_list
             FROM Employee 
  );
END
