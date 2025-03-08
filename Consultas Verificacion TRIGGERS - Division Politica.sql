--Listar las capitales de Departamento de Colombia
SELECT R.Nombre, C.Nombre Ciudad, C.CapitalRegion, C.Id IdCiudad, R.Id IdRegion
	FROM Ciudad C
		JOIN Region R ON C.IdRegion=R.Id
		JOIN Pais P ON P.Id=R.IdPais
	WHERE P.Nombre = 'Colombia'
		AND C.CapitalRegion=1

--Contar las ciudades de Antioquia
SELECT COUNT(*)
	FROM Ciudad C
		JOIN Region R ON C.IdRegion=R.Id
	WHERE R.Nombre='Antioquia'

--Volver capital de Antioquia a Bello
UPDATE Ciudad
	SET CapitalRegion=1
	WHERE Id=23

--Volver capital a todas las ciudades de Antioquia (ERROR)
UPDATE Ciudad
	SET CapitalRegion=1
	WHERE IdRegion=2

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