-------------------------------------------------------------------------------
-- TABLAS
-------------------------------------------------------------------------------

DROP TABLE RESPUESTAS;
DROP TABLE FORMULARIOS;
DROP TABLE CUESTIONARIOS;
DROP TABLE PREGUNTAS;
DROP TABLE ENVIOS;
DROP TABLE MENSAJES;
DROP TABLE DONACIONES;
DROP TABLE TIPODONACIONES;
DROP TABLE PATROCINIOS;
DROP TABLE INSCRIPCIONES;
DROP TABLE RECIBOS;
DROP TABLE COLABORACIONES;
DROP TABLE ENCARGADOS;
DROP TABLE ACTIVIDADES;
DROP TABLE PROYECTOS;
DROP TABLE INSTITUCIONES;
DROP TABLE INFORMESMEDICOS;
DROP TABLE ESTAINTERESADOEN;
DROP TABLE PARTICIPANTES;
DROP TABLE VOLUNTARIOS;
DROP TABLE TUTORESLEGALES;
DROP TABLE COORDINADORES;
DROP TABLE PERSONAS;

-- Tabla de PERSONAS y su clasificación de herencia

CREATE TABLE PERSONAS (
    dni CHAR(9) NOT NULL
        CONSTRAINT ck_dni CHECK (REGEXP_LIKE(dni, '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][A-Z]')),
    nombre VARCHAR2(50) NOT NULL,
    apellidos VARCHAR2(50),
    fechaNacimiento DATE NOT NULL,
    direccion VARCHAR2(50),
    localidad VARCHAR2(50),
    provincia VARCHAR2(50),
    codigoPostal CHAR(5),
    email VARCHAR2(50),
    telefono CHAR(9) NOT NULL,
    PRIMARY KEY (dni)
);

CREATE TABLE COORDINADORES (
    OID_Coord INTEGER PRIMARY KEY NOT NULL,
    dni CHAR(9) NOT NULL,
    FOREIGN KEY (dni) REFERENCES PERSONAS ON DELETE CASCADE
);

CREATE TABLE TUTORESLEGALES (
    OID_Tut INTEGER PRIMARY KEY NOT NULL,
    dni CHAR(9) NOT NULL,
    FOREIGN KEY (dni) REFERENCES PERSONAS ON DELETE CASCADE
);

CREATE TABLE VOLUNTARIOS (
    OID_Vol INTEGER PRIMARY KEY NOT NULL,
    dni CHAR(9) NOT NULL,
    prioridadParticipacion VARCHAR2(50)
        CONSTRAINT e_prioridad_Vol CHECK (prioridadParticipacion IN ('alta', 'media', 'baja')),
    FOREIGN KEY (dni) REFERENCES PERSONAS ON DELETE CASCADE
);

CREATE TABLE PARTICIPANTES (
    OID_Part INTEGER PRIMARY KEY NOT NULL,
    dni CHAR(9) NOT NULL,
    gradoDiscapacidad NUMBER NOT NULL
        CONSTRAINT ck_gradoDiscapacidad CHECK (gradoDiscapacidad BETWEEN 0.0 AND 1.0),
    prioridadParticipacion VARCHAR2(50)
        CONSTRAINT e_prioridad_Part CHECK (prioridadParticipacion IN ('alta', 'media', 'baja')),
    OID_Tut INTEGER,
    OID_Vol INTEGER,
    FOREIGN KEY (dni) REFERENCES PERSONAS ON DELETE CASCADE,
    FOREIGN KEY (OID_Vol) REFERENCES VOLUNTARIOS,
    FOREIGN KEY (OID_Tut) REFERENCES TUTORESLEGALES
);

-- Tablas de información de referencia de PARTICIPANTE y VOLUNTARIOS

CREATE TABLE INFORMESMEDICOS (
    OID_Inf INTEGER PRIMARY KEY NOT NULL,
    OID_Part INTEGER NOT NULL,
    descripcion LONG NOT NULL,
    fecha DATE NOT NULL,
    FOREIGN KEY (OID_Part) REFERENCES PARTICIPANTES ON DELETE CASCADE
);

CREATE TABLE ESTAINTERESADOEN (
    OID_Int INTEGER PRIMARY KEY NOT NULL,
    OID_Part INTEGER,
    OID_Vol INTEGER,
    OID_Act INTEGER NOT NULL,
    estado SMALLINT NOT NULL
        CONSTRAINT intSelector CHECK (estado IN (0,1)),
    UNIQUE (OID_Part, OID_Act),
    UNIQUE (OID_Vol, OID_ACT),
    FOREIGN KEY (OID_Part) REFERENCES PARTICIPANTES ON DELETE CASCADE,
    FOREIGN KEY (OID_Vol) REFERENCES VOLUNTARIOS ON DELETE CASCADE
);

-- Tabla de INSTITUCIONES

CREATE TABLE INSTITUCIONES (
    cif CHAR(9) PRIMARY KEY NOT NULL
        CONSTRAINT ck_cif CHECK (REGEXP_LIKE(cif, '[A-Z][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')),
    nombre VARCHAR2(50) NOT NULL,
    telefono CHAR(9) NOT NULL,
    direccion VARCHAR2(50),
    localidad VARCHAR2(50),
    provincia VARCHAR2(50),
    codigoPostal CHAR(5),
    email VARCHAR2(50),
    esPatrocinador SMALLINT NOT NULL
        CONSTRAINT ck_esPatrocinador CHECK (esPatrocinador IN (0,1)),
    tipo VARCHAR2(50)
        CONSTRAINT enum_tipoPatrocinador CHECK (tipo IN ('oro', 'plata', 'bronce'))
);

-- Tabla de PROYECTOS y ACTIVIDADES

CREATE TABLE PROYECTOS (
    OID_Proj INTEGER PRIMARY KEY NOT NULL,
    nombre VARCHAR2(50) NOT NULL,
    ubicacion VARCHAR2(50) NOT NULL,
    esEvento SMALLINT NOT NULL
        CONSTRAINT ck_esEvento CHECK (esEvento IN (0,1)),
    esProgDep SMALLINT NOT NULL
        CONSTRAINT ck_esProgDep CHECK (esProgDep IN (0,1))
);

CREATE TABLE ACTIVIDADES (
    OID_Act INTEGER PRIMARY KEY NOT NULL,
    OID_Proj INTEGER NOT NULL,
    nombre VARCHAR2(50) NOT NULL,
    objetivo VARCHAR2(255) NOT NULL,
    fechaInicio DATE NOT NULL,
    fechaFin DATE NOT NULL,
    numeroPlazas INTEGER NOT NULL,
    voluntariosRequeridos INTEGER NOT NULL,
    tipo VARCHAR2(50) NOT NULL
        CONSTRAINT enum_tipoActividad CHECK (tipo IN ('deportiva', 'formativa', 'social')),
    costeTotal NUMBER(*,2) NOT NULL,
    costeInscripcion NUMBER(*,2) NOT NULL,
    UNIQUE (OID_Proj, nombre),
    FOREIGN KEY (OID_Proj) REFERENCES PROYECTOS ON DELETE CASCADE
);

CREATE TABLE ENCARGADOS (
    OID_RP INTEGER PRIMARY KEY NOT NULL,
    OID_Proj INTEGER NOT NULL,
    OID_Coord INTEGER NOT NULL,
    FOREIGN KEY (OID_Proj) REFERENCES PROYECTOS ON DELETE CASCADE,
    FOREIGN KEY (OID_Coord) REFERENCES COORDINADORES
);

CREATE TABLE COLABORACIONES (
    OID_Colab INTEGER PRIMARY KEY NOT NULL,
    OID_Vol INTEGER NOT NULL,
    OID_Act INTEGER NOT NULL,
    FOREIGN KEY (OID_Vol) REFERENCES VOLUNTARIOS ON DELETE CASCADE,
    FOREIGN KEY (OID_Act) REFERENCES ACTIVIDADES ON DELETE CASCADE
);

CREATE TABLE RECIBOS (
    OID_Rec INTEGER PRIMARY KEY NOT NULL,
    OID_Act INTEGER NOT NULL,
    OID_Part INTEGER,
    fechaEmision DATE NOT NULL,
    fechaVencimiento DATE NOT NULL,
    importe NUMBER(*,2) NOT NULL,
    estado VARCHAR2(50) NOT NULL
        CONSTRAINT enum_estadoRecibo CHECK (estado IN ('pagado', 'pendiente', 'anulado')),
    FOREIGN KEY (OID_Act) REFERENCES ACTIVIDADES,
    FOREIGN KEY (OID_Part) REFERENCES PARTICIPANTES
);

CREATE TABLE INSCRIPCIONES (
    OID_Ins INTEGER PRIMARY KEY NOT NULL,
    OID_Part INTEGER NOT NULL,
    OID_Act INTEGER NOT NULL,
    OID_Rec INTEGER,
    FOREIGN KEY (OID_Part) REFERENCES PARTICIPANTES ON DELETE CASCADE,
    FOREIGN KEY (OID_Act) REFERENCES ACTIVIDADES ON DELETE CASCADE,
    FOREIGN KEY (OID_Rec) REFERENCES RECIBOS
);

-- Tablas de PATROCINIOS y DONACIONES

CREATE TABLE PATROCINIOS (
    OID_Fin INTEGER PRIMARY KEY NOT NULL,
    cif CHAR(9) NOT NULL,
    cantidad NUMBER(*,2) NOT NULL,
    OID_Act INTEGER NOT NULL,
    FOREIGN KEY (cif) REFERENCES INSTITUCIONES,
    FOREIGN KEY (OID_Act) REFERENCES ACTIVIDADES
);

CREATE TABLE TIPODONACIONES (
    OID_TDon INTEGER PRIMARY KEY NOT NULL,
    nombre VARCHAR2(50) NOT NULL,
    tipoUnidad VARCHAR2(50) NOT NULL
);

CREATE TABLE DONACIONES (
    OID_Don INTEGER PRIMARY KEY NOT NULL,
    cif CHAR(9),
    dni CHAR(9),
    OID_TDon INTEGER NOT NULL,
    fecha DATE NOT NULL,
    cantidad NUMBER(*,2) NOT NULL,
    valorUnitario NUMBER(*,2) NOT NULL,
    FOREIGN KEY (cif) REFERENCES INSTITUCIONES,
    FOREIGN KEY (dni) REFERENCES PERSONAS,
    FOREIGN KEY (OID_TDon) REFERENCES TIPODONACIONES
);

-- Tablas de MENSAJES y ENVIOS

CREATE TABLE MENSAJES (
    OID_M INTEGER PRIMARY KEY NOT NULL,
    OID_Coord INTEGER NOT NULL,
    tipo VARCHAR2(50) NOT NULL
        CONSTRAINT enum_tipoMensaje CHECK (tipo IN ('email', 'newsletter', 'informe')),
    fechaEnvio DATE NOT NULL,
    asunto VARCHAR2(255) NOT NULL,
    contenido LONG NOT NULL,
    FOREIGN KEY (OID_Coord) REFERENCES COORDINADORES
);

CREATE TABLE ENVIOS (
    OID_Env INTEGER PRIMARY KEY NOT NULL,
    OID_M INTEGER NOT NULL,
    dni CHAR(9),
    cif CHAR(9),
    FOREIGN KEY (OID_M) REFERENCES MENSAJES,
    FOREIGN KEY (dni) REFERENCES PERSONAS,
    FOREIGN KEY (cif) REFERENCES INSTITUCIONES
);

-- Tablas de CUESTIONARIOS

CREATE TABLE PREGUNTAS (
    OID_Q INTEGER PRIMARY KEY NOT NULL,
    tipo VARCHAR2(50) NOT NULL
        CONSTRAINT enum_tipoPregunta CHECK (tipo IN ('textual', 'numerica', 'selectiva', 'opcional')),
    enunciado VARCHAR(255) NOT NULL
);

CREATE TABLE CUESTIONARIOS (
    OID_Cues INTEGER PRIMARY KEY NOT NULL,
    OID_Act INTEGER NOT NULL,
    fechaCreacion DATE NOT NULL,
    FOREIGN KEY (OID_Act) REFERENCES ACTIVIDADES
);

CREATE TABLE FORMULARIOS (
    OID_Form INTEGER PRIMARY KEY NOT NULL,
    OID_Cues INTEGER NOT NULL,
    OID_Q INTEGER NOT NULL,
    FOREIGN KEY (OID_Cues) REFERENCES CUESTIONARIOS ON DELETE CASCADE,
    FOREIGN KEY (OID_Q) REFERENCES PREGUNTAS
);

CREATE TABLE RESPUESTAS (
    OID_Ans INTEGER PRIMARY KEY NOT NULL,
    OID_Form INTEGER NOT NULL,
    OID_Part INTEGER,
    OID_Vol INTEGER,
    contenido VARCHAR2(1000) NOT NULL,
    FOREIGN KEY (OID_Form) REFERENCES FORMULARIOS ON DELETE CASCADE,
    FOREIGN KEY (OID_Part) REFERENCES PARTICIPANTES,
    FOREIGN KEY (OID_Vol) REFERENCES VOLUNTARIOS
);

-------------------------------------------------------------------------------
-- SECUENCIAS
-------------------------------------------------------------------------------

DROP SEQUENCE SEC_Coord;
CREATE SEQUENCE SEC_Coord INCREMENT BY 1 START WITH 1;
DROP SEQUENCE SEC_Tut;
CREATE SEQUENCE SEC_Tut INCREMENT BY 1 START WITH 1;
DROP SEQUENCE SEC_Vol;
CREATE SEQUENCE SEC_Vol INCREMENT BY 1 START WITH 1;
DROP SEQUENCE SEC_Part;
CREATE SEQUENCE SEC_Part INCREMENT BY 1 START WITH 1;
DROP SEQUENCE SEC_Inf;
CREATE SEQUENCE SEC_Inf INCREMENT BY 1 START WITH 1;
DROP SEQUENCE SEC_Int;
CREATE SEQUENCE SEC_Int INCREMENT BY 1 START WITH 1;
DROP SEQUENCE SEC_Proj;
CREATE SEQUENCE SEC_Proj INCREMENT BY 1 START WITH 1;
DROP SEQUENCE SEC_Act;
CREATE SEQUENCE SEC_Act INCREMENT BY 1 START WITH 1;
DROP SEQUENCE SEC_RP;
CREATE SEQUENCE SEC_RP INCREMENT BY 1 START WITH 1;
DROP SEQUENCE SEC_Colab;
CREATE SEQUENCE SEC_Colab INCREMENT BY 1 START WITH 1;
DROP SEQUENCE SEC_Rec;
CREATE SEQUENCE SEC_Rec INCREMENT BY 1 START WITH 1;
DROP SEQUENCE SEC_Ins;
CREATE SEQUENCE SEC_Ins INCREMENT BY 1 START WITH 1;
DROP SEQUENCE SEC_Fin;
CREATE SEQUENCE SEC_Fin INCREMENT BY 1 START WITH 1;
DROP SEQUENCE SEC_TDon;
CREATE SEQUENCE SEC_TDon INCREMENT BY 1 START WITH 1;
DROP SEQUENCE SEC_Don;
CREATE SEQUENCE SEC_Don INCREMENT BY 1 START WITH 1;
DROP SEQUENCE SEC_M;
CREATE SEQUENCE SEC_M INCREMENT BY 1 START WITH 1;
DROP SEQUENCE SEC_Env;
CREATE SEQUENCE SEC_Env INCREMENT BY 1 START WITH 1;
DROP SEQUENCE SEC_Q;
CREATE SEQUENCE SEC_Q INCREMENT BY 1 START WITH 1;
DROP SEQUENCE SEC_Cues;
CREATE SEQUENCE SEC_Cues INCREMENT BY 1 START WITH 1;
DROP SEQUENCE SEC_Form;
CREATE SEQUENCE SEC_Form INCREMENT BY 1 START WITH 1;
DROP SEQUENCE SEC_Ans;
CREATE SEQUENCE SEC_Ans INCREMENT BY 1 START WITH 1;

-------------------------------------------------------------------------------
-- TRIGGERS ASOCIADOS A SECUENCIAS
-------------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER SECUENCIA_COORDINADORES
BEFORE INSERT ON COORDINADORES
FOR EACH ROW
BEGIN
    SELECT SEC_Coord.NEXTVAL INTO :NEW.OID_Coord FROM DUAL;
END;
/

CREATE OR REPLACE TRIGGER SECUENCIA_TUTORESLEGALES
BEFORE INSERT ON TUTORESLEGALES
FOR EACH ROW
BEGIN
    SELECT SEC_Tut.NEXTVAL INTO :NEW.OID_Tut FROM DUAL;
END;
/

CREATE OR REPLACE TRIGGER SECUENCIA_VOLUNTARIOS
BEFORE INSERT ON VOLUNTARIOS
FOR EACH ROW
BEGIN
    SELECT SEC_Vol.NEXTVAL INTO :NEW.OID_Vol FROM DUAL;
END;
/

CREATE OR REPLACE TRIGGER SECUENCIA_PARTICIPANTES
BEFORE INSERT ON PARTICIPANTES
FOR EACH ROW
BEGIN
    SELECT SEC_Part.NEXTVAL INTO :NEW.OID_Part FROM DUAL;
END;
/

CREATE OR REPLACE TRIGGER SECUENCIA_INFORMESMEDICOS
BEFORE INSERT ON INFORMESMEDICOS
FOR EACH ROW
BEGIN
    SELECT SEC_Inf.NEXTVAL INTO :NEW.OID_Inf FROM DUAL;
END;
/

CREATE OR REPLACE TRIGGER SECUENCIA_ESTAINTERESADOEN
BEFORE INSERT ON ESTAINTERESADOEN
FOR EACH ROW
BEGIN
    SELECT SEC_Int.NEXTVAL INTO :NEW.OID_Int FROM DUAL;
END;
/

CREATE OR REPLACE TRIGGER SECUENCIA_PROYECTOS
BEFORE INSERT ON PROYECTOS
FOR EACH ROW
BEGIN
    SELECT SEC_Proj.NEXTVAL INTO :NEW.OID_Proj FROM DUAL;
END;
/

CREATE OR REPLACE TRIGGER SECUENCIA_ACTIVIDADES
BEFORE INSERT ON ACTIVIDADES
FOR EACH ROW
BEGIN
    SELECT SEC_Act.NEXTVAL INTO :NEW.OID_Act FROM DUAL;
END;
/

CREATE OR REPLACE TRIGGER SECUENCIA_ENCARGADOS
BEFORE INSERT ON ENCARGADOS
FOR EACH ROW
BEGIN
    SELECT SEC_RP.NEXTVAL INTO :NEW.OID_RP FROM DUAL;
END;
/

CREATE OR REPLACE TRIGGER SECUENCIA_COLABORACIONES
BEFORE INSERT ON COLABORACIONES
FOR EACH ROW
BEGIN
    SELECT SEC_Colab.NEXTVAL INTO :NEW.OID_Colab FROM DUAL;
END;
/

CREATE OR REPLACE TRIGGER SECUENCIA_RECIBOS
BEFORE INSERT ON RECIBOS
FOR EACH ROW
BEGIN
    SELECT SEC_Rec.NEXTVAL INTO :NEW.OID_Rec FROM DUAL;
END;
/

CREATE OR REPLACE TRIGGER SECUENCIA_INSCRIPCIONES
BEFORE INSERT ON INSCRIPCIONES
FOR EACH ROW
BEGIN
    SELECT SEC_Ins.NEXTVAL INTO :NEW.OID_Ins FROM DUAL;
END;
/

CREATE OR REPLACE TRIGGER SECUENCIA_PATROCINIOS
BEFORE INSERT ON PATROCINIOS
FOR EACH ROW
BEGIN
    SELECT SEC_Fin.NEXTVAL INTO :NEW.OID_Fin FROM DUAL;
END;
/

CREATE OR REPLACE TRIGGER SECUENCIA_TIPODONACIONES
BEFORE INSERT ON TIPODONACIONES
FOR EACH ROW
BEGIN
    SELECT SEC_TDon.NEXTVAL INTO :NEW.OID_TDon FROM DUAL;
END;
/

CREATE OR REPLACE TRIGGER SECUENCIA_DONACIONES
BEFORE INSERT ON DONACIONES
FOR EACH ROW
BEGIN
    SELECT SEC_Don.NEXTVAL INTO :NEW.OID_Don FROM DUAL;
END;
/

CREATE OR REPLACE TRIGGER SECUENCIA_MENSAJES
BEFORE INSERT ON MENSAJES
FOR EACH ROW
BEGIN
    SELECT SEC_M.NEXTVAL INTO :NEW.OID_M FROM DUAL;
END;
/

CREATE OR REPLACE TRIGGER SECUENCIA_ENVIOS
BEFORE INSERT ON ENVIOS
FOR EACH ROW
BEGIN
    SELECT SEC_Env.NEXTVAL INTO :NEW.OID_Env FROM DUAL;
END;
/

CREATE OR REPLACE TRIGGER SECUENCIA_PREGUNTAS
BEFORE INSERT ON PREGUNTAS
FOR EACH ROW
BEGIN
    SELECT SEC_Q.NEXTVAL INTO :NEW.OID_Q FROM DUAL;
END;
/

CREATE OR REPLACE TRIGGER SECUENCIA_CUESTIONARIOS
BEFORE INSERT ON CUESTIONARIOS
FOR EACH ROW
BEGIN
    SELECT SEC_Cues.NEXTVAL INTO :NEW.OID_Cues FROM DUAL;
END;
/

CREATE OR REPLACE TRIGGER SECUENCIA_FORMULARIOS
BEFORE INSERT ON FORMULARIOS
FOR EACH ROW
BEGIN
    SELECT SEC_Form.NEXTVAL INTO :NEW.OID_Form FROM DUAL;
END;
/

CREATE OR REPLACE TRIGGER SECUENCIA_RESPUESTAS
BEFORE INSERT ON RESPUESTAS
FOR EACH ROW
BEGIN
    SELECT SEC_Ans.NEXTVAL INTO :NEW.OID_Ans FROM DUAL;
END;
/
