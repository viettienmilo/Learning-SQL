USE sakila;
-- Write a query that returns the title of every film in which 
-- an actor with the first name JOHN appeared.
SELECT f.title,
    a.first_name,
    a.last_name
FROM film f
    INNER JOIN film_actor fa ON f.film_id = fa.film_id
    INNER JOIN actor a ON fa.actor_id = a.actor_id
WHERE a.first_name LIKE '%JOHN%';
-- Construct a query that returns all addresses that are in the 
-- same city. You will need to join the address table to itself,
-- and each row should include two different addresses.
SELECT a1.address,
    a2.address,
    a1.city_id
FROM address a1
    INNER JOIN address a2
WHERE a1.city_id = a2.city_id
    AND a1.address <> a2.address;