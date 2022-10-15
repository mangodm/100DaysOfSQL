-- Question : Tweets' Rolling Averages

-- Solution
WITH tmp_table AS (

    SELECT
        user_id,
        tweet_date,
        COUNT(*) AS n_count 
    FROM tweets 
    GROUP BY user_id, tweet_date
    
)

SELECT
    user_id,
    tweet_date,
    ROUND(AVG(n_count) OVER (PARTITION BY user_id ORDER BY tweet_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2) AS rolling_avg_3days
FROM tmp_table;