-- Question : First Transaction

-- Solution
WITH transactions_rn_list AS (

    SELECT
        user_id,
        spend,
        ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY transaction_date, transaction_id) AS rn
    FROM user_transactions

), first_transactions_list AS (

    SELECT
        user_id,
        CASE
            WHEN spend >= 50 THEN 1
            ELSE 0 
        END AS is_over_50
    FROM transactions_rn_list 
    WHERE rn = 1

)

SELECT COUNT(user_id) AS users
FROM first_transactions_list
WHERE is_over_50 = 1;
