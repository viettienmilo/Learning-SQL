CREATE DATABASE lms;
USE lms;
/*
 Create tables
 */
----------------------
CREATE TABLE categories (
    categoryId varchar(10) PRIMARY KEY,
    categoryDescription varchar(256)
);
----------------------
CREATE TABLE departments (
    departmentId varchar(10) PRIMARY KEY,
    departmentName varchar(100)
) ENGINE = InnoDB;
----------------------
CREATE TABLE courses (
    courseId varchar(10) PRIMARY KEY,
    courseTitle varchar(256),
    abstract text(1000),
    bibliography text(1000),
    categoryId varchar(10),
    departmentId varchar(10),
    FOREIGN KEY (categoryId) REFERENCES categories(categoryId) ON UPDATE CASCADE ON DELETE
    SET NULL,
        FOREIGN KEY (departmentId) REFERENCES departments(deparmentId) ON UPDATE CASCADE ON DELETE
    SET NULL
) ENGINE = InnoDB;
----------------------
CREATE TABLE cycles (
    cycleId varchar(10) PRIMARY KEY,
    cycleDescription varchar(256),
    cycleStartDate date,
    cycleEndDate date,
    vacationStartDate date,
    vacationEndDate date
) ENGINE = InnoDB;
----------------------
CREATE TABLE courses_by_cycle (
    courseId varchar(10),
    cycleId varchar(10),
    courseStartDate date,
    courseEndDate date,
    PRIMARY KEY (courseId, cycleId),
    FOREIGN KEY (courseId) REFERENCES courses(courseId) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (cycleId) REFERENCES courses(cycleId) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE = InnoDB;
----------------------
CREATE TABLE students (
    studentId varchar(10) PRIMARY KEY,
    studentFName varchar(50),
    studentLName varchar(50),
    studentEmail varchar(100) UNIQUE,
    studentDOB date,
    studentAddress varchar(15)
) ENGINE = InnoDB;
----------------------
CREATE TABLE enrollments (
    courseId varchar(10),
    cycleId varchar(10),
    studentId varchar(10),
    enrollmentDate date,
    cancelled BOOLEAN,
    cancellationReason varchar(100),
    PRIMARY KEY (courseId, cycleId, studentId),
    FOREIGN KEY (courseId, cycleId) REFERENCES courses_by_cycle(courseId, cycleId) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (studentId) REFERENCES students(studentId) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE = InnoDB;
----------------------
CREATE TABLE teachers (
    teacherId varchar(10) PRIMARY KEY,
    teacherFName varchar(50),
    teacherLName varchar(50),
    teacherEmail varchar(100) UNIQUE,
    teacherPhoneNumber varchar(15)
) ENGINE = InnoDB;
----------------------
CREATE TABLE teachers_per_course (
    courseId varchar(10),
    cycleId varchar(10),
    teacherId varchar(10),
    PRIMARY KEY (courseId, cycleId, teacherId),
    FOREIGN KEY (courseId, cycleId) REFERENCES courses_by_cycle(courseId, cycleId),
    FOREIGN KEY (teacherId) REFERENCES teachers(teacherId)
) ENGINE = InnoDB;
----------------------
CREATE TABLE classes (
    courseId varchar(10),
    cycleId varchar(10),
    classId varchar(10),
    classTitle varchar(100),
    classDay varchar(10),
    room varchar(20),
    startTime time,
    endTime time,
    PRIMARY KEY (courseId, cycleId, classId),
    FOREIGN KEY (courseId, cycleId) REFERENCES courses_by_cycle(courseId, cycleId)
) ENGINE = InnoDB;
----------------------
CREATE TABLE attendance (
    courseId varchar(10),
    cycleId varchar(10),
    classId varchar(10),
    studentId varchar(10),
    attendDate date,
    status ENUM('present', 'absent') DEFAULT 'present',
    absentPermitted BOOLEAN DEFAULT NULL,
    PRIMARY KEY (
        courseId,
        cycleId,
        classId,
        studentId,
        attendDate
    ),
    FOREIGN KEY (courseId, cycleId, classId) REFERENCES classes(courseId, cycleId, classId),
    FOREIGN KEY (studentId) REFERENCES students(studentId)
) ENGINE = InnoDB;
----------------------
CREATE TABLE tests (
    courseId varchar(10),
    cycleId varchar(10),
    testNo int,
    testType varchar(50),
    testDate date,
    testTime time,
    PRIMARY KEY (courseId, cycleId, testNo),
    FOREIGN KEY (courseId, cycleId) REFERENCES courses_by_cycle(courseId, cycleId)
) ENGINE = InnoDB;
----------------------
CREATE TABLE test_scores (
    courseId varchar(10),
    cycleId varchar(10),
    testNo int,
    studentId varchar(10),
    score decimal(3, 1) DEFAULT 0,
    PRIMARY KEY (courseId, cycleId, testNo, studentId),
    FOREIGN KEY (courseId, cycleId, testNo) REFERENCES tests(courseId, cycleId, testNo),
    FOREIGN KEY (studentId) REFERENCES students(studentId)
) ENGINE = InnoDB;
----------------------