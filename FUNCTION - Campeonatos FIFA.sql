CREATE FUNCTION fTablaPosiciones(@idGrupo int)
RETURNS @TablaPosiciones TABLE(
	IdPais int,
	Pais varchar(100),
	PJ int,
	PG int,
	PE int,
	PP int,
	GF int,
	GC int,
	Puntos int
)
AS
BEGIN
	DECLARE @tp TABLE(
		IdPais int,
		Pais varchar(100),
		PJ int,
		PG int,
		PE int,
		PP int,
		GF int,
		GC int
	)

	INSERT INTO @tp
		SELECT P.Id, P.Pais, 0, 0, 0, 0, 0, 0
			FROM GrupoPais GP
				JOIN Pais P ON P.Id=GP.IdPais
			WHERE GP.IdGrupo = @idGrupo

	DECLARE @idPais int,
		@valor int,
		@idCampeonato int

	SELECT @idCampeonato=IdCampeonato
		FROM Grupo
		WHERE Id=@idGrupo
	
	DECLARE cPaises CURSOR FOR
		SELECT IdPais
			FROM @tp

	OPEN cPaises
	FETCH NEXT FROM cPaises INTO @idPais
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SELECT @valor=COUNT(*)
			FROM Encuentro
			WHERE (IdPais1=@idPais OR IdPais2=@idPais)
				AND IdFase=1 AND IdCampeonato=@idCampeonato
				AND Goles1 IS NOT NULL AND Goles2 IS NOT NULL

		UPDATE @tp
			SET PJ=@valor
			WHERE IdPais=@idPais

		SELECT @valor=SUM(CASE WHEN (IdPais1=@idPais AND Goles1>Goles2) OR (IdPais2=@idPais AND Goles2>Goles1)
							THEN 1
							ELSE 0
							END)
			FROM Encuentro
			WHERE (IdPais1=@idPais OR IdPais2=@idPais)
				AND IdFase=1 AND IdCampeonato=@idCampeonato
				AND Goles1 IS NOT NULL AND Goles2 IS NOT NULL

		UPDATE @tp
			SET PG=@valor
			WHERE IdPais=@idPais

		SELECT @valor=SUM(CASE WHEN (IdPais1=@idPais AND Goles1=Goles2) OR (IdPais2=@idPais AND Goles2=Goles1)
							THEN 1
							ELSE 0
							END)
			FROM Encuentro
			WHERE (IdPais1=@idPais OR IdPais2=@idPais)
				AND IdFase=1 AND IdCampeonato=@idCampeonato
				AND Goles1 IS NOT NULL AND Goles2 IS NOT NULL

		UPDATE @tp
			SET PE=@valor
			WHERE IdPais=@idPais

		SELECT @valor=SUM(CASE WHEN (IdPais1=@idPais AND Goles1<Goles2) OR (IdPais2=@idPais AND Goles2<Goles1)
							THEN 1
							ELSE 0
							END)
			FROM Encuentro
			WHERE (IdPais1=@idPais OR IdPais2=@idPais)
				AND IdFase=1 AND IdCampeonato=@idCampeonato
				AND Goles1 IS NOT NULL AND Goles2 IS NOT NULL

		UPDATE @tp
			SET PP=@valor
			WHERE IdPais=@idPais

		SELECT @valor=SUM(CASE WHEN IdPais1=@idPais 
							THEN Goles1
							ELSE Goles2
							END)
			FROM Encuentro
			WHERE (IdPais1=@idPais OR IdPais2=@idPais)
				AND IdFase=1 AND IdCampeonato=@idCampeonato
				AND Goles1 IS NOT NULL AND Goles2 IS NOT NULL

		UPDATE @tp
			SET GF=@valor
			WHERE IdPais=@idPais

		SELECT @valor=SUM(CASE WHEN IdPais1=@idPais 
							THEN Goles2
							ELSE Goles1
							END)
			FROM Encuentro
			WHERE (IdPais1=@idPais OR IdPais2=@idPais)
				AND IdFase=1 AND IdCampeonato=@idCampeonato
				AND Goles1 IS NOT NULL AND Goles2 IS NOT NULL

		UPDATE @tp
			SET GC=@valor
			WHERE IdPais=@idPais

		FETCH NEXT FROM cPaises INTO @idPais
	END

	DEALLOCATE cPaises

	INSERT INTO @TablaPosiciones
		SELECT IdPais, Pais, PJ, PG, PE, PP, GF, GC, 3*PG+PE
			FROM @tp
			ORDER BY 3*PG+PE

	RETURN
END
GO

ALTER FUNCTION fTablaPosiciones(@idGrupo int)
RETURNS @TablaPosiciones TABLE(
	IdPais int,
	Pais varchar(100),
	PJ int,
	PG int,
	PE int,
	PP int,
	GF int,
	GC int,
	Puntos int
)
AS
BEGIN
	INSERT INTO @TablaPosiciones
		SELECT P.Id, P.Pais, COUNT(*), 
			SUM(CASE WHEN (P.Id=E.IdPais1 AND Goles1>Goles2) OR (P.Id=E.IdPais2 AND Goles2>Goles1)
							THEN 1
							ELSE 0
							END), 
			SUM(CASE WHEN (P.Id=E.IdPais1 AND Goles1=Goles2) OR (P.Id=E.IdPais2 AND Goles2=Goles1)
							THEN 1
							ELSE 0
							END), 
			SUM(CASE WHEN (P.Id=E.IdPais1 AND Goles1<Goles2) OR (P.Id=E.IdPais2 AND Goles2<Goles1)
							THEN 1
							ELSE 0
							END), 
			SUM(CASE WHEN P.Id=E.IdPais1 
							THEN Goles1
							ELSE Goles2
							END),
			SUM(CASE WHEN P.Id=E.IdPais1 
							THEN Goles2
							ELSE Goles1
							END),
			SUM(CASE WHEN P.Id=E.IdPais1 AND Goles1>Goles2 THEN 3
					WHEN P.Id=E.IdPais2 AND Goles2>Goles1 THEN 3
					WHEN Goles2=Goles1 THEN 1
					ELSE 0
					END)
			FROM GrupoPais GP
				JOIN Pais P ON GP.IdPais=P.Id
				JOIN Encuentro E ON (P.Id=E.IdPais1 OR P.Id=E.IdPais2)
			WHERE GP.IdGrupo=@idGrupo
				AND E.IdFase=1
			GROUP BY P.Id, P.Pais

	RETURN
END
GO

--Funcion escalar que devuelve el estadio de un encuentro
ALTER FUNCTION fObtenerEstadioEncuentro(@idEncuentro int)
RETURNS varchar(200)
AS
BEGIN
	DECLARE @Estadio varchar(200)
	SELECT @Estadio=Estadio + ' - ' + Ciudad +  ' - ' + Campeonato
		FROM vEnCuentro
		WHERE Id=@idEncuentro

	RETURN @Estadio
END
