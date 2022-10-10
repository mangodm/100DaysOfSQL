-- Question : Highest Number of Products

-- Solution
SELECT
    user_id,
    COUNT(DISTINCT product_id) AS product_num
FROM user_transactions
GROUP BY user_id
HAVING SUM(spend) >= 1000
ORDER BY COUNT(DISTINCT product_id) DESC, SUM(spend) DESC 
LIMIT 3;