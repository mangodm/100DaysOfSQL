-- 01. 
-- Description
-- Let's start with creating a table that provides the following details: 
-- actor's first and last name combined as full_name, film title, film description and length of the movie.
-- How many rows are there in the table?

-- Solution
SELECT
	CONCAT(actor.first_name, ' ', actor.last_name) AS full_name,
    film.title,
    film.description,
    film.length
FROM film
INNER JOIN film_actor
	ON film.film_id = film_actor.film_id
INNER JOIN actor
	ON film_actor.actor_id = actor.actor_id;

-- 02.
-- Description
-- Write a query that creates a list of actors and movies where the movie length was more than 60 minutes. 
-- How many rows are there in this query result?

-- Solution
SELECT COUNT(*)
FROM film_actor
WHERE film_id IN (SELECT film_id
                  FROM film
                  WHERE length > 60);

-- 03.
-- Description
-- Write a query that captures the actor id, full name of the actor, and counts the number of movies each actor has made. 
-- (HINT: Think about whether you should group by actor id or the full name of the actor.) 

-- Solution
SELECT
    actor.actor_id,
    CONCAT(actor.first_name, ' ', actor.last_name) AS full_name,
    COUNT(film_actor.film_id) AS n_count
FROM actor
INNER JOIN film_actor
    ON actor.actor_id = film_actor.actor_id 
GROUP BY actor.actor_id, CONCAT(actor.first_name, ' ', actor.last_name);

-- Description
-- Identify the actor who has made the maximum number movies.

-- Solution
SELECT *
FROM actor
WHERE actor_id = (SELECT actor_id
                  FROM film_actor
                  GROUP BY actor_id
                  ORDER BY COUNT(film_id) DESC
                  LIMIT 1);
