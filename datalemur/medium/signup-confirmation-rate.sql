-- Question : Signup Confirmation Rate

-- Solution
SELECT
    ROUND((SUM(CASE WHEN texts.signup_action = 'Confirmed' THEN 1 ELSE 0 END)::DECIMAL /
    COUNT(*)), 2) AS confirm_rate
FROM emails
LEFT JOIN texts
    ON emails.email_id = texts.email_id
   AND texts.signup_action = 'Confirmed';