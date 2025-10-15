USE Universidad;
-- Retrieve all students with first surname, second surname, and name, ordered alphabetically
SELECT apellido1, apellido2, nombre
FROM persona
WHERE tipo = 'alumno'
ORDER BY apellido1 ASC, apellido2 ASC, nombre ASC;

-- Retrieve students who have not provided their phone number
SELECT nombre, apellido1, apellido2
FROM persona
WHERE tipo = 'alumno' AND telefono IS NULL
ORDER BY apellido1, apellido2, nombre;

-- Retrieve students born in 1999
SELECT nombre, apellido1, apellido2
FROM persona
WHERE tipo = 'alumno' AND YEAR(fecha_nacimiento) = 1999
ORDER BY apellido1, apellido2, nombre;

-- Retrieve professors with no phone number and NIF ending with 'K'
SELECT nombre, apellido1, apellido2, nif
FROM persona
WHERE tipo = 'profesor' AND telefono IS NULL AND nif LIKE '%K'
ORDER BY apellido1, apellido2, nombre;

-- Retrieve subjects taught in semester 1, year 3, for the degree with id=7
SELECT nombre
FROM asignatura
WHERE cuatrimestre = 1 AND curso = 3 AND id_grado = 7
ORDER BY nombre;

-- Retrieve all professors along with their department name
SELECT p.apellido1, p.apellido2, p.nombre, d.nombre AS departamento
FROM persona p
JOIN profesor pr ON p.id = pr.id_profesor
JOIN departamento d ON pr.id_departamento = d.id
WHERE p.tipo = 'profesor'
ORDER BY p.apellido1 ASC, p.apellido2 ASC, p.nombre ASC;

-- Retrieve subjects and academic year for student with NIF '26902806M'
SELECT a.nombre, c.anyo_inicio, c.anyo_fin
FROM asignatura a
JOIN alumno_se_matricula_asignatura m ON a.id = m.id_asignatura
JOIN curso_escolar c ON m.id_curso_escolar = c.id
JOIN persona p ON m.id_alumno = p.id
WHERE p.nif = '26902806M'
ORDER BY a.nombre;

-- Retrieve all departments that have professors teaching subjects in the 'Grado en Ingeniería Informática (Plan 2015)'
SELECT DISTINCT d.nombre
FROM departamento d
JOIN profesor pr ON d.id = pr.id_departamento
JOIN asignatura a ON pr.id_profesor = a.id_profesor
JOIN grado g ON a.id_grado = g.id
WHERE g.nombre = 'Grado en Ingeniería Informática (Plan 2015)'
ORDER BY d.nombre;

-- Retrieve all students enrolled in any subject in the academic year 2018/2019
SELECT DISTINCT p.nombre, p.apellido1, p.apellido2
FROM persona p
JOIN alumno_se_matricula_asignatura m ON p.id = m.id_alumno
JOIN curso_escolar c ON m.id_curso_escolar = c.id
WHERE c.anyo_inicio = 2018 AND c.anyo_fin = 2019
ORDER BY p.apellido1, p.apellido2, p.nombre;

-- List all professors and their departments, including professors without a department
SELECT d.nombre AS departamento, p.apellido1, p.apellido2, p.nombre
FROM profesor pr
LEFT JOIN persona p ON pr.id_profesor = p.id
LEFT JOIN departamento d ON pr.id_departamento = d.id
ORDER BY d.nombre ASC, p.apellido1 ASC, p.apellido2 ASC, p.nombre ASC;

-- List professors who are not associated with any department
SELECT p.nombre, p.apellido1, p.apellido2
FROM profesor pr
LEFT JOIN departamento d ON pr.id_departamento = d.id
JOIN persona p ON pr.id_profesor = p.id
WHERE d.id IS NULL
ORDER BY p.apellido1, p.apellido2, p.nombre;

-- List departments without any associated professors
SELECT d.nombre
FROM departamento d
LEFT JOIN profesor pr ON d.id = pr.id_departamento
WHERE pr.id_profesor IS NULL
ORDER BY d.nombre;

-- List professors who do not teach any subject
SELECT p.nombre, p.apellido1, p.apellido2
FROM persona p
LEFT JOIN profesor pr ON p.id = pr.id_profesor
LEFT JOIN asignatura a ON pr.id_profesor = a.id_profesor
WHERE a.id_profesor IS NULL AND p.tipo='profesor'
ORDER BY p.apellido1, p.apellido2, p.nombre;

-- List subjects without any assigned professor
SELECT nombre
FROM asignatura
WHERE id_profesor IS NULL
ORDER BY nombre;

-- List departments that have not taught any subjects in any academic year
SELECT DISTINCT d.nombre
FROM departamento d
LEFT JOIN profesor pr ON d.id = pr.id_departamento
LEFT JOIN asignatura a ON pr.id_profesor = a.id_profesor
WHERE a.id IS NULL
ORDER BY d.nombre;

-- Retrieve the total number of students
SELECT COUNT(*) AS total_alumnos
FROM persona
WHERE tipo = 'alumno';

-- Count how many students were born in 1999
SELECT COUNT(*) AS alumnos_1999
FROM persona
WHERE tipo = 'alumno' AND YEAR(fecha_nacimiento) = 1999;

-- Count the number of professors in each department (only departments with professors), ordered descending
SELECT d.nombre AS departamento, COUNT(pr.id_profesor) AS numero_profesores
FROM departamento d
JOIN profesor pr ON d.id = pr.id_departamento
GROUP BY d.id
ORDER BY numero_profesores DESC;

-- List all departments with the number of professors (including departments with zero professors)
SELECT d.nombre AS departamento, COUNT(pr.id_profesor) AS numero_profesores
FROM departamento d
LEFT JOIN profesor pr ON d.id = pr.id_departamento
GROUP BY d.id
ORDER BY d.nombre;

-- List all degrees and the number of subjects they have (including degrees with zero subjects), ordered descending
SELECT g.nombre AS grado, COUNT(a.id) AS numero_asignaturas
FROM grado g
LEFT JOIN asignatura a ON g.id = a.id_grado
GROUP BY g.id
ORDER BY numero_asignaturas DESC;

-- List degrees with more than 40 subjects
SELECT g.nombre AS grado, COUNT(a.id) AS numero_asignaturas
FROM grado g
LEFT JOIN asignatura a ON g.id = a.id_grado
GROUP BY g.id
HAVING COUNT(a.id) > 40
ORDER BY numero_asignaturas DESC;

-- Show degree name, type of subject, and sum of credits per type
SELECT g.nombre AS grado, a.tipo, SUM(a.creditos) AS total_creditos
FROM grado g
JOIN asignatura a ON g.id = a.id_grado
GROUP BY g.id, a.tipo
ORDER BY g.nombre, a.tipo;

-- Count how many students are enrolled in each academic year
SELECT c.anyo_inicio, COUNT(DISTINCT m.id_alumno) AS numero_alumnos
FROM curso_escolar c
LEFT JOIN alumno_se_matricula_asignatura m ON c.id = m.id_curso_escolar
GROUP BY c.id
ORDER BY c.anyo_inicio;

-- List the number of subjects each professor teaches, including professors with zero subjects, ordered descending
SELECT p.id, p.nombre, p.apellido1, p.apellido2, COUNT(a.id) AS numero_asignaturas
FROM persona p
LEFT JOIN profesor pr ON p.id = pr.id_profesor
LEFT JOIN asignatura a ON pr.id_profesor = a.id_profesor
WHERE p.tipo='profesor'
GROUP BY p.id
ORDER BY numero_asignaturas DESC;

-- Retrieve all data of the youngest student
SELECT *
FROM persona
WHERE tipo='alumno'
ORDER BY fecha_nacimiento DESC
LIMIT 1;

-- List professors who have a department but do not teach any subject
SELECT p.nombre, p.apellido1, p.apellido2, d.nombre AS departamento
FROM persona p
JOIN profesor pr ON p.id = pr.id_profesor
JOIN departamento d ON pr.id_departamento = d.id
LEFT JOIN asignatura a ON pr.id_profesor = a.id_profesor
WHERE a.id_profesor IS NULL
ORDER BY p.apellido1, p.apellido2, p.nombre;
