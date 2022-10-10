-- Question : Apple Pay Volume

-- Solution
WITH merchant_list AS (

    SELECT DISTINCT merchant_id
    FROM transactions

), transactions_list AS (

    SELECT
        merchant_id,
        SUM(transaction_amount) AS volume
    FROM transactions
    WHERE LOWER(payment_method) = 'apple pay'
    GROUP BY merchant_id

)

SELECT 
    merchant_list.merchant_id,
    COALESCE(transactions_list.volume, 0) AS volume
FROM merchant_list
LEFT JOIN transactions_list
    ON merchant_list.merchant_id = transactions_list.merchant_id
ORDER BY COALESCE(transactions_list.volume, 0) DESC;