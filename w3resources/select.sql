USE excercise_db;
-- 1. Write a query to display the names (first_name, last_name) using alias name 
-- "First Name", "Last Name"
SELECT FIRST_NAME as `First Name`,
    LAST_NAME as `Last Name`
FROM employees;
-- 2. Write a query to get unique department ID from employee table.
SELECT DISTINCT DEPARTMENT_ID
FROM employees;
-- 3. Write a query to get all employee details from the employee table order by 
-- first name, descending.
SELECT *
FROM employees
ORDER BY FIRST_NAME DESC;
-- 4. Write a query to get the names (first_name, last_name), salary, PF of all 
-- the employees (PF is calculated as 15% of salary).
SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) as `Full Name`,
    SALARY,
    ROUND(SALARY * 0.15, 2) as PF
FROM employees;
-- 5. Write a query to get the employee ID, names (first_name, last_name), salary 
-- in ascending order of salary.
SELECT EMPLOYEE_ID,
    CONCAT(FIRST_NAME, ' ', LAST_NAME) as `Full Name`,
    SALARY
FROM employees
ORDER BY SALARY ASC;
-- 6. Write a query to get the total salaries payable to employees.
SELECT SUM(SALARY) as `TOTAL SALARY PAYABLE`
FROM employees;
-- 7. Write a query to get the maximum and minimum salary from employees table.
SELECT MAX(SALARY),
    MIN(SALARY)
FROM employees;
-- display in rows
SELECT 'MAX SALARY' as TYPE,
    MAX(SALARY) as VALUE
FROM employees
UNION
SELECT 'MIN SALARY' as TYPE,
    MIN(SALARY) as VALUE
FROM employees;
-- 8. Write a query to get the average salary and number of employees in the employees 
-- table.
SELECT 'AVERAVE SALARY' AS TYPE,
    SUM(SALARY) / COUNT(*) AS VALUE
FROM employees
UNION
SELECT 'NUMBER OF EMPLOYEES',
    COUNT(EMPLOYEE_ID)
FROM employees;
-- 9. Write a query to get the number of employees working with the company.
SELECT COUNT(*) as `NUMBER OF EMPLOYEES`
FROM employees;
-- 10. Write a query to get the number of jobs available in the employees table.
SELECT COUNT(DISTINCT JOB_ID) as `NUMBER OF JOBS AVAILABLE`
FROM employees;
-- 11. Write a query get all first name from employees table in upper case.
SELECT UPPER(FIRST_NAME)
FROM employees;
-- 12. Write a query to get the first 3 characters of first name from employees table.
SELECT LEFT(FIRST_NAME, 3)
FROM employees;
-- 13. Write a query to calculate 171*214+625.
SELECT 171 * 214 + 625 AS RESULT;
-- 14. Write a query to get the names (for example Ellen Abel, Sundar Ande etc.) of 
-- all the employees from employees table.
SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) as `Full Name`
FROM employees;
-- 15. Write a query to get first name from employees table after removing white spaces 
-- from both side.
SELECT TRIM(FIRST_NAME)
FROM employees;
-- 16. Write a query to get the length of the employee names (first_name, last_name) 
-- from employees table.
SELECT LENGTH(CONCAT(FIRST_NAME, LAST_NAME)) as `FULLNAME LENGTH`
FROM employees;
-- 17. Write a query to check if the first_name fields of the employees table contains 
-- numbers.
SELECT FIRST_NAME as `FIRST NAME`,
    CASE
        WHEN FIRST_NAME REGEXP '[0-9]' THEN 'YES'
        ELSE 'NO'
    END AS HAS_NUMBERS
FROM employees;
-- 18. Write a query to select first 10 records from a table.
SELECT *
FROM employees
LIMIT 10;
-- 19. Write a query to get monthly salary (round 2 decimal places) of each and every 
-- employee
-- Note : Assume the salary field provides the 'annual salary' information.
SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) as `Full Name`,
    ROUND(SALARY / 12, 2) AS `MONTHLY SALARY`
FROM employees;