--Listar Grupos Campeonato Catar
SELECT *
	FROM vGrupo
	WHERE Campeonato LIKE '%2022%'


--Listar los Encuentros de un Grupo
DECLARE @IdGrupo INT
SET @IdGrupo=26
SELECT *
	FROM vEnCuentro
	WHERE (IdPais1 IN (SELECT IdPais FROM GrupoPais WHERE IdGrupo=@IdGrupo)
	OR IdPais2 IN (SELECT IdPais FROM GrupoPais WHERE IdGrupo=@IdGrupo))
	AND IdCampeonato=(SELECT IdCampeonato FROM Grupo WHERE Id=@IdGrupo)

--Consultar la funcion de tabla
SELECT *
	FROM fTablaPosiciones(25)
	ORDER BY PUNTOS desc


--Eliminar Paises y Grupos de un Campeonato
DELETE GP
	FROM Grupo G
		JOIN GrupoPais GP on gp.idgrupo=g.id
		--DELETE FROM Grupo
		where IdCampeonato=11
