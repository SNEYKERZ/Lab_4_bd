/* DROPS */
/* Cree un archivo con el nombre drops.sql con las instrucciones necesarias para hacer el borrado de todas las tablas, secuencias, disparadores, etc, que se crearon en los anteriores puntos de este laboratorio. (No utilice la instrucción CASCADE) */
DROP VIEW better_students;
DROP TABLE requires, teaches, enrolls, course_offering, course, instructor, student; 
DROP SEQUENCE increment_student, increment_course;
DROP FUNCTION create_teaches, invalidación_notaigual, mostar_modificaciónerronea, mostar_modificaciónexitosa, mostrarinvalidación;