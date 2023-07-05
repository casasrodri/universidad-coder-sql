-- TRIGGERS

-- Trigger usando el evento BEFORE
-- Este trigger analiza la validez de la nota (rango entre 0 y 10), y setea el campo aprobado, considerando que con 4 ya se obtiene dicha condición.
DELIMITER ||
CREATE TRIGGER notas
BEFORE INSERT ON calificaciones
FOR EACH ROW
BEGIN
	IF NEW.nota < 0 THEN
		SET NEW.nota = 0;
	ELSEIF NEW.nota > 10 THEN
		SET NEW.nota = 10;
	END IF;

    IF NEW.nota >= 4 THEN
		SET NEW.aprobado = 1;
	ELSE
		SET NEW.aprobado = 0;
	END IF;
END||
DELIMITER ;

-- Ejemplo de uso:
INSERT INTO calificaciones (alumno_legajo, materia_id, profesor_legajo, aula_id, fecha_examen, nota)
VALUES
	(1,1,1,1,'2023-09-30',-1),
    (1,1,1,1,'2023-09-30',38),
    (1,1,1,1,'2023-09-30',3),
    (1,1,1,1,'2023-09-30',8)
;

SELECT * FROM calificaciones ORDER BY id DESC;

-- Trigger tipo Log, tabla: Alumnos, evento: AFTER
-- El presente trigger registra sólo las modificaciones que sufre cada registro y campo de la tabla alumnos.
-- Aclaración: no registra inserciones ni eliminaciones.
CREATE TABLE log_modif_alumnos (
	legajo INT,
    campo_modificado VARCHAR(40),
    valor_nuevo VARCHAR(50),
    valor_anterior VARCHAR(50),
    fecha_hora TIMESTAMP,
    usuario VARCHAR(50)
);

DELIMITER ||
CREATE TRIGGER modif_alumnos
AFTER UPDATE ON alumnos
FOR EACH ROW
BEGIN
	SET @fecha_hora = NOW();
    SET @usuario = USER();

	IF NEW.nombre != OLD.nombre THEN
		INSERT INTO log_modif_alumnos
			(legajo, campo_modificado, valor_nuevo, valor_anterior, fecha_hora, usuario)
		VALUES
			(NEW.legajo, 'nombre', NEW.nombre, OLD.nombre, @fecha_hora, @usuario);
	END IF;

	IF NEW.apellido != OLD.apellido THEN
		INSERT INTO log_modif_alumnos
			(legajo, campo_modificado, valor_nuevo, valor_anterior, fecha_hora, usuario)
		VALUES
			(NEW.legajo, 'apellido', NEW.apellido, OLD.apellido, @fecha_hora, @usuario);
	END IF;

	IF NEW.fecha_nac != OLD.fecha_nac THEN
		INSERT INTO log_modif_alumnos
			(legajo, campo_modificado, valor_nuevo, valor_anterior, fecha_hora, usuario)
		VALUES
			(NEW.legajo, 'fecha_nac', NEW.fecha_nac, OLD.fecha_nac, @fecha_hora, @usuario);
	END IF;

	IF NEW.sexo != OLD.sexo THEN
		INSERT INTO log_modif_alumnos
			(legajo, campo_modificado, valor_nuevo, valor_anterior, fecha_hora, usuario)
		VALUES
			(NEW.legajo, 'sexo', NEW.sexo, OLD.sexo, @fecha_hora, @usuario);
	END IF;

	IF NEW.sexo != OLD.sexo THEN
		INSERT INTO log_modif_alumnos
			(legajo, campo_modificado, valor_nuevo, valor_anterior, fecha_hora, usuario)
		VALUES
			(NEW.legajo, 'sexo', NEW.sexo, OLD.sexo, @fecha_hora, @usuario);
	END IF;

    IF NEW.email != OLD.email THEN
		INSERT INTO log_modif_alumnos
			(legajo, campo_modificado, valor_nuevo, valor_anterior, fecha_hora, usuario)
		VALUES
			(NEW.legajo, 'email', NEW.email, OLD.email, @fecha_hora, @usuario);
	END IF;

    IF NEW.telefono != OLD.telefono THEN
		INSERT INTO log_modif_alumnos
			(legajo, campo_modificado, valor_nuevo, valor_anterior, fecha_hora, usuario)
		VALUES
			(NEW.legajo, 'telefono', NEW.telefono, OLD.telefono, @fecha_hora, @usuario);
	END IF;

    IF NEW.provincia_id != OLD.provincia_id THEN
		INSERT INTO log_modif_alumnos
			(legajo, campo_modificado, valor_nuevo, valor_anterior, fecha_hora, usuario)
		VALUES
			(NEW.legajo, 'provincia_id', NEW.provincia_id, OLD.provincia_id, @fecha_hora, @usuario);
	END IF;

END||
DELIMITER ;

-- Ejemplos de uso:
SELECT * FROM log_modif_alumnos;
UPDATE alumnos SET nombre = 'Rodrigo' WHERE legajo = 3;
SELECT * FROM log_modif_alumnos;
UPDATE alumnos SET apellido = 'Casas', email = 'rodri@gmail.com' WHERE legajo = 3;
SELECT * FROM log_modif_alumnos;

-- Trigger tipo Log, tabla: Materias, evento: AFTER
-- El presente trigger registra los eventos realizados sobre cada id de la tabla materias.
-- Aclaración: no registra valores anteriores y nuevos.
CREATE TABLE log_tablas (
	id SERIAL,
	entidad VARCHAR(40),
    entidad_id VARCHAR(40),
    operacion VARCHAR(6),
    fecha DATE,
    hora TIME,
    usuario VARCHAR(50)
);

CREATE PROCEDURE RegistrarEntradaLog(
 IN entidad VARCHAR(40),
 IN entidad_id VARCHAR(40),
 IN operacion VARCHAR(6)
)
INSERT INTO log_tablas (entidad, entidad_id, operacion, fecha, hora, usuario)
VALUES (entidad, entidad_id, operacion, CURDATE(), CURTIME(), USER());

-- Ejemplo de registración de entrada en log
CALL RegistrarEntradaLog('préstamos', '2', 'DELETE');


-- Se crean los triggers para la tabla materias
CREATE TRIGGER log_insert_materias
AFTER INSERT ON materias
FOR EACH ROW
CALL RegistrarEntradaLog('materias', NEW.id, 'INSERT');

CREATE TRIGGER log_update_materias
AFTER UPDATE ON materias
FOR EACH ROW
CALL RegistrarEntradaLog('materias', NEW.id, 'UPDATE');

CREATE TRIGGER log_delete_materias
AFTER DELETE ON materias
FOR EACH ROW
CALL RegistrarEntradaLog('materias', OLD.id, 'DELETE');

-- Prueba de funcionamiento
INSERT INTO materias (nombre, puntos, sem_dict, carrera_id)VALUES ('Matemática Avanzada', 30, '1', 1);
UPDATE materias SET nombre = 'Derecho Laboral' WHERE id = 3;
SET @ultimo_id = (SELECT id FROM materias ORDER BY id DESC LIMIT 1);
SELECT @ultimo_id;
DELETE FROM materias WHERE id = @ultimo_id;
SELECT * FROM log_tablas;
