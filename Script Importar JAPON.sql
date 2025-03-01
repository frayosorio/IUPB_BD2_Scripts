USE DivisionPolitica
GO

DROP TABLE #Japon

--Crear una tabla temporal para recibir los datos
CREATE TABLE #Japon(
	Prefectura varchar(100),
	Capital varchar(100),
	Area float,
	Poblacion int
);

BULK INSERT #Japon
	FROM 'D:\Catedra\IU Pascual Bravo\Bases de Datos II\Ejercicios\Proyecto Division Politica\Japon.csv'
	WITH (DATAFILETYPE='char',
			FIELDTERMINATOR=',');

DECLARE @IdPais int
SELECT @IdPais=Id FROM Pais
	WHERE Nombre='Japón';

IF @IdPais IS NULL
BEGIN
	DECLARE @IdTR int,
			@IdC int

	SELECT @IdTR=Id FROM TipoRegion
		WHERE TipoRegion='Prefectura';
	IF @IdTR IS NULL
	BEGIN
		INSERT INTO TipoRegion
			(TipoRegion)
			VALUES('Prefectura');
		SET @IdTR=@@IDENTITY
	END;

	SELECT @IdC=Id FROM Continente
		WHERE Nombre='ASIA';
	IF @IdC IS NULL
	BEGIN
		INSERT INTO Continente
			(Nombre)
			VALUES('ASIA');
		SET @IdC=@@IDENTITY
	END;

	INSERT INTO Pais
		(Nombre, IdContinente, IdTipoRegion, Moneda)
		VALUES('Japón', @IdC, @IdTR, 'YEN');
	SET @IdPais=@@IDENTITY
END;

--Agregar los registros de las REGIONES
INSERT INTO Region
	(Nombre, IdPais, Area, Poblacion)
	SELECT J.Prefectura, @IdPais, J.Area, J.Poblacion 
		FROM #Japon J
		WHERE J.Prefectura NOT IN (SELECT Nombre
									FROM Region
									WHERE IdPais=@IdPais)

--Agregar los registros de CIUDAD
INSERT INTO Ciudad
	(Nombre, IdRegion, CapitalRegion)
	SELECT J.Capital, R.Id, 1
		FROM #Japon J
			JOIN Region R ON J.Prefectura=R.Nombre 
			AND  R.IdPais=@IdPais