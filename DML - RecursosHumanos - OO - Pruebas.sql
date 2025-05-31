INSERT INTO persona
	(apellido1, apellido2, nombres, documento, idtipodocumento, fechanacimiento, idciudadnacimiento,
	direccion, movil, correo)
	VALUES('Osorio', 'Rivera', 'Fray León', '71707721', 1, '1969-06-12', 126,
	ROW('Calle 16a # 43b-126 apto 1102', 70), -- tipo direcciontipo
	'3162956865', 'frayosorio@gmail.com');

INSERT INTO persona
	(apellido1, apellido2, nombres, documento, idtipodocumento, fechanacimiento, idciudadnacimiento,
	direccion, movil, correo)
	VALUES('Gómez', 'Torva', 'Elber', '1122333444', 4, '2001-09-25', 27,
	ROW('Cra 80 # 10-12', 27), -- tipo direcciontipo
	'3002555666', 'egt@gmail.com');

--Consultas de prueba
SELECT P.*, CD.nombre Residencia, CN.nombre Nacimiento
	FROM persona P
		JOIN ciudad CD ON (P.direccion).idciudad=CD.id
		JOIN ciudad CN ON idciudadnacimiento=CN.id

INSERT INTO informacionacademica
	(idpersona, desde, hasta, entidad, titulo, idgrado, idciudad, proyecto)
	VALUES(1, '1976-02-01', '1979-11-30', 'Escuela Urbana de Varones', '', 1, 52, '');

INSERT INTO informacionacademica
	(idpersona, desde, hasta, entidad, titulo, idgrado, idciudad, proyecto)
	VALUES
	(1, '1980-02-01', '1985-11-30', 'Liceo Gilberto Alzate Avendaño', 'Bachiller Académico', 2, 70, ''),
	(1, '1986-07-01', '1989-06-30', 'Tecnológico de Antioquia', 'Tecnólogo en Administración Documental y Micrografía', 4, 70, 'Gestión Documental Colanta');

--Consultas de prueba
SELECT IA.*, C.nombre ciudad, GA.grado
	FROM informacionacademica IA
		JOIN ciudad C ON IA.idciudad=C.id
		JOIN gradoacademico GA ON IA.idgrado=GA.id;

INSERT INTO informacionlaboral
	(idpersona, desde, hasta, entidad, cargo, idciudad, telefonocontacto, correocontacto)
	VALUES
	(1, '1989-08-01', '1990-06-30', 'Contraloría Departamental', 'Analista de Archivo', 70, '', ''),
	(1, '1991-01-01', '1992-12-31', 'Colegio Militar José María Córdoba', 'Analista de Sistemas', 70, '', '');

--Consultas de prueba
SELECT IL.*, C.nombre ciudad
	FROM informacionlaboral IL
		JOIN ciudad C ON IL.idciudad=C.id
