-- Borrado para crear nuevamente
DROP DATABASE IF EXISTS universidad;

-- Creación esquema:
CREATE SCHEMA IF NOT EXISTS Universidad;
USE Universidad;

-- Creación de tablas:
CREATE TABLE IF NOT EXISTS PROVINCIAS (	
	id TINYINT AUTO_INCREMENT,
	nombre VARCHAR(60) NOT NULL,
	habitantes BIGINT,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS AULAS (
    id SMALLINT AUTO_INCREMENT,
    nombre VARCHAR(30),
    edificio VARCHAR(20),
    capacidad SMALLINT,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS PROFESORES (	
	legajo MEDIUMINT AUTO_INCREMENT,
	nombre VARCHAR(50) NOT NULL,
	apellido VARCHAR(50) NOT NULL,
	fecha_nac DATE,
	sexo ENUM('F', 'M', 'X'),
	email VARCHAR(50),
	telefono BIGINT,
	profesion VARCHAR(50),
	tipo_jornada ENUM('Full-Time', 'Part-Time'),
	direccion VARCHAR(50),
	provincia_id TINYINT,
    PRIMARY KEY (legajo),
    FOREIGN KEY (provincia_id) REFERENCES provincias(id)
);

CREATE TABLE IF NOT EXISTS ALUMNOS (	
	legajo INT AUTO_INCREMENT,
	nombre VARCHAR(50) NOT NULL,
	apellido VARCHAR(50) NOT NULL,
	fecha_nac DATE,
	sexo ENUM('F', 'M', 'X'),
	email VARCHAR(50),
	telefono BIGINT,
	provincia_id TINYINT,
	PRIMARY KEY (legajo),
    FOREIGN KEY (provincia_id) REFERENCES provincias(id)	
);	

CREATE TABLE IF NOT EXISTS CARRERAS (	
	id TINYINT AUTO_INCREMENT,
	nombre VARCHAR(50) NOT NULL,
	puntos INT,
	director MEDIUMINT NOT NULL,
	plan_vigente VARCHAR(40),
	PRIMARY KEY (id),
    FOREIGN KEY (director) REFERENCES profesores(legajo)
);	

CREATE TABLE IF NOT EXISTS MATERIAS (	
	id SMALLINT AUTO_INCREMENT,
	nombre VARCHAR(50) NOT NULL,
	puntos INT,
	sem_dict ENUM('1', '2'),
	carrera_id TINYINT NOT NULL,
	PRIMARY KEY (id),
    FOREIGN KEY (carrera_id) REFERENCES carreras(id)
);	

CREATE TABLE IF NOT EXISTS MATRICULAS (	
	id INT AUTO_INCREMENT,
	alumno_legajo INT,
	fecha DATETIME,
	semestre ENUM('1', '2'),
	per_lectivo SMALLINT,
	importe DECIMAL(10,2) DEFAULT 0,
	PRIMARY KEY (id, alumno_legajo, semestre, per_lectivo),
    FOREIGN KEY (alumno_legajo) REFERENCES alumnos(legajo)
);	

CREATE TABLE IF NOT EXISTS FACTURAS (	
	factura VARCHAR(13),
	alumno_legajo INT NOT NULL,
	fecha DATETIME,
	tipo_factura ENUM('A', 'B'),
	PRIMARY KEY (factura),
    FOREIGN KEY (alumno_legajo) REFERENCES alumnos(legajo)
);	

CREATE TABLE IF NOT EXISTS MATRICULAS_FACTURADAS (	
	id INT AUTO_INCREMENT,
	matricula_id INT NOT NULL,
	factura_id VARCHAR(13) NOT NULL,
	PRIMARY KEY (id),
    FOREIGN KEY (matricula_id) REFERENCES matriculas(id),
    FOREIGN KEY (factura_id) REFERENCES facturas(factura)
);	

CREATE TABLE IF NOT EXISTS COBRANZAS (	
	id BIGINT AUTO_INCREMENT,
	factura_id VARCHAR(13) NOT NULL,
	fecha DATETIME,
	medio_pago ENUM('Efectivo', 'Transferencia', 'Tarjeta de Crédito'), 
	PRIMARY KEY (id),
	FOREIGN KEY (factura_id) REFERENCES facturas(factura)
);

CREATE TABLE IF NOT EXISTS CURSADAS (	
	id INT AUTO_INCREMENT,
	alumno_legajo INT NOT NULL,
	materia_id SMALLINT NOT NULL,
	profesor_legajo MEDIUMINT NOT NULL,
	aula_id SMALLINT NOT NULL,
	fecha_inscripcion DATETIME,
	semestre ENUM('1', '2'),
	per_lectivo SMALLINT,
	condicion ENUM('Promoción', 'Regular', 'Libre'),
	PRIMARY KEY (id, alumno_legajo, materia_id, semestre, per_lectivo),
	FOREIGN KEY (alumno_legajo) REFERENCES alumnos(legajo),
	FOREIGN KEY (materia_id) REFERENCES materias(id),
	FOREIGN KEY (profesor_legajo) REFERENCES profesores(legajo),
    FOREIGN KEY (aula_id) REFERENCES aulas(id)
);

CREATE TABLE IF NOT EXISTS CALIFICACIONES (	
	id INT AUTO_INCREMENT,
	alumno_legajo INT NOT NULL,
	materia_id SMALLINT NOT NULL,
	profesor_legajo MEDIUMINT NOT NULL,
	aula_id SMALLINT NOT NULL,
	fecha_examen DATETIME,
    nota SMALLINT NOT NULL,
	aprobado BOOLEAN,
	PRIMARY KEY (id),
	FOREIGN KEY (alumno_legajo) REFERENCES alumnos(legajo),
	FOREIGN KEY (materia_id) REFERENCES materias(id),
	FOREIGN KEY (profesor_legajo) REFERENCES profesores(legajo),
    FOREIGN KEY (aula_id) REFERENCES aulas(id)
);

-- INSERCIÓN DE DATOS
INSERT INTO PROVINCIAS (nombre, habitantes) 
VALUES
	('Buenos Aires', 17446000),
	('Catamarca', 406000),
	('Chaco', 1356000),
	('Chubut', 615000),
	('Ciudad Autónoma de Buenos Aires', 2890000),
	('Córdoba', 3670000),
	('Corrientes', 1102000),
	('Entre Ríos', 1285000),
	('Formosa', 640000),
	('Jujuy', 780000),
	('La Pampa', 369000),
	('La Rioja', 398000),
	('Mendoza', 2054000),
	('Misiones', 1291000),
	('Neuquén', 677000),
	('Río Negro', 747000),
	('Salta', 1697000),
	('San Juan', 771000),
	('San Luis', 497000),
	('Santa Cruz', 373000),
	('Santa Fe', 3529000),
	('Santiago del Estero', 995000),
	('Tierra del Fuego, Antártida e Islas del Atlántico Sur', 180000),
	('Tucumán', 1623000)
;

INSERT INTO AULAS (nombre, edificio, capacidad) 
VALUES
	('Juan Domingo Perón', 'Principal', 131),
	('Eva Perón', 'Principal', 281),
	('Manuel Belgrano', 'Principal', 267),
	('José de San Martín', 'Principal', 309),
	('Domingo Faustino Sarmiento', 'Principal', 474),
	('María Eva Duarte de Perón', 'Principal', 436),
	('Carlos Gardel', 'Aulas A', 90),
	('Jorge Luis Borges', 'Aulas A', 34),
	('René Favaloro', 'Aulas A', 379),
	('Che Guevara', 'Aulas A', 165),
	('Julio Cortázar', 'Aulas A', 184),
	('Mercedes Sosa', 'Aulas A', 207),
	('Juan Manuel Fangio', 'Aulas B', 65),
	('Lionel Messi', 'Aulas B', 149),
	('Diego Maradona', 'Aulas B', 107)
;

INSERT INTO PROFESORES (nombre, apellido, fecha_nac, sexo, email, telefono, profesion, tipo_jornada, direccion, provincia_id)
VALUES
	('Juan', 'García', '19811024', 'M', 'j.garcia@universidad.com', 3515872339, 'Médico', 'Full-Time', 'Calle Rosario, 123', 16),
	('María', 'López', '19901111', 'F', 'm.lopez@universidad.com', 3516591826, 'Ingeniero', 'Full-Time', 'Avenida del Sol, 456', 17),
	('Carlos', 'Rodríguez', '19620607', 'M', 'c.rodriguez@universidad.com', 3515688117, 'Abogado', 'Part-Time', 'Calle Primavera, 789', 14),
	('Laura', 'Martínez', '19850930', 'F', 'l.martinez@universidad.com', 3516289377, 'Profesor', 'Full-Time', 'Paseo de los Pinos, 234', 15),
	('José', 'González', '19671012', 'M', 'j.gonzalez@universidad.com', 3516361643, 'Arquitecto', 'Full-Time', 'Avenida Libertad, 567', 12),
	('Ana', 'Fernández', '19860418', 'F', 'a.fernandez@universidad.com', 3516516586, 'Diseñador gráfico', 'Full-Time', 'Calle Mayor, 890', 10),
	('Pedro', 'Sánchez', '19850908', 'M', 'p.sanchez@universidad.com', 3516257428, 'Contador', 'Full-Time', 'Avenida de la Luna, 1234', 11),
	('Isabel', 'Ramírez', '19960130', 'F', 'i.ramirez@universidad.com', 3515321747, 'Programador de software', 'Full-Time', 'Calle del Mar, 5678', 18),
	('Andrés', 'Torres', '19671224', 'M', 'a.torres@universidad.com', 3516322878, 'Psicólogo', 'Full-Time', 'Avenida de los Robles, 9012', 18),
	('Carmen', 'Vargas', '19811117', 'F', 'c.vargas@universidad.com', 3515469091, 'Contador', 'Full-Time', 'Calle de la Paz, 3456', 18),
	('Francisco', 'Medina', '19630111', 'X', 'f.medina@universidad.com', 3516217810, 'Médico', 'Full-Time', 'Avenida del Parque, 7890', 20),
	('Elena', 'Castro', '19831102', 'F', 'e.castro@universidad.com', 3515258325, 'Ingeniero', 'Full-Time', 'Calle San Juan, 12345', 10),
	('Luis', 'Morales', '19620924', 'M', 'l.morales@universidad.com', 3515501428, null, 'Part-Time', 'Avenida de la Montaña, 67890', 19),
	('Marta', 'Ortega', '19730419', 'F', 'm.ortega@universidad.com', 3516883068, 'Profesor', 'Full-Time', 'Calle del Río, 123456', 8),
	('Antonio', 'Herrera', '19950111', 'M', 'a.herrera@universidad.com', 3515295386, 'Arquitecto', 'Full-Time', 'Avenida de la Estrella, 7profesores89012', 11),
	('Carolina', 'Ruiz', '19720526', 'F', 'c.ruiz@universidad.com', 3516971308, 'Diseñador gráfico', 'Full-Time', 'Calle de los Olivos, 345678', 9),
	('Manuel', 'Silva', '19680709', 'M', 'm.silva@universidad.com', 3515959691, 'Contador', 'Part-Time', 'Avenida del Bosque, 901234', 24),
	('Julia', 'Paredes', '19930804', 'X', 'j.paredes@universidad.com', 3516928842, 'Programador de software', 'Full-Time', 'Calle del Carmen, 567890', 21),
	('Miguel', 'Mendoza', '19780303', 'M', 'm.mendoza@universidad.com', 3515504102, 'Psicólogo', 'Full-Time', 'Avenida de la Fuente, 1234567', 12),
	('Paula', 'Jiménez', '19860426', 'F', 'p.jimenez@universidad.com', 3516244547, 'Contador', 'Full-Time', 'Calle del Sol, 8901234', 11)
;

INSERT INTO ALUMNOS (nombre, apellido, fecha_nac, sexo, email, telefono, provincia_id)
VALUES
	('Sofía', 'García', '20010821', 'F', 'sofia_garcia@gmail.com', 3516864233, 9),
	('Mateo', 'Rodríguez', '19961022', 'M', 'mateo_rodriguez@gmail.com', 3516611277, 11),
	('Valentina', 'López', '20010819', 'F', 'valentina_lopez@gmail.com', 3515846713, 10),
	('Santiago', 'Martínez', '20010605', 'M', 'santiago_martinez@gmail.com', 3515788754, 4),
	('Isabella', 'Gómez', '20010516', 'F', 'isabella_gomez@gmail.com', 3515113189, 7),
	('Leonardo', 'Hernández', '19990412', 'M', 'leonardo_hernandez@gmail.com', 3515188794, 22),
	('Camila', 'Pérez', '19971210', 'F', 'camila_perez@gmail.com', 3516855290, 9),
	('Sebastián', 'González', '19960208', 'M', 'sebastian_gonzalez@gmail.com', 3515706084, 19),
	('Valeria', 'Torres', '19990428', 'F', 'valeria_torres@gmail.com', 3515896108, 14),
	('Nicolás', 'Díaz', '19990502', 'M', 'nicolas_diaz@gmail.com', 3516093676, 17),
	('Luciana', 'Silva', '19970129', 'F', 'luciana_silva@gmail.com', 3516655337, 24),
	('Emiliano', 'Rojas', '19991013', 'M', 'emiliano_rojas@gmail.com', 3516927826, 10),
	('Renata', 'Vargas', '20010730', 'F', 'renata_vargas@gmail.com', 3516638240, 17),
	('Facundo', 'Medina', '19951211', 'M', 'facundo_medina@gmail.com', 3515879081, 5),
	('Martina', 'Suárez', '20000718', 'F', 'martina_suarez@gmail.com', 3515467296, 2),
	('Daniel', 'Castro', '20010710', 'M', 'daniel_castro@gmail.com', 3515740947, 3),
	('Gabriela', 'Ortega', '19970714', 'F', 'gabriela_ortega@gmail.com', 3516083193, 5),
	('Andrés', 'Flores', '19970704', 'M', 'andres_flores@gmail.com', 3516236328, 10),
	('Victoria', 'Sanchez', '19980511', 'F', 'victoria_sanchez@gmail.com', 3516668235, 9),
	('Alejandro', 'Mendoza', '19990507', 'M', 'alejandro_mendoza@gmail.com', 3515619653, 15)
;

INSERT INTO CARRERAS (nombre, puntos, director, plan_vigente)
VALUES
	('Medicina', 136, 6, 'Plan 2010 - Res. HCD 2675/2010'),
	('Ingeniería Civil', 144, 18, 'Plan 2022 - Res. HCD 2891/2022'),
	('Derecho', 105, 19, 'Plan 2015 - Res. HCD 2623/2015'),
	('Psicología', 122, 14, 'Plan 2023 - Res. HCD 2488/2023'),
	('Administración de Empresas', 147, 14, 'Plan 2009 - Res. HCD 3051/2009'),
	('Arquitectura', 120, 6, 'Plan 2017 - Res. HCD 3379/2017'),
	('Ciencias de la Computación', 165, 19, 'Plan 2016 - Res. HCD 3367/2016'),
	('Marketing', 131, 8, 'Plan 2012 - Res. HCD 2862/2012'),
	('Comunicación Audiovisual', 198, 18, 'Plan 2016 - Res. HCD 2750/2016'),
	('Biología', 142, 18, 'Plan 2016 - Res. HCD 3391/2016')
;

INSERT INTO MATERIAS (nombre, puntos, sem_dict, carrera_id)
VALUES
	('Anatomía', 36, '1', 1),
	('Farmacología I', 28, '1', 1),
	('Materiales constructivos', 45, '1', 2),
	('Leyes impositivas', 24, '2', 3),
	('Derecho procesal', 50, '2', 3),
	('Derecho penal I', 29, '1', 3),
	('Derecho penal II', 47, '2', 3),
	('Aspectos cognitivos', 24, '2', 4),
	('Derecho del paciente', 38, '1', 4),
	('Economía', 47, '1', 5),
	('Diseño de viviendas rurales', 36, '1', 6),
	('Análisis y diseño de software', 31, '1', 7),
	('Ventas online', 42, '2', 8),
	('Cine y televisión', 43, '1', 9),
	('Fauna y biomas I', 30, '1', 10),
	('Vida subacuática II', 37, '1', 10)
;

INSERT INTO MATRICULAS (alumno_legajo, fecha, semestre, per_lectivo, importe)
VALUES
	(2, '20220321', '1', 2022, 67679.27),
	(10, '20220314', '1', 2022, 63533.81),
	(16, '20220326', '1', 2022, 78551.32),
	(13, '20220323', '1', 2022, 98423.47),
	(9, '20220301', '1', 2022, 69033.59),
	(5, '20220306', '1', 2022, 79542.13),
	(2, '20220316', '1', 2022, 95465.07),
	(16, '20220307', '1', 2022, 85928.64),
	(12, '20220304', '1', 2022, 99785.98),
	(18, '20220330', '1', 2022, 92715.83),
	(13, '20220331', '1', 2022, 85308.65),
	(9, '20220305', '1', 2022, 86791.38),
	(6, '20220330', '1', 2022, 89380.68),
	(2, '20220625', '2', 2022, 93468.57),
	(12, '20220701', '2', 2022, 114455.58),
	(12, '20220627', '2', 2022, 95381.33),
	(5, '20220602', '2', 2022, 98001.14),
	(5, '20220630', '2', 2022, 93477.61),
	(4, '20220612', '2', 2022, 93001.3),
	(9, '20220607', '2', 2022, 108967.13),
	(3, '20220628', '2', 2022, 119952.24),
	(17, '20220604', '2', 2022, 116388.79),
	(1, '20220606', '2', 2022, 110061.16),
	(7, '20220607', '2', 2022, 103845.98),
	(17, '20220613', '2', 2022, 98198.62),
	(20, '20220610', '2', 2022, 102156.13),
	(16, '20230302', '1', 2023, 103256.1),
	(8, '20230326', '1', 2023, 101316.04),
	(9, '20230310', '1', 2023, 107718.75),
	(13, '20230327', '1', 2023, 104400.51),
	(18, '20230320', '1', 2023, 145523.37),
	(1, '20230401', '1', 2023, 120529.05),
	(9, '20230324', '1', 2023, 142076.97),
	(7, '20230321', '1', 2023, 107312.41),
	(12, '20230309', '1', 2023, 110357.8),
	(20, '20230328', '1', 2023, 100932.43),
	(12, '20230310', '1', 2023, 122896.15),
	(3, '20230320', '1', 2023, 146675.72),
	(9, '20230321', '1', 2023, 108175.27),
	(19, '20230303', '1', 2023, 108568.39),
	(7, '20230319', '1', 2023, 116432.33),
	(4, '20230305', '1', 2023, 145377.68),
	(1, '20230313', '1', 2023, 136699.33)
;

INSERT INTO FACTURAS (factura, alumno_legajo, fecha, tipo_factura)
VALUES
	('0001-00007062', 2, '20220702', 'B'),
	('0001-00005046', 5, '20230316', 'B'),
	('0001-00002829', 18, '20220406', 'B'),
	('0001-00001715', 20, '20220617', 'B'),
	('0001-00002883', 9, '20220614', 'A'),
	('0001-00003297', 3, '20230327', 'B'),
	('0001-00003642', 12, '20220311', 'B'),
	('0001-00004227', 16, '20230309', 'A'),
	('0001-00001383', 19, '20230310', 'A'),
	('0001-00001540', 4, '20230312', 'B'),
    ('0001-00009999', 18, '20220407', 'B')
;

INSERT INTO MATRICULAS_FACTURADAS (matricula_id,  factura_id)
VALUES
	(8, '0001-00007062'),
	(14, '0001-00007062'),
	(6, '0001-00005046'),
	(35, '0001-00005046'),
	(10, '0001-00001715'),
	(26, '0001-00002883'),
	(17, '0001-00003297'),
	(20, '0001-00003297'),
	(38, '0001-00003642'),
	(21, '0001-00003642'),
	(9, '0001-00004227'),
	(11, '0001-00001383'),
	(27, '0001-00001383'),
	(40, '0001-00001540'),
	(42, '0001-00002829'),
	(19, '0001-00002829'),
    (42, '0001-00009999')
;

INSERT INTO COBRANZAS (factura_id, fecha, medio_pago)
VALUES
	('0001-00001383', '20230322', 'Transferencia'),
	('0001-00002829', '20220406', 'Tarjeta de Crédito'),
	('0001-00002883', '20220618', 'Transferencia'),
	('0001-00003297', '20230401', 'Tarjeta de Crédito'),
	('0001-00005046', '20230318', 'Efectivo'),
	('0001-00007062', '20220831', 'Transferencia'),
	('0001-00009999', '20220409', 'Transferencia')
;

INSERT INTO CURSADAS (alumno_legajo, materia_id, profesor_legajo, aula_id, fecha_inscripcion, semestre, per_lectivo, condicion)
VALUES
	(16, 5, 19, 7, '20220402', '1', 2022, 'Promoción'),
	(19, 1, 20, 13, '20220406', '1', 2022, 'Libre'),
	(3, 10, 3, 9, '20220326', '1', 2022, 'Regular'),
	(8, 7, 4, 12, '20220325', '1', 2022, 'Regular'),
	(1, 10, 17, 6, '20220323', '1', 2022, 'Libre'),
	(4, 12, 19, 15, '20220703', '2', 2022, 'Promoción'),
	(8, 2, 14, 7, '20220710', '2', 2022, 'Libre'),
	(15, 11, 13, 8, '20220710', '2', 2022, 'Regular'),
	(17, 6, 18, 8, '20220704', '2', 2022, 'Promoción'),
	(1, 1, 16, 5, '20220625', '2', 2022, 'Libre'),
	(15, 10, 4, 11, '20230406', '1', 2023, 'Promoción'),
	(6, 1, 4, 2, '20230402', '1', 2023, 'Regular'),
	(9, 3, 10, 4, '20230325', '1', 2023, 'Libre'),
	(2, 2, 15, 8, '20230405', '1', 2023, 'Promoción'),
	(3, 13, 4, 2, '20230403', '1', 2023, 'Libre')
;

INSERT INTO CALIFICACIONES (alumno_legajo, materia_id, profesor_legajo, aula_id, fecha_examen, nota, aprobado)
VALUES
	(7, 12, 14, 7, '20230215', 9, true),
	(14, 1, 18, 6, '20220916', 10, true),
	(16, 15, 10, 10, '20230511', 2, false),
	(20, 5, 11, 4, '20220708', 6, true),
	(1, 15, 1, 1, '20221103', 4, true),
	(15, 1, 5, 9, '20221222', 8, true),
	(4, 13, 9, 8, '20230215', 10, true),
	(12, 7, 8, 13, '20221019', 1, false),
	(16, 9, 18, 7, '20220325', 9, true),
	(4, 2, 8, 2, '20230203', 7, true),
	(13, 3, 19, 15, '20230203', 3, false),
	(9, 5, 11, 2, '20230314', 9, true),
	(3, 11, 18, 14, '20220907', 7, true),
	(8, 5, 16, 6, '20220326', 2, false),
	(4, 4, 11, 3, '20220603', 3, false),
	(12, 5, 19, 12, '20221220', 4, true),
	(3, 14, 11, 9, '20230502', 7, true),
	(10, 2, 20, 10, '20220309', 9, true),
	(9, 6, 1, 11, '20220330', 5, true),
	(12, 12, 18, 10, '20220529', 6, true),
	(2, 11, 11, 8, '20221124', 2, false),
	(13, 15, 1, 9, '20220401', 3, false),
	(19, 14, 11, 14, '20220730', 8, true),
	(4, 16, 2, 6, '20220928', 1, false),
	(5, 13, 20, 3, '20221105', 8, true)
;

CREATE OR REPLACE VIEW promedios_alumnos AS
	SELECT legajo, nombre, apellido, AVG(nota) as promedio
	FROM alumnos a
	JOIN calificaciones c ON a.legajo = c.alumno_legajo
	GROUP BY legajo, nombre, apellido
	ORDER BY AVG(nota) DESC
;

CREATE OR REPLACE VIEW alumnos_por_provincia AS
	SELECT p.nombre, COUNT(legajo) as cantidad_alumnos
	FROM provincias p
	LEFT JOIN alumnos a ON p.id = a.provincia_id
	GROUP BY p.nombre
	ORDER BY COUNT(legajo) DESC
;

CREATE OR REPLACE VIEW facturacion_historica_alumnos AS
	SELECT a.legajo, a.nombre, a.apellido, SUM(importe) total_facturado
	FROM matriculas_facturadas mf
	LEFT JOIN facturas f ON mf.factura_id = f.factura
	LEFT JOIN matriculas m ON m.id = mf.matricula_id
	LEFT JOIN alumnos a ON a.legajo = f.alumno_legajo
	GROUP BY a.legajo, a.nombre, a.apellido
	ORDER BY SUM(importe) DESC
;

CREATE OR REPLACE VIEW matriculas_pendientes_facturar AS
	SELECT per_lectivo, semestre, sum(importe) as pendiente_facturar
	FROM matriculas m 
	LEFT JOIN matriculas_facturadas mf ON m.id = mf.matricula_id
	WHERE mf.id IS NULL
	GROUP BY per_lectivo, semestre
;

CREATE OR REPLACE VIEW facturas_impagas AS
	SELECT f.*
	FROM facturas f
	LEFT JOIN cobranzas c ON f.factura = c.factura_id
	WHERE c.id IS NULL
;

CREATE OR REPLACE VIEW facturacion_duplicada AS
	SELECT alumno_legajo, fecha, factura, tipo_factura, matricula_id
	FROM matriculas_facturadas mf
	LEFT JOIN facturas f ON f.factura = mf.factura_id
	WHERE matricula_id IN (
		SELECT matricula_id
		FROM matriculas_facturadas
		GROUP BY matricula_id
		HAVING COUNT(*) > 1
	)
;

CREATE OR REPLACE VIEW alumnos_promocionados AS
	SELECT 
		per_lectivo, semestre, 
		CONCAT(a.nombre, ' ', a.apellido) as alumno,
		m.nombre as materia,
		CONCAT(p.nombre, ' ', p.apellido) as profesor
	FROM cursadas c
	LEFT JOIN alumnos a ON c.alumno_legajo = a.legajo
	LEFT JOIN profesores p ON c.profesor_legajo = p.legajo
	LEFT JOIN materias m ON c.materia_id = m.id
	WHERE condicion = 'Promoción'
	ORDER BY per_lectivo, semestre
;

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


-- USERS
-- Uso del esquema de mysql para hacer cambios en usuarios.
USE mysql;

-- 1) Usuario que posee permiso de sólo lectura sobre todas las tablas
-- Creación del usuario "casas"
CREATE USER casas@localhost;
-- Se otorgan permisos de realizar SELECT sobre todos los objetos del esquema "Universidad".
GRANT SELECT ON Universidad.* TO casas@localhost;
-- Se asegura de haber revocado los permisos de borrado para este usuario en el esquema "Universidad".
REVOKE DELETE ON Universidad.* FROM casas@localhost;
-- Se visualizan los permisos otorgados para el usuario, para verificar que se cumpla lo esperado.
SHOW GRANTS FOR casas@localhost;

-- 2) Usuario con permisos de lectura, inserción y modificación de datos.
-- Creación del usuario "rodri", seteando una contraseña
CREATE USER rodri@localhost IDENTIFIED BY 'ContrasenaSuperSecreta.2307';
-- Se otorgan permisos de realizar SELECT, INSERT y UPDATE sobre todos los objetos del esquema "Universidad".
GRANT SELECT, INSERT, UPDATE ON Universidad.* TO rodri@localhost;
-- Se asegura de haber revocado los permisos de borrado para este usuario en el esquema "Universidad".
REVOKE DELETE ON Universidad.* FROM rodri@localhost;
-- Se visualizan los permisos otorgados para el usuario, para verificar que se cumpla lo esperado.
SHOW GRANTS FOR rodri@localhost;

-- Se vuelve al esquema "Universidad"
USE Universidad;



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