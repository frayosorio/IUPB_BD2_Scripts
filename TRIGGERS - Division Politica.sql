--version que no deja capital de region ante ambiguedades
CREATE TRIGGER tActualizarCapitalRegion
ON Ciudad
FOR INSERT, UPDATE
AS BEGIN
	--Validar que se esta actualizando una capital de region
	IF EXISTS(SELECT * FROM Inserted WHERE CapitalRegion=1)
	BEGIN
		-- Verificar si la inserción o actualización causaría que haya más de una capital de región
		IF EXISTS(SELECT 1
					FROM Inserted I
						JOIN Ciudad C ON I.IdRegion=C.IdRegion
					WHERE I.CapitalRegion=1 AND C.CapitalRegion=1 AND C.Id<>I.Id
					GROUP BY I.IdRegion
					HAVING COUNT(*) > 1)
		BEGIN
			RAISERROR('No se acepta más de una capital por región', 16, 1)
			ROLLBACK TRANSACTION
		END

		-- Si se está estableciendo una ciudad como capital, asegurarse de que las demás no lo sean
		UPDATE Ciudad
			SET CapitalRegion=0
			FROM Ciudad C
				JOIN Inserted I ON C.IdRegion=I.IdRegion
					AND C.Id<>I.Id
				
		
	END
END
GO

--version que deja la ultima capital de region ante ambiguedades
ALTER TRIGGER tActualizarCapitalRegion
ON Ciudad
FOR INSERT, UPDATE
AS BEGIN
	-- Asegurarnos de que solo quede una ciudad como CapitalRegion = 1 por cada IdRegion
	WITH UltimaCapital AS (SELECT Id, IdRegion
							FROM inserted
							WHERE CapitalRegion=1)
	UPDATE C
		SET C.CapitalRegion=CASE WHEN C.Id=U.Id THEN 1
								ELSE 0
							END
		FROM Ciudad C
		JOIN UltimaCapital U ON U.IdRegion = C.IdRegion

END
GO

--Trigger para actualizar la capital de un país
ALTER TRIGGER tActualizarCapitalPais
ON Ciudad
FOR INSERT, UPDATE
AS
BEGIN
	-- Evitar ejecución recursiva del trigger
    IF TRIGGER_NESTLEVEL() > 1
        RETURN;	

	-- Asegurarnos de que solo quede una ciudad como CapitalPais = 1 por cada Pais
	WITH UltimaCapital AS (SELECT C.Id, R.IdPais
							FROM Inserted I
								JOIN Ciudad C ON C.Id=I.Id
								JOIN Region R ON C.IdRegion=R.Id
							WHERE I.CapitalPais=1)

	UPDATE C
		SET C.CapitalPais=CASE WHEN C.Id=U.Id THEN 1
							ELSE 0
							END
		FROM Ciudad C
			JOIN Region R ON C.IdRegion=R.Id
			JOIN UltimaCapital U ON U.IdPais = R.IdPais
END;
GO;