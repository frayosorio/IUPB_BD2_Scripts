--Crear vistas

CREATE VIEW vGrupo
AS
SELECT G.IdCampeonato, C.Campeonato, C.IdPais IdPaisOrganizador, P.Pais PaisOrganizador, G.Grupo, G.Id, GP.IdPais, PG.Pais
FROM Campeonato C
JOIN Grupo G ON G.idCampeonato=C.Id
JOIN Pais P ON C.IdPais=P.Id
LEFT JOIN GrupoPais GP ON GP.idGrupo = G.Id
LEFT JOIN Pais PG ON PG.Id = GP.IdPais
GO

ALTER VIEW vEnCuentro
AS
SELECT E.Id, E.Fecha, E.IdPais1, P1.Pais Pais1, E.Goles1, E.IdPais2, P2.Pais Pais2, E.Goles2,
        C.Campeonato, E.IdCampeonato, E.IdFase, F.Fase, ES.Estadio, E.IdEstadio, CD.Ciudad, ES.IdCiudad
FROM EnCuentro E
JOIN Pais P1 ON E.IdPais1=P1.Id
JOIN Pais P2 ON E.IdPais2=P2.Id
JOIN Campeonato C ON E.IdCampeonato=C.Id
            JOIN Estadio ES ON E.IdEstadio=ES.Id
JOIN Ciudad CD ON ES.IdCiudad=CD.Id
            JOIN Fase F ON E.IdFase=F.Id;
GO