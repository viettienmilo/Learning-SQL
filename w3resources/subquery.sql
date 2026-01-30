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
    d.DEPARTMENT_NAME
FROM employees e
    NATURAL JOIN departments d
WHERE e.MANAGER_ID IN (
        SELECT MANAGER_ID
        FROM employees
        WHERE DEPARTMENT_ID IN (
                SELECT DEPARTMENT_ID
                FROM departments
                WHERE LOCATION_ID IN (
                        SELECT LOCATION_ID
                        FROM locations
                        WHERE COUNTRY_ID = 'US'
                    )
            )
    );
-- 4. Write a MySQL query to find the name (first_name, last_name) of the employees who 
-- are managers.
SELECT CONCAT(e.FIRST_NAME, ' ', e.LAST_NAME) AS MANAGER,
    d.DEPARTMENT_NAME AS 'DEPT. NAME'
FROM employees e
    LEFT JOIN departments d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
WHERE EMPLOYEE_ID IN (
        SELECT MANAGER_ID
        FROM departments
    );
-- 5. Write a MySQL query to find the name (first_name, last_name), and salary of the 
-- employees whose salary is greater than the average salary.
SELECT CONCAT(e.FIRST_NAME, ' ', e.LAST_NAME) AS EMPLOYEE,
    e.SALARY AS `SALARY ABOVE AVG`
FROM employees e
WHERE e.SALARY > (
        SELECT AVG(SALARY)
        FROM employees
    );
-- 6. Write a MySQL query to find the name (first_name, last_name), and salary of the 
-- employees whose salary is equal to the minimum salary for their job grade.
SELECT CONCAT(e.FIRST_NAME, ' ', e.LAST_NAME) AS EMPLOYEE,
    e.SALARY AS `SALARY`,
    j.JOB_TITLE AS `JOB TITLE`
FROM employees e
    INNER JOIN jobs j USING (JOB_ID)
WHERE e.SALARY = (
        SELECT MIN_SALARY
        FROM jobs
        WHERE e.JOB_ID = jobs.JOB_ID
    );
-- 7. Write a MySQL query to find the name (first_name, last_name), and salary of the 
-- employees who earns more than the average salary and works in any of the IT departments.
SELECT CONCAT(e.FIRST_NAME, ' ', e.LAST_NAME) AS EMPLOYEE,
    e.SALARY AS `SALARY`
FROM employees e
WHERE e.SALARY > (
        SELECT AVG(SALARY)
        FROM employees
    )
    AND e.DEPARTMENT_ID IN (
        SELECT DEPARTMENT_ID
        FROM departments
        WHERE DEPARTMENT_NAME LIKE 'IT%'
    );
-- 8. Write a MySQL query to find the name (first_name, last_name), and salary of the 
-- employees who earns more than the earning of Mr. Bell.
SELECT CONCAT(e.FIRST_NAME, ' ', e.LAST_NAME) AS EMPLOYEE,
    e.SALARY AS `SALARY`
FROM employees e
WHERE e.SALARY > (
        SELECT SALARY
        FROM employees
        WHERE LAST_NAME = 'Bell'
    );
-- 9. Write a MySQL query to find the name (first_name, last_name), and salary of the 
-- employees who earn the same salary as the minimum salary for all departments.
SELECT CONCAT(e.FIRST_NAME, ' ', e.LAST_NAME) AS EMPLOYEE,
    e.SALARY AS `SALARY`
FROM employees e
WHERE e.SALARY = (
        SELECT MIN(SALARY)
        FROM employees
    );
-- 10. Write a MySQL query to find the name (first_name, last_name), and salary of the 
-- employees whose salary is greater than the average salary of each department.
SELECT CONCAT(e.FIRST_NAME, ' ', e.LAST_NAME) AS EMPLOYEE,
    e.SALARY AS `SALARY`,
    j.JOB_TITLE
FROM employees e
    NATURAL JOIN jobs j
WHERE e.SALARY > ALL(
        SELECT AVG(SALARY)
        FROM employees
        GROUP BY DEPARTMENT_ID
    );
-- 11. Write a MySQL query to find the name (first_name, last_name) and salary of the 
-- employees who earn a salary that is higher than the salary of all the Shipping Clerk 
-- (JOB_ID = 'SH_CLERK'). Sort the results of the salary of the lowest to highest.
SELECT CONCAT(e.FIRST_NAME, ' ', e.LAST_NAME) AS EMPLOYEE,
    e.SALARY AS `SALARY`,
    e.JOB_ID
FROM employees e
WHERE e.SALARY > ALL(
        SELECT SALARY
        FROM employees
        WHERE JOB_ID = 'SH_CLERK'
    )
ORDER BY e.SALARY ASC;
-- 12. Write a MySQL query to find the name (first_name, last_name) of the employees 
-- who are not supervisors (manager).
SELECT CONCAT(e.FIRST_NAME, ' ', e.LAST_NAME) AS EMPLOYEE
FROM employees e
WHERE NOT EXISTS (
        SELECT EMPLOYEE_ID
        FROM employees m
        WHERE e.EMPLOYEE_ID = m.MANAGER_ID
    );
-- 13. Write a MySQL query to display the employee ID, first name, last name, and 
-- department names of all employees.
SELECT EMPLOYEE_ID,
    FIRST_NAME,
    LAST_NAME,
    DEPARTMENT_NAME
FROM employees
    NATURAL JOIN departments;
-- 14. Write a MySQL query to display the employee ID, first name, last name, salary 
-- of all employees whose salary is above average for their departments
SELECT e.EMPLOYEE_ID,
    e.FIRST_NAME,
    e.LAST_NAME,
    e.SALARY
FROM employees e
WHERE e.SALARY > (
        SELECT AVG(SALARY)
        FROM employees
        WHERE e.DEPARTMENT_ID = employees.DEPARTMENT_ID
    );
-- 15. Write a MySQL query to fetch even numbered records from employees table.
SELECT *
FROM (
        SELECT ROW_NUMBER() OVER (
                ORDER BY EMPLOYEE_ID
            ) AS i,
            EMPLOYEE_ID,
            FIRST_NAME,
            LAST_NAME
        FROM employees
    ) AS e
WHERE MOD(i, 2) = 0;
-- 16. Write a MySQL query to find the 5th maximum salary in the employees table.
SELECT DISTINCT SALARY
FROM employees
ORDER BY SALARY DESC
LIMIT 1 OFFSET 4;
-- OR
SELECT DISTINCT S.SALARY
FROM (
        SELECT SALARY,
            DENSE_RANK() OVER (
                ORDER BY SALARY DESC
            ) AS RNK
        FROM employees
    ) AS S
WHERE S.RNK = 5;
-- 17. Write a MySQL query to find the 4th minimum salary in the employees table.
SELECT DISTINCT S.SALARY
FROM (
        SELECT SALARY,
            DENSE_RANK() OVER (
                ORDER BY SALARY ASC
            ) AS RNK
        FROM employees
    ) AS S
WHERE S.RNK = 4;
-- 18. Write a MySQL query to select last 10 records from a table.
SELECT *
FROM (
        SELECT *
        FROM employees
        ORDER BY EMPLOYEE_ID DESC
        LIMIT 10
    ) AS T
ORDER BY T.EMPLOYEE_ID ASC;
-- 19. Write a MySQL query to list the department ID and name of all the 
-- departments where no employee is working.
SELECT d.DEPARTMENT_ID,
    d.DEPARTMENT_NAME
FROM departments d
WHERE d.DEPARTMENT_ID NOT IN (
        SELECT DEPARTMENT_ID
        FROM employees
    );
-- 20. Write a MySQL query to get 3 maximum salaries.
SELECT DISTINCT SALARY
FROM (
        SELECT SALARY,
            DENSE_RANK() OVER (
                ORDER BY SALARY DESC
            ) AS RNK
        FROM employees
    ) AS T
WHERE T.RNK <= 3;
-- 21. Write a MySQL query to get 3 minimum salaries.
SELECT DISTINCT SALARY
FROM (
        SELECT SALARY,
            DENSE_RANK() OVER (
                ORDER BY SALARY ASC
            ) AS RNK
        FROM employees
    ) AS T
WHERE T.RNK <= 3;
-- 22. Write a MySQL query to get nth max salaries of employees.
--  ==> see 16.