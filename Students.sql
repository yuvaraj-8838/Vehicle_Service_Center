CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    department VARCHAR(30),
    marks INT
);

INSERT INTO Students (student_id, student_name, department, marks) VALUES
(1, 'Arun', 'CSE', 85),
(2, 'Priya', 'CSE', 92),
(3, 'Karthik', 'CSE', 78),
(4, 'Janani', 'CSE', 88),
(5, 'Rahul', 'CSE', 70),

(6, 'Meena', 'ECE', 76),
(7, 'Sanjay', 'ECE', 82),
(8, 'Divya', 'ECE', 91),
(9, 'Vijay', 'ECE', 68),
(10, 'Anitha', 'ECE', 74),

(11, 'Ravi', 'IT', 95),
(12, 'Swetha', 'IT', 89),
(13, 'Manoj', 'IT', 93),
(14, 'Deepa', 'IT', 81),
(15, 'Hari', 'IT', 77);

-- Query 31

SELECT department, AVG(marks) AS average_marks
FROM Students
GROUP BY department;

-- Query 32

SELECT department, AVG(marks) AS average_marks
FROM Students
GROUP BY department
HAVING AVG(marks) > 75;

-- Query 33

SELECT department, MAX(marks) AS highest_mark
FROM Students
GROUP BY department;

-- Query 34

SELECT department, COUNT(student_id) AS total_students
FROM Students
GROUP BY department;

-- Query 35

SELECT department, COUNT(student_id) AS total_students
FROM Students
GROUP BY department
HAVING COUNT(student_id) > 5;

-- Query 36

SELECT department, AVG(marks) AS average_marks
FROM Students
GROUP BY department
ORDER BY average_marks DESC;

-- Query 37

SELECT department, AVG(marks) AS average_marks
FROM Students
GROUP BY department
ORDER BY average_marks DESC
LIMIT 3;

-- Query 38

SELECT department, AVG(marks) AS average_marks
FROM Students
GROUP BY department
HAVING AVG(marks) BETWEEN 70 AND 90;

-- Query 39

SELECT department, SUM(marks) AS total_marks
FROM Students
GROUP BY department;

-- Query 40

SELECT department, COUNT(student_id) AS total_students
FROM Students
GROUP BY department
ORDER BY total_students ASC;

-- Query 41

SELECT department, MIN(marks) AS lowest_mark
FROM Students
GROUP BY department;

-- Query 42

SELECT department, MAX(marks) AS highest_mark
FROM Students
GROUP BY department
HAVING MAX(marks) > 90;

-- Query 43

SELECT department, COUNT(student_id) AS students_above_80
FROM Students
WHERE marks > 80
GROUP BY department;

-- Query 44

SELECT department, COUNT(student_id) AS students_above_75
FROM Students
WHERE marks > 75
GROUP BY department
HAVING COUNT(student_id) > 3;

-- Query 45

SELECT department, MAX(marks) AS highest_mark
FROM Students
GROUP BY department
ORDER BY highest_mark DESC;