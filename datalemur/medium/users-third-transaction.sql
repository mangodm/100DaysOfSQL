-- Question : User's Third Transaction

-- Solution
WITH transactions_rn_list AS (

  SELECT
      user_id,
      spend,
      transaction_date,
      ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY transaction_date) AS rn
  FROM transactions

)

SELECT 
    user_id,
    spend,
    transaction_date
FROM transactions_rn_list
WHERE rn = 3;