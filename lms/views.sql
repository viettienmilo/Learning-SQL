USE lms;
-------------------
-- create view for students that are absent more than 1 session
CREATE VIEW students_absent_gt1 AS
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
-------------------
-- create student grades view
CREATE VIEW student_grades AS WITH score_table AS (
    SELECT studentId,
        s.studentFName AS `SURNAME`,
        s.studentLName AS `NAME`,
        co.courseTitle AS `COURSE`,
        cy.cycleDescription AS `TERM`,
        MAX(
            CASE
                WHEN testNo = 1 THEN score
            END
        ) AS TX,
        MAX(
            CASE
                WHEN testNo = 2 THEN score
            END
        ) AS BT01,
        MAX(
            CASE
                WHEN testNo = 3 THEN score
            END
        ) AS BT02
    FROM test_scores
        INNER JOIN students s USING (studentId)
        INNER JOIN courses co USING (courseId)
        INNER JOIN cycles cy USING (cycleId)
    WHERE courseId = 'BUA3302'
        AND cycleId = 'HKII/2526'
    GROUP BY studentId
)
SELECT *,
    (
        TX * 0.2 + BT01 * 0.15 + BT02 * 0.15
    ) AS GRADE
FROM score_table
ORDER BY NAME;
-------------------
-- create updatable student score view
CREATE VIEW updatable_tx_scores AS (
    SELECT studentId,
        s.studentFName,
        s.studentLName,
        courseId,
        cycleId,
        testNo,
        score AS TX
    FROM test_scores
        INNER JOIN students s USING (studentId)
        INNER JOIN courses co USING (courseId)
        INNER JOIN cycles cy USING (cycleId)
    WHERE courseId = 'BUA3302'
        AND cycleId = 'HKII/2526'
        AND testNo = 1
);
CREATE VIEW updatable_bt01_scores AS (
    SELECT studentId,
        s.studentFName,
        s.studentLName,
        courseId,
        cycleId,
        testNo,
        score AS BT01
    FROM test_scores
        INNER JOIN students s USING (studentId)
        INNER JOIN courses co USING (courseId)
        INNER JOIN cycles cy USING (cycleId)
    WHERE courseId = 'BUA3302'
        AND cycleId = 'HKII/2526'
        AND testNo = 2
);
CREATE VIEW updatable_bt02_scores AS (
    SELECT studentId,
        s.studentFName,
        s.studentLName,
        courseId,
        cycleId,
        testNo,
        score AS BT02
    FROM test_scores
        INNER JOIN students s USING (studentId)
        INNER JOIN courses co USING (courseId)
        INNER JOIN cycles cy USING (cycleId)
    WHERE courseId = 'BUA3302'
        AND cycleId = 'HKII/2526'
        AND testNo = 3
);
-------------------
-- create student attendance overview view
CREATE VIEW student_attendance_overview AS (
    SELECT studentId,
        s.studentFName AS `SURNAME`,
        s.studentLName AS `NAME`,
        co.courseTitle AS `COURSE`,
        cy.cycleDescription AS `TERM`,
        MAX(
            CASE
                WHEN attendDate = '2026/01/13' THEN status
            END
        ) AS '13/01/2026',
        MAX(
            CASE
                WHEN attendDate = '2026/01/20' THEN status
            END
        ) AS '20/01/2026',
        MAX(
            CASE
                WHEN attendDate = '2026/01/27' THEN status
            END
        ) AS '27/01/2026',
        MAX(
            CASE
                WHEN attendDate = '2026/02/03' THEN status
            END
        ) AS '03/02/2026',
        MAX(
            CASE
                WHEN attendDate = '2026/03/03' THEN status
            END
        ) AS '03/03/2026',
        MAX(
            CASE
                WHEN attendDate = '2026/03/10' THEN status
            END
        ) AS '10/03/2026',
        MAX(
            CASE
                WHEN attendDate = '2026/03/17' THEN status
            END
        ) AS '17/03/2026',
        MAX(
            CASE
                WHEN attendDate = '2026/03/24' THEN status
            END
        ) AS '24/03/2026',
        COUNT(
            CASE
                WHEN status = 'absent' THEN 1
            END
        ) AS `ABSENT TOTAL`
    FROM attendance
        INNER JOIN students s USING (studentId)
        INNER JOIN courses co USING (courseId)
        INNER JOIN cycles cy USING (cycleId)
    WHERE courseId = 'BUA3302'
        AND cycleId = 'HKII/2526'
    GROUP BY studentId
);
-------------------
-- create updatable attendance 03/03/2026 view
CREATE VIEW attendace_03_03_2026 AS (
    SELECT studentId,
        s.studentFName AS `SURNAME`,
        s.studentLName AS `NAME`,
        courseId AS `COURSE`,
        cycleId AS `TERM`,
        classId AS `CLASS`,
        attendDate AS '03/03/2026',
        status AS `STATUS`,
        absentPermitted AS `PERMITTED`
    FROM attendance
        INNER JOIN students s USING (studentId)
        INNER JOIN courses co USING (courseId)
        INNER JOIN cycles cy USING (cycleId)
    WHERE courseId = 'BUA3302'
        AND cycleId = 'HKII/2526'
        AND attendDate = '2026/03/03'
);
-- create updatable attendance 10/03/2026 view
CREATE VIEW attendace_10_03_2026 AS (
    SELECT studentId,
        s.studentFName AS `SURNAME`,
        s.studentLName AS `NAME`,
        courseId AS `COURSE`,
        cycleId AS `TERM`,
        classId AS `CLASS`,
        attendDate AS '10/03/2026',
        status AS `STATUS`,
        absentPermitted AS `PERMITTED`
    FROM attendance
        INNER JOIN students s USING (studentId)
        INNER JOIN courses co USING (courseId)
        INNER JOIN cycles cy USING (cycleId)
    WHERE courseId = 'BUA3302'
        AND cycleId = 'HKII/2526'
        AND attendDate = '2026/03/10'
);
-- create updatable attendance 17/03/2026 view
CREATE VIEW attendace_17_03_2026 AS (
    SELECT studentId,
        s.studentFName AS `SURNAME`,
        s.studentLName AS `NAME`,
        courseId AS `COURSE`,
        cycleId AS `TERM`,
        classId AS `CLASS`,
        attendDate AS '17/03/2026',
        status AS `STATUS`,
        absentPermitted AS `PERMITTED`
    FROM attendance
        INNER JOIN students s USING (studentId)
        INNER JOIN courses co USING (courseId)
        INNER JOIN cycles cy USING (cycleId)
    WHERE courseId = 'BUA3302'
        AND cycleId = 'HKII/2526'
        AND attendDate = '2026/03/17'
);
-- create updatable attendance 24/03/2026 view
CREATE VIEW attendace_24_03_2026 AS (
    SELECT studentId,
        s.studentFName AS `SURNAME`,
        s.studentLName AS `NAME`,
        courseId AS `COURSE`,
        cycleId AS `TERM`,
        classId AS `CLASS`,
        attendDate AS '24/03/2026',
        status AS `STATUS`,
        absentPermitted AS `PERMITTED`
    FROM attendance
        INNER JOIN students s USING (studentId)
        INNER JOIN courses co USING (courseId)
        INNER JOIN cycles cy USING (cycleId)
    WHERE courseId = 'BUA3302'
        AND cycleId = 'HKII/2526'
        AND attendDate = '2026/03/24'
);