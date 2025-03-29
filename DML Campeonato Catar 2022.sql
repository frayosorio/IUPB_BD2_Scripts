--Declaracion de variables
DECLARE @nuevoIdPais int,
	@idCatar int,
	@nuevoIdCampeonato int,
	@nuevoIdCiudad int,
	@nuevoIdEstadio int,
	@idCiudad1 int, @idCiudad2 int, @idCiudad3 int, @idCiudad4 int, @idCiudad5 int,
	@idEstadio1 int, @idEstadio2 int, @idEstadio3 int, @idEstadio4 int,
	@idEstadio5 int, @idEstadio6 int, @idEstadio7 int, @idEstadio8 int,
	@nuevoIdGrupo int,
	@idPais1Grupo int, @idPais2Grupo int, @idPais3Grupo int, @idPais4Grupo int,
	@totalPaises int,
	@nuevoIdEncuentro int;

--Obtener el Id de un nuevo PAIS
SELECT @nuevoIdPais=MAX(Id)+1
	FROM Pais;

--***** Agregar el Campeonato ****

SELECT @idCatar=Id 
	FROM Pais 
	WHERE Pais='Catar';
IF @idCatar IS NULL --Verifica si 'Catar' no está en la base de datos
BEGIN
	SET IDENTITY_INSERT Pais ON --Obliga a reemplazar el Id autonumérico
	INSERT INTO Pais
		(Id, Pais, Entidad) VALUES(@nuevoIdPais, 'Catar', 'Asociación de Fútbol de Catar');
	SET IDENTITY_INSERT Pais OFF
	SET @idCatar = @nuevoIdPais;
	SET @nuevoIdPais = @nuevoIdPais + 1;
END

--validar si ya está el campeonato
SELECT @nuevoIdCampeonato=Id 
    FROM Campeonato
    WHERE Campeonato='FIFA World Cup 2022';
IF @nuevoIdCampeonato IS NULL --Verifica si el campeonato no está en la base de datos
BEGIN
	INSERT INTO Campeonato
		(Campeonato, IdPais, Año)
		VALUES('FIFA World Cup 2022', @idCatar, 2022);
	SELECT @nuevoIdCampeonato=Id 
		FROM Campeonato
		WHERE Campeonato='FIFA World Cup 2022';
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
	WHERE Estadio='Estadio Al Bayt';
IF @idEstadio1 IS NULL --Verifica si 'Estadio Atanasio Girardot' no está en la base de datos
BEGIN
	SELECT @idCiudad1=Id FROM Ciudad WHERE Ciudad='Jor';
	IF @idCiudad1 IS NULL  --Verifica si 'Jor' no está en la base de datos
		BEGIN
			SET IDENTITY_INSERT Ciudad ON --Obliga a reemplazar el Id autonumérico
			INSERT INTO Ciudad
				(id, Ciudad, IdPais) VALUES(@nuevoIdCiudad, 'Jor', @idCatar);
			SET IDENTITY_INSERT Ciudad OFF
			SET @idCiudad1 = @nuevoIdCiudad;
			SET @nuevoIdCiudad = @nuevoIdCiudad + 1;
		END;
	--Agregar ESTADIO
	SET IDENTITY_INSERT Estadio ON --Obliga a reemplazar el Id autonumérico
	INSERT INTO Estadio
		(Id, Estadio, Capacidad, IdCiudad) VALUES(@nuevoIdEstadio, 'Estadio Al Bayt', 0, @idCiudad1);
	SET IDENTITY_INSERT Estadio OFF
	SET @idEstadio1 = @nuevoIdEstadio;
	SET @nuevoIdEstadio = @nuevoIdEstadio + 1;
END

SELECT @idEstadio2=id
	FROM Estadio 
	WHERE Estadio='Estadio de Lusail';
IF @idEstadio2 IS NULL --Verifica si 'Estadio de Lusail' no está en la base de datos
BEGIN
	SELECT @idCiudad2=Id FROM Ciudad WHERE Ciudad='Lusail';
    IF @idCiudad2 IS NULL 
    BEGIN
        SET IDENTITY_INSERT Ciudad ON;
        INSERT INTO Ciudad 
			(Id, Ciudad, IdPais) VALUES (@nuevoIdCiudad, 'Lusail', @idCatar);
        SET IDENTITY_INSERT Ciudad OFF;
        SET @idCiudad2 = @nuevoIdCiudad;
        SET @nuevoIdCiudad = @nuevoIdCiudad + 1;
    END;
	--Agregar ESTADIO
    SET IDENTITY_INSERT Estadio ON;
    INSERT INTO Estadio 
		(Id, Estadio, Capacidad, IdCiudad) VALUES (@nuevoIdEstadio, 'Estadio de Lusail', 0, @idCiudad2);
    SET IDENTITY_INSERT Estadio OFF;
    SET @idEstadio2 = @nuevoIdEstadio;
	SET @nuevoIdEstadio = @nuevoIdEstadio + 1;
END;

SELECT @idEstadio3=id
	FROM Estadio 
	WHERE Estadio='Estadio 974';
IF @idEstadio3 IS NULL --Verifica si 'Estadio 974' no está en la base de datos
BEGIN
	SELECT @idCiudad3=Id FROM Ciudad WHERE Ciudad='Doha';
    IF @idCiudad3 IS NULL 
    BEGIN
        SET IDENTITY_INSERT Ciudad ON;
        INSERT INTO Ciudad 
			(Id, Ciudad, IdPais) VALUES (@nuevoIdCiudad, 'Doha', @idCatar);
        SET IDENTITY_INSERT Ciudad OFF;
        SET @idCiudad3 = @nuevoIdCiudad;
        --SET @nuevoIdCiudad = @nuevoIdCiudad + 1;
    END;
	--Agregar ESTADIO
    SET IDENTITY_INSERT Estadio ON;
    INSERT INTO Estadio 
		(Id, Estadio, Capacidad, IdCiudad) VALUES (@nuevoIdEstadio, 'Estadio 974', 0, @idCiudad3);
    SET IDENTITY_INSERT Estadio OFF;
    SET @idEstadio3 = @nuevoIdEstadio;
	SET @nuevoIdEstadio = @nuevoIdEstadio + 1;
END;

SELECT @idEstadio4=id
	FROM Estadio 
	WHERE Estadio='Estadio Al Thumama';
IF @idEstadio4 IS NULL --Verifica si 'Estadio Al Thumama' no está en la base de datos
BEGIN
    IF @idCiudad3 IS NULL 
    BEGIN
		SELECT @idCiudad3=id  FROM ciudad WHERE ciudad='Doha';
    END;
	--Agregar ESTADIO
    SET IDENTITY_INSERT Estadio ON;
    INSERT INTO Estadio 
		(Id, Estadio, Capacidad, IdCiudad) VALUES (@nuevoIdEstadio, 'Estadio Al Thumama', 0, @idCiudad3);
    SET IDENTITY_INSERT Estadio OFF;
    SET @idEstadio4 = @nuevoIdEstadio;
	SET @nuevoIdEstadio = @nuevoIdEstadio + 1;
END;

--******************

SELECT @idEstadio5=id
	FROM Estadio 
	WHERE Estadio='Estadio Ciudad de la Educación';
IF @idEstadio5 IS NULL --Verifica si 'Estadio Ciudad de la Educación' no está en la base de datos
BEGIN
	SELECT @idCiudad4=Id FROM Ciudad WHERE Ciudad='Rayán';
	IF @idCiudad4 IS NULL  --Verifica si 'Jor' no está en la base de datos
		BEGIN
			SET IDENTITY_INSERT Ciudad ON --Obliga a reemplazar el Id autonumérico
			INSERT INTO Ciudad
				(id, Ciudad, IdPais) VALUES(@nuevoIdCiudad, 'Rayán', @idCatar);
			SET IDENTITY_INSERT Ciudad OFF
			SET @idCiudad4 = @nuevoIdCiudad;
			SET @nuevoIdCiudad = @nuevoIdCiudad + 1;
		END;
	--Agregar ESTADIO
	SET IDENTITY_INSERT Estadio ON --Obliga a reemplazar el Id autonumérico
	INSERT INTO Estadio
		(Id, Estadio, Capacidad, IdCiudad) VALUES(@nuevoIdEstadio, 'Estadio Ciudad de la Educación', 0, @idCiudad4);
	SET IDENTITY_INSERT Estadio OFF
	SET @idEstadio5 = @nuevoIdEstadio;
	SET @nuevoIdEstadio = @nuevoIdEstadio + 1;
END

SELECT @idEstadio6=id
	FROM Estadio 
	WHERE Estadio='Estadio Áhmad bin Ali';
IF @idEstadio6 IS NULL --Verifica si 'Estadio de Lusail' no está en la base de datos
BEGIN
    IF @idCiudad4 IS NULL 
    BEGIN
		SELECT @idCiudad4=id  FROM ciudad WHERE ciudad='Rayán';
    END;
	--Agregar ESTADIO
    SET IDENTITY_INSERT Estadio ON;
    INSERT INTO Estadio 
		(Id, Estadio, Capacidad, IdCiudad) VALUES (@nuevoIdEstadio, 'Estadio Áhmad bin Ali', 0, @idCiudad4);
    SET IDENTITY_INSERT Estadio OFF;
    SET @idEstadio6 = @nuevoIdEstadio;
	SET @nuevoIdEstadio = @nuevoIdEstadio + 1;
END;

SELECT @idEstadio7=id
	FROM Estadio 
	WHERE Estadio='Estadio 974';
IF @idEstadio7 IS NULL --Verifica si 'Estadio 974' no está en la base de datos
BEGIN
    IF @idCiudad4 IS NULL 
    BEGIN
		SELECT @idCiudad4=id  FROM ciudad WHERE ciudad='Rayán';
    END;
	--Agregar ESTADIO
    SET IDENTITY_INSERT Estadio ON;
    INSERT INTO Estadio 
		(Id, Estadio, Capacidad, IdCiudad) VALUES (@nuevoIdEstadio, 'Estadio 974', 0, @idCiudad4);
    SET IDENTITY_INSERT Estadio OFF;
    SET @idEstadio7 = @nuevoIdEstadio;
	SET @nuevoIdEstadio = @nuevoIdEstadio + 1;
END;

SELECT @idEstadio8=id
	FROM Estadio 
	WHERE Estadio='Estadio Al Janoub';
IF @idEstadio8 IS NULL --Verifica si 'Estadio Al Thumama' no está en la base de datos
BEGIN
     IF @idCiudad5 IS NULL 
    BEGIN
        SET IDENTITY_INSERT Ciudad ON;
        INSERT INTO Ciudad 
			(Id, Ciudad, IdPais) VALUES (@nuevoIdCiudad, 'Al Wakrah', @idCatar);
        SET IDENTITY_INSERT Ciudad OFF;
        SET @idCiudad5 = @nuevoIdCiudad;
        --SET @nuevoIdCiudad = @nuevoIdCiudad + 1;
    END;
	--Agregar ESTADIO
    SET IDENTITY_INSERT Estadio ON;
    INSERT INTO Estadio 
		(Id, Estadio, Capacidad, IdCiudad) VALUES (@nuevoIdEstadio, 'Estadio Al Janoub', 0, @idCiudad5);
    SET IDENTITY_INSERT Estadio OFF;
    SET @idEstadio8 = @nuevoIdEstadio;
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
		(@nuevoIdGrupo+5, 'F', @nuevoIdCampeonato),
		(@nuevoIdGrupo+6, 'G', @nuevoIdCampeonato),
		(@nuevoIdGrupo+7, 'H', @nuevoIdCampeonato);
	SET IDENTITY_INSERT Grupo OFF;
END

--***** Validar si ya están los Paises del Grupo A *****

SET IDENTITY_INSERT Pais ON --Obliga a reemplazar el Id autonumérico

SET @idPais1Grupo = @idCatar; --'Catar' es el Pais1 del Grupo A

SELECT @idPais2Grupo=id  FROM Pais WHERE pais='Ecuador';
IF @idPais2Grupo IS NULL --verifica si 'Ecuador' no existe en la base de datos
BEGIN
    INSERT INTO Pais
        (Id, Pais, Entidad) VALUES(@nuevoIdPais, 'Ecuador', '');
    SET @idPais2Grupo = @nuevoIdPais;
    SET @nuevoIdPais = @nuevoIdPais + 1;
END;

SELECT @idPais3Grupo=id  FROM Pais WHERE pais='Senegal';
IF @idPais3Grupo IS NULL --verifica si 'Senegal' no existe en la base de datos
BEGIN
    INSERT INTO Pais
        (Id, Pais, Entidad) VALUES(@nuevoIdPais, 'Senegal', '');
    SET @idPais3Grupo = @nuevoIdPais;
    SET @nuevoIdPais = @nuevoIdPais + 1;
END;

SELECT @idPais4Grupo=id  FROM Pais WHERE pais='Países Bajos';
IF @idPais4Grupo IS NULL --verifica si 'Países Bajos' no existe en la base de datos
BEGIN
    INSERT INTO Pais
        (Id, Pais, Entidad) VALUES(@nuevoIdPais, 'Países Bajos', '');
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

-- Catar vs Ecuador
IF NOT EXISTS(SELECT * FROM Encuentro
			WHERE IdPais1=@idPais1Grupo AND IdPais2=@idPais2Grupo
				AND IdCampeonato=@nuevoIdCampeonato AND IdFase=1)
BEGIN
	INSERT INTO Encuentro
		(Id, IdPais1, Goles1, IdPais2, Goles2, Fecha, IdEstadio, IdFase, IdCampeonato)
		VALUES(@nuevoIdEncuentro, @idPais1Grupo, 0, @idPais2Grupo, 2, '2022-11-20', @idEstadio1, 1, @nuevoIdCampeonato);
	SET @nuevoIdEncuentro=@nuevoIdEncuentro+1;
END

-- Senegal vs Paises Bajos
IF NOT EXISTS(SELECT * FROM Encuentro
			WHERE IdPais1=@idPais3Grupo AND IdPais2=@idPais4Grupo
				AND IdCampeonato=@nuevoIdCampeonato AND IdFase=1)
BEGIN
	INSERT INTO Encuentro
		(Id, IdPais1, Goles1, IdPais2, Goles2, Fecha, IdEstadio, IdFase, IdCampeonato)
		VALUES(@nuevoIdEncuentro, @idPais3Grupo, 0, @idPais4Grupo, 2, '2022-11-21', @idEstadio4, 1, @nuevoIdCampeonato);
	SET @nuevoIdEncuentro=@nuevoIdEncuentro+1;
END

-- Catar vs Senegal
IF NOT EXISTS(SELECT * FROM Encuentro
			WHERE IdPais1=@idPais1Grupo AND IdPais2=@idPais3Grupo
				AND IdCampeonato=@nuevoIdCampeonato AND IdFase=1)
BEGIN
	INSERT INTO Encuentro
		(Id, IdPais1, Goles1, IdPais2, Goles2, Fecha, IdEstadio, IdFase, IdCampeonato)
		VALUES(@nuevoIdEncuentro, @idPais1Grupo, 1, @idPais3Grupo, 3, '2022-11-25', @idEstadio4, 1, @nuevoIdCampeonato);
	SET @nuevoIdEncuentro=@nuevoIdEncuentro+1;
END

-- Paises Bajos vs Ecuador
IF NOT EXISTS(SELECT * FROM Encuentro
			WHERE IdPais1=@idPais4Grupo AND IdPais2=@idPais2Grupo
				AND IdCampeonato=@nuevoIdCampeonato AND IdFase=1)
BEGIN
	INSERT INTO Encuentro
		(Id, IdPais1, Goles1, IdPais2, Goles2, Fecha, IdEstadio, IdFase, IdCampeonato)
		VALUES(@nuevoIdEncuentro, @idPais4Grupo, 1, @idPais2Grupo, 1, '2022-11-25', @idEstadio7, 1, @nuevoIdCampeonato);
	SET @nuevoIdEncuentro=@nuevoIdEncuentro+1;
END

-- Ecuador vs Senegal
IF NOT EXISTS(SELECT * FROM Encuentro
			WHERE IdPais1=@idPais2Grupo AND IdPais2=@idPais3Grupo
				AND IdCampeonato=@nuevoIdCampeonato AND IdFase=1)
BEGIN
	INSERT INTO Encuentro
		(Id, IdPais1, Goles1, IdPais2, Goles2, Fecha, IdEstadio, IdFase, IdCampeonato)
		VALUES(@nuevoIdEncuentro, @idPais2Grupo, 1, @idPais3Grupo, 2, '2022-11-29', @idEstadio7, 1, @nuevoIdCampeonato);
	SET @nuevoIdEncuentro=@nuevoIdEncuentro+1;
END

-- Paises Bajos vs Catar
IF NOT EXISTS(SELECT * FROM Encuentro
			WHERE IdPais1=@idPais4Grupo AND IdPais2=@idPais1Grupo
				AND IdCampeonato=@nuevoIdCampeonato AND IdFase=1)
BEGIN
	INSERT INTO Encuentro
		(Id, IdPais1, Goles1, IdPais2, Goles2, Fecha, IdEstadio, IdFase, IdCampeonato)
		VALUES(@nuevoIdEncuentro, @idPais4Grupo, 2, @idPais1Grupo, 0, '2022-11-29', @idEstadio1, 1, @nuevoIdCampeonato);
	SET @nuevoIdEncuentro=@nuevoIdEncuentro+1;
END



SET IDENTITY_INSERT Encuentro OFF

--***** Validar si ya están los Paises del Grupo B *****
SET @idPais1Grupo=NULL;
SET @idPais2Grupo=NULL;
SET @idPais3Grupo=NULL;
SET @idPais4Grupo=NULL;

SET IDENTITY_INSERT Pais ON --Obliga a reemplazar el Id autonumérico

SELECT @idPais1Grupo=id  FROM Pais WHERE pais='Inglaterra';
IF @idPais1Grupo IS NULL --verifica si 'Inglaterra' no existe en la base de datos
BEGIN
    INSERT INTO Pais
        (Id, Pais, Entidad) VALUES(@nuevoIdPais, 'Inglaterra', '');
    SET @idPais1Grupo = @nuevoIdPais;
    SET @nuevoIdPais = @nuevoIdPais + 1;
END;

SELECT @idPais2Grupo=id  FROM Pais WHERE pais='Irán';
IF @idPais2Grupo IS NULL --verifica si 'Irán' no existe en la base de datos
BEGIN
    INSERT INTO Pais
        (Id, Pais, Entidad) VALUES(@nuevoIdPais, 'Irán', '');
    SET @idPais2Grupo = @nuevoIdPais;
    SET @nuevoIdPais = @nuevoIdPais + 1;
END;

SELECT @idPais3Grupo=id  FROM Pais WHERE pais='Estados Unidos';
IF @idPais3Grupo IS NULL --verifica si 'Estados Unidos' no existe en la base de datos
BEGIN
    INSERT INTO Pais
        (Id, Pais, Entidad) VALUES(@nuevoIdPais, 'Estados Unidos', '');
    SET @idPais3Grupo = @nuevoIdPais;
    SET @nuevoIdPais = @nuevoIdPais + 1;
END;

SELECT @idPais4Grupo=id  FROM Pais WHERE pais='Gales';
IF @idPais4Grupo IS NULL --verifica si 'Gales' no existe en la base de datos
BEGIN
    INSERT INTO Pais
        (Id, Pais, Entidad) VALUES(@nuevoIdPais, 'Gales', '');
    SET @idPais4Grupo = @nuevoIdPais;
    SET @nuevoIdPais = @nuevoIdPais + 1;
END;

SET IDENTITY_INSERT Pais OFF

SELECT @totalPaises=COUNT(*)
    FROM GrupoPais
    WHERE IdGrupo=@nuevoIdGrupo+1;

IF @totalPaises=0
BEGIN
	INSERT INTO GrupoPais
		(IdGrupo, IdPais)
		VALUES
		(@nuevoIdGrupo+1, @idPais1Grupo),
		(@nuevoIdGrupo+1, @idPais2Grupo),
		(@nuevoIdGrupo+1, @idPais3Grupo),
		(@nuevoIdGrupo+1, @idPais4Grupo)
END

--***** Validar si ya estan los Encuentros de la Fase de Grupos del Grupo B *****

SET IDENTITY_INSERT Encuentro ON --Obliga a reemplazar el Id autonumérico

-- Inglaterra vs Irán
IF NOT EXISTS(SELECT * FROM Encuentro
			WHERE IdPais1=@idPais1Grupo AND IdPais2=@idPais2Grupo
				AND IdCampeonato=@nuevoIdCampeonato AND IdFase=1)
BEGIN
	INSERT INTO Encuentro
		(Id, IdPais1, Goles1, IdPais2, Goles2, Fecha, IdEstadio, IdFase, IdCampeonato)
		VALUES(@nuevoIdEncuentro, @idPais1Grupo, 6, @idPais2Grupo, 2, '2022-11-21', @idEstadio7, 1, @nuevoIdCampeonato);
	SET @nuevoIdEncuentro=@nuevoIdEncuentro+1;
END

-- Estados Unidos vs Gales
IF NOT EXISTS(SELECT * FROM Encuentro
			WHERE IdPais1=@idPais3Grupo AND IdPais2=@idPais4Grupo
				AND IdCampeonato=@nuevoIdCampeonato AND IdFase=1)
BEGIN
	INSERT INTO Encuentro
		(Id, IdPais1, Goles1, IdPais2, Goles2, Fecha, IdEstadio, IdFase, IdCampeonato)
		VALUES(@nuevoIdEncuentro, @idPais3Grupo, 1, @idPais4Grupo, 1, '2022-11-21', @idEstadio6, 1, @nuevoIdCampeonato);
	SET @nuevoIdEncuentro=@nuevoIdEncuentro+1;
END

-- Inglaterra vs Estados Unidos
IF NOT EXISTS(SELECT * FROM Encuentro
			WHERE IdPais1=@idPais1Grupo AND IdPais2=@idPais3Grupo
				AND IdCampeonato=@nuevoIdCampeonato AND IdFase=1)
BEGIN
	INSERT INTO Encuentro
		(Id, IdPais1, Goles1, IdPais2, Goles2, Fecha, IdEstadio, IdFase, IdCampeonato)
		VALUES(@nuevoIdEncuentro, @idPais1Grupo, 0, @idPais3Grupo, 0, '2022-11-25', @idEstadio1, 1, @nuevoIdCampeonato);
	SET @nuevoIdEncuentro=@nuevoIdEncuentro+1;
END

-- Gales vs Irán
IF NOT EXISTS(SELECT * FROM Encuentro
			WHERE IdPais1=@idPais4Grupo AND IdPais2=@idPais2Grupo
				AND IdCampeonato=@nuevoIdCampeonato AND IdFase=1)
BEGIN
	INSERT INTO Encuentro
		(Id, IdPais1, Goles1, IdPais2, Goles2, Fecha, IdEstadio, IdFase, IdCampeonato)
		VALUES(@nuevoIdEncuentro, @idPais4Grupo, 0, @idPais2Grupo, 2, '2022-11-25', @idEstadio6, 1, @nuevoIdCampeonato);
	SET @nuevoIdEncuentro=@nuevoIdEncuentro+1;
END


-- Gales vs Inglaterra
IF NOT EXISTS(SELECT * FROM Encuentro
			WHERE IdPais1=@idPais4Grupo AND IdPais2=@idPais1Grupo
				AND IdCampeonato=@nuevoIdCampeonato AND IdFase=1)
BEGIN
	INSERT INTO Encuentro
		(Id, IdPais1, Goles1, IdPais2, Goles2, Fecha, IdEstadio, IdFase, IdCampeonato)
		VALUES(@nuevoIdEncuentro, @idPais4Grupo, 0, @idPais1Grupo, 3, '2022-11-29', @idEstadio6, 1, @nuevoIdCampeonato);
	SET @nuevoIdEncuentro=@nuevoIdEncuentro+1;
END

-- Irán vs Estados Unidos
IF NOT EXISTS(SELECT * FROM Encuentro
			WHERE IdPais1=@idPais2Grupo AND IdPais2=@idPais3Grupo
				AND IdCampeonato=@nuevoIdCampeonato AND IdFase=1)
BEGIN
	INSERT INTO Encuentro
		(Id, IdPais1, Goles1, IdPais2, Goles2, Fecha, IdEstadio, IdFase, IdCampeonato)
		VALUES(@nuevoIdEncuentro, @idPais2Grupo, 0, @idPais3Grupo, 1, '2022-11-29', @idEstadio4, 1, @nuevoIdCampeonato);
	SET @nuevoIdEncuentro=@nuevoIdEncuentro+1;
END

SET IDENTITY_INSERT Encuentro OFF
