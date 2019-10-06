USE db_University_basic;

-- 1. Among the professors who works in Taylor building, what is their average salary? (C. 78000)
-- A. 74833		B. 77333	C. 78000	D. 78500;
SELECT AVG(salary)
FROM instructor
INNER JOIN department
ON instructor.dept_name=department.dept_name
WHERE building='Taylor';

-- 2. Which of the following sets of rooms had professor Srinivasan used? (A. 101,120,3128)
-- A. 101,120,3128		B. 120,514,3128		C. 100,101,514		D.100,120,514
SELECT room_number
FROM instructor, teaches, section
WHERE instructor.ID = teaches.ID AND teaches.course_id = section.course_id AND
	  teaches.sec_id = section.sec_id AND teaches.semester = section.semester AND
      teaches.year = section.year AND name = 'Srinivasan';
SELECT DISTINCT room_number FROM section;

-- 3. For students whose ID starts with 7 or 9, who took the least classes? (A. Aoi)
-- A. Aoi		B. Bourikas		C. Brown	D. Tanaka
SELECT name, COUNT(course_id) AS class_number
FROM student, takes
WHERE student.ID = takes.ID AND student.ID REGEXP '^7|^9'
GROUP BY student.ID;

-- 4. How many different students have taken a Computer Science course? (B. 6)
-- A. 5			B. 6		C. 7		D. 8
SELECT COUNT(DISTINCT ID)
FROM takes
WHERE course_id LIKE 'CS%';