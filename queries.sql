/* The average grade that is given by each professor */
  SELECT 
  professors_name,
  g
  FROM professors
  JOIN (
  SELECT grades_professors_id, AVG(grades_value) as g 
  FROM grades GROUP BY grades_professors_id) p 
  on professors_id = grades_professors_id;




/* The top grades for each student */

  SELECT 
  students_name,
  g
  FROM students
  JOIN (
  SELECT grades_students_id, MAX(grades_value) as g 
  FROM grades GROUP BY grades_students_id) s 
  on students_id = grades_students_id;


  /* Group students by the courses that they are enrolled in */
  
SELECT 
students_name,
courses_name
FROM courses
CROSS JOIN grades
ON courses.courses_id = grades.grades_course_id
CROSS JOIN students 
ON students.students_id = grades_students_id;

/*Create a summary report of courses and their average grades, sorted by the most challenging course 
(course with the lowest average grade) to the easiest course*/
  SELECT 
  courses_name,
  AVG(grades_value)
  FROM grades
  JOIN courses
  ON grades.grades_course_id = courses.courses_id
  GROUP BY grades_course_id
  order by AVG(grades_value) ASC;



/*Finding which student and professor have the most courses in common */

with stm as (
  select 
    students_name,
    professors_name, 
    count(distinct courses_id) counter 
  from grades
  join students on grades.grades_students_id = students.students_id
  join courses on grades.grades_course_id = courses.courses_id
  join professors on courses.courses_professors_id = professors.professors_id
  group by 
    students_name,
    professors_name
)

select * from stm
where stm.counter = (
  select max(counter) from stm
);


