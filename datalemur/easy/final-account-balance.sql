-- Question : Final Account Balance

-- Solution
SELECT
    account_id,
    SUM(CASE WHEN transaction_type = 'Deposit' THEN amount ELSE -amount END) AS amount
FROM transactions
GROUP BY account_id