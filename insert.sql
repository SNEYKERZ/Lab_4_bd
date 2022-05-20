-- Inserción de datos --
INSERT INTO student (name, program) 
VALUES
  ('Marny Mills','programa1'),
  ('Oprah Vang','programa2'),
  ('Sharon Camacho','programa3'),
  ('Ariana Bishop','programa4'),
  ('Elliott Hancock','programa5');
    
INSERT INTO instructor (name, dept, title)
VALUES
  ('Amos Rose','dept1','title1'),
  ('Nero Barker','dept2','title2'),
  ('George Sampson','dept3','title3'),
  ('Eve Juarez','dept4','title4'),
  ('Brett Martin','dept5','title5');
  
INSERT INTO course (title, syllabus, credits)
VALUES
  ('titleCourse1','erat vel pede blandit congue. In scelerisque scelerisque dui. Suspendisse',2),
  ('titleCourse2','Nunc mauris elit, dictum eu, eleifend nec, malesuada ut, sem.', 1),
  ('titleCourse3','consequat dolor vitae dolor. Donec fringilla. Donec feugiat metus sit',4),
  ('titleCourse4','ut nisi a odio semper cursus. Integer mollis. Integer tincidunt',3),
  ('titleCourse5','pellentesque eget, dictum placerat, augue. Sed molestie. Sed id risus',2);

INSERT INTO course_offering (course_id, sec_id, year, semester, time, classroom)
VALUES
  (837827, 1, 1900, 1, '2:00pm', 1),
  (837850, 2, 1990, 2, '10:00am', 2),
  (837873, 3, 2000, 3, '3:00pm', 3),
  (837896, 4, 2018, 5, '7:00am', 7),
  (837919, 5, 2020, 3, '1:00pm', 6);

INSERT INTO enrolls (student_id, course_id, sec_id, semester, year, grade)
VALUES
  (7488, 837827, 1, 1, 1900, 1.45),
  (7656, 837850, 2, 2, 1990, 4.04),
  (7824, 837873, 3, 3, 2000, 3.59),
  (7992, 837896, 4, 5, 2018, 5.00),
  (8160, 837919, 5, 3, 2020, 2.99);


INSERT INTO teaches (course_id, sec_id, semester, year, instructor_id)
VALUES
  (837827, 1, 1, 1900, 1),
  (837850, 2, 2, 1990, 2),
  (837873, 3, 3, 2000, 3),
  (837896, 4, 5, 2018, 4),
  (837919, 5, 3, 2020, 5);

INSERT INTO requires
VALUES
  (837827, 837827),
  (837850, 837850),
  (837873, 837873),
  (837896, 837896),
  (837919, 837919);


