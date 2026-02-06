USE lms;
--------------------------------
-- Students were absent more than 1 session
SELECT studentId AS `STUDENT ID`,
    CONCAT(studentFName, ' ', studentLName) as FULLNAME,
    COUNT(status) AS `ABSENT TIMES`,
    COUNT(absentPermitted) AS `PERMITTED TIMES`
FROM students
    INNER JOIN attendance USING (studentId)
WHERE status = 'absent'
GROUP BY studentId,
    status
HAVING COUNT(status) >= 2
ORDER BY studentLName;