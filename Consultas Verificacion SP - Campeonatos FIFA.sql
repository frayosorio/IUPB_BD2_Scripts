--Listar los paises de un Grupo
SELECT IdPais IdPaisG, *
	FROM vGrupo
	WHERE Id= 2
	ORDER BY IdPaisG

--Listar los Estadios
SELECT *
	FROM Estadio

--Listar los Encuentros de un Campeonato
SELECT *
	FROM vEnCuentro
	WHERE IdCampeonato=4

--Listar los Encuentros de un Grupo
DECLARE @IdGrupo INT
SET @IdGrupo=2
SELECT *
	FROM vEnCuentro
	WHERE (IdPais1 IN (SELECT IdPais FROM GrupoPais WHERE IdGrupo=@IdGrupo)
	OR IdPais2 IN (SELECT IdPais FROM GrupoPais WHERE IdGrupo=@IdGrupo))
	AND IdCampeonato=(SELECT IdCampeonato FROM Grupo WHERE Id=@IdGrupo)

--Ejecutar el SP que genera los encuentros de un Grupo
EXEC spGenerarEncuentrosGrupo 2

--Eliminar registros de un grupo
DECLARE @IdGrupoEliminar INT
SET @IdGrupoEliminar=25
DELETE FROM EnCuentro
	WHERE (IdPais1 IN (SELECT IdPais FROM GrupoPais WHERE IdGrupo=@IdGrupoEliminar)
	OR IdPais2 IN (SELECT IdPais FROM GrupoPais WHERE IdGrupo=@IdGrupoEliminar))
	AND IdCampeonato=(SELECT IdCampeonato FROM Grupo WHERE Id=@IdGrupoEliminar)


