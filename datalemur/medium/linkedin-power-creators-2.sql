-- Question : LinkedIn Power Creators (Part 2)

-- Solution
WITH has_more_followers_list AS (

    SELECT
        personal_profiles.profile_id,
        MIN(CASE
            WHEN personal_profiles.followers > company_pages.followers THEN 1 
            ELSE 0 
        END) AS has_more_followers
    FROM personal_profiles
    INNER JOIN employee_company
        ON personal_profiles.profile_id = employee_company.personal_profile_id 
    INNER JOIN company_pages
        ON employee_company.company_id = company_pages.company_id
    GROUP BY personal_profiles.profile_id
    
)

SELECT profile_id
FROM has_more_followers_list
WHERE has_more_followers = 1
ORDER BY profile_id;