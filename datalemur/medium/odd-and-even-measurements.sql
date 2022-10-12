-- Question : Odd and Even Measurements

-- Solution
WITH measurements_rn_list AS (
  
    SELECT
        measurement_value,
        measurement_time::DATE AS measurement_day,
        ROW_NUMBER() OVER (PARTITION BY measurement_time::DATE ORDER BY measurement_time) AS rn
    FROM measurements

)

SELECT
    measurement_day,
    SUM(CASE
        WHEN rn % 2 = 1 THEN measurement_value
        ELSE 0
    END) AS odd_sum,
    SUM(CASE
        WHEN rn % 2 = 0 THEN measurement_value
        ELSE 0
    END) AS even_sum
FROM measurements_rn_list
GROUP BY measurement_day;