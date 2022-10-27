-- Question : User Shopping Sprees

-- Solution
WITH is_next_equal_list AS (

    SELECT
        user_id,
        transaction_date,
        CASE
            WHEN transaction_date + INTERVAL '1 day' = LEAD(transaction_date, 1) OVER(PARTITION BY user_id ORDER BY transaction_date) THEN 1 
            ELSE 0 
        END AS is_next_1_equal,
        CASE
            WHEN transaction_date + INTERVAL '2 day' = LEAD(transaction_date, 2) OVER(PARTITION BY user_id ORDER BY transaction_date) THEN 1 
            ELSE 0 
        END AS is_next_2_equal
    FROM transactions
    
)

SELECT
    DISTINCT user_id
FROM is_next_equal_list
WHERE is_next_1_equal = 1
  AND is_next_2_equal = 1
ORDER BY user_id;