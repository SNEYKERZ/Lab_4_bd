
/* DISPARADORES */
/* Al agregar una tupla en enrolls, en caso de que la nota sea negativa, cero (0.0) o mayor de 5.00 se debe generar una excepción indicando que el valor a guardar en grade es incorrecto o invalido. */
-- Creación de la función para mostrar un mensaje cuando la nota es invalida --
CREATE OR REPLACE FUNCTION mostrarInvalidación() RETURNS trigger AS $$
BEGIN
    RAISE EXCEPTION 'Calificación invalida';
RETURN new;
END;
$$
LANGUAGE 'plpgsql';

-- Creación del disparador --
CREATE OR REPLACE TRIGGER calificacionInvalida BEFORE INSERT ON enrolls
	for EACH row 
	WHEN (new.grade < 1.00 or new.grade > 5.00) EXECUTE FUNCTION mostrarInvalidación();

-- Pruebas --
INSERT INTO enrolls (student_id, course_id, sec_id, semester, year, grade)
	VALUES
  	(7488, 837827, 10, 2, 1723, 4.99);
    
/* Durante la actualización de un registro si el valor grade es modificado, usando RAISE NOTICE se debe presentar un mensaje indicando el cambio, si es igual al valor grade en la tabla se debe indicar que el valor no ha sido modificado. Si el grade a actualizar es negativo, cero o mayor de cinco use RAISE EXCEPTION. */
-- Creación de la función para cuando la modificación de las notas son iguales --
CREATE OR REPLACE FUNCTION invalidación_notaIgual() RETURNS trigger AS $$
BEGIN    	
	RAISE NOTICE 'La modificación es invalida ya que los valores son iguales';      
    RETURN new;
END;
$$
LANGUAGE 'plpgsql';

-- Creación del disparador --
CREATE OR REPLACE TRIGGER modificacionInvalida BEFORE UPDATE of grade ON enrolls
	for EACH row
	WHEn (new.grade = old.grade) EXECUTE PROCEDURE invalidación_notaIgual();
    
-- Creación de la función para cuando la modificación fue exitosa --
CREATE OR REPLACE FUNCTION mostar_ModificaciónExitosa() RETURNS trigger AS $$
BEGIN    	
	RAISE NOTICE 'La modificación se realizo exitosamente';      
    RETURN new;
END;
$$
LANGUAGE 'plpgsql';

-- Creación del disparador --
CREATE OR REPLACE TRIGGER modificacionExitosa BEFORE UPDATE of grade ON enrolls
	for EACH row
	WHEn (new.grade != old.grade) EXECUTE PROCEDURE mostar_ModificaciónExitosa();

-- Creación de la función para la modificación erronea de las notas --
CREATE OR REPLACE FUNCTION mostar_ModificaciónErronea() RETURNS trigger AS $$
BEGIN    	
	RAISE EXCEPTION 'Calificación invalida';      
    RETURN new;
END;
$$
LANGUAGE 'plpgsql';

-- Creación del disparador --
CREATE OR REPLACE TRIGGER modificacionErronea BEFORE UPDATE of grade ON enrolls
	for EACH row
	WHEN (new.grade < 1.00 or new.grade > 5.00) EXECUTE PROCEDURE mostar_ModificaciónErronea();

-- Pruebas --
update enrolls set grade = 0.45 
	where sec_id = 2;


/* Cree un procedimiento create_teaches que automáticamente agregue un registro a teaches. Este recibe dos argumentos un identificador de instructor instructor_id y un identificador de course_id. Se asume que ambos existen en la base de datos. 
Este procedimiento debe verificar que el curso exista en la oferta de cursos. */
CREATE or REPLACE FUNCTION create_teaches (INTEGER, INTEGER) RETURNs void as $$
DECLARE 
	instructorID alias for $1;
   	courseID alias for $2; 
    anio INTEGER;
    semestre INTEGER;
    secID INTEGER;
    
	BEGIN
		anio = (SELECT year from  course_offering WHERE courseID = course_offering.course_id);
		semestre = (SELECT semester from  course_offering WHERE courseID = course_offering.course_id);
    	secID = (SELECT sec_id from  course_offering WHERE courseID = course_offering.course_id);
	
    INSERT INTO teaches (course_id, sec_id, semester, year, instructor_id) 
    	VALUES (courseID, secID, semestre, anio, instructorID);
end;    
$$
LANGUAGE 'plpgsql';

-- Pruebas --
SELECT create_teaches (2, 837827);