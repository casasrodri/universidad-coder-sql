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
