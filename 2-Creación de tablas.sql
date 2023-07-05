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
