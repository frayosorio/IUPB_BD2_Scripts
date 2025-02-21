--Eliminar indice (para validar consecuencias)
DROP INDEX ixPais_Pais ON Pais;

--Agregar registros (que estan duplicados)
INSERT INTO Pais
	(Pais, Entidad)
	VALUES('Colombia', 'División Mayor del Futbol');
INSERT INTO Pais
	(Pais, Entidad)
	VALUES('Argentina', 'AFA');

--Contar registros con valores duplicados
SELECT Pais, COUNT(*) Repeticiones
	FROM Pais
	GROUP BY Pais
	HAVING COUNT(*)>1

--Consulta que cumpla con valores de una lista
SELECT *
	FROM Pais
	WHERE Pais IN ('Argentina', 'Colombia')

--Consultar los registros que corresponden a los valores repetidos(SUBCONSULTAS)
SELECT p.* 
	FROM Pais p
	JOIN (
		SELECT Pais 
		FROM Pais
		GROUP BY Pais
		HAVING COUNT(*) > 1
	) duplicados
	ON p.Pais = duplicados.Pais;

--Retirar registros
DELETE FROM Pais
	WHERE Id=1

DELETE FROM Pais
	WHERE Id>1 AND Pais='Colombia'

DELETE FROM Pais
	WHERE Id>2 AND Pais='Argentina'

--Crear de nuevo el indice
CREATE UNIQUE INDEX ixPais_Pais ON Pais(Pais);

--Consulta a una tabla con múltiples claves foráneas
SELECT *
	FROM Encuentro

--Creación de una vista (Se agiliza las consultas)
CREATE VIEW vEncuentro
AS
	SELECT E.Fecha, E.IdPais1, P1.Pais Pais1, E.Goles1, E.IdPais2, P2.Pais Pais2, E.Goles2,
        C.Campeonato, E.IdCampeonato, E.IdFase, F.Fase, ES.Estadio, E.IdEStadio
		FROM Encuentro E
			JOIN Pais P1 ON E.IdPais1=P1.Id
			JOIN Pais P2 ON E.IdPais2=P2.Id
			JOIN Campeonato C ON E.IdCampeonato=C.Id
            JOIN Estadio ES ON E.IdEstadio=ES.Id
            JOIN Fase F ON E.IdFase=F.Id;

--JOIN de una vista con tablas
SELECT E.*, C.Ciudad
	FROM vEncuentro E
	JOIN Estadio Es ON E.IdEstadio=Es.Id
	JOIN Ciudad C ON C.Id=Es.IdCiudad