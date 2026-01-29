USE excercise_db;
-- 1. Write a query to list the number of jobs available in the employees table.
SELECT COUNT(DISTINCT JOB_ID)
FROM employees;
-- 2. Write a query to get the total salaries payable to employees.
SELECT SUM(SALARY) AS `TOTAL SALARIES`
FROM employees;
-- 3. Write a query to get the minimum salary from employees table.
SELECT MIN(SALARY) AS `MIN SALARY`
FROM employees;
-- 4. Write a query to get the maximum salary of an employee working as a Programmer.
SELECT MAX(SALARY)
FROM employees
WHERE JOB_ID = (
        SELECT JOB_ID
        FROM jobs
        WHERE JOB_TITLE = 'Programmer'
    );
-- 5. Write a query to get the average salary and number of employees working 
-- the department 90.
SELECT ROUND(AVG(SALARY), 2) AS `AVERAGE SALARY`,
    COUNT(*) AS `NUMBER OF WORKING`
FROM employees
WHERE DEPARTMENT_ID = 90;
-- 6. Write a query to get the highest, lowest, sum, and average salary of all 
-- employees.
SELECT MAX(SALARY) AS `HIGHEST SALARY`,
    MIN(SALARY) AS `LOWEST SALARY`,
    SUM(SALARY) AS `SUM OF SALARIES`,
    ROUND(AVG(SALARY), 2) AS `AVERAGE SALARY`
FROM employees;
-- 7. Write a query to get the number of employees with the same job.
SELECT JOB_ID,
    COUNT(*) AS `NO OF EMPLOYEES`
FROM employees
GROUP BY JOB_ID;
-- 8. Write a query to get the difference between the highest and lowest salaries
SELECT MAX(SALARY) - MIN(SALARY) AS `SALARY DIFF`
FROM employees;
-- 9. Write a query to find the manager ID and the salary of the lowest-paid 
-- employee for that manager.
SELECT MANAGER_ID,
    MIN(SALARY) AS `LOWEST SALARY`,
    MAX(SALARY) AS `HIGHEST SALARY`
FROM employees
GROUP BY MANAGER_ID;
-- 10. Write a query to get the department ID and the total salary payable in 
-- each department.
SELECT DEPARTMENT_ID,
    SUM(SALARY) AS `TOTAL DEPT. SALARIES`
FROM employees
GROUP BY DEPARTMENT_ID;
-- 11. Write a query to get the average salary for each job ID excluding programmer.
SELECT JOB_ID,
    ROUND(AVG(SALARY), 2) AS `TOTAL DEPT. SALARIES`
FROM employees
WHERE JOB_ID <> (
        SELECT JOB_ID
        FROM jobs
        WHERE JOB_TITLE = 'Programmer'
    )
GROUP BY JOB_ID;
-- 12. Write a query to get the total salary, maximum, minimum, average salary of 
-- employees (job ID wise), for department ID 90 only.
SELECT JOB_ID,
    DEPARTMENT_ID,
    SUM(SALARY) AS `TOTAL SALARIES`,
    MAX(SALARY) AS `HIGHEST SALARY`,
    MIN(SALARY) AS `LOWEST SALARY`,
    ROUND(AVG(SALARY), 2) AS `AVERAGE SALARY`
FROM employees
WHERE DEPARTMENT_ID = 90
GROUP BY JOB_ID;
-- 13. Write a query to get the job ID and maximum salary of the employees where 
-- maximum salary is greater than or equal to $4000.
SELECT JOB_ID,
    MAX(SALARY) AS `HIGHEST SALARY`
FROM employees
GROUP BY JOB_ID
HAVING MAX(SALARY) >= 4000;
-- 14. Write a query to get the average salary for all departments employing more 
-- than 10 employees.
SELECT DEPARTMENT_ID,
    COUNT(*) AS `NUMBER OF EMPLOYEES`,
    ROUND(AVG(SALARY), 2) AS `AVERAGE SALARY`
FROM employees
GROUP BY DEPARTMENT_ID
HAVING COUNT(*) > 10;