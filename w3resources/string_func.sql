USE excercise_db;
-- 1. Write a MySQL query to get the job_id and related employee's id.
SELECT DISTINCT JOB_ID AS JOB,
    GROUP_CONCAT(EMPLOYEE_ID) AS EMPLOYEES
FROM employees
GROUP BY JOB_ID;
-- 2. Write a MySQL query to update the portion of the phone_number in 
-- the employees table, within the phone number the substring '124' will 
-- be replaced by '999'.
UPDATE employees
SET PHONE_NUMBER = REPLACE(PHONE_NUMBER, '124', '999')
WHERE PHONE_NUMBER LIKE '%124%';
-- 3. Write a MySQL query to get the details of the employees where the 
-- length of the first name greater than or equal to 8.
SELECT *
FROM employees
WHERE LENGTH(FIRST_NAME) >= 8;
-- 4. Write a MySQL query to display leading zeros before maximum and 
-- minimum salary.
SELECT MAX(SALARY),
    LPAD(MAX(SALARY), LENGTH(MAX(SALARY)) + 1, '0') AS MAX_SAL,
    MIN(SALARY),
    LPAD(MIN(SALARY), LENGTH(MIN(SALARY)) + 1, '0') AS MIN_SAL
FROM employees;
-- 5. Write a MySQL query to append '@example.com' to email field.
UPDATE employees
SET email = CONCAT(email, '@example.com');
-- 6. Write a MySQL query to get the employee id, first name and hire month.
SELECT EMPLOYEE_ID,
    FIRST_NAME,
    MID(HIRE_DATE, 6, 2) AS HIRE_MONTH
FROM employees;
-- 7. Write a MySQL query to get the employee id, email id (discard the 
-- last three characters).
SELECT EMPLOYEE_ID,
    SUBSTR(email, 1, LENGTH(email) -3) AS MAIL
FROM employees;
-- 8. Write a MySQL query to find all employees where first names are in 
-- upper case.
SELECT *
FROM employees
WHERE FIRST_NAME = BINARY UPPER(FIRST_NAME);
-- 9. Write a MySQL query to extract the last 4 character of phone numbers.
SELECT RIGHT(PHONE_NUMBER, 4) AS PHONE
FROM employees;
-- 10. Write a MySQL query to get the last word of the street address.
SELECT STREET_ADDRESS,
    REVERSE(
        SUBSTR(
            REVERSE(STREET_ADDRESS),
            1,
            LOCATE(' ', REVERSE(STREET_ADDRESS))
        )
    )
FROM locations;
-- 11. Write a MySQL query to get the locations that have minimum street length.
SELECT *
FROM locations
WHERE LENGTH(STREET_ADDRESS) = (
        SELECT MIN(LENGTH(STREET_ADDRESS))
        FROM locations
    );
-- 12. Write a MySQL query to display the first word from those job titles 
-- which contains more than one words.
SELECT JOB_TITLE,
    CASE
        WHEN LOCATE(' ', JOB_TITLE) > 0 THEN SUBSTR(JOB_TITLE, 1, INSTR(JOB_TITLE, ' '))
        ELSE JOB_TITLE
    END
FROM jobs;
-- 13. Write a MySQL query to display the first name and last name for employees 
-- where first occurrence of last name contain character 'c' after 2nd position.
SELECT FIRST_NAME,
    LAST_NAME
FROM employees
WHERE LOCATE('c', LAST_NAME) > 2;
-- 14. Write a MySQL query that displays the first name and the length of the first 
-- name for all employees whose name starts with the letters 'A', 'J' or 'M'. Give 
-- each column an appropriate label. Sort the results by the employees' first names.
SELECT FIRST_NAME AS EMP_FN,
    LENGTH(FIRST_NAME) AS FN_AJM
FROM employees
WHERE LEFT(FIRST_NAME, 1) IN ('A', 'J', 'M')
ORDER BY FIRST_NAME;
-- 15. Write a MySQL query to display the first name and salary for all employees. 
-- Format the salary to be 10 characters long, left-padded with the $ symbol. Label 
-- the column SALARY.
SELECT FIRST_NAME,
    LPAD(SALARY, 10, '$')
FROM employees;
-- 16. Write a MySQL query to display the first eight characters of the employees' 
-- first names and indicates the amounts of their salaries with '$' sign. Each '$' 
-- sign signifies a thousand dollars. Sort the data in descending order of salary.
SELECT LEFT(FIRST_NAME, 8),
    SALARY,
    REPEAT('$', FLOOR(SALARY / 1000))
FROM employees
ORDER BY SALARY DESC;
-- 17. Write a MySQL query to display the employees with their code, first name, 
-- last name and hire date who hired either on seventh day of any month or seventh 
-- month in any year.
SELECT EMPLOYEE_ID,
    FIRST_NAME,
    LAST_NAME,
    HIRE_DATE
FROM employees
WHERE DAY(HIRE_DATE) = 7
    OR MONTH(HIRE_DATE) = 7;