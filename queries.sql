-- Consultas --
/*
Encuentre el dept, title de los instructores registrados en la base de datos.
*/
SELECT dept, title FROM instructor

/*
Indique el nombre y programa del estudiante con student_id = 7656
*/
SELECT name, program FROM student 
	WHERE student_id = 7656

/*
Encuentre los nombres de todos los estudiantes que se han matriculado en el curso con course_id = 837873
*/
SELECT name FROM enrolls 
	JOIN student
	ON course_id = 837873 AND student.student_id = enrolls.student_id;

/*
Cree una vista llamada better_students que presente los estudiantes que obtuvieron las notas más altas por cada semestre entre los años 1900 y 2018
*/
CREATE VIEW better_students AS
	SELECT student_id FROM enrolls
	WHERE grade >= 3.00 AND year BETWEEN 1900 AND 2018;

