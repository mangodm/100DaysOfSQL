-- Question : Top Rated Businesses

-- Solution
WITH is_top_rated_biz_list AS (

    SELECT
        business_id,
        CASE
            WHEN MIN(review_stars)>= 4 THEN 1 
            ELSE 0 
        END AS is_top_rated_biz
    FROM reviews
    GROUP BY business_id

)

SELECT
    SUM(is_top_rated_biz) AS business_count,
    ((SUM(is_top_rated_biz)::FLOAT / COUNT(*)) * 100)::INT AS top_rated_pct
FROM is_top_rated_biz_list;