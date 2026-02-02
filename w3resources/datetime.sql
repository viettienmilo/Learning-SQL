-- 1. Write a query to display the first day of the month (in datetime format) 
-- three months before the current month.
-- Sample current date : 2014-09-03
-- Expected result : 2014-06-01
-- Hint: Extract year and month, then subtract 3 , multiply by 100 (to set format
-- YYYYMM00) and add 1 to form YYYYMM001, then convert to DATE
SELECT DATE(
        PERIOD_ADD (
            EXTRACT(
                YEAR_MONTH
                FROM CURDATE()
            ),
            -3
        ) * 100 + 1
    );
-- 2. Write a query to display the last day of the month (in datetime format) 
-- three months before the current month.
SELECT LAST_DAY(DATE_SUB(CURDATE(), INTERVAL 3 MONTH)) AS LAST_DAY_3_MONTH_AGO;
-- 3. Write a query to get the distinct Mondays from hire_date in employees tables.
USE excercise_db;
SELECT DISTINCT DATE(HIRE_DATE),
    DAYNAME(HIRE_DATE)
FROM employees
WHERE WEEKDAY(HIRE_DATE) = 0;
-- 4. Write a query to get the first day of the current year.
SELECT MAKEDATE(YEAR(CURDATE()), 1);
-- 5. Write a query to get the last day of the current year.
SELECT LAST_DAY(CONCAT(YEAR(CURDATE()), '-12-01'));
-- 6. Write a query to calculate the years of experience.
SELECT EMPLOYEE_ID,
    LAST_NAME,
    TIMESTAMPDIFF(YEAR, HIRE_DATE, CURDATE()) AS YRS_OF_EXP
FROM employees;
-- 7. Write a query to get the current date in the following format.
-- Sample date : 2014-09-04
-- Output : September 4, 2014
SELECT DATE_FORMAT(HIRE_DATE, '%W, %M %d, %Y') AS DATE_FULL
FROM employees;
-- 8. Write a query to get the current date in Thursday September 2014 format.
-- Thursday September 2014
SELECT DATE_FORMAT(HIRE_DATE, '%W %M %Y') AS DATE_FULL
FROM employees;
-- 9. Write a query to extract the year from the current date.
SELECT YEAR(CURDATE());
-- 10. Write a query to get the DATE value from a given day (number in N).
-- Sample days: 730677
-- Output : 2000-07-11
SELECT FROM_DAYS(730677);
-- 11. Write a query to get the first name and hire date from employees table 
-- where hire date between '1987-06-01' and '1987-07-30'
SELECT FIRST_NAME,
    HIRE_DATE
FROM employees
WHERE DATE(HIRE_DATE) BETWEEN '1987-06-01' AND '1987-07-30';
-- 12. Write a query to display the current date in the following format.
-- Sample output: Thursday 4th September 2014 00:00:00
SELECT DATE_FORMAT(CURRENT_TIMESTAMP(), '%W %D %M %Y %H:%i:%s');
-- 13. Write a query to display the current date in the following format.
-- Sample output: 05/09/2014
SELECT DATE_FORMAT(CURDATE(), '%d/%m/%Y');
-- 14. Write a query to display the current date in the following format.
-- Sample output: 12:00 AM Sep 5, 2014
SELECT DATE_FORMAT(CURRENT_TIMESTAMP(), '%h:%i %p %b %d, %Y');
-- 15. Write a query to get the firstname, lastname who joined in the month 
-- of June.
SELECT FIRST_NAME,
    LAST_NAME,
    HIRE_DATE
FROM employees
WHERE MONTH(HIRE_DATE) = 6;
-- 16. Write a query to get the years in which more than 10 employees joined.
SELECT YEAR(HIRE_DATE),
    COUNT(*) AS NUM_OF_EMPS
FROM employees
GROUP BY YEAR(HIRE_DATE)
HAVING COUNT(*) > 10;
-- 17. Write a query to get first name of employees who joined in 1987.
SELECT FIRST_NAME,
    HIRE_DATE
FROM employees
WHERE YEAR(HIRE_DATE) = 1987;
-- 18. Write a query to get department name, manager name, and salary of the 
-- manager for all managers whose experience is more than 5 years.
SELECT d.DEPARTMENT_NAME,
    CONCAT(e.FIRST_NAME, ' ', e.LAST_NAME) AS NAME,
    e.SALARY,
    TIMESTAMPDIFF(YEAR, e.HIRE_DATE, CURDATE()) AS YRS_OF_EXP
FROM departments d
    INNER JOIN employees e ON d.MANAGER_ID = e.EMPLOYEE_ID
WHERE TIMESTAMPDIFF(YEAR, e.HIRE_DATE, CURDATE()) > 5;
-- 19. Write a query to get employee ID, last name, and date of first salary 
-- of the employees.
SELECT EMPLOYEE_ID,
    LAST_NAME,
    HIRE_DATE,
    LAST_DAY(HIRE_DATE) AS 'FIRST_DATE_OF_SALARY'
FROM employees;
-- 20. Write a query to get first name, hire date and experience of the employees.
SELECT FIRST_NAME,
    HIRE_DATE,
    TIMESTAMPDIFF(YEAR, HIRE_DATE, CURDATE()) AS YRS_OF_EXP
FROM employees;
-- 21. Write a query to get the department ID, year, and number of employees joined.
SELECT DEPARTMENT_ID,
    YEAR(HIRE_DATE),
    COUNT(*)
FROM employees
GROUP BY DEPARTMENT_ID,
    YEAR(HIRE_DATE)
ORDER BY DEPARTMENT_ID;