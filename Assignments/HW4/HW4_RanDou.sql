USE db_University_basic;

-- 1. Can you please list all the courses that belong to the Comp. Sci. department and have 3 credits?
SELECT *
FROM course
WHERE dept_name = 'Comp. Sci.' AND credits = 3;

-- 2. Can you please list all the students who were instructed by Einstein; make sure there are not duplicities
# DISTINCT
SELECT DISTINCT student.name
FROM student, takes, teaches, instructor
WHERE student.ID=takes.ID AND instructor.ID=teaches.ID AND takes.course_id=teaches.course_id AND
      takes.sec_id=teaches.sec_id AND takes.semester_id=teaches.semester AND takes.year=teaches.year AND
	  instructor.name='Einstein';

-- 3. Can you please list the names of the all the faculty getting the highest salary within the whole university? (Retrieve aside of their names, their departments names and buildings)
# should be left join
SELECT instructor.*, building
FROM instructor
LEFT JOIN department
ON instructor.dept_name=department.dept_name
WHERE salary=(SELECT MAX(salary) FROM instructor);

-- 4. Can you please list the names of all the instructors along with the titles of the courses that they teach?
# DISTINCT
# ALL INSTRUCTORS (even null in course)
SELECT DISTINCT instructor.name, course.title
FROM instructor
LEFT JOIN teaches ON instructor.ID=teaches.ID 
LEFT JOIN course ON teaches.course_id=course.course_id;

-- 5. Can you please list the names of instructors with salary amounts between $90K and $100K?
SELECT name
FROM instructor
WHERE salary BETWEEN 90e3 AND 100e3;

-- 6. Can you please list what courses were taught in the fall of 2009?
# DISTINCT
SELECT DISTINCT course.title
FROM course, teaches
WHERE course.course_id=teaches.course_id AND semester='Fall' AND year='2009';

-- 7. Can you please list all the courses taught in the spring of 2010?
# DISTINCT
SELECT DISTINCT course.title
FROM course, teaches
WHERE course.course_id=teaches.course_id AND semester='Spring' AND year='2010';

-- 8. Can you please list all the courses taught in the fall of 2009 or in the spring of 2010.
# DISTINCT
SELECT DISTINCT course.title
FROM course, teaches
WHERE course.course_id=teaches.course_id AND
     ((semester='Fall' AND year='2009') OR (semester='Spring' AND year='2010'));

-- 9. List the all the courses taught in the fall of 2009 and in the spring of 2010.
# DISTINCT
SELECT DISTINCT course.title
FROM course, teaches
WHERE course.course_id=teaches.course_id AND
      course.title IN (SELECT DISTINCT course.title
					   FROM course, teaches
					   WHERE course.course_id=teaches.course_id
							 AND semester='Fall' AND year='2009') AND
	  course.title IN (SELECT DISTINCT course.title
					   FROM course, teaches
					   WHERE course.course_id=teaches.course_id
							 AND semester='Spring' AND year='2010');

-- 10. List all the faculty along with their salary and department of the faculty who tough a course in 2009
# DISTINCT
SELECT DISTINCT instructor.*
FROM instructor, teaches
WHERE instructor.ID=teaches.ID AND year='2009';

-- 11. Find the average salary of instructors in the Computer Science department.
SELECT AVG(salary)
FROM instructor
WHERE dept_name='Comp. Sci.';

-- 12. For each department, please find the maximum enrollment, across all sections, in autumn 2009
SELECT dept_name, MAX(count_enrol)
FROM (SELECT course.dept_name, sec_id, COUNT(*) as count_enrol
      FROM course
      LEFT JOIN takes
      ON course.course_id=takes.course_id
      WHERE takes.semester_id='Fall' AND year='2009'
      GROUP BY course.dept_name, sec_id) AS temp_table
GROUP BY temp_table.dept_name;

-- 13. Get a table displaying a list of all the students with their ID, the name, the name of the department and the total number of credits along with the courses they have already taken?
# 1. they've already taken (IS NOT NULL)
# 2. DISTINCT
SELECT DISTINCT student.*, takes.course_id
FROM student
LEFT JOIN takes
ON student.ID=takes.ID AND grade IS NOT NULL;

-- 14. Display a list of students in the Comp. Sci. department, along with the course sections, that they have taken in the spring of 2009. Make sure all courses taught in the spring are displayed even if no student from the Comp. Sci. department has taken it.

SELECT course_table.*, name
FROM (SELECT teaches.course_id, sec_id, title
	  FROM teaches, course
	  WHERE teaches.course_id=course.course_id AND semester='Spring') AS course_table
LEFT JOIN (SELECT student.name, takes.course_id, takes.sec_id, title
		   FROM student, takes, course
		   WHERE student.ID=takes.ID AND takes.course_id=course.course_id AND
				 semester_id='Spring' AND year='2009' AND student.dept_name='Comp. Sci.') AS student_table
ON course_table.course_id = student_table.course_id AND
   course_table.sec_id = student_table.sec_id AND
   course_table.title = student_table.title;
   
   
   
   
   
   
   