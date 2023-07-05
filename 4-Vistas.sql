-- Creación de vistas
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
