-- Question 580. Count Student Number in Departments

-- Table: Student

-- +--------------+---------+
-- | Column Name  | Type    |
-- +--------------+---------+
-- | student_id   | int     |
-- | student_name | varchar |
-- | gender       | varchar |
-- | dept_id      | int     |
-- +--------------+---------+
-- student_id is the primary key column for this table.
-- dept_id is a foreign key to dept_id in the Department tables.
-- Each row of this table indicates the name of a student, their gender, and the id of their department.
 

-- Table: Department

-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | dept_id     | int     |
-- | dept_name   | varchar |
-- +-------------+---------+
-- dept_id is the primary key column for this table.
-- Each row of this table contains the id and the name of a department.
 

-- Write an SQL query to report the respective department name and number of students majoring in each department for all departments in the Department table (even ones with no current students).

-- Return the result table ordered by student_number in descending order. In case of a tie, order them by dept_name alphabetically.

-- The query result format is in the following example.

 

-- Example 1:

-- Input: 
-- Student table:
-- +------------+--------------+--------+---------+
-- | student_id | student_name | gender | dept_id |
-- +------------+--------------+--------+---------+
-- | 1          | Jack         | M      | 1       |
-- | 2          | Jane         | F      | 1       |
-- | 3          | Mark         | M      | 2       |
-- +------------+--------------+--------+---------+
-- Department table:
-- +---------+-------------+
-- | dept_id | dept_name   |
-- +---------+-------------+
-- | 1       | Engineering |
-- | 2       | Science     |
-- | 3       | Law         |
-- +---------+-------------+
-- Output: 
-- +-------------+----------------+
-- | dept_name   | student_number |
-- +-------------+----------------+
-- | Engineering | 2              |
-- | Science     | 1              |
-- | Law         | 0              |
-- +-------------+----------------+

-- Solution
SELECT
    Department.dept_name,
    COALESCE(COUNT(Student.student_id), 0) AS student_number
FROM Department
LEFT JOIN Student
    ON Department.dept_id = Student.dept_id
GROUP BY Department.dept_name
ORDER BY COALESCE(COUNT(Student.student_id), 0) DESC, Department.dept_name;


