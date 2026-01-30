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
-- 2. Write a MySQL query to find the name (first_name, last name), department ID and 
-- name of all the employees.
SELECT CONCAT(e.FIRST_NAME, ' ', e.LAST_NAME) AS NAME,
    e.DEPARTMENT_ID,
    d.DEPARTMENT_NAME
FROM employees e
    NATURAL JOIN departments d;
-- 3. Write a MySQL query to find the name (first_name, last_name), job, department ID 
-- and name of the employees who works in London.
SELECT CONCAT(e.FIRST_NAME, ' ', e.LAST_NAME) AS NAME,
    j.JOB_TITLE,
    e.DEPARTMENT_ID,
    d.DEPARTMENT_NAME,
    FROM employees e
    INNER JOIN departments d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
    INNER JOIN jobs j ON e.JOB_ID = j.JOB_ID
WHERE d.LOCATION_ID = (
        SELECT LOCATION_ID
        FROM locations
        WHERE CITY = 'London'
    );
-- 4. Write a MySQL query to find the employee id, name (last_name) along with their 
-- manager_id and name (last_name).
SELECT e.EMPLOYEE_ID,
    e.LAST_NAME,
    e.MANAGER_ID AS `MANAGER ID`,
    m.LAST_NAME AS `MANAGER NAME`
FROM employees e
    INNER JOIN employees m ON e.MANAGER_ID = m.EMPLOYEE_ID;
-- 5. Write a MySQL query to find the name (first_name, last_name) and hire date of 
-- the employees who was hired after 'Jones'.
SELECT CONCAT(e.FIRST_NAME, ' ', e.LAST_NAME) AS NAME,
    e.HIRE_DATE
FROM employees e
    INNER JOIN employees m ON m.LAST_NAME = 'Jones'
WHERE e.HIRE_DATE > m.HIRE_DATE;
-- 6. Write a MySQL query to get the department name and number of employees in the 
-- department.
SELECT d.DEPARTMENT_ID,
    d.DEPARTMENT_NAME,
    COUNT(*) AS `NUM OF EMPLOYEES`
FROM departments d
    LEFT JOIN employees e ON d.DEPARTMENT_ID = e.DEPARTMENT_ID
GROUP BY d.DEPARTMENT_ID;
-- 7. Write a MySQL query to find the employee ID, job title, number of days between 
-- ending date and starting date for all jobs in department 90.
SELECT h.EMPLOYEE_ID,
    j.JOB_TITLE,
    h.START_DATE,
    (h.END_DATE - h.START_DATE) AS `NUM OF DAYS`
FROM job_history h
    INNER JOIN jobs j ON j.JOB_ID = h.JOB_ID
WHERE h.DEPARTMENT_ID = 90;
-- 8. Write a MySQL query to display the department ID and name and first name of 
-- manager.
SELECT d.DEPARTMENT_ID,
    d.DEPARTMENT_NAME,
    d.MANAGER_ID,
    e.FIRST_NAME AS MANAGER
FROM departments d
    INNER JOIN employees e ON e.EMPLOYEE_ID = d.MANAGER_ID;
-- 9. Write a MySQL query to display the department name, manager name, and city.
SELECT d.DEPARTMENT_NAME AS DEPARTMENT,
    CONCAT(e.FIRST_NAME, ' ', e.LAST_NAME) AS MANAGER,
    l.CITY
FROM departments d
    INNER JOIN employees e ON e.EMPLOYEE_ID = d.MANAGER_ID
    INNER JOIN locations l ON l.LOCATION_ID = d.LOCATION_ID;
-- 10. Write a MySQL query to display the job title and average salary of employees.
SELECT j.JOB_TITLE,
    ROUND(AVG(e.SALARY), 2)
FROM jobs j
    NATURAL JOIN employees e
GROUP BY j.JOB_TITLE;
-- 11. Write a MySQL query to display job title, employee name, and the difference 
-- between salary of the employee and minimum salary for the job.
SELECT j.JOB_TITLE,
    CONCAT(e.FIRST_NAME, ' ', e.LAST_NAME) AS EMPLOYEE,
    (e.SALARY - j.MIN_SALARY) AS `HIGHER THAN MIN SALARY`
FROM employees e
    NATURAL JOIN jobs j;
-- 13. Write a MySQL query to display department name, name (first_name, last_name), 
-- hire date, salary of the manager for all managers whose experience is more than 
-- 15 years.
SELECT CONCAT(e.FIRST_NAME, ' ', e.LAST_NAME) AS MANAGER,
    d.DEPARTMENT_NAME,
    e.HIRE_DATE,
    e.SALARY,
    ROUND(DATEDIFF(CURDATE(), e.HIRE_DATE) / 365, 0) AS `YEAR OF EXP`
FROM departments d
    INNER JOIN employees e ON d.MANAGER_ID = e.EMPLOYEE_ID
WHERE DATEDIFF(CURDATE(), e.HIRE_DATE) / 365 >= 15;