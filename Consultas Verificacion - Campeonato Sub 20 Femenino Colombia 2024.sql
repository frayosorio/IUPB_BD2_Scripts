--Consulta de verificacion de Grupos
SELECT c.id, c.campeonato, p.pais, g.grupo, g.id, pg.id, pg.pais
    FROM campeonato c
        JOIN grupo g ON g.idcampeonato=c.id
        JOIN pais p ON c.idpais=p.id
        LEFT JOIN grupopais gp ON gp.idgrupo = g.id
        LEFT JOIN pais pg ON pg.id = gp.idpais
        WHERE campeonato='FIFA U-20 Women''s World Cup Colombia 2024';