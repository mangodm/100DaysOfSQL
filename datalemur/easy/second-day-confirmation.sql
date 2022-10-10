-- Question : Second Day Confirmation

-- Solution
SELECT
    DISTINCT emails.user_id
FROM (
SELECT
    email_id,
    ROW_NUMBER() OVER (PARTITION BY email_id ORDER BY action_date) AS rn,
    signup_action,
    LEAD(signup_action, 1) OVER (PARTITION BY email_id ORDER BY action_date) AS next_action
FROM texts) tmp 
INNER JOIN emails
    ON tmp.email_id = emails.email_id
WHERE tmp.rn = 1 
  AND tmp.signup_action = 'Not confirmed'
  AND tmp.next_action = 'Confirmed';