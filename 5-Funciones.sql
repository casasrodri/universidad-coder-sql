-- Creación de funciones

DELIMITER //

-- Esta función devuelve un texto asociado a la nota obtenida por el alumno.
-- Se obtuvo la escala de ejemplo de la siguiente página (Facultad Ciencias Económicas).
-- https://www.eco.unc.edu.ar/reglamentaciones/#escala-de-calificaciones-ordenanza-n-482-2009
-- Ejemplos:
-- SELECT f_nota_texto(3) --> Insuficiente
-- SELECT f_nota_texto(8) --> Distinguido
-- SELECT f_nota_texto(10) --> Sobresaliente
CREATE FUNCTION f_nota_texto(nota SMALLINT)
RETURNS VARCHAR(15)
DETERMINISTIC
BEGIN
	CASE
		WHEN nota = 10 THEN RETURN 'Sobresaliente';
		WHEN nota >= 7 THEN RETURN 'Distinguido';
		WHEN nota >= 5 THEN RETURN 'Bueno';
		WHEN nota = 4 THEN RETURN 'Suficiente';
		WHEN nota >= 1 THEN RETURN 'Insuficiente';
		ELSE RETURN 'Reprobado';
    END CASE;
END//



-- Esta función cuenta la cantidad de materias aprobadas para un alumno dado,
-- en la determinada carrera. Se agrega la carrera porque el alumno puede estar
-- cursando más de una carrera.
-- Ejemplos:
-- SELECT f_materias_aprobadas(3, 'Comunicación Audiovisual') --> 1
-- SELECT f_materias_aprobadas(332, 'Comunicación Audiovisual') --> ERROR: No existe alumno 332
-- SELECT f_materias_aprobadas(3, 'Perro') --> ERROR: No existe carrera Perro
CREATE FUNCTION f_materias_aprobadas(legajo_alumno SMALLINT, carrera VARCHAR(50))
RETURNS SMALLINT
NOT DETERMINISTIC READS SQL DATA
BEGIN
	DECLARE existe_alumno INT;
    DECLARE existe_carrera INT;
    DECLARE mensaje_error TEXT;
	DECLARE cantidad SMALLINT;

    -- Comprobación de que el alumno existe
    SELECT COUNT(*) INTO existe_alumno
    FROM alumnos
    WHERE legajo = legajo_alumno;

    SET mensaje_error = CONCAT('No existe el alumno: ', legajo_alumno);

    IF existe_alumno = 0 THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = mensaje_error;
	END IF;

    -- Comprobación de que la carrera existe
	SELECT COUNT(*) INTO existe_carrera
    FROM carreras
    WHERE nombre = carrera;

    SET mensaje_error = CONCAT('No existe la carrera: ', carrera);

    IF existe_carrera = 0 THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = mensaje_error;
	END IF;

	SELECT COUNT(*) INTO cantidad
	FROM calificaciones cal
	JOIN materias mat ON cal.materia_id = mat.id
	JOIN carreras car ON mat.carrera_id = car.id
	WHERE
		cal.nota >= 4 AND
		cal.alumno_legajo = legajo_alumno AND
		car.nombre = carrera;

	RETURN cantidad;
END//
DELIMITER ;
