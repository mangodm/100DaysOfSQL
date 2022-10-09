-- Question : Cities With Completed Trades

-- Solution
SELECT
    users.city,
    COUNT(*) AS total_orders
FROM trades 
INNER JOIN users 
    ON trades.user_id = users.user_id
WHERE trades.status = 'Completed'
GROUP BY users.city
ORDER BY COUNT(*) DESC
LIMIT 3;