--Listar los tipos de region
SELECT * FROM TipoRegion

--Listar las regiones de JAPON
SELECT * 
	FROM Pais P
		LEFT JOIN Region R
			ON P.Id=R.IdPais
	WHERE P.Nombre='Jap�n'

--Contar las regiones de JAPON
SELECT COUNT(*)
	FROM Pais P
		LEFT JOIN Region R
			ON P.Id=R.IdPais
	WHERE P.Nombre='Jap�n'

--Eliminar las regiones de JAPON
DELETE R 
	FROM Pais P
		LEFT JOIN Region R
			ON P.Id=R.IdPais
	WHERE P.Nombre='Jap�n'

--Crear un indice que evite REGIONES duplicadas
CREATE UNIQUE INDEX ixRegion
	ON Region(IdPais, Nombre);

--Crear un indice que evite CIUDADES duplicadas
CREATE UNIQUE INDEX ixCiudad
	ON Ciudad(IdRegion, Nombre);