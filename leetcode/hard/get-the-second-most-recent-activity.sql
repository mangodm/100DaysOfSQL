-- Question 1369. Get the Second Most Recent Activity

-- Table: UserActivity

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | username      | varchar |
-- | activity      | varchar |
-- | startDate     | Date    |
-- | endDate       | Date    |
-- +---------------+---------+
-- There is no primary key for this table. It may contain duplicates.
-- This table contains information about the activity performed by each user in a period of time.
-- A person with username performed an activity from startDate to endDate.
 

-- Write an SQL query to show the second most recent activity of each user.

-- If the user only has one activity, return that one. A user cannot perform more than one activity at the same time.

-- Return the result table in any order.

-- The query result format is in the following example.

 

-- Example 1:

-- Input: 
-- UserActivity table:
-- +------------+--------------+-------------+-------------+
-- | username   | activity     | startDate   | endDate     |
-- +------------+--------------+-------------+-------------+
-- | Alice      | Travel       | 2020-02-12  | 2020-02-20  |
-- | Alice      | Dancing      | 2020-02-21  | 2020-02-23  |
-- | Alice      | Travel       | 2020-02-24  | 2020-02-28  |
-- | Bob        | Travel       | 2020-02-11  | 2020-02-18  |
-- +------------+--------------+-------------+-------------+
-- Output: 
-- +------------+--------------+-------------+-------------+
-- | username   | activity     | startDate   | endDate     |
-- +------------+--------------+-------------+-------------+
-- | Alice      | Dancing      | 2020-02-21  | 2020-02-23  |
-- | Bob        | Travel       | 2020-02-11  | 2020-02-18  |
-- +------------+--------------+-------------+-------------+
-- Explanation: 
-- The most recent activity of Alice is Travel from 2020-02-24 to 2020-02-28, before that she was dancing from 2020-02-21 to 2020-02-23.
-- Bob only has one record, we just take that one.

-- Solution
WITH row_number_activity_list AS (

    SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY username ORDER BY startDate DESC) AS rn
    FROM UserActivity

), max_rn_list AS (
    SELECT 
        username,
        CASE 
            WHEN MAX(rn) >= 2 THEN 2
            ELSE 1
        END AS max_rn
    FROM row_number_activity_list
    GROUP BY username
    
)

SELECT 
    row_number_activity_list.username,
    row_number_activity_list.activity,
    row_number_activity_list.startDate,
    row_number_activity_list.endDate
FROM row_number_activity_list
INNER JOIN max_rn_list
    ON row_number_activity_list.username = max_rn_list.username
   AND row_number_activity_list.rn = max_rn_list.max_rn;
