USE excercise_db;
-- 1. Write a query to display the name (first_name, last_name) and salary for all 
-- employees whose salary is not in the range $10,000 through $15,000.
SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) AS NAME,
    SALARY
FROM employees
WHERE SALARY NOT BETWEEN 10000 AND 15000;
-- 2. Write a query to display the name (first_name, last_name) and department ID 
-- of all employees in departments 30 or 100 in ascending order.
SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) AS NAME,
    DEPARTMENT_ID
FROM employees
WHERE DEPARTMENT_ID IN (30, 100)
ORDER BY DEPARTMENT_ID ASC;
-- 3. Write a query to display the name (first_name, last_name) and salary for all 
-- employees whose salary is not in the range $10,000 through $15,000 and are in 
-- department 30 or 100.
SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) AS NAME,
    SALARY,
    DEPARTMENT_ID
FROM employees
WHERE SALARY NOT BETWEEN 10000 AND 15000
    AND DEPARTMENT_ID IN (30, 100);
-- 4. Write a query to display the name (first_name, last_name) and hire date for 
-- all employees who were hired in 1987.
SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) AS NAME,
    HIRE_DATE
FROM employees
WHERE YEAR(HIRE_DATE) = '1987';
-- 5. Write a query to display the first_name of all employees who have both "b" 
-- and "c" in their first name.
SELECT FIRST_NAME
FROM employees
WHERE FIRST_NAME LIKE '%b%'
    AND FIRST_NAME LIKE '%c%';
-- 6. Write a query to display the last name, job, and salary for all employees 
-- whose job is that of a Programmer or a Shipping Clerk, and whose salary is not 
-- equal to $4,500, $10,000, or $15,000.
SELECT e.LAST_NAME,
    j.JOB_TITLE,
    e.SALARY
FROM employees e
    INNER JOIN jobs j ON e.JOB_ID = j.JOB_ID
WHERE SALARY NOT IN (4500, 10000, 15000)
    AND j.JOB_TITLE IN ('Programmer', 'Shipping Clerk');
-- 7. Write a query to display the last name of employees whose names have exactly 
-- 6 characters.
SELECT LAST_NAME
FROM employees
WHERE LENGTH(LAST_NAME) = 6;
-- 8. Write a query to display the last name of employees having 'e' as the third 
-- character.
SELECT LAST_NAME
FROM employees
WHERE LAST_NAME LIKE '__e%';
-- 9. Write a query to display the jobs/designations available in the employees table.
SELECT DISTINCT e.JOB_ID,
    j.JOB_TITLE
FROM employees e
    INNER JOIN jobs j ON e.JOB_ID = j.JOB_ID;
-- 10. Write a query to display the name (first_name, last_name), salary and PF (15% 
-- of salary) of all employees.
SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) AS NAME,
    SALARY,
    ROUND(SALARY * 0.15, 2) AS `PF (15%)`
FROM employees -- 11. Write a query to select all record from employees where last name in 'BLAKE', 
    -- 'SCOTT', 'KING' and 'FORD'.
SELECT *
FROM employees
WHERE UPPER(LAST_NAME) IN ('BLAKE', 'SCOTT', 'KING', 'FORD');