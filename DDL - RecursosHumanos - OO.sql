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

CREATE TABLE ciudad(
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(100) NOT NULL,
	idpais INT NOT NULL REFERENCES pais(id),
	UNIQUE(idpais, nombre)
);

CREATE TYPE direcciontipo 
AS (
	direccion VARCHAR(100),
	idciudad INT
);

SELECT  *--typname, typcategory, typtype 
	FROM pg_type 
	--WHERE typname='direcciontipo'
	ORDER BY typname;

CREATE TABLE persona(
	id SERIAL PRIMARY KEY,
	apellido1 VARCHAR(50) NOT NULL,
	apellido2 VARCHAR(50) NOT NULL,
	nombre VARCHAR(100) NOT NULL,
	documento VARCHAR(20) NOT NULL,
	idtipodocumento INT NOT NULL REFERENCES tipodocumento(id),
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


