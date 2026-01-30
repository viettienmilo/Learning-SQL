USE excercise_db;
-- 1. Write a MySQL query to find the name (first_name, last_name) and the salary of 
-- the employees who have a higher salary than the employee whose last_name='Bull'.
SELECT CONCAT(e.FIRST_NAME, ' ', e.LAST_NAME) AS EMPLOYEE,
    e.SALARY
FROM employees e
WHERE e.SALARY > (
        SELECT SALARY
        FROM employees
        WHERE LAST_NAME = 'Bull'
    );
-- 2. Write a MySQL query to find the name (first_name, last_name) of all employees who 
-- works in the IT department.
SELECT CONCAT(e.FIRST_NAME, ' ', e.LAST_NAME) AS EMPLOYEE,
    e.DEPARTMENT_ID
FROM employees e
WHERE e.DEPARTMENT_ID = (
        SELECT DEPARTMENT_ID
        FROM departments
        WHERE DEPARTMENT_NAME = 'IT'
    );
-- 3. Write a MySQL query to find the name (first_name, last_name) of the employees who 
-- have a manager and worked in a USA based department.
-- Hint : Write single-row and multiple-row subqueries.
SELECT CONCAT(e.FIRST_NAME, ' ', e.LAST_NAME) AS EMPLOYEE,
    e.DEPARTMENT_ID,
    c.COUNTRY_NAME
FROM employees e
    INNER JOIN departments d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
    INNER JOIN locations l ON d.LOCATION_ID = l.LOCATION_ID
    INNER JOIN countries c ON l.COUNTRY_ID = c.COUNTRY_ID
WHERE c.COUNTRY_ID = (
        SELECT COUNTRY_ID
        FROM countries
        WHERE COUNTRY_NAME = 'United States of America'
    );