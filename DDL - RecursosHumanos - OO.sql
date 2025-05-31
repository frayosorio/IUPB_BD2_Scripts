--Eliminar la BD si existe
DROP DATABASE RecursosHumanosOO WITH (FORCE);

--Crear la base de datos
CREATE DATABASE RecursosHumanosOO; 

--Tablas Base
CREATE TABLE tipodocumento (
    id SERIAL PRIMARY KEY,
    tipo VARCHAR(50) NOT NULL UNIQUE,
    sigla VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE pais (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE ciudad (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    region VARCHAR(100) NOT NULL,
    idpais INT NOT NULL REFERENCES pais(id),
    UNIQUE (idpais, region, nombre)
);

CREATE TABLE nivelacademico (
    id SERIAL PRIMARY KEY,
    nivel VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE gradoacademico (
    id SERIAL PRIMARY KEY,
    grado VARCHAR(50) NOT NULL UNIQUE,
    idnivel INT NOT NULL REFERENCES nivelacademico(id)
);

CREATE TABLE sector (
    id SERIAL PRIMARY KEY,
    sector VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE idioma (
    id SERIAL PRIMARY KEY,
    idioma VARCHAR(50) NOT NULL UNIQUE
);

-- Tipo compuesto
CREATE TYPE direcciontipo AS (
    direccion VARCHAR(100),
    idciudad INT
);

-- Persona
CREATE TABLE persona (
    id SERIAL PRIMARY KEY,
    apellido1 VARCHAR(50) NOT NULL,
    apellido2 VARCHAR(50) NOT NULL,
    nombres VARCHAR(100) NOT NULL,
    documento VARCHAR(20) NOT NULL,
    idtipodocumento INT NOT NULL REFERENCES tipodocumento(id),
    fechanacimiento DATE NOT NULL,
    idciudadnacimiento INT NOT NULL REFERENCES ciudad(id),
    direccion direcciontipo,
    movil VARCHAR(100),
    correo VARCHAR(100),
    foto BYTEA,
    UNIQUE(idtipodocumento, documento)
);

-- Informacion Base (SuperClase)
CREATE TABLE informacionbase (
    id SERIAL PRIMARY KEY,
    idpersona INT NOT NULL REFERENCES persona(id),
    desde DATE,
    hasta DATE,
    entidad VARCHAR(100)
);

--Información Académica
CREATE TABLE informacionacademica (
    titulo VARCHAR(100),
    idgrado INT REFERENCES gradoacademico(id),
    idciudad INT REFERENCES ciudad(id),
    proyecto TEXT
) INHERITS (informacionbase);

--Información Laboral
CREATE TABLE informacionlabotal (
    cargo VARCHAR(100),
    idciudad INT REFERENCES ciudad(id),
    telefonocontacto VARCHAR(100),
    correocontacto VARCHAR(100)
) INHERITS (informacionbase);
