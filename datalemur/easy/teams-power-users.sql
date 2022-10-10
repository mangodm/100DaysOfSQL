-- Question : Teams Power Users

-- Solution
SELECT
    sender_id,
    COUNT(DISTINCT message_id) AS message_count
FROM messages
WHERE LEFT(sent_date::VARCHAR, 7) = '2022-08'
GROUP BY sender_id
ORDER BY COUNT(DISTINCT message_id) DESC 
LIMIT 2;