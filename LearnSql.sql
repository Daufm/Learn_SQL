-- Learn SQL
-- Date: 2025-21-09
-- Author: Fuad Mohammed

--------------------------------------------------------------


-- Basic SQL
-- create table and db
CREATE DATABASE StudentsDB;
use StudentsDB;

CREATE TABLE  Students (
    ID INT PRIMARY KEY NOT NULL,
    FIRST_NAME VARCHAR(100) NOT NULL,
    LAST_NAME VARCHAR(100) NOT NULL,
    AGE INT NOT NULL,
    MAJOR VARCHAR(100) NOT NULL
);


--A insert data
INSERT INTO Students (ID, FIRST_NAME, LAST_NAME, AGE, MAJOR) VALUES (1, 'John', 'Doe', 23, 'Computer Science');
INSERT INTO Students (ID, FIRST_NAME, LAST_NAME, AGE, MAJOR) VALUES (2, 'Jane', 'Smith', 22, 'Mathematics');
INSERT INTO Students (ID, FIRST_NAME, LAST_NAME, AGE, MAJOR) VALUES (3, 'Alice', 'Johnson', 19, 'Physics');
INSERT INTO Students (ID, FIRST_NAME, LAST_NAME, AGE, MAJOR) VALUES (4, 'Bob', 'Brown', 25, 'Chemistry');

--B retrieve data
SELECT * FROM Students 
SELECT FIRST_NAME FROM Students
SELECT AGE FROM Students
SELECT FIRST_NAME, LAST_NAME FROM Students
--remove duplicates
SELECT DISTINCT MAJOR FROM Students


--C retrieve data with condition
SELECT * FROM Students WHERE AGE > 18
SELECT * FROM Students WHERE MAJOR = 'Computer Science'
SELECT * FROM Students WHERE LAST_NAME LIKE 'D%'
SELECT * FROM Students WHERE FIRST_NAME LIKE '_ohn'
SELECT * FROM Students WHERE AGE BETWEEN 18 AND 22
SELECT * FROM Students WHERE AGE IS NULL
SELECT * FROM Students WHERE AGE IS NOT NULL
SELECT * FROM Students WHERE AGE IN (18, 20, 22)
SELECT * FROM Students WHERE AGE NOT IN (18, 20, 22)
SELECT * FROM Students WHERE AGE > 18 AND MAJOR = 'Computer Science'

--D retrieve data with sorting
SELECT * FROM Students ORDER BY LAST_NAME ASC
SELECT * FROM Students ORDER BY AGE DESC
-- retrieve by major then for each major in descending age
SELECT * FROM Students ORDER BY MAJOR ASC, AGE DESC


--E update data
UPDATE Students SET AGE = 24 WHERE ID = 1;
UPDATE Students SET MAJOR = 'Data Science' WHERE ID = 2;
UPDATE Students SET AGE = AGE + 1 WHERE AGE < 22;
UPDATE Students SET MAJOR = 'Undeclared' WHERE MAJOR IS NULL;

--F. alter table
-- add column GPA
ALTER TABLE Students ADD GPA DECIMAL(3, 2);
-- delete column GPA
ALTER TABLE Students DROP COLUMN GPA;
ALTER TABLE Students ADD  EMAIL VARCHAR(100);
-- modify column EMAIL to VARCHAR(150)
ALTER TABLE Students ALTER COLUMN EMAIL VARCHAR(150);
-- correct syntax for modify column in MySQL
ALTER TABLE Students MODIFY COLUMN EMAIL VARCHAR(150);
-- rename column EMAIL to CONTACT_EMAIL
ALTER TABLE Students RENAME COLUMN EMAIL TO CONTACT_EMAIL;
-- rename table Students to University_Students
ALTER TABLE Students RENAME TO University_Students;


--G. delete data
DELETE FROM University_Students WHERE ID = 1;
DELETE FROM University_Students WHERE AGE < 20;
DELETE FROM University_Students WHERE MAJOR = 'Undeclared';
DELETE FROM University_Students; -- delete all data


--H . AGGREGATE FUNCTIONS
-- count
SELECT COUNT(*) AS Total_Students FROM University_Students;
SELECT COUNT(DISTINCT MAJOR) AS Unique_Majors FROM University_Students;
-- avg
SELECT AVG(AGE) AS Average_Age FROM University_Students;
-- sum
SELECT SUM(AGE) AS Total_Age FROM University_Students;
-- min
SELECT MIN(AGE) AS Youngest_Student FROM University_Students;
-- max
SELECT MAX(AGE) AS Oldest_Student FROM University_Students;
-- group by
SELECT MAJOR, COUNT(*) AS Students_Per_Major FROM University_Students GROUP BY MAJOR
-- having
SELECT MAJOR, COUNT(*) AS Students_Per_Major FROM University_Students GROUP BY MAJOR HAVING COUNT(*) > 1;
-- combined
SELECT MAJOR, AVG(AGE) AS Average_Age, COUNT(*) AS Students_Per_Major FROM University_Students GROUP BY MAJOR HAVING COUNT(*) > 1;


-- I. JOINS
-- create another table Courses
CREATE TABLE Courses (
    COURSE_ID INT PRIMARY KEY NOT NULL,
    COURSE_NAME VARCHAR(100) NOT NULL,
    STUDENT_ID INT,
    FOREIGN KEY (STUDENT_ID) REFERENCES University_Students(ID)
);

-- insert data into Courses
INSERT INTO Courses (COURSE_ID, COURSE_NAME, STUDENT_ID) VALUES (1, 'Database Systems', 2);
INSERT INTO Courses (COURSE_ID, COURSE_NAME, STUDENT_ID) VALUES (2, 'Calculus', 3);
INSERT INTO Courses (COURSE_ID, COURSE_NAME, STUDENT_ID) VALUES (3, 'Physics I', 4);
INSERT INTO Courses (COURSE_ID, COURSE_NAME, STUDENT_ID) VALUES (4, 'Chemistry I', NULL);

-- inner join(inner join means only the matching records from both tables)
SELECT us.FIRST_NAME, us.LAST_NAME, c.COURSE_NAME
FROM University_Students us
INNER JOIN Courses c ON us.ID = c.STUDENT_ID;

-- left join(means all records from the left table and the matching records from the right table)
SELECT us.FIRST_NAME, us.LAST_NAME, c.COURSE_NAME
FROM University_Students us
LEFT JOIN Courses c ON us.ID = c.STUDENT_ID;

-- right join(means all records from the right table and the matching records from the left table)
SELECT us.FIRST_NAME, us.LAST_NAME, c.COURSE_NAME 
FROM University_Students us 
RIGHT JOIN Courses c ON us.ID = c.STUDENT_ID;

-- full outer join(means all records when there is a match in either left or right table)
SELECT us.FIRST_NAME, us.LAST_NAME, c.COURSE_NAME
FROM University_Students us
FULL OUTER JOIN Courses c ON us.ID = c.STUDENT_ID;

--cross join(produces the Cartesian product of the two tables involved in the join)
SELECT us.FIRST_NAME, us.LAST_NAME, c.COURSE_NAME
FROM University_Students us
CROSS JOIN Courses c;

-- self join(means joining the table with itself)
SELECT a.FIRST_NAME AS Student1, b.FIRST_NAME AS Student2
FROM University_Students a, University_Students b
WHERE a.ID <> b.ID;

-- J. SUBQUERIES

-- simple subquery
-- find students enrolled in any course
SELECT FIRST_NAME, LAST_NAME
FROM University_Students
WHERE ID IN (SELECT STUDENT_ID FROM Courses);

-- correlated subquery
-- find students enrolled in at least one course
SELECT FIRST_NAME, LAST_NAME
FROM University_Students us
WHERE EXISTS (SELECT 1 FROM Courses c WHERE c.STUDENT_ID = us.ID);

-- nested subquery
-- find the student enrolled in 'Database Systems'
SELECT FIRST_NAME, LAST_NAME
FROM University_Students
WHERE ID = (SELECT STUDENT_ID FROM Courses WHERE COURSE_NAME = 'Database Systems');

-- K. VIEWS
-- create view for students in Computer Science major
CREATE VIEW CS_Students AS
SELECT FIRST_NAME, LAST_NAME, AGE
FROM University_Students
WHERE MAJOR = 'Computer Science';
-- query the view
SELECT * FROM CS_Students;
-- drop the view
DROP VIEW CS_Students;


-- L. TRANSACTIONS
-- start transaction
BEGIN;
    -- perform multiple operations
    UPDATE University_Students SET AGE = AGE + 1 WHERE ID = 2;
    INSERT INTO University_Students (ID, FIRST_NAME, LAST_NAME, AGE, MAJOR) VALUES (5, 'Eve', 'Davis', 21, 'Biology');
    -- commit transaction (if everything is fine)
COMMIT;


-- rollback transaction(if something goes wrong or you want to undo the changes)
BEGIN;
    -- perform multiple operations
    UPDATE University_Students SET AGE = AGE + 1 WHERE ID = 3;
    INSERT INTO University_Students (ID, FIRST_NAME, LAST_NAME, AGE, MAJOR) VALUES (6, 'Frank', 'Miller', 23, 'History');
    -- rollback transaction
ROLLBACK;

-- checkpoint(savepoint and rollback to savepoint)
BEGIN;
    -- perform multiple operations
    UPDATE University_Students SET AGE = AGE + 1 WHERE ID = 4;
    SAVE TRANSACTION sp1; -- create a savepoint
    INSERT INTO University_Students (ID, FIRST_NAME, LAST_NAME, AGE, MAJOR) VALUES (7, 'Grace', 'Wilson', 22, 'Philosophy');
    -- rollback to savepoint if needed
    ROLLBACK TRANSACTION sp1;
COMMIT;

-- end transaction
-- END;


-- M. INDEXES
-- create index on LAST_NAME
CREATE INDEX idx_last_name ON University_Students (LAST_NAME);
-- query using the index
SELECT * FROM University_Students WHERE LAST_NAME = 'Smith';
-- drop the index
DROP INDEX idx_last_name ON University_Students;
-- create index on MAJOR and AGE
CREATE INDEX idx_major_age ON University_Students (MAJOR, AGE);
-- query using the composite index
SELECT * FROM University_Students WHERE MAJOR = 'Mathematics' AND AGE > 20;
-- drop the composite index
DROP INDEX idx_major_age ON University_Students;


-- N. CLEAN UP
-- drop tables
DROP TABLE Courses;
DROP TABLE University_Students;
-- drop database
DROP DATABASE StudentsDB;
-- end of Learn SQL