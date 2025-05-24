--Eliminar la BD si existe
DROP DATABASE RecursosHumanos WITH (FORCE);

--Crear la base de datos
CREATE DATABASE RecursosHumanos; 

--Se debe hacer cambio de conexion a BD
CREATE TABLE tipodocumento(
	id SERIAL PRIMARY KEY,
	tipo VARCHAR(50) NOT NULL,
	sigla VARCHAR(50) NOT NULL,
	UNIQUE(tipo),
	UNIQUE(sigla)
);

CREATE TABLE pais(
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(100) NOT NULL,
	UNIQUE(nombre)
);

CREATE TABLE  ciudad(
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(100) NOT NULL,
	region VARCHAR(100) NOT NULL,
	idpais INT NOT NULL REFERENCES pais(id),
	UNIQUE(idpais, region, nombre)
);

CREATE TYPE direcciontipo 
AS (
	direccion VARCHAR(100),
	idciudad INT
);

/*
SELECT  *--typname, typcategory, typtype 
	FROM pg_type 
	ORDER BY typname;
*/

CREATE TABLE persona(
	id SERIAL PRIMARY KEY,
	apellido1 VARCHAR(50) NOT NULL,
	apellido2 VARCHAR(50) NOT NULL,
	nombres VARCHAR(100) NOT NULL,
	documento VARCHAR(20) NOT NULL,
	idtipodocumento INT NOT NULL REFERENCES tipodocumento(id),
	fechanacimiento DATE NOT NULL,
	idciudadnacimiento INT NOT NULL REFERENCES ciudad(id),
	direccion DIRECCIONTIPO,
	movil VARCHAR(100),
	correo VARCHAR(100),
	foto BYTEA,
	UNIQUE(idtipodocumento, documento)
);

CREATE TYPE informacionbasetipo 
AS (
	desde DATE,
	hasta DATE,
	entidad VARCHAR(100)
);


CREATE TYPE informacionacademicatipo
AS (
	BASE informacionbasetipo,
	titulo VARCHAR(100),
	idgrado INT,
	idciudad INT,
	proyecto TEXT
);

CREATE TYPE informacionlaboraltipo
AS (
	BASE informacionbasetipo,
	cargo VARCHAR(100),
	idciudad INT,
	telefonocontacto VARCHAR(100),
	correocontacto VARCHAR(100)
);

CREATE TABLE informacionacademica (
	idpersona INT NOT NULL references persona(id),
	informacion informacionacademicatipo
	--CONSTRAINT fk_informacionacademica_ciudad FOREIGN KEY ((informacion).idciudad) REFERENCES ciudad(id)
);

CREATE TABLE informacionlaboral (
	idpersona INT NOT NULL references persona(id),
	informacion informacionlaboraltipo
);

CREATE TABLE nivelacademico(
	id SERIAL PRIMARY KEY,
	nivel VARCHAR(50) NOT NULL,
	UNIQUE(nivel)
);

CREATE TABLE gradoacademico(
	id SERIAL PRIMARY KEY,
	grado VARCHAR(50) NOT NULL,
	idnivel INT NOT NULL references nivelacademico(id),
	UNIQUE(grado)
);

CREATE TABLE sector(
	id SERIAL PRIMARY KEY,
	sector VARCHAR(50) NOT NULL,	--Ej: Tecnología, Finanzas, Salud
	UNIQUE(sector)
);

CREATE TABLE idioma(
	id SERIAL PRIMARY KEY,
	idioma VARCHAR(50) NOT NULL,
	UNIQUE(idioma)
);

CREATE TYPE habilidadbasetipo 
AS (
	nombre VARCHAR(100),
	descripcion TEXT,
	nivel VARCHAR(50),	--Ej: de 1 a 10, A1 a C1
	añosexperiencia INT
);

CREATE TYPE habilidadprofesionaltipo 
AS (
	BASE habilidadbasetipo,
	idsector INT,
	certificacion TEXT	--eJ: Certificacion AWS, PMP, ITIL, etc.
);

CREATE TYPE habilidadpersonaltipo 
AS (
	BASE habilidadbasetipo,
	categoria VARCHAR(50),	--Ej: Música, Pintura, Deporte
	frecuencia VARCHAR(50)	--Ej: Semanal, Diario, Esporádico
);

CREATE TYPE habilidadidiomatipo 
AS (
	BASE habilidadbasetipo,
	ididioma INT,
	nivellectura VARCHAR(50),	--Ej: Alto, Intermedio, Bajo
	nivelescritura VARCHAR(50),
	nivelconversacion VARCHAR(50)
);

CREATE TABLE habilidadprofesional(
	idpersona INT NOT NULL references persona(id),
	habilidad habilidadprofesionaltipo
);

CREATE TABLE habilidadpersonal(
	idpersona INT NOT NULL references persona(id),
	habilidad habilidadpersonaltipo
);

CREATE TABLE habilidadidioma(
	idpersona INT NOT NULL references persona(id),
	habilidad habilidadidiomatipo
);

