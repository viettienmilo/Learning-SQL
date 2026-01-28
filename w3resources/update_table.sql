use excercise_db;
-- 1. Write a SQL statement to change the email column of employees table 
-- with 'not available' for all employees.
ALTER TABLE employees DROP INDEX EMP_EMAIL_UK;
UPDATE employees
SET email = 'not available';
-- 2. Write a SQL statement to change the email and commission_pct column 
-- of employees table with 'not available' and 0.10 for all employees.
UPDATE employees
SET COMMISSION_PCT = 0.1;
-- 3. Write a SQL statement to change the email and commission_pct column 
-- of employees table with 'not available' and 0.10 for those employees 
-- whose department_id is 110.
UPDATE employees
SET COMMISSION_PCT = 0.25,
    email = 'not available'
WHERE DEPARTMENT_ID = 110;
-- 4. Write a SQL statement to change the email column of employees table 
-- with 'not available' for those employees whose department_id is 80 and 
-- gets a commission_pct is less than .20
UPDATE employees
SET email = 'N/A'
WHERE DEPARTMENT_ID = 80
    AND COMMISSION_PCT < 0.2;