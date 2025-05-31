SELECT *
	FROM ciudad
	WHERE nombre IN ('YOLOMBO', 'MEDELLIN', 'GOMEZ PLATA');

SELECT *
	FROM gradoacademico;

SELECT *
	FROM tipodocumento;

SELECT *
	FROM sector;

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
	(idpersona, informacion)
	VALUES(1, ROW(ROW('1976-02-01', '1979-11-30', 'Escuela Urbana de Varones'), '', 1, 52, '') );

INSERT INTO informacionacademica
	(idpersona, informacion)
	VALUES
	(1, ROW(ROW('1980-02-01', '1985-11-30', 'Liceo Gilberto Alzate Avendaño'), 'Bachiller Académico', 2, 70, '') ),
	(1, ROW(ROW('1986-07-01', '1989-06-30', 'Tecnológico de Antioquia'), 'Tecnólogo en Administración Documental y Micrografía', 4, 70, 'Gestión Documental Colanta') );

INSERT INTO informacionacademica
	(idpersona, informacion)
	VALUES
	(11, ROW(ROW('2011-02-01', '2017-11-30', 'Colegio Nacional de Varones'), 'Bachiller Agropecuario', 3, 27, '') ),
	(11, ROW(ROW('2018-02-01', '2024-06-30', 'IU Pascual Bravo'), 'Ingeniería Electrónica', 5, 70, 'Circuito digital programable para Drone') );

--Consultas de prueba
SELECT IA.*, C.nombre ciudad, GA.grado
	FROM informacionacademica IA
		JOIN ciudad C ON (IA.informacion).idciudad=C.id
		JOIN gradoacademico GA ON (IA.informacion).idgrado=GA.id;

SELECT IA.idpersona,
	(IA.informacion).BASE.desde,
	(IA.informacion).BASE.hasta,
	(IA.informacion).BASE.entidad || '-' || C.nombre entidad,
	(IA.informacion).titulo AS titulo,
	GA.grado || '-' || NA.nivel grado,
	(IA.informacion).proyecto
	FROM informacionacademica IA
		JOIN ciudad C ON (IA.informacion).idciudad=C.id
		JOIN gradoacademico GA ON (IA.informacion).idgrado=GA.id
		JOIN nivelacademico NA ON GA.idnivel=NA.id;

INSERT INTO informacionlaboral
	(idpersona, informacion)
	VALUES
	(1, ROW(ROW('1989-08-01', '1990-06-30', 'Contraloría Departamental'), 'Analista de Archivo', 70, '', '') ),
	(1, ROW(ROW('1991-01-01', '1992-12-31', 'Colegio Militar José María Córdoba'), 'Analista de Sistemas', 70, '', '') );

INSERT INTO informacionlaboral
	(idpersona, informacion)
	VALUES
	(11, ROW(ROW('2024-02-01', '2025-05-24', 'Basf Química'), 'Ingeniero de Mantenimiento', 70, '6041222333', 'rrhh@basfquimica.com') )

--Consultas de prueba
SELECT IA.idpersona,
	(IA.informacion).BASE.desde,
	(IA.informacion).BASE.hasta,
	(IA.informacion).BASE.entidad,
	C.nombre ciudad,
	(IA.informacion).cargo,
	(IA.informacion).telefonocontacto,
	(IA.informacion).correocontacto
	FROM informacionlaboral IA
		JOIN ciudad C ON (IA.informacion).idciudad=C.id

INSERT INTO habilidadprofesional
	(idpersona, habilidad)
	VALUES
	(1, ROW(ROW('Desarrollo en Java', 'Desarrollo APIS', 'Avanzado', 10), 1, 'Oracle Java SE 17') ),
	(1, ROW(ROW('Bases de Datos SQL Server', 'Bases de datos en la nube', 'Intermedio', 10), 1, 'Microsoft Certified:Azure Data Fundamentals') );

SELECT HP.idpersona,
	(HP.habilidad).BASE.nombre,
	(HP.habilidad).BASE.descripcion,
	(HP.habilidad).BASE.nivel,
	(HP.habilidad).BASE.añosexperiencia,
	S.sector,
	(HP.habilidad).certificacion
	FROM habilidadprofesional HP
		JOIN sector S ON (HP.habilidad).idsector=S.id;



SELECT distinct attrelid
FROM pg_attribute
WHERE attrelid = 'informacionacademicatipo'::regtype
  AND attnum > 0
  AND NOT attisdropped;


