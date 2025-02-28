--Declaracion de variables
DECLARE @nuevoIdPais int,
	@idColombia int,
	@nuevoIdCampeonato int,
	@nuevoIdCiudad int,
	@nuevoIdEstadio int,
	@idMedellin int, @idCali int, @idBogota int,
	@idEstadio1 int, @idEstadio2 int, @idEstadio3 int, @idEstadio4 int,
	@nuevoIdGrupo int,
	@idPais1Grupo int, @idPais2Grupo int, @idPais3Grupo int, @idPais4Grupo int,
	@totalPaises int,
	@nuevoIdEncuentro int;

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
	--Agregar ESTADIO
	SET IDENTITY_INSERT Estadio ON --Obliga a reemplazar el Id autonumérico
	INSERT INTO Estadio
		(Id, Estadio, Capacidad, IdCiudad) VALUES(@nuevoIdEstadio, 'Estadio Atanasio Girardot', 0, @idMedellin);
	SET IDENTITY_INSERT Estadio OFF
	SET @idEstadio1 = @nuevoIdEstadio;
	SET @nuevoIdEstadio = @nuevoIdEstadio + 1;
END

SELECT @idEstadio2=id
	FROM Estadio 
	WHERE Estadio='Estadio Olímpico Pascual Guerrero';
IF @idEstadio2 IS NULL --Verifica si 'Estadio Olímpico Pascual Guerrero' no está en la base de datos
BEGIN
	SELECT @idCali=Id FROM Ciudad WHERE Ciudad='Cali';
    IF @idCali IS NULL 
    BEGIN
        SET IDENTITY_INSERT Ciudad ON;
        INSERT INTO Ciudad 
			(Id, Ciudad, IdPais) VALUES (@nuevoIdCiudad, 'Cali', @idColombia);
        SET IDENTITY_INSERT Ciudad OFF;
        SET @idCali = @nuevoIdCiudad;
        SET @nuevoIdCiudad = @nuevoIdCiudad + 1;
    END;
	--Agregar ESTADIO
    SET IDENTITY_INSERT Estadio ON;
    INSERT INTO Estadio 
		(Id, Estadio, Capacidad, IdCiudad) VALUES (@nuevoIdEstadio, 'Estadio Olímpico Pascual Guerrero', 0, @idCali);
    SET IDENTITY_INSERT Estadio OFF;
    SET @idEstadio2 = @nuevoIdEstadio;
	SET @nuevoIdEstadio = @nuevoIdEstadio + 1;
END;

SELECT @idEstadio3=id
	FROM Estadio 
	WHERE Estadio='Estadio Nemesio Camacho El Campín';
IF @idEstadio3 IS NULL --Verifica si 'Estadio Nemesio Camacho El Campín' no está en la base de datos
BEGIN
	SELECT @idBogota=Id FROM Ciudad WHERE Ciudad='Bogotá';
    IF @idBogota IS NULL 
    BEGIN
        SET IDENTITY_INSERT Ciudad ON;
        INSERT INTO Ciudad 
			(Id, Ciudad, IdPais) VALUES (@nuevoIdCiudad, 'Bogotá', @idColombia);
        SET IDENTITY_INSERT Ciudad OFF;
        SET @idBogota = @nuevoIdCiudad;
        --SET @nuevoIdCiudad = @nuevoIdCiudad + 1;
    END;
	--Agregar ESTADIO
    SET IDENTITY_INSERT Estadio ON;
    INSERT INTO Estadio 
		(Id, Estadio, Capacidad, IdCiudad) VALUES (@nuevoIdEstadio, 'Estadio Nemesio Camacho El Campín', 0, @idBogota);
    SET IDENTITY_INSERT Estadio OFF;
    SET @idEstadio3 = @nuevoIdEstadio;
	SET @nuevoIdEstadio = @nuevoIdEstadio + 1;
END;

SELECT @idEstadio4=id
	FROM Estadio 
	WHERE Estadio='Estadio Metropolitano de Techo';
IF @idEstadio4 IS NULL --Verifica si 'Estadio Metropolitano de Techo' no está en la base de datos
BEGIN
    IF @idBogota IS NULL 
    BEGIN
		SELECT @idBogota=id  FROM ciudad WHERE ciudad='Bogotá';
    END;
	--Agregar ESTADIO
    SET IDENTITY_INSERT Estadio ON;
    INSERT INTO Estadio 
		(Id, Estadio, Capacidad, IdCiudad) VALUES (@nuevoIdEstadio, 'Estadio Metropolitano de Techo', 0, @idBogota);
    SET IDENTITY_INSERT Estadio OFF;
    SET @idEstadio4 = @nuevoIdEstadio;
	--SET @nuevoIdEstadio = @nuevoIdEstadio + 1;
END;

--***** Validar si ya estan los grupos *****
SELECT @nuevoIdGrupo=id 
    FROM Grupo
    WHERE IdCampeonato = @nuevoIdCampeonato
        AND Grupo='A';
IF @nuevoIdGrupo IS NULL --Los grupos no estan
BEGIN
	SELECT @nuevoIdGrupo=MAX(Id)+1 FROM Grupo;
	SET IDENTITY_INSERT Grupo ON;
	INSERT INTO Grupo
		(Id, Grupo, IdCampeonato)
		VALUES
		(@nuevoIdGrupo, 'A', @nuevoIdCampeonato),
		(@nuevoIdGrupo+1, 'B', @nuevoIdCampeonato),
		(@nuevoIdGrupo+2, 'C', @nuevoIdCampeonato),
		(@nuevoIdGrupo+3, 'D', @nuevoIdCampeonato),
		(@nuevoIdGrupo+4, 'E', @nuevoIdCampeonato),
		(@nuevoIdGrupo+5, 'F', @nuevoIdCampeonato);
	SET IDENTITY_INSERT Grupo OFF;
END

--***** Validar si ya están los Paises del Grupo A *****
SET IDENTITY_INSERT Pais ON --Obliga a reemplazar el Id autonumérico

SET @idPais1Grupo = @idColombia; --'Colombia' es el Pais1 del Grupo A

SELECT @idPais2Grupo=id  FROM Pais WHERE pais='Australia';
IF @idPais2Grupo IS NULL --verifica si 'Australia' no existe en la base de datos
BEGIN
    INSERT INTO Pais
        (Id, Pais, Entidad) VALUES(@nuevoIdPais, 'Australia', '');
    SET @idPais2Grupo = @nuevoIdPais;
    SET @nuevoIdPais = @nuevoIdPais + 1;
END;

SELECT @idPais3Grupo=id  FROM Pais WHERE pais='Camerún';
IF @idPais3Grupo IS NULL --verifica si 'Camerún' no existe en la base de datos
BEGIN
    INSERT INTO Pais
        (Id, Pais, Entidad) VALUES(@nuevoIdPais, 'Camerún', '');
    SET @idPais3Grupo = @nuevoIdPais;
    SET @nuevoIdPais = @nuevoIdPais + 1;
END;

SELECT @idPais4Grupo=id  FROM Pais WHERE pais='México';
IF @idPais4Grupo IS NULL --verifica si 'Camerún' no existe en la base de datos
BEGIN
    INSERT INTO Pais
        (Id, Pais, Entidad) VALUES(@nuevoIdPais, 'México', '');
    SET @idPais4Grupo = @nuevoIdPais;
    SET @nuevoIdPais = @nuevoIdPais + 1;
END;

SET IDENTITY_INSERT Pais OFF

SELECT @totalPaises=COUNT(*)
    FROM GrupoPais
    WHERE IdGrupo=@nuevoIdGrupo;

IF @totalPaises=0
BEGIN
	INSERT INTO GrupoPais
		(IdGrupo, IdPais)
		VALUES
		(@nuevoIdGrupo, @idPais1Grupo),
		(@nuevoIdGrupo, @idPais2Grupo),
		(@nuevoIdGrupo, @idPais3Grupo),
		(@nuevoIdGrupo, @idPais4Grupo)
END

--Obtener el Id de un nuevo Encuentro
SELECT @nuevoIdEncuentro=MAX(Id)+1
	FROM Encuentro;

--***** Validar si ya estan los Encuentros de la Fase de Grupos del Grupo A *****
SET IDENTITY_INSERT Encuentro ON --Obliga a reemplazar el Id autonumérico

-- Camerun vs Mexico
IF NOT EXISTS(SELECT * FROM Encuentro
			WHERE IdPais1=@idPais3Grupo AND IdPais2=@idPais4Grupo
				AND IdCampeonato=@nuevoIdCampeonato AND IdFase=1)
BEGIN
	INSERT INTO Encuentro
		(Id, IdPais1, Goles1, IdPais2, Goles2, Fecha, IdEstadio, IdFase, IdCampeonato)
		VALUES(@nuevoIdEncuentro, @idPais3Grupo, 2, @idPais4Grupo, 2, '2024-08-31', @idEstadio3, 1, @nuevoIdCampeonato);
	SET @nuevoIdEncuentro=@nuevoIdEncuentro+1;
END

-- Colombia vs Australia
IF NOT EXISTS(SELECT * FROM Encuentro
			WHERE IdPais1=@idPais1Grupo AND IdPais2=@idPais2Grupo
				AND IdCampeonato=@nuevoIdCampeonato AND IdFase=1)
BEGIN
	INSERT INTO Encuentro
		(Id, IdPais1, Goles1, IdPais2, Goles2, Fecha, IdEstadio, IdFase, IdCampeonato)
		VALUES(@nuevoIdEncuentro, @idPais1Grupo, 2, @idPais2Grupo, 0, '2024-08-31', @idEstadio3, 1, @nuevoIdCampeonato);
	SET @nuevoIdEncuentro=@nuevoIdEncuentro+1;
END

SET IDENTITY_INSERT Encuentro OFF
