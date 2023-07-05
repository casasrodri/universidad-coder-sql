-- TRANSACTION CONTROL LANGUAGE
SET autocommit=0;

-- 1) Tabla Alumnos: eliminación y luego COMMIT o ROLLBACK:
START TRANSACTION;
SELECT * FROM alumnos;
DELETE FROM alumnos WHERE legajo = 11;
SELECT * FROM alumnos;
-- ROLLBACK;
COMMIT;
SELECT * FROM alumnos;

-- 2) Tabla: Aulas: inserción de 8 registros usando savepoints.
START TRANSACTION;
INSERT INTO aulas (nombre, edificio, capacidad) VALUES ('Perro','Animales', 100);
INSERT INTO aulas (nombre, edificio, capacidad) VALUES ('Gato','Animales', 200);
INSERT INTO aulas (nombre, edificio, capacidad) VALUES ('Loro','Animales', 300);
INSERT INTO aulas (nombre, edificio, capacidad) VALUES ('Mono','Animales', 400);
SELECT * FROM aulas ORDER BY id DESC;
SAVEPOINT aulas_animales;

INSERT INTO aulas (nombre, edificio, capacidad) VALUES ('Plutón','Planetas', 500);
INSERT INTO aulas (nombre, edificio, capacidad) VALUES ('Mercurio','Planetas', 600);
INSERT INTO aulas (nombre, edificio, capacidad) VALUES ('Jupiter','Planetas', 700);
INSERT INTO aulas (nombre, edificio, capacidad) VALUES ('Saturno','Planetas', 800);
SELECT * FROM aulas ORDER BY id DESC;
SAVEPOINT aulas_planetas;

-- Ejemplo de cómo volvería al punto hasta donde se agregaron las aulas de animales.
--  dejando de lado las aulas de planetas.

-- ROLLBACK TO aulas_animales;
-- SELECT * FROM aulas ORDER BY id DESC;
-- COMMIT;

-- Línea comentada de eliminación del savepoint de los primeros 4 registros insertados:
-- RELEASE SAVEPOINT aulas_animales;

-- Para finalizar la transacción (alguna de las siguientes):
-- COMMIT;
-- ROLLBACK;
