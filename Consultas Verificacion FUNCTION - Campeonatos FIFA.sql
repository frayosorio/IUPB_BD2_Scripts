--Listar los Encuentros de un Grupo
DECLARE @IdGrupo INT
SET @IdGrupo=5
SELECT *
	FROM vEnCuentro
	WHERE (IdPais1 IN (SELECT IdPais FROM GrupoPais WHERE IdGrupo=@IdGrupo)
	OR IdPais2 IN (SELECT IdPais FROM GrupoPais WHERE IdGrupo=@IdGrupo))
	AND IdCampeonato=(SELECT IdCampeonato FROM Grupo WHERE Id=@IdGrupo)

--Consultar la funcion de tabla
SELECT *
	FROM fTablaPosiciones(5)
	ORDER BY PUNTOS desc