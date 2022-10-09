-- Question : LinkedIn Power Creators (Part 1)

-- Solution
SELECT profile_id
FROM personal_profiles
INNER JOIN company_pages 
    ON personal_profiles.employer_id = company_pages.company_id
WHERE personal_profiles.followers > company_pages.followers
ORDER BY profile_id;