--Declaracion de variables
DECLARE @nuevoIdPais int,
	@idColombia int,
	@nuevoIdCampeonato int,
	@nuevoIdCiudad int,
	@nuevoIdEstadio int,
	@idMedellin int, @idCali int, @idBogota int,
	@idEstadio1 int, @idEstadio2 int, @idEstadio3 int, @idEstadio4 int;

--Obtener el Id de un nuevo PAIS
SELECT @nuevoIdPais=MAX(Id)+1
	FROM Pais;

--***** Agregar el Campeonato ****

SELECT @idColombia=Id 
	FROM Pais 
	WHERE Pais='Colombia';
IF @idColombia IS NULL --Verifica si 'Colombia' no está en la base de datos
BEGIN
	SET IDENTITY_INSERT Pais ON --Obliga a reemplazar el Id autonumérico
	INSERT INTO Pais
		(Id, Pais, Entidad) VALUES(@nuevoIdPais, 'Colombia', 'Federación Colombiana de Futbol');
	SET IDENTITY_INSERT Pais OFF
	SET @idColombia = @nuevoIdPais;
	SET @nuevoIdPais = @nuevoIdPais + 1;
END

--validar si ya está el campeonato
SELECT @nuevoIdCampeonato=Id 
    FROM Campeonato
    WHERE Campeonato='FIFA U-20 Women''s World Cup Colombia 2024';
IF @nuevoIdCampeonato IS NULL --Verifica si el campeonato no está en la base de datos
BEGIN
	INSERT INTO Campeonato
		(Campeonato, IdPais, Año)
		VALUES('FIFA U-20 Women''s World Cup Colombia 2024', @idColombia, 2024);
	SELECT @nuevoIdCampeonato=Id 
		FROM Campeonato
		WHERE Campeonato='FIFA U-20 Women''s World Cup Colombia 2024';
END

--***** Agregar las ciudades de los encuentros *****

--Obtener el Id de una nueva CIUDAD
SELECT @nuevoIdCiudad=MAX(Id)+1
	FROM Ciudad;

--Obtener el Id de un nuevo ESTADIO
SELECT @nuevoIdEstadio=MAX(Id)+1
        FROM Estadio;

SELECT @idEstadio1=id
	FROM Estadio 
	WHERE Estadio='Estadio Atanasio Girardot';
IF @idEstadio1 IS NULL --Verifica si 'Estadio Atanasio Girardot' no está en la base de datos
BEGIN
	SELECT @idMedellin=Id FROM Ciudad WHERE Ciudad='Medellín';
	IF @idMedellin IS NULL  --Verifica si 'Medellín' no está en la base de datos
		BEGIN
			SET IDENTITY_INSERT Ciudad ON --Obliga a reemplazar el Id autonumérico
			INSERT INTO Ciudad
				(id, Ciudad, IdPais) VALUES(@nuevoIdCiudad, 'Medellín', @idColombia);
			SET IDENTITY_INSERT Ciudad OFF
			SET @idMedellin = @nuevoIdCiudad;
			SET @nuevoIdCiudad = @nuevoIdCiudad + 1;
		END;
	SET IDENTITY_INSERT Estadio ON --Obliga a reemplazar el Id autonumérico
	INSERT INTO Estadio
		(Id, Estadio, Capacidad, IdCiudad) VALUES(@nuevoIdEstadio, 'Estadio Atanasio Girardot', 0, @idMedellin);
	SET IDENTITY_INSERT Estadio OFF
	SET @idColombia = @nuevoIdPais;
	SET @nuevoIdPais = @nuevoIdPais + 1;
END
