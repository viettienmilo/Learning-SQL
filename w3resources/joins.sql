USE excercise_db;
-- 1. Write a MySQL query to find the addresses (location_id, street_address, city, 
-- state_province, country_name) of all the departments.
-- Hint : Use NATURAL JOIN.
SELECT d.DEPARTMENT_ID,
    d.DEPARTMENT_NAME,
    l.STREET_ADDRESS,
    l.CITY,
    l.STATE_PROVINCE,
    c.COUNTRY_NAME
FROM departments d
    NATURAL JOIN locations l
    NATURAL JOIN countries c;