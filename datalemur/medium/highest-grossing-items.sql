-- Question : Highest-Grossing Items

-- Solution
WITH product_spend_agg_list AS (

    SELECT
        category,
        product,
        SUM(spend) AS total_spend
    FROM product_spend
    WHERE LEFT(transaction_date::VARCHAR, 4) = '2022'
    GROUP BY category, product

), product_spend_rank_list AS (

    SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY category ORDER BY total_spend DESC) AS rn
    FROM product_spend_agg_list

)

SELECT
    category,
    product,
    total_spend
FROM product_spend_rank_list 
WHERE rn <= 2;