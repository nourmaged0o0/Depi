CREATE TABLE students (

id SERIAL PRIMARY KEY, -- Unique ID for each student

name VARCHAR(50) NOT NULL -- Name of the student

);

CREATE TABLE courses (

id SERIAL PRIMARY KEY, -- Unique ID for each course

name VARCHAR(100) NOT NULL -- Name of the course

);

CREATE TABLE enrollments (

id SERIAL PRIMARY KEY, -- Unique ID for each enrollment record

student_id INT REFERENCES students(id), -- Foreign key linking to the students table

course_id INT REFERENCES courses(id) -- Foreign key linking to the courses table

);
INSERT INTO students (name) VALUES

('Ali'),

('Sarah'),

('Ahmed'),

('Fatima');


-- Insert sample data into the courses table

INSERT INTO courses (name) VALUES

('Mathematics'),

('Physics'),

('Computer Science');


-- Insert sample data into the enrollments table

INSERT INTO enrollments (student_id, course_id) VALUES

(1, 1), -- Ali enrolled in Mathematics

(2, 1), -- Sarah enrolled in Mathematics

(3, 2), -- Ahmed enrolled in Physics

(4, 1), -- Fatima enrolled in Mathematics

(3, 3); -- Ahmed enrolled in Computer Science


-- Retrieve courses with more than one enrollment using a subquery

SELECT c.name, sub.enrollments

FROM courses c

JOIN (

-- Subquery to count the number of enrollments per course

SELECT course_id, COUNT(id) AS enrollments

FROM enrollments

GROUP BY course_id

) sub ON c.id = sub.course_id

WHERE sub.enrollments > 1; -- Filter to include only courses with more than one enrollment


-- Retrieve all courses with their enrollment counts (optional)

SELECT c.name, COUNT(e.id) AS enrollments

FROM courses c

LEFT JOIN enrollments e ON c.id = e.course_id

GROUP BY c.id; -- Group by course ID to calculate enrollments for each course


Create VIEW myView AS
SELECT 
	s.name as students_name,count(e.id)as counter
	from enrollments e join students s on s.id = e.student_id
	group by s.name;
	select * from myView;

create view myview2 as
select 
 c.name as course_name,count(e.id)
 from enrollments e join courses c on e.course_id = c.id
 group by c.name having count (e.id )>2;
select * from myview2;

create view myview3 as 
select s.name as sname ,c.name as coursen
from courses c join enrollments e on c.id =e.course_id
join students s on e.student_id = s.id;

SELECT *FROM myview3;


Drop view if exists myview3 ;