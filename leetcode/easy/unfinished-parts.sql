-- Question : Unfinished Parts

-- Solution
SELECT DISTINCT part   
FROM parts_assembly
WHERE finish_date IS NULL;