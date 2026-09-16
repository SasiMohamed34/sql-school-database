# SQL School Database System

A normalized relational database built with SQL and XAMPP.

## Features
- 4-table schema: Students, Instructors, Courses, Enrollments
- Primary and foreign key constraints
- 10 analytical queries using JOINs, GROUP BY, HAVING, and subqueries

## Schema
- Students (student_id, first_name, last_name, major, year_level, gpa)
- Instructors (instructor_id, first_name, last_name, department)
- Courses (course_id, course_code, course_title, credits, department, instructor_id)
- Enrollments (enrollment_id, student_id, course_id, semester, year, grade)

## How to Run
1. Install XAMPP and start MySQL
2. Open phpMyAdmin
3. Import Assign3_Sasi.sql

## What I Learned
- Relational schema design and normalization
- JOIN operations across multiple tables
- Aggregate functions (GROUP BY, HAVING) and subqueries
- Primary and foreign key constraints
