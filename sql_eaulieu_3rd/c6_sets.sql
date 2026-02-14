USE sakila;
-- 6.2 Write a compound query that finds the first and last names of all actors
-- and customers whose last name starts with L.
SELECT 'ACTOR' AS TYP,
    first_name,
    last_name
FROM actor
WHERE last_name LIKE 'L%'
UNION ALL
SELECT 'CUSTOMER' AS TYP,
    first_name,
    last_name
FROM customer
WHERE last_name LIKE 'L%';
-- Sort the results from Exercise 6 -2 by the last_name column.
SELECT 'ACTOR' AS TYP,
    first_name AS FNAME,
    last_name AS LNAME
FROM actor
WHERE last_name LIKE 'L%'
UNION ALL
SELECT 'CUSTOMER' AS TYP,
    first_name,
    last_name
FROM customer
WHERE last_name LIKE 'L%'
ORDER BY LNAME;