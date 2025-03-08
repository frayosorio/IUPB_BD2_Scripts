CREATE TRIGGER tActualizarCapitalRegion
ON Ciudad
FOR INSERT, UPDATE
AS BEGIN
	--Validar que se esta actualizando una capital de region
	IF EXISTS(SELECT * FROM Inserted WHERE CapitalRegion=1)
	BEGIN
		UPDATE Ciudad
			SET CapitalRegion=0
			FROM Ciudad C
				JOIN Inserted I ON C.IdRegion=I.IdRegion
					AND C.Id<>I.Id
				
		
	END
END