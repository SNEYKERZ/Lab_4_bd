-- Secuencia para la tabla student --
CREATE SEQUENCE increment_student
  	INCREMENT 168
	START WITH 7488;

-- student (student_id, name, program) --
CREATE TABLE student (
	student_id INTEGER DEFAULT nextval ('increment_student'),
  	name VARCHAR (200), 
  	program VARCHAR (200),
  	PRIMARY key (student_id)
);

-- instructor (instructor_id, name, dept, title) --
CREATE TABLE instructor (
	instructor_id SERIAL PRIMARY KEY, 
  	name VARCHAR (200), 
  	dept VARCHAR (200),
  	title VARCHAR (200)
);

-- Secuencia para la tabla course --
CREATE SEQUENCE increment_course
  	INCREMENT 23 
	START WITH 837827;
    
-- course (course_id, title, syllabus, credits) --
CREATE TABLE course (
	course_id INTEGER DEFAULT nextval ('increment_course'),
  	title VARCHAR (200), 
  	syllabus VARCHAR (500),
  	credits INTEGER,
  	PRIMARY key (course_id)
);

-- course_offering (course_id*, sec_id, year, semester, time, classroom) --
CREATE TABLE course_offering (
	course_id INTEGER, 
  	sec_id INTEGER PRIMARY key, 
  	year INTEGER, 
  	semester INTEGER, 
  	time VARCHAR(100), 
  	classroom INTEGER,
  	FOREIGN KEY (course_id)
  		REFERENCES course (course_id)
);

-- enrols (student_id*, course_id*, sec_id, semester, year, grade) --
CREATE TABLE enrolls (
	student_id INTEGER, 
  	course_id INTEGER, 
  	sec_id INTEGER, 
  	year INTEGER, 
  	semester INTEGER, 
  	grade NUMERIC(3,2),
  	CHECK (grade BETWEEN 1.00 AND 5.00),
  	PRIMARY key (student_id, course_id, sec_id),
  	FOREIGN KEY (student_id)
  		REFERENCES student (student_id),
  	FOREIGN KEY (course_id)
  		REFERENCES course (course_id)
);

-- teaches (course_id*, sec_id, semester, year, instructor_id*) --
CREATE TABLE teaches (
  	course_id INTEGER, 
  	sec_id INTEGER, 
  	semester INTEGER, 	
  	year INTEGER, 
 	instructor_id INTEGER, 
    PRIMARY key (course_id, sec_id, instructor_id),
  	FOREIGN KEY (course_id)
  		REFERENCES course (course_id),
  	FOREIGN KEY (instructor_id)
  		REFERENCES instructor (instructor_id)
);

--requires (main_course*, prerequisite*)
CREATE TABLE  requires (
  main_course INTEGER,
  prereqisite INTEGER,
  PRIMARY key (main_course, prereqisite),
  FOREIGN KEY (main_course)
  	REFERENCES course (course_id),
  FOREIGN KEY (prereqisite)
  	REFERENCES course (course_id)
);

