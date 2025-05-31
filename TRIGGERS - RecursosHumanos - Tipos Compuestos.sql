--Validar [idciudad] en [direccion] de la tabla [persona]
CREATE OR REPLACE FUNCTION fvalidarciudaddireccion()
RETURNS TRIGGER AS $$
BEGIN
	IF NOT EXISTS (SELECT 1 FROM ciudad WHERE id = (NEW.direccion).idciudad ) THEN
		RAISE EXCEPTION 'La [ciudad] con [id]=% no existe en [direccion]', (NEW.direccion).idciudad;
	END IF;
	RETURN NEW;
END
$$ LANGUAGE plpgsql;

CREATE TRIGGER tvalidarciudaddireccion
BEFORE INSERT OR UPDATE ON persona
	FOR EACH ROW
		EXECUTE FUNCTION fvalidarciudaddireccion();

--Validar [idciudad] y [idgrado] en [informacion] de la tabla [informacionacademica]
CREATE OR REPLACE FUNCTION fvalidarinformacionacademica()
RETURNS TRIGGER AS $$
BEGIN
	IF NOT EXISTS(SELECT 1 FROM ciudad WHERE id = (NEW.informacion).idciudad) THEN
		RAISE EXCEPTION 'La [ciudad] con [id]=% no existe en [informacion]', (NEW.informacion).idciudad;
	END IF;

	IF NOT EXISTS(SELECT 1 FROM gradoacademico WHERE id = (NEW.informacion).idgrado) THEN
		RAISE EXCEPTION 'El [gradoacademico] con [id]=% no existe en [informacion]', (NEW.informacion).idgrado;
	END IF;

	RETURN NEW;
END
$$ LANGUAGE plpgsql;

CREATE TRIGGER tvalidarinformacionacademica
BEFORE INSERT OR UPDATE ON informacionacademica
	FOR EACH ROW
		EXECUTE FUNCTION fvalidarinformacionacademica();

--Validar [idciudad] en [informacion] de la tabla [informacionlaboral]
CREATE OR REPLACE FUNCTION fvalidarinformacionlaboral()
RETURNS TRIGGER AS $$
BEGIN
	IF NOT EXISTS(SELECT 1 FROM ciudad WHERE id = (NEW.informacion).idciudad) THEN
		RAISE EXCEPTION 'La [ciudad] con [id]=% no existe en [informacion]', (NEW.informacion).idciudad;
	END IF;

	RETURN NEW;
END
$$ LANGUAGE plpgsql;

CREATE TRIGGER tvalidarinformacionlaboral
BEFORE INSERT OR UPDATE ON informacionlaboral
	FOR EACH ROW
		EXECUTE FUNCTION fvalidarinformacionlaboral();

--Validar [idsector] en [habilidad] de la tabla [habilidadprofesional]
CREATE OR REPLACE FUNCTION fvalidarhabilidadprofesional()
RETURNS TRIGGER AS $$
BEGIN
	IF NOT EXISTS(SELECT 1 FROM sector WHERE id = (NEW.habilidad).idsector) THEN
		RAISE EXCEPTION 'El [sector] con [id]=% no existe en [habilidad]', (NEW.habilidad).idsector;
	END IF;

	RETURN NEW;
END
$$ LANGUAGE plpgsql;

CREATE TRIGGER tvalidarhabilidadprofesional
BEFORE INSERT OR UPDATE ON habilidadprofesional
	FOR EACH ROW
		EXECUTE FUNCTION fvalidarhabilidadprofesional();
