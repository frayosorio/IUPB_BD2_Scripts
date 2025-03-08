--Listar las capitales de Departamento de Colombia
SELECT R.Nombre, C.Nombre Ciudad, C.CapitalRegion, C.Id IdCiudad, R.Id IdRegion
	FROM Ciudad C
		JOIN Region R ON C.IdRegion=R.Id
		JOIN Pais P ON P.Id=R.IdPais
	WHERE P.Nombre = 'Colombia'
		AND C.CapitalRegion=1

--Listar las capitales de Departamento de Colombia (optimizada)
SELECT R.Nombre, R.Id IdRegion,
	CASE WHEN EXISTS(SELECT 1 FROM Ciudad WHERE CapitalRegion=1 AND IdRegion=R.Id)
	THEN
		(SELECT Nombre FROM Ciudad WHERE CapitalRegion=1 AND IdRegion=R.Id)
	ELSE
		'** Sin Capital **'
	END Capital
	FROM Region R
		JOIN Pais P ON P.Id=R.IdPais
	WHERE P.Nombre = 'Colombia'


--Contar las ciudades de Antioquia
SELECT COUNT(*)
	FROM Ciudad C
		JOIN Region R ON C.IdRegion=R.Id
	WHERE R.Nombre='Antioquia'
		AND C.CapitalRegion=1

--Volver capital de Antioquia a Bello
UPDATE Ciudad
	SET CapitalRegion=1
	WHERE Id=23

--Volver capital a todas las ciudades de Antioquia (ERROR)
UPDATE Ciudad
	SET CapitalRegion=1
	WHERE IdRegion=2

--Volver capital a todas las ciudades de Colombia (ERROR)
UPDATE Ciudad
	SET CapitalRegion=1
	FROM Pais P 
		JOIN Region R ON P.Id=R.IdPais
		JOIN Ciudad C ON C.IdRegion=R.Id
	WHERE P.Nombre='Colombia'

--Volver capital a 'San Antonio de Pereira'
INSERT INTO Ciudad	
	(Nombre, IdRegion, CapitalRegion)
	VALUES('San Antonio de Pereira', 2, 1)

--Volver capitales a 'Santa Helena' y 'San Antonio de Prado'
INSERT INTO Ciudad	
	(Nombre, IdRegion, CapitalRegion)
	VALUES
	('Santa Helena', 2, 1),
	('San Antonio de Prado', 2, 1)

--Listar Ciudades de Antioquia
SELECT R.Nombre, C.Nombre Ciudad, C.CapitalRegion, C.Id IdCiudad, R.Id IdRegion
	FROM Ciudad C
		JOIN Region R ON C.IdRegion=R.Id
		JOIN Pais P ON P.Id=R.IdPais
	WHERE P.Nombre = 'Colombia'
		AND R.Nombre='Antioquia'

--Quitar la capital de Antioquia
UPDATE Ciudad
	SET CapitalRegion=0
	WHERE IdRegion=2

--Eliminar Ciudades agregadas para pruebas
DELETE FROM Ciudad	
	WHERE Nombre IN ('San Antonio de Pereira', 'Santa Helena', 'San Antonio de Prado')
