-- Question : Compensation Outliers

-- Solution
WITH salary_outliers_list AS (

    SELECT
        title,
        AVG(salary) * 2 AS overpaid,
        AVG(salary) / 2 AS underpaid
    FROM employee_pay
    GROUP BY title

)

SELECT
    employee_pay.employee_id,
    employee_pay.salary,
    CASE
        WHEN employee_pay.salary > salary_outliers_list.overpaid THEN 'Overpaid'
        WHEN employee_pay.salary < salary_outliers_list.underpaid THEN 'Underpaid'
        ELSE 'ETC'
    END AS status
FROM salary_outliers_list
INNER JOIN employee_pay
    ON salary_outliers_list.title = employee_pay.title
   AND (salary_outliers_list.overpaid < employee_pay.salary OR
        salary_outliers_list.underpaid > employee_pay.salary);