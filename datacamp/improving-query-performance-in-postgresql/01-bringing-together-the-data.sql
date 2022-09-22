-- Join tables to return countries with participating athletes.
-- Athlete count by country and region
SELECT
    reg.region,
    reg.country,
    COUNT(DISTINCT ath.athlete_id) AS no_athletes 
FROM athletes AS ath
INNER JOIN oregions AS reg
    ON ath.country_code = reg.olympic_cc
GROUP BY reg.region, reg.country
ORDER BY no_athletes;

-- Using different joins to explore athletes' regions
SELECT
    reg.region,
    reg.country,
    COUNT(DISTINCT ath.athlete_id) AS no_athletes 
FROM regions AS reg
LEFT JOIN athletes AS ath
    ON ath.country_code = reg.olympic_cc
GROUP BY reg.region, reg.country
ORDER BY no_athletes;

-- Exploring the hypothesis(Africa does not send many athletes to the Winter Games)
SELECT 
    reg.region
  , ath.season
  , COUNT(DISTINCT ath.athlete_id) AS no_athletes
  , COUNT(DISTINCT reg.olympic_cc) AS no_countries
  , COUNT(DISTINCT ath.athlete_id)/COUNT(DISTINCT reg.olympic_cc) AS athletes_per_country
FROM athletes ath
INNER JOIN oregions reg
  ON ath.country_code = reg.olympic_cc
GROUP BY reg.region, ath.season -- Group by region and season
ORDER BY reg.region, COUNT(DISTINCT ath.athlete_id)/COUNT(DISTINCT reg.olympic_cc);

-- Exploring climate data to see if all African countries lack winter sports conditions
-- Countries cold enough for snow year-round
SELECT country_code
  , country
  , COUNT (DISTINCT athlete_id) AS winter_athletes -- Athletes can compete in multiple events 
FROM athletes
WHERE country_code IN (SELECT olympic_cc FROM oclimate  WHERE temp_annual < 0)
AND season = 'Winter'
GROUP BY country_code, country;

-- Looking at climate data by using a CTE
WITH south_cte AS -- CTE
(
  SELECT region
    , ROUND(AVG(temp_06),2) AS avg_winter_temp
    , ROUND(AVG(precip_06),2) AS avg_winter_precip
  FROM oclimate
  WHERE region IN ('Africa','South America','Australia and Oceania')
  GROUP BY region
)

SELECT south.region, south.avg_winter_temp, south.avg_winter_precip
  , COUNT(DISTINCT ath.athlete_id)
FROM south_cte as south
INNER JOIN athletes_recent ath
  ON south.region = ath.region
  AND ath.season = 'Winter'
GROUP BY south.region, south.avg_winter_temp, south.avg_winter_precip
ORDER BY south.avg_winter_temp;

-- Using both a subquery and CTE structure
-- Climate by country with Olympian athletes
SELECT country
  , temp_06
  , precip_06
FROM climate
WHERE region = 'Africa'
AND olympic_cc IN (SELECT DISTINCT country_code FROM athletes_wint WHERE region = 'Africa')
ORDER BY temp_06;

WITH countries_cte AS -- CTE
(
    SELECT olympic_cc
      , country
      , temp_06
      , precip_06
    FROM climate
    WHERE region = 'Africa'
)

SELECT DISTINCT cte.country
  , cte.temp_06
  , cte.precip_06
FROM athletes_wint AS wint
INNER JOIN countries_cte AS cte
  ON wint.country_code = cte.olympic_cc
ORDER BY temp_06;

-- Using a temporary table to get the results
-- Create a temp table of Canadians
CREATE TEMP TABLE canadians AS
    SELECT *
    FROM athletes_recent
    WHERE country_code = 'CAN'
    AND season = 'Winter'; -- The table has both summer and winter athletes

-- Find the most popular sport
SELECT sport
  , COUNT(DISTINCT athlete_id) as no_athletes
FROM canadians
GROUP BY sport 
ORDER BY no_athletes DESC;

-- Using a temp table + allowing the query planner to optimize the query execution better
-- Create temp countries table
CREATE TEMP TABLE countries AS
    SELECT DISTINCT o.region, a.country_code, o.country
    FROM athletes a
    INNER JOIN oregions o
      ON a.country_code = o.olympic_cc;

ANALYZE countries; -- Collect the statistics

-- Count the entries
SELECT COUNT(*) FROM countries;