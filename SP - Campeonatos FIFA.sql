ALTER PROCEDURE spGenerarEncuentrosGrupo
@idGrupo int
AS BEGIN
	DECLARE @idPais1 int, @idPais2 int, @idCampeonato int

	--Obtner el ID del Campeonato del grup
	SELECT @idCampeonato=IdCampeonato
		FROM Grupo
		WHERE Id=@idGrupo

	--Definir un Cursor para la lista de paises del grupo
	DECLARE cPaises CURSOR FOR
		SELECT IdPais
			 FROM GrupoPais
			 WHERE IdGrupo = @idGrupo
			 ORDER BY IdPais

	--Abrir el cursor
	OPEN cPaises

	--Leer primer fila del cursor
	FETCH NEXT FROM cPaises INTO @idPais1

	--Recorrer todas las filas 
	WHILE @@FETCH_STATUS=0
	BEGIN
		--Obtener los siguientes paises
		DECLARE cSiguientesPaises CURSOR FOR
			SELECT IdPais
				 FROM GrupoPais
				 WHERE IdGrupo = @idGrupo
					AND IdPais > @idPais1
				 ORDER BY IdPais

		--Abrir el cursor
		OPEN cSiguientesPaises

		--Leer primer fila del cursor
		FETCH NEXT FROM cSiguientesPaises INTO @idPais2

		--Recorrer todas las filas 
		WHILE @@FETCH_STATUS=0
			BEGIN
				--Verificar que el Encuentro no exista
				IF NOT EXISTS(SELECT 1 FROM Encuentro
							WHERE ((IdPais1=@idPais1 AND IdPais2=@idPais2)
								OR(IdPais1=@idPais2 AND IdPais2=@idPais1))
								AND IdFase=1
								AND IdCampeonato=@IdCampeonato)
				BEGIN
					INSERT INTO Encuentro
						(IdPais1, IdPais2, IdEstadio, IdFase, IdCampeonato)
						VALUES(@idPais1, @idPais2, 0, 1, @idCampeonato);
				END

				--avanzar a la siguiente fila
				FETCH NEXT FROM cSiguientesPaises INTO @idPais2
			END

		--Liberar cursor
		DEALLOCATE cSiguientesPaises

		--avanzar a la siguiente fila
		FETCH NEXT FROM cPaises INTO @idPais1
	END

	--Liberar cursor
	DEALLOCATE cPaises


END