USE lms;
SHOW VARIABLES LIKE 'secure_file_priv';
-- students
LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 9.4/Uploads/ec_k9a.csv" INTO TABLE students CHARACTER SET utf8mb4 FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;
-- departments
INSERT INTO departments
VALUES('EC', 'Economics');
-- categories
INSERT INTO categories
VALUES('MNG', 'Management');
-- courses
INSERT INTO courses (
        courseId,
        courseTitle,
        abstract,
        bibliography,
        categoryId,
        departmentId
    )
VALUES (
        'BUA3302',
        'E-commerce',
        'Understanding of E-commerce basics, Important Role of E-Commerce and farther knowledge.',
        'E-commerce 2017 Business.Technology.Society 13th - Kenneth C. Laudon - Carol Guercio Traver',
        'MNG',
        'EC'
    );
-- cycles
INSERT INTO cycles
VALUES (
        'HKII/2526',
        'Học kỳ 2 - Năm học 2025/2026',
        '2026/01/12',
        '2026/06/15',
        NULL,
        NULL
    );
-- courses_by_cycle
INSERT INTO courses_by_cycle
VALUES (
        'BUA3302',
        'HKII/2526',
        '2026/01/13',
        '2026/03/24'
    );
-- teachers
INSERT INTO teachers
VALUES (
        'NVTIEN',
        'Nguyễn Việt',
        'Tiên',
        'viettien.milo@gmail.com',
        '0913928188'
    );
-- teachers_per_course
INSERT INTO teachers_per_course
VALUES ('BUA3302', 'HKII/2526', 'NVTIEN');
-- enrollments
INSERT INTO enrollments (
        courseId,
        cycleId,
        studentId,
        enrollmentDate,
        cancelled,
        cancellationReason
    )
SELECT 'BUA3302',
    'HKII/2526',
    studentId,
    '2026/01/13',
    0,
    NULL
FROM students;
-- classes
INSERT INTO classes
VALUES (
        'BUA3302',
        'HKII/2526',
        'MK9A',
        'QTKD Marketing K9-A',
        'Tuesday',
        'D201-CS2',
        '07:30:00',
        '10:30:00'
    );
INSERT INTO tests
VALUES (
        'BUA3302',
        'HKII/2526',
        1,
        'BT01',
        '2026/02/07',
        NULL
    ),
    (
        'BUA3302',
        'HKII/2526',
        2,
        'BT02',
        NULL,
        NULL
    ),
    (
        'BUA3302',
        'HKII/2526',
        3,
        'TX',
        NULL,
        NULL
    );
-- attendance
INSERT INTO attendance (
        courseId,
        cycleId,
        classId,
        studentId,
        attendDate
    )
SELECT 'BUA3302',
    'HKII/2526',
    'MK9A',
    studentId,
    '2026/01/13'
FROM students;
-----
INSERT INTO attendance (
        courseId,
        cycleId,
        classId,
        studentId,
        attendDate
    )
SELECT 'BUA3302',
    'HKII/2526',
    'MK9A',
    studentId,
    '2026/01/20'
FROM students;
-----
INSERT INTO attendance (
        courseId,
        cycleId,
        classId,
        studentId,
        attendDate
    )
SELECT 'BUA3302',
    'HKII/2526',
    'MK9A',
    studentId,
    '2026/01/27'
FROM students;
-----
INSERT INTO attendance (
        courseId,
        cycleId,
        classId,
        studentId,
        attendDate
    )
SELECT 'BUA3302',
    'HKII/2526',
    'MK9A',
    studentId,
    '2026/02/03'
FROM students;
-----
UPDATE attendance
SET status = 'absent'
WHERE attendDate = '2026/01/20'
    AND studentId IN (
        '24193020',
        '24193035',
        '24193037',
        '24193040',
        '24193091',
        '24193143',
        '24193145',
        '24193135'
    );
-----
UPDATE attendance
SET status = 'absent'
WHERE attendDate = '2026/01/27'
    AND studentId IN (
        '24193020',
        '24193049',
        '24193053',
        '24193081',
        '24193107',
        '24193118',
        '24193119',
        '24193140',
        '24193141',
        '24193149',
        '23193042'
    );
-----
UPDATE attendance
SET absentPermitted = TRUE
WHERE attendDate = '2026/01/27'
    AND studentId IN (
        '24193119',
        '24193149',
        '24193118',
        '24193081',
        '24193140',
        '24193107',
        '24193049'
    );
-----
UPDATE attendance
SET status = 'absent'
WHERE attendDate = '2026/02/03'
    AND studentId IN (
        '24193002',
        '24109132',
        '24193037',
        '24193049',
        '24193052',
        '24193061',
        '24193064',
        '24193077',
        '24193081'
    );
-----
UPDATE attendance
SET absentPermitted = TRUE
WHERE attendDate = '2026/02/03'
    AND studentId IN (
        '24193077',
        '24193081',
        '24193052',
        '24193037'
    );
-----