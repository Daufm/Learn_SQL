-- Learn SQL

-- 1. Basic SQL
-- create table and db
CREATE DATABASE StudentsDDB;
use StudentsDDB;

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
SELECT * FROM Students WHERE AGE IN (18, 20, 22)