-- Question : Average Review Ratings

-- Solution
SELECT
    CAST(SUBSTRING(CAST(submit_date AS VARCHAR), 6, 2) AS INT) AS mth,
    product_id,
    ROUND(AVG(stars), 2) AS avg_stars
FROM reviews
GROUP BY
    CAST(SUBSTRING(CAST(submit_date AS VARCHAR), 6, 2) AS INT),
    product_id
ORDER BY CAST(SUBSTRING(CAST(submit_date AS VARCHAR), 6, 2) AS INT), product_id;