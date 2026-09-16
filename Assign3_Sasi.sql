-- Mohamed Sasi
-- Assignment 3

-- Part 1: Install Database Management Software using XAMPP: COMPLETED

-- Part 2: Write "Create Table" statement to create 4 relations. 
DROP DATABASE IF EXISTS school_db;
CREATE DATABASE school_db;
USE school_db;

CREATE TABLE Students (
    student_id   INT          PRIMARY KEY,
    first_name   VARCHAR(50)  NOT NULL,
    last_name    VARCHAR(50)  NOT NULL,
    major        VARCHAR(100),
    year_level   INT,
    gpa          DECIMAL(3,2)
);

CREATE TABLE Instructors (
    instructor_id  INT         PRIMARY KEY,
    first_name     VARCHAR(50) NOT NULL,
    last_name      VARCHAR(50) NOT NULL,
    department     VARCHAR(100)
);

CREATE TABLE Courses (
    course_id      INT          PRIMARY KEY,
    course_code    VARCHAR(20)  NOT NULL,
    course_title   VARCHAR(100) NOT NULL,
    credits        INT,
    department     VARCHAR(100),
    instructor_id  INT,
    FOREIGN KEY (instructor_id) REFERENCES Instructors(instructor_id)
);

CREATE TABLE Enrollments (
    enrollment_id  INT         PRIMARY KEY,
    student_id     INT,
    course_id      INT,
    semester       VARCHAR(20),
    year           INT,
    grade          VARCHAR(2),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id)  REFERENCES Courses(course_id)
);


-- Part 3: Insert 5 rows in each table

-- Students
INSERT INTO Students VALUES (001, 'Jordan',  'Lee',      'Computer Science', 2, 3.72);
INSERT INTO Students VALUES (002, 'Maya',    'Patel',    'Biology',             3, 3.41);
INSERT INTO Students VALUES (003, 'Noah',    'Bennett',  'Mechanical Engineering', 1, 3.63);
INSERT INTO Students VALUES (004, 'Sophia',  'Nguyen',   'Chemistry',           4, 3.08);
INSERT INTO Students VALUES (005, 'Ethan',   'Morales',  'Economics',           2, 3.27);

-- Instructors
INSERT INTO Instructors VALUES (001, 'Karen',   'Mitchell', 'Computer Science');
INSERT INTO Instructors VALUES (002, 'Priya',   'Shah',     'Computer Science');
INSERT INTO Instructors VALUES (003, 'Daniel',  'Ortiz',    'Mathematics');
INSERT INTO Instructors VALUES (004, 'Thomas',  'Reed',     'Physics');
INSERT INTO Instructors VALUES (005, 'Angela',  'Brooks',   'English');

-- Courses
INSERT INTO Courses VALUES (001, 'CS110',  'Programming Fundamentals',     3, 'Computer Science', 001);
INSERT INTO Courses VALUES (002, 'CS240',  'Database Systems',             3, 'Computer Science', 002);
INSERT INTO Courses VALUES (003, 'MATH121','Statistics I',                 3, 'Mathematics',      003);
INSERT INTO Courses VALUES (004, 'PHYS115','Applied Physics',              3, 'Physics',          004);
INSERT INTO Courses VALUES (005, 'ENG210', 'Technical Writing',            3, 'English',          005);

-- Enrollments
INSERT INTO Enrollments VALUES (001, 001, 002, 'Spring', 2026, 'A');
INSERT INTO Enrollments VALUES (002, 001, 003, 'Fall',   2026, 'A');
INSERT INTO Enrollments VALUES (003, 001, 004, 'Fall',   2026, 'B');
INSERT INTO Enrollments VALUES (004, 001, 005, 'Spring', 2026, 'A');
INSERT INTO Enrollments VALUES (005, 002, 001, 'Spring', 2026, 'B');
INSERT INTO Enrollments VALUES (006, 002, 002, 'Fall',   2026, 'B');
INSERT INTO Enrollments VALUES (007, 003, 001, 'Spring', 2026, 'A');
INSERT INTO Enrollments VALUES (008, 003, 002, 'Fall',   2026, 'A');
INSERT INTO Enrollments VALUES (009, 003, 003, 'Fall',   2026, 'B');
INSERT INTO Enrollments VALUES (010, 003, 004, 'Spring', 2026, 'A');
INSERT INTO Enrollments VALUES (011, 004, 001, 'Spring', 2026, 'C');
INSERT INTO Enrollments VALUES (012, 004, 002, 'Fall',   2026, 'B');
INSERT INTO Enrollments VALUES (013, 005, 001, 'Spring', 2026, 'A');
INSERT INTO Enrollments VALUES (014, 005, 002, 'Fall',   2026, 'A');
INSERT INTO Enrollments VALUES (015, 005, 003, 'Fall',   2026, 'B');
INSERT INTO Enrollments VALUES (016, 005, 004, 'Spring', 2026, 'A');
INSERT INTO Enrollments VALUES (017, 005, 005, 'Spring', 2026, 'A');


-- Part 4: Write SQL queries for the following questions.
-- Q1: Display the first name, last name, and major of all students.
SELECT first_name, last_name, major
FROM Students;

-- Q2: Display all students whose GPA is greater than 3.50
SELECT *
FROM Students
WHERE gpa > 3.50;

-- Q3: Find all students whose major is Computer Science and whose GPA is at least 3.00
SELECT *
FROM Students
WHERE major = 'Computer Science'
  AND gpa >= 3.00;

-- Q4: Display students ordered by GPA from highest to lowest.
SELECT *
FROM Students
ORDER BY gpa DESC;

-- Q5: List all courses taught by instructors from the Computer Science department.
SELECT c.*
FROM Courses c
JOIN Instructors i ON c.instructor_id = i.instructor_id
WHERE i.department = 'Computer Science';

-- Q6: List each course along with the instructor's first and last name.
SELECT c.course_code, c.course_title, i.first_name, i.last_name
FROM Courses c
JOIN Instructors i ON c.instructor_id = i.instructor_id;

-- Q7: Count how many courses are offered by each department.
SELECT department, COUNT(*) AS course_count
FROM Courses
GROUP BY department;

-- Q8: Show only those courses that have more than 10 students enrolled.
SELECT c.course_code, c.course_title, COUNT(e.student_id) AS enrolled_count
FROM Courses c
JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_code, c.course_title
HAVING COUNT(e.student_id) > 10;

-- Q9: Find the names of students who are enrolled in more than 3 courses.
SELECT s.first_name, s.last_name, COUNT(e.course_id) AS course_count
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, s.first_name, s.last_name
HAVING COUNT(e.course_id) > 3;

-- Q10: Find the student(s) with the highest GPA.
SELECT *
FROM Students
WHERE gpa = (SELECT MAX(gpa) FROM Students);
