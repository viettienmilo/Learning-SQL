USE excercise_db;
-- 1. Start a Transaction and Commit Changes
-- Write a MySQL query to start a transaction, update a column,
-- and commit the changes.
START TRANSACTION;
UPDATE employees
SET COMMISSION_PCT = 0
WHERE EMPLOYEE_ID = 100;
COMMIT;
-- 2. Rollback a Transaction on Error
-- Write a MySQL query to start a transaction, attempt to update 
-- a column, and rollback the changes if an error occurs.
START TRANSACTION;
UPDATE employees
SET COMMISSION_PCT = 0.2
WHERE EMPLOYEE_ID = 100;
ROLLBACK;
-- 3. Set Isolation Level to Read Committed
-- Write a MySQL query to set the isolation level to READ COMMITTED 
-- and perform a read operation.
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
START TRANSACTION;
SELECT *
FROM employees
WHERE EMPLOYEE_ID = 100;
COMMIT;
-- 4. Set Isolation Level to Serializable
-- Write a MySQL query to set the isolation level to SERIALIZABLE 
-- and perform a read operation.
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
START TRANSACTION;
SELECT *
FROM employees
WHERE EMPLOYEE_ID = 100;
COMMIT;
-- 5. Handle Deadlocks
-- Write a MySQL query to handle a deadlock situation by retrying 
-- the transaction.
START TRANSACTION;
UPDATE employees
SET COMMISSION_PCT = 0
WHERE EMPLOYEE_ID = 100;
ROLLBACK;
-- 6. Use Savepoints in a Transaction
-- Write a MySQL query to create a savepoint within a transaction 
-- and rollback to that savepoint if needed.
START TRANSACTION;
UPDATE employees
SET COMMISSION_PCT = 0.2
WHERE EMPLOYEE_ID = 100;
SAVEPOINT before_update_commission_pct;
COMMIT;