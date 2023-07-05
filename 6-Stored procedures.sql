
-- STORED PROCEDURES

-- El presente SP hace una consulta a una tabla pasada por parámetro, ordenando por un campo pasado
-- también por parámetro. Asimismo, debe especificarse ASC o DESC para indicar el modo de orden.
-- En caso de estar vacío el modo de orden, se realizará un orden ascendente.
DELIMITER //
CREATE PROCEDURE OrdenarTabla(
  IN tabla VARCHAR(30),
  IN campo VARCHAR(30),
IN orden VARCHAR(4)
)
BEGIN
	-- Comienzo de la sentencia
	SET @query = 'SELECT * FROM ';

	-- Agregado de la tabla
	IF tabla = '' THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Se debe ingresar una tabla.';
	END IF;

	SET @query = CONCAT(@query, tabla);

	-- Agregado del campo
	IF campo = '' THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Se debe ingresar un campo de la tabla.';
	END IF;

	SET @query = CONCAT(@query, ' ORDER BY ', campo);

	-- Agregado del tipo de orden
	IF orden = '' or LOWER(orden) = 'asc' THEN
		SET @query = CONCAT(@query, ' ASC');
	ELSE
		SET @query = CONCAT(@query, ' DESC');
	END IF;

	-- Creación de la sentencia y ejecución
	PREPARE sentencia FROM @query;
	EXECUTE sentencia;
	DEALLOCATE PREPARE sentencia;
END //
DELIMITER ;

-- Ejemplos de uso:
CALL OrdenarTabla('alumnos', 'apellido', 'desc');
CALL OrdenarTabla('profesores', 'fecha_nac', 'asc');
CALL OrdenarTabla('carreras', 'nombre', '');



-- El siguiente SP devuelve en un parámetro de salida el promedio de las notas obtenidos por un alumno.
DELIMITER //
CREATE PROCEDURE CalcularPromedioAlumno(
 IN legajo SMALLINT,
 OUT promedio DECIMAL(4,2)
)
BEGIN
	SELECT AVG(nota) INTO promedio
	FROM calificaciones
	WHERE alumno_legajo = legajo;
END //
DELIMITER ;

-- Ejemplo de uso:
CALL CalcularPromedioAlumno(2, @promedio);
SELECT @promedio;


-- El presente SP registra una cobranza de una factura existente en la tabla facturas.
DELIMITER //
CREATE PROCEDURE RegistrarCobranza(
 IN fecha DATETIME,
 IN factura_id VARCHAR(13),
 IN medio_pago ENUM('Efectivo', 'Transferencia', 'Tarjeta de Crédito')
)
BEGIN
	INSERT INTO cobranzas (fecha, factura_id, medio_pago)
	VALUES (fecha, factura_id, medio_pago);
END //
DELIMITER ;

-- Ejemplo de uso:
CALL RegistrarCobranza('20230723', '0001-00001540', 'Transferencia');
SELECT * FROM cobranzas;


-- Este SP asigna otro profesor como director de carrera. Se le debe indicar la carrera a actualizar
-- y el nombre y apellido del profesor que asumirá el rol de director.
DELIMITER //
CREATE PROCEDURE CambiarDirectorCarrera(
 IN nombre_carrera VARCHAR(50),
 IN nombre_profesor VARCHAR(50),
 IN apellido_profesor VARCHAR(50)
)
BEGIN
	DECLARE legajo_profesor MEDIUMINT;
    DECLARE id_carrera INT;

	-- Determino el legajo del profesor
	SELECT legajo INTO legajo_profesor
	FROM profesores
	WHERE nombre = nombre_profesor AND apellido = apellido_profesor;

    -- Determino el id de la carrera
	SELECT id INTO id_carrera
	FROM carreras
	WHERE nombre = nombre_carrera;

    -- Actualizo la tabla
	UPDATE carreras
	SET director = legajo_profesor
	WHERE id = id_carrera;
END //
DELIMITER ;

-- Ejemplo de uso:
CALL CambiarDirectorCarrera('Medicina', 'Andrés', 'Torres');
SELECT * FROM carreras;
