SET SERVEROUTPUT ON;

-- Función auxiliar
CREATE OR REPLACE FUNCTION ASSERT_EQUALS (salida BOOLEAN, salida_esperada BOOLEAN)
RETURN VARCHAR2 AS 
BEGIN
    IF (salida = salida_esperada) THEN
        RETURN 'EXITO';
    ELSE
        RETURN 'FALLO';
    END IF;
END ASSERT_EQUALS;
/

-----------------------------------
--ESPECIFICACIÓN DEL PAQUETE 
-----------------------------------
--PRUEBAS_PERSONAS
create or replace 
PACKAGE PRUEBAS_PERSONAS AS
    PROCEDURE inicializar;
    PROCEDURE insertar 
        (nombre_prueba VARCHAR2, w_dni CHAR, w_nombre VARCHAR2, w_apellidos VARCHAR2, w_fechaNacimiento DATE, w_direccion VARCHAR, 
        w_localidad VARCHAR2, w_provincia VARCHAR2, w_codigoPostal CHAR, w_email VARCHAR, w_telefono CHAR, salidaEsperada BOOLEAN);
    PROCEDURE actualizar 
        (nombre_prueba VARCHAR2, w_dni CHAR, w_nombre VARCHAR2, w_apellidos VARCHAR2, w_fechaNacimiento DATE, w_direccion VARCHAR, 
        w_localidad VARCHAR2, w_provincia VARCHAR2, w_codigoPostal CHAR, w_email VARCHAR, w_telefono CHAR, salidaEsperada BOOLEAN);
    PROCEDURE eliminar
        (nombre_prueba VARCHAR2, w_dni CHAR, salidaEsperada BOOLEAN);
END PRUEBAS_PERSONAS;
/
--PRUEBAS_COORDINADORES
create or replace 
PACKAGE PRUEBAS_COORDINADORES AS
    PROCEDURE inicializar;
    PROCEDURE insertar 
        (nombre_prueba VARCHAR2, w_dni CHAR, salidaEsperada BOOLEAN);
    PROCEDURE actualizar
        (nombre_prueba VARCHAR2, w_OID_Coord INTEGER, w_dni CHAR, salidaEsperada BOOLEAN);
    PROCEDURE eliminar
        (nombre_prueba VARCHAR2, w_OID_Coord INTEGER, salidaEsperada BOOLEAN);
END PRUEBAS_COORDINADORES;
/
--PRUEBAS_TUTORESLEGALES
create or replace 
PACKAGE PRUEBAS_TUTORESLEGALES AS
    PROCEDURE inicializar;
    PROCEDURE insertar 
        (nombre_prueba VARCHAR2, w_dni CHAR, salidaEsperada BOOLEAN);
    PROCEDURE actualizar
        (nombre_prueba VARCHAR2, w_OID_Tut INTEGER, w_dni CHAR, salidaEsperada BOOLEAN);
    PROCEDURE eliminar
        (nombre_prueba VARCHAR2, w_OID_Tut INTEGER, salidaEsperada BOOLEAN);
END PRUEBAS_TUTORESLEGALES;
/
--PRUEBAS_VOLUNTARIOS
create or replace 
PACKAGE PRUEBAS_VOLUNTARIOS AS
    PROCEDURE inicializar;
    PROCEDURE insertar 
        (nombre_prueba VARCHAR2, w_dni CHAR, w_prioridadParticipacion VARCHAR2, salidaEsperada BOOLEAN);
    PROCEDURE actualizar 
        (nombre_prueba VARCHAR2, w_OID_Vol INTEGER, w_dni CHAR, w_prioridadParticipacion VARCHAR2, salidaEsperada BOOLEAN);
    PROCEDURE eliminar
        (nombre_prueba VARCHAR2, w_OID_Vol INTEGER, salidaEsperada BOOLEAN);
END PRUEBAS_VOLUNTARIOS;
/
--PRUEBAS_PARTICIPANTES
create or replace 
PACKAGE PRUEBAS_PARTICIPANTES AS
    PROCEDURE inicializar;
    PROCEDURE insertar
        (nombre_prueba VARCHAR2, w_dni CHAR, w_gradoDiscapacidad VARCHAR2, w_prioridadParticipacion VARCHAR2, w_OID_Tut INTEGER,
            w_OID_Vol INTEGER, salidaEsperada BOOLEAN);
    PROCEDURE actualizar 
        (nombre_prueba VARCHAR2, w_OID_Part INTEGER, w_dni CHAR, w_gradoDiscapacidad VARCHAR2, w_prioridadParticipacion VARCHAR2,
            w_OID_Tut INTEGER, w_OID_Vol INTEGER, salidaEsperada BOOLEAN); 
    PROCEDURE eliminar
        (nombre_prueba VARCHAR2, w_OID_Part INTEGER, salidaEsperada BOOLEAN);
END PRUEBAS_PARTICIPANTES;
/
--PRUEBAS_INFORMESMEDICOS
create or replace 
PACKAGE PRUEBAS_INFORMESMEDICOS AS
    PROCEDURE inicializar;
    PROCEDURE insertar
        (nombre_prueba VARCHAR2, w_OID_Part INTEGER, w_descripcion LONG, w_fecha DATE, salidaEsperada BOOLEAN);
    PROCEDURE actualizar 
        (nombre_prueba VARCHAR2, w_OID_Inf INTEGER, w_OID_Part INTEGER, w_descripcion LONG, w_fecha DATE, salidaEsperada BOOLEAN); 
    PROCEDURE eliminar
        (nombre_prueba VARCHAR2, w_OID_Inf INTEGER, salidaEsperada BOOLEAN);
END PRUEBAS_INFORMESMEDICOS;
/
--PRUEBAS_ESTAINTERESADOEN
create or replace 
PACKAGE PRUEBAS_ESTAINTERESADOEN AS
    PROCEDURE inicializar;
    PROCEDURE insertar
        (nombre_prueba VARCHAR2, w_OID_Part INTEGER, w_OID_Vol INTEGER, w_OID_Act INTEGER, w_estado SMALLINT , salidaEsperada BOOLEAN);
    PROCEDURE actualizar 
        (nombre_prueba VARCHAR2, w_OID_Int INTEGER, w_OID_Part INTEGER, w_OID_Vol INTEGER, w_OID_Act INTEGER, w_estado SMALLINT,
            salidaEsperada BOOLEAN); 
    PROCEDURE eliminar
        (nombre_prueba VARCHAR2, w_OID_Int INTEGER, salidaEsperada BOOLEAN);
END PRUEBAS_ESTAINTERESADOEN;
/
--PRUEBAS_INSTITUCIONES
create or replace 
PACKAGE PRUEBAS_INSTITUCIONES AS
    PROCEDURE inicializar;
    PROCEDURE insertar 
        (nombre_prueba VARCHAR2, w_cif CHAR, w_nombre VARCHAR2, w_telefono CHAR, w_direccion VARCHAR2, w_localidad VARCHAR2, w_provincia VARCHAR2,
        w_codigoPostal CHAR, w_email VARCHAR2, w_esPatrocinador SMALLINT, w_tipo VARCHAR2, salidaEsperada BOOLEAN);
    PROCEDURE actualizar 
        (nombre_prueba VARCHAR2, w_cif CHAR, w_nombre VARCHAR2, w_telefono CHAR, w_direccion VARCHAR2, w_localidad VARCHAR2, w_provincia VARCHAR2,
        w_codigoPostal CHAR, w_email VARCHAR2, w_esPatrocinador SMALLINT, w_tipo VARCHAR2, salidaEsperada BOOLEAN);
    PROCEDURE eliminar
        (nombre_prueba VARCHAR2, w_cif CHAR, salidaEsperada BOOLEAN);
END PRUEBAS_INSTITUCIONES;
/
--PRUEBAS_PROYECTOS
create or replace 
PACKAGE PRUEBAS_PROYECTOS AS
    PROCEDURE inicializar;
    PROCEDURE insertar 
        (nombre_prueba VARCHAR2, w_nombre VARCHAR2, w_ubicacion CHAR, w_esEvento SMALLINT, w_esProgDep SMALLINT, salidaEsperada BOOLEAN);
    PROCEDURE actualizar 
        (nombre_prueba VARCHAR2, w_OID_Proj INTEGER, w_nombre VARCHAR2, w_ubicacion CHAR, w_esEvento SMALLINT, w_esProgDep SMALLINT,
            salidaEsperada BOOLEAN);
    PROCEDURE eliminar
        (nombre_prueba VARCHAR2, w_OID_Proj INTEGER, salidaEsperada BOOLEAN);
END PRUEBAS_PROYECTOS;
/
--PRUEBAS_ACTIVIDADES
create or replace 
PACKAGE PRUEBAS_ACTIVIDADES AS
    PROCEDURE inicializar;
    PROCEDURE insertar 
        (nombre_prueba VARCHAR2, w_OID_Proj INTEGER, w_nombre VARCHAR2, w_objetivo VARCHAR2, w_fechaInicio DATE, w_fechaFin DATE,
            w_numeroPlazas INTEGER, w_voluntariosRequeridos INTEGER, w_tipo VARCHAR2, w_costeTotal NUMBER, w_costeInscripcion NUMBER,
            salidaEsperada BOOLEAN);
    PROCEDURE actualizar 
        (nombre_prueba VARCHAR2, w_OID_Act INTEGER, w_OID_Proj INTEGER, w_nombre VARCHAR2, w_objetivo VARCHAR2, w_fechaInicio DATE,
            w_fechaFin DATE, w_numeroPlazas INTEGER, w_voluntariosRequeridos INTEGER, w_tipo VARCHAR2, w_costeTotal NUMBER,
            w_costeInscripcion NUMBER, salidaEsperada BOOLEAN);
    PROCEDURE eliminar
        (nombre_prueba VARCHAR2, w_OID_Act INTEGER, salidaEsperada BOOLEAN);
END PRUEBAS_ACTIVIDADES;
/
--PRUEBAS_ENCARGADOS
create or replace 
PACKAGE PRUEBAS_ENCARGADOS AS
    PROCEDURE inicializar;
    PROCEDURE insertar 
        (nombre_prueba VARCHAR2, w_OID_Proj INTEGER, w_OID_Coord INTEGER, salidaEsperada BOOLEAN);
    PROCEDURE actualizar 
        (nombre_prueba VARCHAR2, w_OID_RP INTEGER, w_OID_Proj INTEGER, w_OID_Coord INTEGER, salidaEsperada BOOLEAN);
    PROCEDURE eliminar
        (nombre_prueba VARCHAR2, w_OID_RP INTEGER, salidaEsperada BOOLEAN);
END PRUEBAS_ENCARGADOS;
/
--PRUEBAS_COLABORACIONES
create or replace 
PACKAGE PRUEBAS_COLABORACIONES AS
    PROCEDURE inicializar;
    PROCEDURE insertar 
        (nombre_prueba VARCHAR2, w_OID_Vol INTEGER, w_OID_Act INTEGER, salidaEsperada BOOLEAN);
    PROCEDURE actualizar 
        (nombre_prueba VARCHAR2, w_OID_Colab INTEGER, w_OID_Vol INTEGER, w_OID_Act INTEGER, salidaEsperada BOOLEAN);
    PROCEDURE eliminar
        (nombre_prueba VARCHAR2, w_OID_Colab INTEGER, salidaEsperada BOOLEAN);
END PRUEBAS_COLABORACIONES;
/
--PRUEBAS_RECIBOS
create or replace 
PACKAGE PRUEBAS_RECIBOS AS
    PROCEDURE inicializar;
    PROCEDURE insertar 
        (nombre_prueba VARCHAR2, w_OID_Act INTEGER, w_OID_Part INTEGER, w_fechaEmision DATE, w_fechaVencimiento DATE, w_importe NUMBER,
            w_estado VARCHAR2, salidaEsperada BOOLEAN);
    PROCEDURE actualizar 
        (nombre_prueba VARCHAR2, w_OID_Rec INTEGER, w_OID_Act INTEGER, w_OID_Part INTEGER, w_fechaEmision DATE, w_fechaVencimiento DATE,
            w_importe NUMBER, w_estado VARCHAR2, salidaEsperada BOOLEAN);
    PROCEDURE eliminar
        (nombre_prueba VARCHAR2, w_OID_Rec INTEGER, salidaEsperada BOOLEAN);
END PRUEBAS_RECIBOS;
/
--PRUEBAS_INSCRIPCIONES
create or replace 
PACKAGE PRUEBAS_INSCRIPCIONES AS
    PROCEDURE inicializar;
    PROCEDURE insertar 
        (nombre_prueba VARCHAR2, w_OID_Part INTEGER, w_OID_Act INTEGER, w_OID_Rec INTEGER, salidaEsperada BOOLEAN);
    PROCEDURE actualizar 
        (nombre_prueba VARCHAR2, w_OID_Ins INTEGER, w_OID_Part INTEGER, w_OID_Act INTEGER, w_OID_Rec INTEGER, salidaEsperada BOOLEAN);
    PROCEDURE eliminar
        (nombre_prueba VARCHAR2, w_OID_Ins INTEGER, salidaEsperada BOOLEAN);
END PRUEBAS_INSCRIPCIONES;
/
--PRUEBAS_PATROCIONIOS
create or replace 
PACKAGE PRUEBAS_PATROCINIOS AS
    PROCEDURE inicializar;
    PROCEDURE insertar 
        (nombre_prueba VARCHAR2, w_cif CHAR , w_cantidad NUMBER, w_OID_Act INTEGER, salidaEsperada BOOLEAN);
    PROCEDURE actualizar 
        (nombre_prueba VARCHAR2, w_OID_Fin INTEGER, w_cif CHAR , w_cantidad NUMBER, w_OID_Act INTEGER, salidaEsperada BOOLEAN);
    PROCEDURE eliminar
        (nombre_prueba VARCHAR2, w_OID_Fin INTEGER, salidaEsperada BOOLEAN);
END PRUEBAS_PATROCINIOS;
/
--PRUEBAS_TIPOSDONACIONES
create or replace 
PACKAGE PRUEBAS_TIPODONACIONES AS
    PROCEDURE inicializar;
    PROCEDURE insertar
        (nombre_prueba VARCHAR2, w_nombre VARCHAR2, w_tipoUnidad VARCHAR2, salidaEsperada BOOLEAN);
    PROCEDURE actualizar
        (nombre_prueba VARCHAR2,w_OID_TDon INTEGER, w_nombre VARCHAR2, w_tipoUnidad VARCHAR2, salidaEsperada BOOLEAN);
    PROCEDURE eliminar
        (nombre_prueba VARCHAR2, w_OID_TDon INTEGER, salidaEsperada BOOLEAN);
END PRUEBAS_TIPODONACIONES;
/
--PRUEBAS_DONACIONES
create or replace 
PACKAGE PRUEBAS_DONACIONES AS
    PROCEDURE inicializar;
    PROCEDURE insertar
        (nombre_prueba VARCHAR2, w_cif CHAR, w_dni CHAR, w_OID_TDon INTEGER, w_cantidad NUMBER, w_valorUnitario NUMBER, w_fecha DATE,
            salidaEsperada BOOLEAN);
    PROCEDURE actualizar
        (nombre_prueba VARCHAR2,w_OID_Don INTEGER,  w_cif CHAR, w_dni CHAR, w_OID_TDon INTEGER, w_cantidad NUMBER, w_valorUnitario NUMBER,
            w_fecha DATE, salidaEsperada BOOLEAN);
    PROCEDURE eliminar
        (nombre_prueba VARCHAR2, w_OID_Don INTEGER, salidaEsperada BOOLEAN);
END PRUEBAS_DONACIONES;
/
--PRUEBAS_MENSAJES 
create or replace 
PACKAGE PRUEBAS_MENSAJES AS
    PROCEDURE inicializar;
    PROCEDURE insertar
        (nombre_prueba VARCHAR2, w_OID_Coord INTEGER, w_tipo VARCHAR2, w_fechaEnvio DATE, w_asunto VARCHAR2, w_contenido LONG,
            salidaEsperada BOOLEAN);
    PROCEDURE actualizar
        (nombre_prueba VARCHAR2,w_OID_M INTEGER,  w_OID_Coord INTEGER, w_tipo VARCHAR2, w_fechaEnvio DATE, w_asunto VARCHAR2,
            w_contenido LONG, salidaEsperada BOOLEAN);
    PROCEDURE eliminar
        (nombre_prueba VARCHAR2, w_OID_M INTEGER, salidaEsperada BOOLEAN);
END PRUEBAS_MENSAJES;
/
--PRUEBAS_ENVIOS
create or replace 
PACKAGE PRUEBAS_ENVIOS AS
    PROCEDURE inicializar;
    PROCEDURE insertar
        (nombre_prueba VARCHAR2, w_OID_M INTEGER, W_dni CHAR, w_cif CHAR, salidaEsperada BOOLEAN);
    PROCEDURE actualizar
        (nombre_prueba VARCHAR2,w_OID_Env INTEGER,  w_OID_M INTEGER, w_dni CHAR, w_cif CHAR, salidaEsperada BOOLEAN);
    PROCEDURE eliminar
        (nombre_prueba VARCHAR2, w_OID_Env INTEGER, salidaEsperada BOOLEAN);
END PRUEBAS_ENVIOS;
/
--PRUEBAS_PREGUNTAS
create or replace 
PACKAGE PRUEBAS_PREGUNTAS AS
    PROCEDURE inicializar;
    PROCEDURE insertar
        (nombre_prueba VARCHAR2, w_tipo VARCHAR2, w_enunciado VARCHAR, salidaEsperada BOOLEAN);
    PROCEDURE actualizar
        (nombre_prueba VARCHAR2,w_OID_Q INTEGER,w_tipo VARCHAR2, w_enunciado VARCHAR, salidaEsperada BOOLEAN);
    PROCEDURE eliminar
        (nombre_prueba VARCHAR2, w_OID_Q INTEGER, salidaEsperada BOOLEAN);
END PRUEBAS_PREGUNTAS;
/
--PRUEBAS_CUESTIONARIOS
create or replace 
PACKAGE PRUEBAS_CUESTIONARIOS AS
    PROCEDURE inicializar;
    PROCEDURE insertar
        (nombre_prueba VARCHAR2, w_OID_ACT INTEGER, w_fechaCreacion DATE, salidaEsperada BOOLEAN);
    PROCEDURE actualizar
        (nombre_prueba VARCHAR2,w_OID_Cues INTEGER, w_OID_ACT INTEGER,w_fechaCreacion DATE, salidaEsperada BOOLEAN);
    PROCEDURE eliminar
        (nombre_prueba VARCHAR2, w_OID_Cues INTEGER, salidaEsperada BOOLEAN);
END PRUEBAS_CUESTIONARIOS;
/
--PRUEBAS_FORMULARIOS 
create or replace 
PACKAGE PRUEBAS_FORMULARIOS AS
    PROCEDURE inicializar;
    PROCEDURE insertar
        (nombre_prueba VARCHAR2, w_OID_Cues INTEGER, w_OID_Q INTEGER, salidaEsperada BOOLEAN);
    PROCEDURE actualizar
        (nombre_prueba VARCHAR2, w_OID_Form INTEGER ,w_OID_Cues INTEGER, w_OID_Q INTEGER, salidaEsperada BOOLEAN);
    PROCEDURE eliminar
        (nombre_prueba VARCHAR2, w_OID_Form INTEGER, salidaEsperada BOOLEAN);
END PRUEBAS_fORMULARIOS;
/
--PRUEBAS_RESPUESTAS
create or replace 
PACKAGE PRUEBAS_RESPUESTAS AS
    PROCEDURE inicializar;
    PROCEDURE insertar
        (nombre_prueba VARCHAR2, w_OID_Form INTEGER, w_OID_Part INTEGER, w_OID_Vol INTEGER, w_contenido VARCHAR2,salidaEsperada BOOLEAN);
    PROCEDURE actualizar
        (nombre_prueba VARCHAR2, w_OID_Ans INTEGER ,w_OID_Form INTEGER,w_OID_Part INTEGER, w_OID_Vol INTEGER, w_contenido VARCHAR2,
            salidaEsperada BOOLEAN);
    PROCEDURE eliminar
        (nombre_prueba VARCHAR2, w_OID_Ans INTEGER, salidaEsperada BOOLEAN);
END PRUEBAS_RESPUESTAS;
/
----------------------------------
--CUERPO DEL PAQUETE
----------------------------------
--PRUEBAS_PERSONAS
create or replace 
PACKAGE BODY PRUEBAS_PERSONAS AS
    PROCEDURE inicializar AS
    BEGIN
        DELETE FROM PERSONAS;
    END inicializar;
    
    PROCEDURE insertar(nombre_prueba VARCHAR2, w_dni CHAR, w_nombre VARCHAR2, w_apellidos VARCHAR2, w_fechaNacimiento DATE, w_direccion VARCHAR, 
        w_localidad VARCHAR2, w_provincia VARCHAR2, w_codigoPostal CHAR, w_email VARCHAR, w_telefono CHAR, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    persona PERSONAS%ROWTYPE;
    BEGIN 
        INSERT INTO PERSONAS VALUES( w_dni, w_nombre, w_apellidos, w_fechaNacimiento, w_direccion, 
        w_localidad, w_provincia, w_codigoPostal, w_email, w_telefono);
        SELECT * INTO persona FROM PERSONAS WHERE dni=w_dni;
        IF (persona.dni<>w_dni AND persona.nombre<>w_nombre AND persona.apellidos<>w_apellidos AND persona.fechaNacimiento<>w_fechaNacimiento
            AND persona.direccion<>w_direccion AND persona.localidad<>w_localidad AND persona.provincia<>w_provincia
            AND persona.codigoPostal<>w_codigoPostal AND persona.email<>w_email AND persona.telefono<>w_telefono) THEN
            salida:=false;
        END IF;
        COMMIT WORK;
        
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
        
        EXCEPTION 
        WHEN OTHERS THEN 
            DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
    END insertar; 
    
    PROCEDURE actualizar(nombre_prueba VARCHAR2, w_dni CHAR, w_nombre VARCHAR2, w_apellidos VARCHAR2, w_fechaNacimiento DATE, w_direccion VARCHAR, 
        w_localidad VARCHAR2, w_provincia VARCHAR2, w_codigoPostal CHAR, w_email VARCHAR, w_telefono CHAR, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    persona PERSONAS%ROWTYPE;
    BEGIN
    UPDATE PERSONAS SET nombre=w_nombre, apellidos=w_apellidos, fechaNacimiento=w_fechaNacimiento, direccion=w_direccion,
        localidad=w_localidad,provincia=w_provincia, codigoPostal=w_codigoPostal, email=w_email, telefono=w_telefono WHERE dni=w_dni;
    SELECT * INTO persona FROM PERSONAS WHERE dni= w_dni;
    IF (persona.dni<>w_dni AND persona.nombre<>w_nombre AND persona.apellidos<>w_apellidos AND persona.fechaNacimiento<>w_fechaNacimiento
        AND persona.direccion<>w_direccion AND persona.localidad<>w_localidad AND persona.provincia<>w_provincia 
        AND persona.codigoPostal<>w_codigoPostal AND persona.email<>w_email AND persona.telefono<>w_telefono) THEN
        salida:=false;
    END IF;
    COMMIT WORK;
    
    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN 
       DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada)); 
       ROLLBACK; 
    END actualizar;
    
    PROCEDURE eliminar(nombre_prueba VARCHAR2, w_dni CHAR, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    n_personas INTEGER;
    BEGIN
    DELETE FROM PERSONAS WHERE dni=w_dni;
    SELECT COUNT (*) INTO n_personas FROM PERSONAS WHERE dni=w_dni;
    IF(n_personas<>0) THEN 
        salida:=false;
    END IF;
    COMMIT WORK;
    
    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false,salidaEsperada));
        ROLLBACK;
    END eliminar;
    
END PRUEBAS_PERSONAS;
/
--PRUEBAS_COORDINADORES
create or replace 
PACKAGE BODY PRUEBAS_COORDINADORES AS
    PROCEDURE inicializar AS
    BEGIN
        DELETE FROM COORDINADORES;
    END inicializar;
    
    PROCEDURE insertar(nombre_prueba VARCHAR2, w_dni CHAR, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    coordinador COORDINADORES%ROWTYPE;
    w_OID_Coord INTEGER;
    BEGIN 
        INSERT INTO COORDINADORES(dni) VALUES(w_dni);
        w_OID_Coord := sec_Coord.currval;
        SELECT * INTO coordinador FROM COORDINADORES WHERE OID_Coord=w_OID_Coord;
        IF (coordinador.dni<>w_dni) THEN
            salida:=false;
        END IF;
        COMMIT WORK;
        
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
        
        EXCEPTION 
        WHEN OTHERS THEN 
            DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
    END insertar;
    
     PROCEDURE actualizar (nombre_prueba VARCHAR2, w_OID_Coord INTEGER, w_dni CHAR, salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    coordinador COORDINADORES%ROWTYPE;
    BEGIN
        UPDATE COORDINADORES SET dni=w_dni WHERE OID_Coord=w_OID_Coord;
        SELECT * INTO coordinador FROM COORDINADORES WHERE OID_Coord=w_OID_Coord;
        IF (coordinador.dni<>w_dni) THEN
            salida := false;
        END IF;
        COMMIT WORK;
    
            DBMS_OUTPUT.PUT_LINE(nombre_prueba || ':' || ASSERT_EQUALS(salida,salidaEsperada));
    
        EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(nombre_prueba || ':' || ASSERT_EQUALS(false,salidaEsperada));    
    ROLLBACK;
    END actualizar;
    
    PROCEDURE eliminar(nombre_prueba VARCHAR2,w_OID_Coord INTEGER, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    n_coordinadores INTEGER;

    BEGIN
    DELETE FROM COORDINADORES WHERE OID_Coord=w_OID_Coord;
    SELECT COUNT (*) INTO n_coordinadores FROM COORDINADORES WHERE OID_Coord=w_OID_Coord ;
    IF(n_coordinadores<>0) THEN 
        salida:=false;
    END IF;
    COMMIT WORK;
    
    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false,salidaEsperada));
        ROLLBACK;
    END eliminar;
    
END PRUEBAS_COORDINADORES;
/
--PRUEBAS_TUTORESLEGALES
create or replace 
PACKAGE BODY PRUEBAS_TUTORESLEGALES AS
    PROCEDURE inicializar AS
    BEGIN
        DELETE FROM TUTORESLEGALES;
    END inicializar;
    
    PROCEDURE insertar(nombre_prueba VARCHAR2, w_dni CHAR, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    tutorlegal TUTORESLEGALES%ROWTYPE;
    w_OID_Tut INTEGER;
    BEGIN 
        INSERT INTO TUTORESLEGALES(dni) VALUES( w_dni);
        w_OID_Tut:= sec_Tut.currval;
        SELECT * INTO tutorlegal FROM TUTORESLEGALES WHERE dni=w_dni;
        IF (tutorlegal.dni<>w_dni) THEN
            salida:=false;
        END IF;
        COMMIT WORK;
        
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
        
        EXCEPTION 
        WHEN OTHERS THEN 
            DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
    END insertar;
    
    PROCEDURE actualizar (nombre_prueba VARCHAR2, w_OID_Tut INTEGER, w_dni CHAR, salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    tutorlegal TUTORESLEGALES%ROWTYPE;
    BEGIN
        UPDATE TUTORESLEGALES SET dni=w_dni WHERE OID_Tut=w_OID_Tut;
        SELECT * INTO tutorlegal FROM TUTORESLEGALES WHERE OID_Tut=w_OID_Tut;
        IF (tutorlegal.dni<>w_dni) THEN
            salida := false;
        END IF;
        COMMIT WORK;
    
        DBMS_OUTPUT.PUT_LINE(nombre_prueba || ':' || ASSERT_EQUALS(salida,salidaEsperada));
    
        EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(nombre_prueba || ':' || ASSERT_EQUALS(false,salidaEsperada));
        ROLLBACK;
    END actualizar;
    
    PROCEDURE eliminar(nombre_prueba VARCHAR2, w_OID_Tut INTEGER, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    n_tutoreslegales INTEGER;
    BEGIN
    DELETE FROM TUTORESLEGALES WHERE OID_Tut=w_OID_Tut;
    SELECT COUNT (*) INTO n_tutoreslegales FROM TUTORESLEGALES WHERE OID_Tut=w_OID_Tut;
    IF(n_tutoreslegales<>0) THEN 
        salida:=false;
    END IF;
    COMMIT WORK;
    
    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false,salidaEsperada));
        ROLLBACK;
    END eliminar;
    
END PRUEBAS_TUTORESLEGALES;
/
--PRUEBAS_VOLUNTARIOS
create or replace 
PACKAGE BODY PRUEBAS_VOLUNTARIOS AS
    PROCEDURE inicializar AS
    BEGIN
        DELETE FROM VOLUNTARIOS;
    END inicializar; 
    
    PROCEDURE insertar(nombre_prueba VARCHAR2, w_dni CHAR, w_prioridadParticipacion VARCHAR2, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    voluntario VOLUNTARIOS%ROWTYPE;
    w_OID_Vol INTEGER;
    BEGIN 
        INSERT INTO VOLUNTARIOS(dni, prioridadParticipacion) VALUES(w_dni, w_prioridadParticipacion);
        w_OID_Vol:=SEC_VOL.CURRVAL;
        SELECT * INTO voluntario FROM VOLUNTARIOS WHERE OID_Vol= w_OID_Vol;
        IF (voluntario.dni<>w_dni or voluntario.prioridadParticipacion<>w_prioridadParticipacion ) THEN
            salida:=false;
        END IF;
        COMMIT WORK;
        
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
        
        EXCEPTION 
        WHEN OTHERS THEN 
            DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
    END insertar;

    PROCEDURE actualizar(nombre_prueba VARCHAR2, w_OID_Vol INTEGER, w_dni CHAR, w_prioridadParticipacion VARCHAR2, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    voluntario VOLUNTARIOS%ROWTYPE;
    BEGIN
    UPDATE VOLUNTARIOS SET dni=w_dni, prioridadParticipacion=w_prioridadParticipacion WHERE OID_Vol= w_OID_Vol;
    SELECT * INTO voluntario FROM VOLUNTARIOS WHERE OID_Vol= w_OID_Vol ;
    IF (voluntario.dni<>w_dni or voluntario.prioridadParticipacion<>w_prioridadParticipacion) THEN
    salida:=false;
    END IF;
    COMMIT WORK;
    
    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN 
       DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada)); 
       ROLLBACK; 
    END actualizar;
    
    PROCEDURE eliminar(nombre_prueba VARCHAR2, w_OID_Vol INTEGER, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    n_voluntarios INTEGER;
    BEGIN
    DELETE FROM VOLUNTARIOS WHERE  OID_Vol= w_OID_Vol ;
    SELECT COUNT (*) INTO n_voluntarios FROM VOLUNTARIOS WHERE OID_Vol= w_OID_Vol;
    IF(n_voluntarios<>0) THEN 
        salida:=false;
    END IF;
    COMMIT WORK;
    
    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false,salidaEsperada));
        ROLLBACK;
    END eliminar;
    
END PRUEBAS_VOLUNTARIOS;
/
--PRUEBAS_PARTICIPANTES
create or replace
PACKAGE BODY PRUEBAS_PARTICIPANTES AS
    PROCEDURE inicializar AS
    BEGIN 
        DELETE FROM PARTICIPANTES;
    END inicializar;
    
    PROCEDURE insertar(nombre_prueba VARCHAR2, w_dni CHAR, w_gradoDiscapacidad VARCHAR2, w_prioridadParticipacion VARCHAR2, w_OID_Tut INTEGER,
        w_OID_Vol INTEGER, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    participante PARTICIPANTES%ROWTYPE;
    w_OID_Part INTEGER;
    BEGIN 
        INSERT INTO PARTICIPANTES(dni, gradoDiscapacidad, prioridadParticipacion, OID_Tut, OID_Vol) VALUES( w_dni, w_gradoDiscapacidad,
            w_prioridadParticipacion, w_OID_Tut, w_OID_Vol);
        w_OID_Part:= SEC_PART.CURRVAL;
        SELECT * INTO participante FROM PARTICIPANTES WHERE OID_Part=w_OID_Part;
        IF (participante.dni<>w_dni AND participante.gradoDiscapacidad<>w_gradoDiscapacidad AND
            participante.prioridadParticipacion<>w_prioridadParticipacion AND participante.OID_Tut<>w_OID_Tut
            AND participante.OID_Vol<>w_OID_Vol) THEN
            salida:=false;
        END IF; 
        COMMIT WORK;
        
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
        
        EXCEPTION 
        WHEN OTHERS THEN 
            DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
    END insertar;
    
    PROCEDURE actualizar(nombre_prueba VARCHAR2, w_OID_Part INTEGER, w_dni CHAR, w_gradoDiscapacidad VARCHAR2, w_prioridadParticipacion VARCHAR2,
        w_OID_Tut INTEGER, w_OID_Vol INTEGER, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    participante PARTICIPANTES%ROWTYPE;
    BEGIN 
        UPDATE PARTICIPANTES SET dni=w_dni, gradoDiscapacidad=w_gradoDiscapacidad, prioridadParticipacion=w_prioridadParticipacion,
            OID_Tut=w_OID_Tut, OID_Vol=w_OID_Vol WHERE OID_Part= w_OID_Part;
        SELECT * INTO participante FROM PARTICIPANTES WHERE OID_Part= w_OID_Part ;
        IF (participante.dni<>w_dni or participante.gradoDiscapacidad<>w_gradoDiscapacidad
            or participante.prioridadParticipacion<>w_prioridadParticipacion or participante.OID_Tut<>w_OID_Tut or participante.OID_Vol<>w_OID_Vol) THEN
            salida:=false;
        END IF;
        COMMIT WORK;
    
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
    
        EXCEPTION
        WHEN OTHERS THEN 
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada)); 
        ROLLBACK; 
    END actualizar;
    
    PROCEDURE eliminar(nombre_prueba VARCHAR2, w_OID_Part INTEGER, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    n_participantes INTEGER;
    BEGIN
        DELETE FROM PARTICIPANTES WHERE  OID_Part= w_OID_Part;
        SELECT COUNT (*) INTO n_participantes FROM PARTICIPANTES WHERE OID_Part= w_OID_Part;
        IF(n_participantes<>0) THEN 
            salida:=false;
        END IF;
        COMMIT WORK;
        
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
    
        EXCEPTION
        WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false,salidaEsperada));
        ROLLBACK;
    END eliminar;
    
END PRUEBAS_PARTICIPANTES;
/
--PRUEBAS_INFORMESMEDICOS
create or replace
PACKAGE BODY PRUEBAS_INFORMESMEDICOS AS
    PROCEDURE inicializar AS
    BEGIN 
        DELETE FROM INFORMESMEDICOS;
    END inicializar;
    
    PROCEDURE insertar(nombre_prueba VARCHAR2, w_OID_Part INTEGER, w_descripcion LONG, w_fecha DATE, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    informeMedico INFORMESMEDICOS%ROWTYPE;
    w_OID_Inf INTEGER;
    BEGIN 
        INSERT INTO INFORMESMEDICOS(OID_Part, descripcion, fecha) VALUES( w_OID_Part, w_descripcion, w_fecha);
        w_OID_Inf:= SEC_INF.CURRVAL;
        SELECT * INTO informeMedico FROM INFORMESMEDICOS WHERE OID_Inf=w_OID_Inf;
        IF (informeMedico.OID_Part<>w_OID_Part AND informeMedico.descripcion<>w_descripcion AND informemedico.fecha<>w_fecha) THEN
            salida:=false;
        END IF; 
        COMMIT WORK;
        
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
        
        EXCEPTION 
        WHEN OTHERS THEN 
            DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
    END insertar;
    
    PROCEDURE actualizar(nombre_prueba VARCHAR2, w_OID_Inf INTEGER, w_OID_Part INTEGER, w_descripcion LONG, w_fecha DATE, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    informeMedico INFORMESMEDICOS%ROWTYPE;
    BEGIN
    UPDATE INFORMESMEDICOS SET OID_Part=w_OID_Part, descripcion=w_descripcion, fecha=w_fecha WHERE OID_Inf= w_OID_Inf;
    SELECT * INTO informeMedico FROM INFORMESMEDICOS WHERE OID_Inf= w_OID_Inf ;
    IF (informeMedico.OID_Part<>w_OID_Part AND informeMedico.descripcion<>w_descripcion AND informemedico.fecha<>w_fecha) THEN
    salida:=false;
    END IF;
    COMMIT WORK;
    
    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN 
       DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada)); 
       ROLLBACK; 
    END actualizar;
    
    PROCEDURE eliminar(nombre_prueba VARCHAR2, w_OID_Inf INTEGER, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    n_informesMedicos INTEGER;
    BEGIN
    DELETE FROM INFORMESMEDICOS WHERE  OID_Inf= w_OID_Inf;
    SELECT COUNT (*) INTO n_informesMedicos FROM INFORMESMEDICOS WHERE OID_Inf= w_OID_Inf;
    IF(n_informesMedicos<>0) THEN 
        salida:=false;
    END IF;
    COMMIT WORK;
    
    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false,salidaEsperada));
        ROLLBACK;
    END eliminar;
    
END PRUEBAS_INFORMESMEDICOS;
/
--PRUEBAS_ESTAINTERESADOEN
create or replace
PACKAGE BODY PRUEBAS_ESTAINTERESADOEN AS
    PROCEDURE inicializar AS
    BEGIN 
        DELETE FROM ESTAINTERESADOEN;
    END inicializar;
 
    PROCEDURE insertar(nombre_prueba VARCHAR2, w_OID_Part INTEGER, w_OID_Vol INTEGER, w_OID_Act INTEGER, w_estado SMALLINT , salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    estaInteresado ESTAINTERESADOEN%ROWTYPE;
    w_OID_Int INTEGER;
    BEGIN 
        INSERT INTO ESTAINTERESADOEN(OID_Part, OID_Vol, OID_Act, estado) VALUES(w_OID_Part, w_OID_Vol, w_OID_Act, w_estado);
        w_OID_Int:= SEC_INT.CURRVAL;
        SELECT * INTO estaInteresado FROM ESTAINTERESADOEN WHERE OID_Int=w_OID_Int;
        IF (estaInteresado.OID_Part<>w_OID_Part AND estaInteresado.OID_Vol<>w_OID_Vol AND estaInteresado.OID_Act<>w_OID_Act
            AND estaInteresado.estado<>w_estado) THEN
            salida:=false;
        END IF; 
        COMMIT WORK;
        
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
        
        EXCEPTION 
        WHEN OTHERS THEN 
            DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
    END insertar;
    
    PROCEDURE actualizar(nombre_prueba VARCHAR2, w_OID_Int INTEGER, w_OID_Part INTEGER, w_OID_Vol INTEGER, w_OID_Act INTEGER,
        w_estado SMALLINT , salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    estaInteresado ESTAINTERESADOEN%ROWTYPE;
    BEGIN
    UPDATE ESTAINTERESADOEN SET OID_Part=w_OID_Part, OID_Vol=w_OID_Vol, OID_Act=w_OID_Act, estado=w_estado WHERE OID_Int= w_OID_Int;
    SELECT * INTO estaInteresado FROM ESTAINTERESADOEN WHERE OID_Int= w_OID_Int;
    IF (estaInteresado.OID_Part<>w_OID_Part AND estaInteresado.OID_Vol<>w_OID_Vol AND estaInteresado.OID_Act<>w_OID_Act
        AND estaInteresado.estado<>w_estado) THEN
    salida:=false;
    END IF;
    COMMIT WORK;
    
    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN 
       DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada)); 
       ROLLBACK; 
    END actualizar;
    
    PROCEDURE eliminar(nombre_prueba VARCHAR2, w_OID_Int INTEGER, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    n_estaInteresadoEn INTEGER;
    BEGIN
    DELETE FROM ESTAINTERESADOEN WHERE  OID_Int= w_OID_Int;
    SELECT COUNT (*) INTO n_estaInteresadoEn FROM ESTAINTERESADOEN WHERE OID_Int= w_OID_Int;
    IF(n_estaInteresadoEn<>0) THEN 
        salida:=false;
    END IF;
    COMMIT WORK;
    
    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false,salidaEsperada));
        ROLLBACK;
    END eliminar;
    
END PRUEBAS_ESTAINTERESADOEN;
/
--PRUEBAS_INSTITUCIONES
create or replace 
PACKAGE BODY PRUEBAS_INSTITUCIONES AS
    PROCEDURE inicializar AS
    BEGIN
        DELETE FROM INSTITUCIONES;
    END inicializar;
    
    PROCEDURE insertar(nombre_prueba VARCHAR2, w_cif CHAR, w_nombre VARCHAR2, w_telefono CHAR, w_direccion VARCHAR2,
        w_localidad VARCHAR2, w_provincia VARCHAR2,w_codigoPostal CHAR, w_email VARCHAR2, w_esPatrocinador SMALLINT,
        w_tipo VARCHAR2, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    institucion INSTITUCIONES%ROWTYPE;
    BEGIN 
        INSERT INTO INSTITUCIONES VALUES( w_cif, w_nombre, w_telefono, w_direccion, w_localidad, w_provincia, w_codigoPostal,
            w_email, w_esPatrocinador, w_tipo);
        SELECT * INTO institucion FROM INSTITUCIONES WHERE cif=w_cif;
        IF (institucion.cif<>w_cif or institucion.nombre<>w_nombre or institucion.telefono<>w_telefono or institucion.direccion<>w_direccion
            or institucion.localidad<>w_localidad or institucion.provincia<>w_provincia or institucion.codigoPostal<>w_codigoPostal
            or institucion.email<>w_email or institucion.esPatrocinador<>w_esPatrocinador or institucion.tipo<>w_tipo) THEN
            salida:=false;
        END IF;
        COMMIT WORK;
        
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
        
        EXCEPTION 
        WHEN OTHERS THEN 
            DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
    END insertar;
    
    PROCEDURE actualizar(nombre_prueba VARCHAR2, w_cif CHAR, w_nombre VARCHAR2, w_telefono CHAR, w_direccion VARCHAR2,
        w_localidad VARCHAR2, w_provincia VARCHAR2, w_codigoPostal CHAR, w_email VARCHAR2, w_esPatrocinador SMALLINT,
        w_tipo VARCHAR2, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    institucion INSTITUCIONES%ROWTYPE;
    BEGIN  
    UPDATE INSTITUCIONES SET nombre=w_nombre, telefono=w_telefono, direccion=w_direccion, localidad=w_localidad,
    provincia=w_provincia, codigoPostal=w_codigoPostal, email=w_email, esPatrocinador=w_esPatrocinador, tipo=w_tipo WHERE cif=w_cif;
    SELECT * INTO institucion FROM INSTITUCIONES WHERE cif= w_cif;
    IF (institucion.cif<>w_cif or institucion.nombre<>w_nombre or institucion.telefono<>w_telefono or institucion.direccion<>w_direccion
        or institucion.localidad<>w_localidad or institucion.provincia<>w_provincia or institucion.codigoPostal<>w_codigoPostal
        or institucion.email<>w_email or institucion.esPatrocinador<>w_esPatrocinador or institucion.tipo<>w_tipo) THEN
        salida:=false;
    END IF;
    COMMIT WORK;
    
    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN 
       DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada)); 
       ROLLBACK; 
    END actualizar;
    
    PROCEDURE eliminar(nombre_prueba VARCHAR2, w_cif CHAR, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    n_instituciones INTEGER;
    BEGIN
    DELETE FROM INSTITUCIONES WHERE cif=w_cif;
    SELECT COUNT (*) INTO n_instituciones FROM INSTITUCIONES WHERE cif=w_cif;
    IF(n_instituciones<>0) THEN 
        salida:=false;
    END IF;
    COMMIT WORK;
    
    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false,salidaEsperada));
        ROLLBACK;
    END eliminar;
    
END PRUEBAS_INSTITUCIONES;
/
--PRUEBAS_PROYECTOS
create or replace
PACKAGE BODY PRUEBAS_PROYECTOS AS

PROCEDURE inicializar AS
BEGIN
    DELETE FROM PROYECTOS;
END inicializar;
    
PROCEDURE insertar(nombre_prueba VARCHAR2, w_nombre VARCHAR2, w_ubicacion CHAR, w_esEvento SMALLINT, w_esProgDep SMALLINT, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    proyecto PROYECTOS%ROWTYPE;
    w_OID_Proj INTEGER;
BEGIN 
    INSERT INTO PROYECTOS(nombre, ubicacion, esEvento, esProgDep) VALUES(w_nombre, w_ubicacion, w_esEvento, w_esProgDep);
    w_OID_Proj:=SEC_PROJ.CURRVAL;
    SELECT * INTO proyecto FROM PROYECTOS WHERE OID_Proj=w_OID_Proj;
    IF (proyecto.nombre<>w_nombre AND proyecto.ubicacion<>w_ubicacion AND proyecto.esEvento<>w_esEvento AND proyecto.esProgDep<>w_esProgDep) THEN
        salida:=false;
    END IF;
    COMMIT WORK;
        
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
        
        EXCEPTION 
        WHEN OTHERS THEN 
            DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
END insertar;
    
PROCEDURE actualizar(nombre_prueba VARCHAR2,w_OID_Proj INTEGER, w_nombre VARCHAR2, w_ubicacion CHAR, w_esEvento SMALLINT,
    w_esProgDep SMALLINT, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    proyecto PROYECTOS%ROWTYPE;
BEGIN  
    UPDATE PROYECTOS SET nombre=w_nombre, ubicacion=w_ubicacion, esEvento=w_esEvento, esProgDep=w_esProgDep WHERE OID_Proj=w_OID_Proj;
    SELECT * INTO proyecto FROM PROYECTOS WHERE OID_Proj=w_OID_Proj;
    IF (proyecto.nombre<>w_nombre AND proyecto.ubicacion<>w_ubicacion AND proyecto.esEvento<>w_esEvento AND proyecto.esProgDep<>w_esProgDep) THEN
        salida:=false;
    END IF;
    COMMIT WORK;
    
    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN 
       DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada)); 
       ROLLBACK; 
END actualizar;
    
PROCEDURE eliminar(nombre_prueba VARCHAR2, w_OID_Proj INTEGER, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    n_proyectos INTEGER;
BEGIN
    DELETE FROM PROYECTOS WHERE OID_Proj=w_OID_Proj;
    SELECT COUNT (*) INTO n_proyectos FROM PROYECTOS WHERE OID_Proj=w_OID_Proj;
    IF(n_proyectos<>0) THEN 
        salida:=false;
    END IF;
    COMMIT WORK;
    
    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false,salidaEsperada));
        ROLLBACK;
END eliminar;
    
END PRUEBAS_PROYECTOS;
/
--PRUEBAS_ACTIVIDADES
create or replace
PACKAGE BODY PRUEBAS_ACTIVIDADES AS
    PROCEDURE inicializar AS
    BEGIN 
        DELETE FROM ACTIVIDADES;
    END inicializar;
 
    PROCEDURE insertar(nombre_prueba VARCHAR2, w_OID_Proj INTEGER, w_nombre VARCHAR2, w_objetivo VARCHAR2, w_fechaInicio DATE,
        w_fechaFin DATE, w_numeroPlazas INTEGER, w_voluntariosRequeridos INTEGER, w_tipo VARCHAR2, w_costeTotal NUMBER,
        w_costeInscripcion NUMBER, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    actividad ACTIVIDADES%ROWTYPE;
    w_OID_Act INTEGER;
    BEGIN 
        INSERT INTO ACTIVIDADES(OID_Proj, nombre, objetivo, fechaInicio, fechaFin, numeroPlazas, voluntariosRequeridos, tipo,
            costeTotal, costeInscripcion) VALUES(w_OID_Proj, w_nombre, w_objetivo, w_fechaInicio, w_fechaFin, w_numeroPlazas,
            w_voluntariosRequeridos, w_tipo, w_costeTotal, w_costeInscripcion);
        w_OID_Act:= SEC_ACT.CURRVAL;
        SELECT * INTO actividad FROM ACTIVIDADES WHERE OID_Act=w_OID_Act;
        IF (actividad.OID_Proj<>w_OID_Proj AND actividad.nombre<>w_nombre AND actividad.objetivo<>w_objetivo
            AND actividad.fechaInicio<>w_fechaInicio AND actividad.fechaFin<>w_fechaFin AND actividad.numeroPlazas<>w_numeroPlazas
            AND actividad.voluntariosRequeridos<>w_voluntariosRequeridos AND actividad.tipo<>w_tipo AND actividad.costeTotal<>w_costeTotal
            AND actividad.costeInscripcion<>w_costeInscripcion) THEN
            salida:=false;
        END IF; 
        COMMIT WORK;
        
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
        
        EXCEPTION 
        WHEN OTHERS THEN 
            DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
    END insertar;
    
    PROCEDURE actualizar(nombre_prueba VARCHAR2, w_OID_Act INTEGER, w_OID_Proj INTEGER, w_nombre VARCHAR2, w_objetivo VARCHAR2,
        w_fechaInicio DATE, w_fechaFin DATE, w_numeroPlazas INTEGER, w_voluntariosRequeridos INTEGER, w_tipo VARCHAR2, w_costeTotal NUMBER,
        w_costeInscripcion NUMBER, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    actividad ACTIVIDADES%ROWTYPE;
    BEGIN
    UPDATE ACTIVIDADES SET OID_Proj=w_OID_Proj, nombre=w_nombre, objetivo=w_objetivo, fechaInicio=w_fechaInicio, fechaFin=w_fechaFin,
        numeroPlazas=w_numeroPlazas, voluntariosRequeridos=w_voluntariosRequeridos,tipo=w_tipo, costeTotal=w_costeTotal,
        costeInscripcion=w_costeInscripcion WHERE OID_Act=w_OID_Act;
    SELECT * INTO actividad FROM ACTIVIDADES WHERE OID_Act= w_OID_Act;
    IF (actividad.OID_Proj<>w_OID_Proj AND actividad.nombre<>w_nombre AND actividad.objetivo<>w_objetivo AND actividad.fechaInicio<>w_fechaInicio
        AND actividad.fechaFin<>w_fechaFin AND actividad.numeroPlazas<>w_numeroPlazas AND actividad.voluntariosRequeridos<>w_voluntariosRequeridos
        AND actividad.tipo<>w_tipo AND actividad.costeTotal<>w_costeTotal AND actividad.costeInscripcion<>w_costeInscripcion) THEN
    salida:=false;
    END IF;
    COMMIT WORK;
    
    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN 
       DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada)); 
       ROLLBACK; 
    END actualizar;
    
    PROCEDURE eliminar(nombre_prueba VARCHAR2, w_OID_Act INTEGER, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    n_actividades INTEGER;
    BEGIN
    DELETE FROM ACTIVIDADES WHERE  OID_Act= w_OID_Act;
    SELECT COUNT (*) INTO n_actividades FROM ACTIVIDADES WHERE OID_Act= w_OID_Act;
    IF(n_actividades<>0) THEN 
        salida:=false;
    END IF;
    COMMIT WORK;
    
    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false,salidaEsperada));
        ROLLBACK;
    END eliminar;
    
END PRUEBAS_ACTIVIDADES;
/
--PRUEBAS_ENCARGADOS
create or replace
PACKAGE BODY PRUEBAS_ENCARGADOS AS
    PROCEDURE inicializar AS
    BEGIN 
        DELETE FROM ENCARGADOS;
    END inicializar;
 
    PROCEDURE insertar(nombre_prueba VARCHAR2,w_OID_Proj INTEGER, w_OID_Coord INTEGER, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    encargado ENCARGADOS%ROWTYPE;
    w_OID_RP INTEGER;
    BEGIN 
        INSERT INTO ENCARGADOS(OID_Proj, OID_Coord) VALUES(w_OID_Proj, w_OID_Coord);
        w_OID_RP:= SEC_RP.CURRVAL;
        SELECT * INTO encargado FROM ENCARGADOS WHERE OID_RP=w_OID_RP;
        IF (encargado.OID_Proj<>w_OID_Proj AND encargado.OID_Coord<>w_OID_Coord) THEN
            salida:=false;
        END IF; 
        COMMIT WORK;
        
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
        
        EXCEPTION 
        WHEN OTHERS THEN 
            DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
    END insertar;
    
    PROCEDURE actualizar(nombre_prueba VARCHAR2,w_OID_RP INTEGER ,w_OID_Proj INTEGER, w_OID_Coord INTEGER, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    encargado ENCARGADOS%ROWTYPE;
    BEGIN
    UPDATE ENCARGADOS SET OID_Proj=w_OID_Proj, OID_Coord=w_OID_Coord WHERE OID_RP= w_OID_RP;
    SELECT * INTO encargado FROM ENCARGADOS WHERE OID_RP= w_OID_RP;
    IF (encargado.OID_Proj<>w_OID_Proj AND encargado.OID_Coord<>w_OID_Coord) THEN
    salida:=false;
    END IF;
    COMMIT WORK;
    
    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN 
       DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada)); 
       ROLLBACK; 
    END actualizar;
    
    PROCEDURE eliminar(nombre_prueba VARCHAR2, w_OID_RP INTEGER, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    n_encargados INTEGER;
    BEGIN
    DELETE FROM ENCARGADOS WHERE  OID_RP= w_OID_RP;
    SELECT COUNT (*) INTO n_encargados FROM ENCARGADOS WHERE OID_RP= w_OID_RP;
    IF(n_encargados<>0) THEN 
        salida:=false;
    END IF;
    COMMIT WORK;
    
    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false,salidaEsperada));
        ROLLBACK;
    END eliminar;
    
END PRUEBAS_ENCARGADOS;
/
--PRUEBAS_COLABORACIONES
create or replace
PACKAGE BODY PRUEBAS_COLABORACIONES AS
    PROCEDURE inicializar AS
    BEGIN 
        DELETE FROM COLABORACIONES;
    END inicializar;

    PROCEDURE insertar(nombre_prueba VARCHAR2, w_OID_Vol INTEGER, w_OID_Act INTEGER, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    colaboracion COLABORACIONES%ROWTYPE;
    w_OID_Colab INTEGER;
    BEGIN 
        INSERT INTO COLABORACIONES(OID_Vol, OID_Act) VALUES(w_OID_Vol, w_OID_Act);
        w_OID_Colab:= SEC_COLAB.CURRVAL;
        SELECT * INTO colaboracion FROM COLABORACIONES WHERE OID_Colab=w_OID_Colab;
        IF (colaboracion.OID_Vol<>w_OID_Vol AND colaboracion.OID_Act<>w_OID_Act) THEN
            salida:=false;
        END IF; 
        COMMIT WORK;
        
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
        
        EXCEPTION 
        WHEN OTHERS THEN 
            DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
    END insertar;

    PROCEDURE actualizar(nombre_prueba VARCHAR2, w_OID_Colab INTEGER, w_OID_Vol INTEGER, w_OID_Act INTEGER, salidaEsperada BOOLEAN) AS
   salida BOOLEAN:=true;
    colaboracion COLABORACIONES%ROWTYPE;
    BEGIN
    UPDATE COLABORACIONES SET OID_Vol=w_OID_Vol, OID_Act=w_OID_Act WHERE OID_Colab= w_OID_Colab;
    SELECT * INTO colaboracion FROM COLABORACIONES WHERE OID_Colab= w_OID_Colab;
    IF (colaboracion.OID_Vol<>w_OID_Vol AND colaboracion.OID_Act<>w_OID_Act) THEN
    salida:=false;
    END IF;
   COMMIT WORK;
    
    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN 
       DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada)); 
       ROLLBACK; 
    END actualizar;
    
    PROCEDURE eliminar(nombre_prueba VARCHAR2, w_OID_Colab INTEGER, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    n_colaboraciones INTEGER;
    BEGIN
    DELETE FROM COLABORACIONES WHERE OID_Colab= w_OID_Colab;
    SELECT COUNT (*) INTO n_colaboraciones FROM COLABORACIONES WHERE OID_Colab= w_OID_Colab;
    IF(n_colaboraciones<>0) THEN 
        salida:=false;
    END IF;
    COMMIT WORK;
    
    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false,salidaEsperada));
        ROLLBACK;
    END eliminar;
    
END PRUEBAS_COLABORACIONES;
/
--PRUEBAS_RECIBOS
create or replace
PACKAGE BODY PRUEBAS_RECIBOS AS
    PROCEDURE inicializar AS
    BEGIN 
        DELETE FROM RECIBOS;
    END inicializar;

    PROCEDURE insertar(nombre_prueba VARCHAR2, w_OID_Act INTEGER, w_OID_Part INTEGER, w_fechaEmision DATE, w_fechaVencimiento DATE,
        w_importe NUMBER, w_estado VARCHAR2, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    recibo RECIBOS%ROWTYPE;
    w_OID_Rec INTEGER;
    BEGIN 
        INSERT INTO RECIBOS(OID_Act, OID_Part, fechaEmision, fechaVencimiento, importe, estado) VALUES(w_OID_Act, w_OID_Part, w_fechaEmision,
            w_fechaVencimiento, w_importe, w_estado);
        w_OID_Rec:= SEC_REC.CURRVAL;
        SELECT * INTO recibo FROM RECIBOS WHERE OID_Rec=w_OID_Rec;
        IF (recibo.OID_Act<>w_OID_Act AND recibo.OID_Part<>w_OID_Part AND recibo.fechaEmision<>w_fechaEmision
            AND recibo.fechaVencimiento<>w_fechaVencimiento AND recibo.importe<>w_importe AND recibo.estado<>w_estado) THEN
            salida:=false;
        END IF; 
        COMMIT WORK;
        
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
        
        EXCEPTION 
        WHEN OTHERS THEN 
            DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
    END insertar;
    
    PROCEDURE actualizar(nombre_prueba VARCHAR2, w_OID_Rec INTEGER, w_OID_Act INTEGER, w_OID_Part INTEGER, w_fechaEmision DATE,
        w_fechaVencimiento DATE, w_importe NUMBER, w_estado VARCHAR2, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    recibo RECIBOS%ROWTYPE;
    BEGIN
    UPDATE RECIBOS SET OID_Act=w_OID_Act, OID_Part=w_OID_Part, fechaEmision=w_fechaEmision, fechaVencimiento=w_fechaVencimiento,
        importe=w_importe, estado=w_estado WHERE OID_Rec= w_OID_Rec;
    SELECT * INTO recibo FROM RECIBOS WHERE OID_Rec= w_OID_Rec;
    IF (recibo.OID_Act<>w_OID_Act AND recibo.OID_Part<>w_OID_Part AND recibo.fechaEmision<>w_fechaEmision
        AND recibo.fechaVencimiento<>w_fechaVencimiento
            AND recibo.importe<>w_importe AND recibo.estado<>w_estado) THEN
    salida:=false;
    END IF;
    COMMIT WORK;
    
    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN 
       DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada)); 
       ROLLBACK; 
    END actualizar;
    
    PROCEDURE eliminar(nombre_prueba VARCHAR2, w_OID_Rec INTEGER, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    n_recibos INTEGER;
    BEGIN
    DELETE FROM RECIBOS WHERE  OID_Rec= w_OID_Rec;
    SELECT COUNT (*) INTO n_recibos FROM RECIBOS WHERE OID_Rec= w_OID_Rec;
    IF(n_recibos<>0) THEN 
        salida:=false;
    END IF;
    COMMIT WORK;
    
    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false,salidaEsperada));
        ROLLBACK;
    END eliminar;
    
END PRUEBAS_RECIBOS;
/
--PRUEBAS_INSCRIPCIONES
create or replace
PACKAGE BODY PRUEBAS_INSCRIPCIONES AS
    PROCEDURE inicializar AS
    BEGIN 
        DELETE FROM INSCRIPCIONES;
    END inicializar;

    PROCEDURE insertar(nombre_prueba VARCHAR2, w_OID_Part INTEGER, w_OID_Act INTEGER, w_OID_Rec INTEGER, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    inscripcion INSCRIPCIONES%ROWTYPE;
    w_OID_Ins INTEGER;
    BEGIN 
        INSERT INTO INSCRIPCIONES(OID_Part, OID_Act, OID_Rec) VALUES(w_OID_Part, w_OID_Act, w_OID_Rec);
        w_OID_Ins:= SEC_INS.CURRVAL;
        SELECT * INTO inscripcion FROM INSCRIPCIONES WHERE OID_Ins=w_OID_Ins;
        IF (inscripcion.OID_Part<>w_OID_Part AND inscripcion.OID_Act<>w_OID_Act AND inscripcion.OID_Rec<>w_OID_Rec) THEN
            salida:=false;
        END IF; 
        COMMIT WORK;
        
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
        
        EXCEPTION 
        WHEN OTHERS THEN 
            DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
    END insertar;
    
    PROCEDURE actualizar(nombre_prueba VARCHAR2, w_OID_Ins INTEGER, w_OID_Part INTEGER, w_OID_Act INTEGER, w_OID_Rec INTEGER, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    inscripcion INSCRIPCIONES%ROWTYPE;
    BEGIN
    UPDATE INSCRIPCIONES SET OID_Part=w_OID_Part, OID_Act=w_OID_Act, OID_Rec=w_OID_Rec WHERE OID_Ins= w_OID_Ins;
    SELECT * INTO inscripcion FROM INSCRIPCIONES WHERE OID_Ins= w_OID_Ins;
    IF (inscripcion.OID_Part<>w_OID_Part AND inscripcion.OID_Act<>w_OID_Act AND inscripcion.OID_Rec<>w_OID_Rec) THEN
    salida:=false;
    END IF;
    COMMIT WORK;
    
    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN 
       DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada)); 
       ROLLBACK; 
    END actualizar;
    
    PROCEDURE eliminar(nombre_prueba VARCHAR2, w_OID_Ins INTEGER, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    n_inscripciones INTEGER;
    BEGIN
    DELETE FROM INSCRIPCIONES WHERE  OID_Ins= w_OID_Ins;
    SELECT COUNT (*) INTO n_inscripciones FROM INSCRIPCIONES WHERE OID_Ins= w_OID_Ins;
    IF(n_inscripciones<>0) THEN 
        salida:=false;
    END IF;
    COMMIT WORK;
    
    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false,salidaEsperada));
        ROLLBACK;
    END eliminar;
    
END PRUEBAS_INSCRIPCIONES;
/
--PRUEBAS_PATROCIONIOS
create or replace
PACKAGE BODY PRUEBAS_PATROCINIOS AS
    PROCEDURE inicializar AS
    BEGIN 
        DELETE FROM PATROCINIOS;
    END inicializar;

    PROCEDURE insertar(nombre_prueba VARCHAR2, w_cif CHAR , w_cantidad NUMBER, w_OID_Act INTEGER, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    patrocinio PATROCINIOS%ROWTYPE;
    w_OID_Fin INTEGER;
    BEGIN 
        INSERT INTO PATROCINIOS(cif, cantidad, OID_Act) VALUES(w_cif, w_cantidad, w_OID_Act);
        w_OID_Fin:= SEC_Fin.CURRVAL;
        SELECT * INTO patrocinio FROM PATROCINIOS WHERE OID_Fin=w_OID_Fin;
        IF (patrocinio.cif<>w_cif AND patrocinio.cantidad<>w_cantidad AND patrocinio.OID_Act<>w_OID_Act) THEN
            salida:=false;
        END IF; 
        COMMIT WORK;
        
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
        
        EXCEPTION 
        WHEN OTHERS THEN 
            DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
    END insertar;
    
    PROCEDURE actualizar(nombre_prueba VARCHAR2, w_OID_Fin INTEGER, w_cif CHAR , w_cantidad NUMBER, w_OID_Act INTEGER, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    patrocinio PATROCINIOS%ROWTYPE;
    BEGIN
    UPDATE PATROCINIOS SET cif=w_cif, cantidad=w_cantidad, OID_Act=w_OID_Act WHERE OID_Fin= w_OID_Fin;
    SELECT * INTO patrocinio FROM PATROCINIOS WHERE OID_Fin= w_OID_Fin;
    IF (patrocinio.cif<>w_cif AND patrocinio.cantidad<>w_cantidad AND patrocinio.OID_Act<>w_OID_Act) THEN
    salida:=false;
    END IF;
    COMMIT WORK;
    
    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN 
       DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada)); 
       ROLLBACK; 
    END actualizar;
    
    PROCEDURE eliminar(nombre_prueba VARCHAR2, w_OID_Fin INTEGER, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    n_patrocinios INTEGER;
    BEGIN
    DELETE FROM PATROCINIOS WHERE  OID_Fin= w_OID_Fin;
    SELECT COUNT (*) INTO n_patrocinios FROM PATROCINIOS WHERE OID_Fin= w_OID_Fin;
    IF(n_patrocinios<>0) THEN 
        salida:=false;
    END IF;
    COMMIT WORK;
    
    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false,salidaEsperada));
        ROLLBACK;
    END eliminar;
    
END PRUEBAS_PATROCINIOS;
/
--PRUEBAS_TIPOSDONACIONES
create or replace
PACKAGE BODY PRUEBAS_TIPODONACIONES AS

PROCEDURE inicializar AS
BEGIN
    DELETE FROM TIPODONACIONES;
END inicializar;

PROCEDURE insertar(nombre_prueba VARCHAR2, w_nombre VARCHAR2, w_tipoUnidad VARCHAR2, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    tipoDonacion TIPODONACIONES%ROWTYPE;
    w_OID_TDon INTEGER;
BEGIN 
    INSERT INTO TIPODONACIONES(nombre, tipoUnidad) VALUES(w_nombre, w_tipoUnidad);
    w_OID_TDon:=SEC_TDon.CURRVAL;
    SELECT * INTO tipoDonacion FROM TIPODONACIONES WHERE OID_TDon=w_OID_TDon;
    IF (tipoDonacion.nombre<>w_nombre or tipoDonacion.tipoUnidad<>w_tipoUnidad) THEN
        salida:=false;
    END IF;
    COMMIT WORK;
        
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
        
        EXCEPTION 
        WHEN OTHERS THEN 
            DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
END insertar;
    
PROCEDURE actualizar (nombre_prueba VARCHAR2, w_OID_TDon INTEGER, w_nombre VARCHAR2, w_tipoUnidad VARCHAR2, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    tipoDonacion TIPODONACIONES%ROWTYPE;
BEGIN  
    UPDATE TIPODONACIONES SET nombre=w_nombre, tipoUnidad=w_tipoUnidad WHERE OID_TDon=w_OID_TDon;
    SELECT * INTO tipoDonacion FROM TIPODONACIONES WHERE OID_TDon=w_OID_TDon;
    IF (tipoDonacion.nombre<>w_nombre or tipoDonacion.tipoUnidad<>w_tipoUnidad) THEN
        salida:=false;
    END IF;
    COMMIT WORK;
    
    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN 
       DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada)); 
       ROLLBACK; 
END actualizar;
    
PROCEDURE eliminar(nombre_prueba VARCHAR2, w_OID_TDon INTEGER, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    n_tipoDonaciones INTEGER;
BEGIN
    DELETE FROM TIPODONACIONES WHERE OID_TDon=w_OID_TDon;
    SELECT COUNT (*) INTO n_tipoDonaciones FROM TIPODONACIONES WHERE OID_TDon=w_OID_TDon;
    IF(n_tipoDonaciones<>0) THEN 
        salida:=false;
    END IF;
    COMMIT WORK;
    
    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false,salidaEsperada));
        ROLLBACK;
END eliminar;
    
END PRUEBAS_TIPODONACIONES;
/
--PRUEBAS_DONACIONES
create or replace
PACKAGE BODY PRUEBAS_DONACIONES AS
    PROCEDURE inicializar AS
    BEGIN 
        DELETE FROM DONACIONES;
    END inicializar;

    PROCEDURE insertar(nombre_prueba VARCHAR2, w_cif CHAR, w_dni CHAR, w_OID_TDon INTEGER, w_cantidad NUMBER, w_valorUnitario NUMBER,
        w_fecha DATE, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    donacion DONACIONES%ROWTYPE;
    w_OID_Don INTEGER;
    BEGIN 
        INSERT INTO DONACIONES(cif, dni, OID_TDon, cantidad, valorUnitario, fecha) VALUES(w_cif, w_dni, w_OID_TDon, w_cantidad, w_valorUnitario, w_fecha);
        w_OID_Don:= SEC_Don.CURRVAL;
        SELECT * INTO donacion FROM DONACIONES WHERE OID_Don=w_OID_Don;
        IF (donacion.cif<>w_cif AND donacion.dni<>w_dni AND donacion.OID_TDon<>w_OID_TDon AND donacion.cantidad<>w_cantidad
            AND donacion.valorUnitario<>w_valorUnitario AND donacion.fecha<>w_fecha) THEN
            salida:=false;
        END IF; 
        COMMIT WORK;
        
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
        
        EXCEPTION 
        WHEN OTHERS THEN 
            DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
    END insertar;
    
    PROCEDURE actualizar(nombre_prueba VARCHAR2,w_OID_Don INTEGER,  w_cif CHAR, w_dni CHAR, w_OID_TDon INTEGER, w_cantidad NUMBER,
        w_valorUnitario NUMBER, w_fecha DATE, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    donacion DONACIONES%ROWTYPE;
    BEGIN
    UPDATE DONACIONES SET cif=w_cif, dni=w_dni, OID_TDon=w_OID_TDon, cantidad=w_cantidad, valorUnitario=w_valorUnitario,
        fecha=w_fecha WHERE OID_Don= w_OID_Don;
    SELECT * INTO donacion FROM DONACIONES WHERE OID_Don= w_OID_Don;
    IF (donacion.cif<>w_cif AND donacion.dni<>w_dni AND donacion.OID_TDon<>w_OID_TDon AND donacion.cantidad<>w_cantidad
        AND donacion.valorUnitario<>w_valorUnitario AND donacion.fecha<>w_fecha) THEN
    salida:=false;
    END IF;
    COMMIT WORK;
    
    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN 
       DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada)); 
       ROLLBACK; 
    END actualizar;
    
    PROCEDURE eliminar(nombre_prueba VARCHAR2, w_OID_Don INTEGER, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    n_donaciones INTEGER;
    BEGIN
    DELETE FROM DONACIONES WHERE  OID_Don= w_OID_Don;
    SELECT COUNT (*) INTO n_donaciones FROM DONACIONES WHERE OID_Don= w_OID_Don;
    IF(n_donaciones<>0) THEN 
        salida:=false;
    END IF;
    COMMIT WORK;
    
    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false,salidaEsperada));
        ROLLBACK;
    END eliminar;
    
END PRUEBAS_DONACIONES;
/
--PRUEBAS_MENSAJES
create or replace 
PACKAGE BODY PRUEBAS_MENSAJES AS
    PROCEDURE inicializar AS
    BEGIN 
        DELETE FROM MENSAJES;
    END inicializar;
 
    PROCEDURE insertar(nombre_prueba VARCHAR2, w_OID_Coord INTEGER, w_tipo VARCHAR2, w_fechaEnvio DATE, w_asunto VARCHAR2,
        w_contenido LONG, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    mensaje MENSAJES%ROWTYPE;
    w_OID_M INTEGER;
    BEGIN 
        INSERT INTO MENSAJES(OID_Coord, tipo, fechaEnvio, asunto, contenido) VALUES(w_OID_Coord, w_tipo, w_fechaEnvio, w_asunto, w_contenido);
        w_OID_M:= SEC_M.CURRVAL;
        SELECT * INTO mensaje FROM MENSAJES WHERE OID_M=w_OID_M;
        IF (mensaje.OID_Coord<>w_OID_Coord AND mensaje.tipo<>w_tipo AND mensaje.fechaEnvio<>w_fechaEnvio AND mensaje.asunto<>w_asunto
            AND mensaje.contenido<>w_contenido) THEN
            salida:=false;
        END IF; 
        COMMIT WORK;
        
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
        
        EXCEPTION 
        WHEN OTHERS THEN 
            DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
    END insertar;
    
    PROCEDURE actualizar(nombre_prueba VARCHAR2, w_OID_M INTEGER, w_OID_Coord INTEGER, w_tipo VARCHAR2, w_fechaEnvio DATE,
        w_asunto VARCHAR2, w_contenido LONG, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    mensaje MENSAJES%ROWTYPE;
    BEGIN
    UPDATE MENSAJES SET OID_M=w_OID_M, OID_Coord=w_OID_Coord, tipo=w_tipo, fechaEnvio=w_fechaEnvio, asunto=w_asunto,
        contenido=w_contenido WHERE OID_M=w_OID_M;
    SELECT * INTO mensaje FROM MENSAJES WHERE OID_M= w_OID_M;
    IF (mensaje.OID_Coord<>w_OID_Coord AND mensaje.tipo<>w_tipo AND mensaje.fechaEnvio<>w_fechaEnvio AND mensaje.asunto<>w_asunto
        AND mensaje.contenido<>w_contenido) THEN
        salida:=false;
    END IF;
    COMMIT WORK;
    
    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN 
       DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada)); 
       ROLLBACK; 
    END actualizar;
    
    PROCEDURE eliminar(nombre_prueba VARCHAR2, w_OID_M INTEGER, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    n_mensajes INTEGER;
    BEGIN
    DELETE FROM MENSAJES WHERE  OID_M= w_OID_M;
    SELECT COUNT (*) INTO n_mensajes FROM MENSAJES WHERE OID_M= w_OID_M;
    IF(n_mensajes<>0) THEN 
        salida:=false;
    END IF;
    COMMIT WORK;
    
    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false,salidaEsperada));
        ROLLBACK;
    END eliminar;
    
END PRUEBAS_MENSAJES;
/
--PRUEBAS_ENVIOS
create or replace 
PACKAGE BODY PRUEBAS_ENVIOS AS
    PROCEDURE inicializar AS
    BEGIN 
        DELETE FROM ENVIOS;
    END inicializar;
 
    PROCEDURE insertar(nombre_prueba VARCHAR2, w_OID_M INTEGER, w_dni CHAR, w_cif CHAR, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    envio ENVIOS%ROWTYPE;
    w_OID_Env INTEGER;
    BEGIN 
        INSERT INTO ENVIOS(OID_M, dni, cif) VALUES(w_OID_M, w_dni, w_cif);
        w_OID_Env:= SEC_ENV.CURRVAL;
        SELECT * INTO envio FROM ENVIOS WHERE OID_Env=w_OID_Env;
        IF (envio.OID_M<>w_OID_M AND envio.dni<>w_dni AND envio.cif<>w_cif) THEN
            salida:=false;
        END IF; 
        COMMIT WORK;
        
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
        
        EXCEPTION 
        WHEN OTHERS THEN 
            DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
    END insertar;
    
    PROCEDURE actualizar(nombre_prueba VARCHAR2, w_OID_Env INTEGER, w_OID_M INTEGER, w_dni CHAR, w_cif CHAR, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    envio ENVIOS%ROWTYPE;
    BEGIN
    UPDATE ENVIOS SET OID_M=w_OID_M, dni=w_dni, cif=w_cif WHERE OID_Env=w_OID_Env;
    SELECT * INTO envio FROM ENVIOS WHERE OID_Env= w_OID_Env;
    IF (envio.OID_M<>w_OID_M AND envio.dni<>w_dni AND envio.cif<>w_cif) THEN
        salida:=false;
    END IF;
    COMMIT WORK;
    
    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN 
       DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada)); 
       ROLLBACK; 
    END actualizar;
    
    PROCEDURE eliminar(nombre_prueba VARCHAR2, w_OID_Env INTEGER, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    n_envios INTEGER;
    BEGIN
    DELETE FROM ENVIOS WHERE  OID_Env= w_OID_Env;
    SELECT COUNT (*) INTO n_envios FROM ENVIOS WHERE OID_Env= w_OID_Env;
    IF(n_envios<>0) THEN 
        salida:=false;
    END IF;
    COMMIT WORK;
    
    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false,salidaEsperada));
        ROLLBACK;
    END eliminar;
    
END PRUEBAS_ENVIOS;
/
--PRUEBAS_PREGUNTAS
create or replace
PACKAGE BODY PRUEBAS_PREGUNTAS AS
    PROCEDURE inicializar AS
    BEGIN
    DELETE FROM PREGUNTAS;
    END inicializar;
    
    PROCEDURE insertar(nombre_prueba VARCHAR2, w_tipo VARCHAR2, w_enunciado VARCHAR, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    pregunta PREGUNTAS%ROWTYPE;
    w_OID_Q INTEGER;
    BEGIN 
    INSERT INTO PREGUNTAS(tipo, enunciado) VALUES(w_tipo, w_enunciado);
    w_OID_Q:=SEC_Q.CURRVAL;
    SELECT * INTO pregunta FROM PREGUNTAS WHERE OID_Q=w_OID_Q;
    IF (pregunta.tipo<>w_tipo AND pregunta.enunciado<>w_enunciado) THEN
        salida:=false;
    END IF;
    COMMIT WORK;
        
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
        
        EXCEPTION 
        WHEN OTHERS THEN 
            DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
    END insertar;
    
    PROCEDURE actualizar(nombre_prueba VARCHAR2,w_OID_Q INTEGER, w_tipo VARCHAR2, w_enunciado VARCHAR, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    pregunta PREGUNTAS%ROWTYPE;
    BEGIN  
    UPDATE PREGUNTAS SET tipo=w_tipo, enunciado=w_enunciado WHERE OID_Q=w_OID_Q;
    SELECT * INTO pregunta FROM PREGUNTAS WHERE OID_Q=w_OID_Q;
    IF (pregunta.tipo<>w_tipo AND pregunta.enunciado<>w_enunciado) THEN
        salida:=false;
    END IF;
    COMMIT WORK;
    
    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN 
       DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada)); 
       ROLLBACK; 
    END actualizar;
    
    PROCEDURE eliminar(nombre_prueba VARCHAR2, w_OID_Q INTEGER, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    n_preguntas INTEGER;
    BEGIN
    DELETE FROM PREGUNTAS WHERE OID_Q=w_OID_Q;
    SELECT COUNT (*) INTO n_preguntas FROM PREGUNTAS WHERE OID_Q=w_OID_Q;
    IF(n_preguntas<>0) THEN 
        salida:=false;
    END IF;
    COMMIT WORK;
    
    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false,salidaEsperada));
        ROLLBACK;
    END eliminar;
    
END PRUEBAS_PREGUNTAS;
/
--PRUEBAS_CUESTIONARIOS
create or replace
PACKAGE BODY PRUEBAS_CUESTIONARIOS AS
    PROCEDURE inicializar AS
    BEGIN 
        DELETE FROM CUESTIONARIOS;
    END inicializar;

    PROCEDURE insertar(nombre_prueba VARCHAR2, w_OID_Act INTEGER,w_fechaCreacion DATE , salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    cuestionario CUESTIONARIOS%ROWTYPE;
    w_OID_Cues INTEGER;
    BEGIN 
        INSERT INTO CUESTIONARIOS(OID_Act, fechaCreacion) VALUES(w_OID_Act, w_fechaCreacion);
        w_OID_Cues:= SEC_CUES.CURRVAL;
        SELECT * INTO cuestionario FROM CUESTIONARIOS WHERE OID_Cues=w_OID_Cues;
        IF (  cuestionario.OID_Act<>w_OID_Act AND cuestionario.fechaCreacion<>w_fechaCreacion) THEN
            salida:=false;
        END IF; 
        COMMIT WORK;
        
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
        
        EXCEPTION 
        WHEN OTHERS THEN 
            DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
    END insertar;
    
    PROCEDURE actualizar(nombre_prueba VARCHAR2, w_OID_Cues INTEGER, w_OID_Act INTEGER, w_fechaCreacion DATE, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    cuestionario CUESTIONARIOS%ROWTYPE;
    BEGIN
    UPDATE CUESTIONARIOS SET OID_Act=w_OID_Act, fechaCreacion= w_fechaCreacion WHERE OID_Cues= w_OID_Cues;
    SELECT * INTO cuestionario FROM CUESTIONARIOS WHERE OID_Cues= w_OID_Cues;
        IF (cuestionario.OID_Act<>w_OID_Act AND cuestionario.fechaCreacion<>w_fechaCreacion) THEN
    salida:=false;
    END IF;
    COMMIT WORK;
    
    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN 
       DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada)); 
       ROLLBACK; 
    END actualizar;
    
    PROCEDURE eliminar(nombre_prueba VARCHAR2, w_OID_Cues INTEGER, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    n_cuestionarios INTEGER;
    BEGIN
    DELETE FROM CUESTIONARIOS WHERE  OID_Cues= w_OID_Cues;
    SELECT COUNT (*) INTO n_cuestionarios FROM CUESTIONARIOS WHERE OID_Cues= w_OID_Cues;
    IF(n_cuestionarios<>0) THEN 
        salida:=false;
    END IF;
    COMMIT WORK;
    
    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false,salidaEsperada));
        ROLLBACK;
    END eliminar;
    
END PRUEBAS_CUESTIONARIOS;
/
--PRUEBAS_FORMULARIOS
create or replace
PACKAGE BODY PRUEBAS_FORMULARIOS AS
    PROCEDURE inicializar AS
    BEGIN 
        DELETE FROM FORMULARIOS;
    END inicializar;

    PROCEDURE insertar(nombre_prueba VARCHAR2, w_OID_Cues INTEGER, w_OID_Q INTEGER, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    formulario FORMULARIOS%ROWTYPE;
    w_OID_Form INTEGER;
    BEGIN 
        INSERT INTO FORMULARIOS(OID_Cues, OID_Q) VALUES(w_OID_Cues, w_OID_Q);
        w_OID_Form:= SEC_FORM.CURRVAL;
        SELECT * INTO formulario FROM FORMULARIOS WHERE OID_Form=w_OID_Form;
        IF (formulario.OID_Cues<>w_OID_Cues AND formulario.OID_Q<>w_OID_Q) THEN
            salida:=false;
        END IF; 
        COMMIT WORK;
        
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
        
        EXCEPTION 
        WHEN OTHERS THEN 
            DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
    END insertar;
    
    PROCEDURE actualizar(nombre_prueba VARCHAR2,w_OID_Form INTEGER, w_OID_Cues INTEGER, w_OID_Q INTEGER, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    formulario FORMULARIOS%ROWTYPE;
    BEGIN
    UPDATE FORMULARIOS SET OID_Cues=w_OID_Cues, OID_Q= w_OID_Q WHERE OID_Form= w_OID_Form;
    SELECT * INTO formulario FROM FORMULARIOS WHERE OID_Form= w_OID_Form;
        IF (formulario.OID_Cues<>w_OID_Cues AND formulario.OID_Q<>w_OID_Q) THEN
    salida:=false;
    END IF;
    COMMIT WORK;
    
    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN 
       DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada)); 
       ROLLBACK; 
    END actualizar;
    
    PROCEDURE eliminar(nombre_prueba VARCHAR2, w_OID_Form INTEGER, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    n_formularios INTEGER;
    BEGIN
    DELETE FROM FORMULARIOS WHERE  OID_Form= w_OID_Form;
    SELECT COUNT (*) INTO n_formularios FROM FORMULARIOS WHERE OID_Form= w_OID_Form;
    IF(n_formularios<>0) THEN 
        salida:=false;
    END IF;
    COMMIT WORK;
    
    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false,salidaEsperada));
        ROLLBACK;
    END eliminar;
    
END PRUEBAS_FORMULARIOS;
/
--PRUEBAS_RESPUESTAS
create or replace
PACKAGE BODY PRUEBAS_RESPUESTAS AS
    PROCEDURE inicializar AS
    BEGIN 
        DELETE FROM RESPUESTAS;
    END inicializar;

    PROCEDURE insertar(nombre_prueba VARCHAR2,w_OID_Form INTEGER, w_OID_Part INTEGER, w_OID_Vol INTEGER, w_contenido VARCHAR2,
        salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    respuesta RESPUESTAS%ROWTYPE;
    w_OID_Ans INTEGER;
    BEGIN 
        INSERT INTO RESPUESTAS(OID_Form, OID_Part, OID_Vol, contenido) VALUES(w_OID_Form, w_OID_Part, w_OID_Vol, w_contenido);
        w_OID_Ans:= SEC_ANS.CURRVAL;
        SELECT * INTO respuesta FROM RESPUESTAS WHERE OID_Ans=w_OID_Ans;
        IF (respuesta.OID_Form<>w_OID_Form AND respuesta.OID_Part<>w_OID_Part AND respuesta.OID_Vol<>w_OID_Vol
            AND respuesta.contenido<>w_contenido) THEN
            salida:=false;
        END IF; 
        COMMIT WORK;
        
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
        
        EXCEPTION 
        WHEN OTHERS THEN 
            DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
    END insertar;
    
    PROCEDURE actualizar(nombre_prueba VARCHAR2,w_OID_Ans INTEGER, w_OID_Form INTEGER, w_OID_Part INTEGER, w_OID_Vol INTEGER,
        w_contenido VARCHAR2, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    respuesta RESPUESTAS%ROWTYPE;
    BEGIN
    UPDATE RESPUESTAS SET OID_Form=w_OID_Form, OID_Part= w_OID_Part, OID_Vol=w_OID_Vol, contenido=w_contenido WHERE OID_Ans= w_OID_Ans;
    SELECT * INTO respuesta FROM RESPUESTAS WHERE OID_Ans= w_OID_Ans;
        IF (respuesta.OID_Form<>w_OID_Form AND respuesta.OID_Part<>w_OID_Part AND respuesta.OID_Vol<>w_OID_Vol
            AND respuesta.contenido<>w_contenido) THEN
    salida:=false;
    END IF;
    COMMIT WORK;
    
    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN 
       DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada)); 
       ROLLBACK; 
    END actualizar;
    
    PROCEDURE eliminar(nombre_prueba VARCHAR2, w_OID_Ans INTEGER, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    n_respuestas INTEGER;
    BEGIN
    DELETE FROM RESPUESTAS WHERE  OID_Ans= w_OID_Ans;
    SELECT COUNT (*) INTO n_respuestas FROM RESPUESTAS WHERE OID_Ans= w_OID_Ans;
    IF(n_respuestas<>0) THEN 
        salida:=false;
    END IF;
    COMMIT WORK;
    
    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false,salidaEsperada));
        ROLLBACK;
    END eliminar;
    
END PRUEBAS_RESPUESTAS;
/

-------------------------------------------------------------------------------
-- PRUEBAS de PAQUETES
-------------------------------------------------------------------------------

--PRUEBAS_PERSONAS
BEGIN
pruebas_personas.inicializar; 
pruebas_personas.insertar('Prueba 1- insertar persona correctamente','47339192V', 'Mario', 'Ruano Fernández', '01/11/1989', 'C/ San Antonio, 17', 'Fuentes de Andalucía', 'Sevilla', '41420', 'mrf1989@hotmail.com', '615337550', true);
pruebas_personas.insertar('Prueba 2- insertar persona correctamente','13227182M', 'Ignacio', 'Vázquez Rial', '11/12/1991', 'Paseo de los Marineros, 23','Lepe', 'Huelva', '40004', 'ignatius1991@gmail.com', '621499732', true);
pruebas_personas.insertar('Prueba 3- insertar persona correctamente','98385816W', 'Cristina', 'Caro Caro', '15/08/1991', 'C/ Vallehermoso, 62, 1ºA','Madrid', 'Madrid', '28023', 'ccaroc@deporteydesafio.com', '629123456' ,true);
pruebas_personas.insertar('Prueba 4- insertar persona correctamente','95487762B', 'Ana','Cuevas Hernández', '04/04/1988', 'C/ Mayor, 12','Segovia', 'Segovia', '20456', 'anacuhe@gmail.com', '644181345',true);
pruebas_personas.insertar('Prueba 5- insertar persona correctamente','55612222B', 'Estafanía', 'Gómez Gómez', '19/10/1990', 'C/ Periodistas, 44, 1ºB','Madrid', 'Madrid', '28006', 'estefa_gg@gmail.com', '695777100',true);
pruebas_personas.insertar('Prueba 6- insertar persona correctamente','38656621L', 'Antonio Luis', 'Orellana Smith', '01/09/1980', 'C/ Molineros, 7, 3ºB','Madrid', 'Madrid', '28017', null, '643998765',true);
pruebas_personas.insertar('Prueba 7- insertar persona correctamente','57153559V', 'Mateo', 'Ruiz López', '06/02/1978', 'C/ Miguel Hernández, 27, 2ºB','Madrid', 'Madrid', '28017', 'mateo_ruiz_lopez@gmail.com', '614888909',true);
pruebas_personas.insertar('Prueba 8- insertar persona correctamente','76184359Q', 'Ramón', 'Román Romo', '25/11/1981', 'C/ Bandoleros de la Sierra, 10, 2ºB','Cercedilla', 'Madrid', '27004', 'ramonromo@gmail.com', '678411522',true);
pruebas_personas.insertar('Prueba 9- insertar persona correctamente','46687881E', 'María Dolores', 'Pilatos Suárez de la Hoz', '15/03/1991', 'C/ Aluminio, 23, 1ºA','Madrid', 'Madrid', '28021', 'maripi_suhoz@gmail.com', '617829955',true);
pruebas_personas.insertar('Prueba 10- insertar persona correctamente','12345678A', 'María', 'Núñez Ortiz', '12/10/1990', 'Avd. Kansas City, 12, 4ºC','Sevilla', 'Sevilla', '41007', 'm_nuor@gmail.com', '645234184',true);
pruebas_personas.insertar('Prueba 11- insertar persona correctamente','57231289R', 'Marcos', 'Gómez Arce', '15/05/1993', 'C/ Tregua, 21, 5ºB','Alcorcón', 'Madrid', '23102', 'magoarce@gmail.com', '698543761',true);
pruebas_personas.insertar('Prueba 12- insertar persona correctamente','23987795C', 'Pablo', 'Cabello Marín', '11/11/1982', 'C/ Narciso, 46, 8ºA','Madrid', 'Madrid', '28015', 'cabello_marin@gmail.com', '658679123',true);
pruebas_personas.insertar('Prueba 13- insertar persona correctamente','66641234M', 'Ángela María', 'Castilla de la Huerta Domínguez', '21/02/1990', 'C/ Anís, 12','Collado Villalba', 'Madrid', '28510', 'angie_castilladom@gmail.com', '610223734',true);
pruebas_personas.insertar('Prueba 14- insertar persona correctamente','89125642G', 'Sara', 'Orellana Luna', '10/06/2009', 'C/ Molineros, 7, 3ºB','Madrid', 'Madrid', '28017', null, '643998765',true);
pruebas_personas.insertar('Prueba 15- insertar persona con dni menor a 9 caracteres', '89321345', 'Pedro', 'López Durán', '23/03/1986', 'C/ Laurel, 23, 1ºB', 'Sevilla', 'Sevilla', '41005', 'pedro86_lodu@hotmail.com', '611765473', false);
pruebas_personas.insertar('Prueba 16- insertar persona con dni null', NULL, 'Pedro', 'López Durán', '23/03/1986', 'C/ Laurel, 23, 1ºB', 'Sevilla', 'Sevilla', '41005', 'pedro86_lodu@hotmail.com', '611765473', false);
pruebas_personas.insertar('Prueba 17- insertar persona con nombre null','43761927D', NULL, 'Ramirez Doblado', '08/01/1998', 'C/ Militante, 12', 'Alcorcón', 'Madrid', '23104', 'glorado1998@gmail.com', '642132534', false);
pruebas_personas.insertar('Prueba 18- insertar persona con fecha de nacimiento null','43761927D', 'Gloria', 'Ramirez Doblado', NULL, 'C/ Militante, 12', 'Alcorcón', 'Madrid', '23104', 'glorado1998@gmail.com', '642132534', false);
pruebas_personas.insertar('Prueba 19- insertar persona con teléfono null','43761927D', 'Gloria', 'Ramirez Doblado', '08/01/1998', 'C/ Militante, 12', 'Alcorcón', 'Madrid', '23104', 'glorado1998@gmail.com', NULL, false);
pruebas_personas.actualizar('Prueba 20- actualizar persona no insertada', '12345678S', 'Manuel', 'Núñez Ortiz', '12/10/1990', 'Avd. Kansas City, 12, 4ºC', 'Sevilla', 'Sevilla', '41007', 'm_nuor@gmail.com', '645234184', false);
pruebas_personas.actualizar('Prueba 21- actualizar persona','13227182M', 'Ignacio', 'Vázquez Rial', '11/12/1991', 'Paseo de los Marineros, 25','Ayamonte', 'Huelva', '21400', 'ignatius1991@gmail.com', '621499732', true);
pruebas_personas.eliminar('Prueba 22- eliminar persona', '47339192V', true);
END;
/
--PRUEBAS_COORDINADORES 
DECLARE
OID_Coord INTEGER;
OID_Coord2 INTEGER;
BEGIN
pruebas_coordinadores.inicializar;
pruebas_coordinadores.insertar('Prueba 23- insertar coordinador correctamente', '98385816W', true);
OID_Coord:=SEC_COORD.CURRVAL;
pruebas_coordinadores.insertar('Prueba 24- insertar un coordinador correctamente','13227182M',true);
OID_Coord2:=SEC_COORD.CURRVAL;
pruebas_coordinadores.insertar('Prueba 25- insertar un coordinador correctamente','55612222B',true);
pruebas_coordinadores.insertar('Prueba 26- insertar coordinador con dni menor a 9 caracteres', '23559156', false);
pruebas_coordinadores.insertar('Prueba 27- insertar coordinador que no existe como persona', '10226644R', false);
pruebas_coordinadores.insertar('Prueba 28- insertar coordinador con dni null', NULL, false);
pruebas_coordinadores.actualizar('Prueba 29- actualizar coordinador con OID_Coord null', NULL , '23559156L' , false);
pruebas_coordinadores.actualizar('Prueba 30- actualizar coordinador', OID_Coord2 , '95487762B' , true);
pruebas_coordinadores.eliminar('Prueba 31- eliminar coordinador', OID_Coord ,true);
END;
/
--PRUEBAS_TUTORESLEGALES
DECLARE
OID_Tut INTEGER;
OID_Tut2 INTEGER;
BEGIN
pruebas_tutoreslegales.inicializar;
pruebas_tutoreslegales.insertar('Prueba 32- insertar tutor legal correctamente', '38656621L',true);
OID_Tut:=SEC_TUT.CURRVAL;
pruebas_tutoreslegales.insertar('Prueba 33- insertar tutor legal correctamente', '13227182M',true);
OID_Tut2:=SEC_TUT.CURRVAL;
pruebas_tutoreslegales.insertar('Prueba 34- insertar tutor legal correctamente', '76184359Q',true);
pruebas_tutoreslegales.insertar('Prueba 35- insertar tutor legal con dni menor a 9 caracteres', '38656621B',false);
pruebas_tutoreslegales.insertar('Prueba 36- insertar tutor legal con dni null', NULL, false);
pruebas_tutoreslegales.insertar('Prueba 37- insertar tutor legal con dos letras en su dni', '89321A45B',false);
pruebas_tutoreslegales.actualizar('Prueba 38- actualizar tutor legal con OID_Tut null', NULL,'38656621L',false);
pruebas_tutoreslegales.actualizar('Prueba 39- actualizar tutor legal', OID_Tut2,'57153559V',true);
pruebas_tutoreslegales.eliminar('Prueba 40- eliminar tutor legal', OID_Tut, true);
END;
/
--PRUEBAS_VOLUNTARIOS 
DECLARE 
OID_Vol INTEGER;
OID_Vol2 INTEGER;
BEGIN
pruebas_voluntarios.inicializar;
pruebas_voluntarios.insertar('Prueba 41- insertar voluntario correctamente','46687881E', 'baja',true);
OID_Vol:=SEC_VOL.CURRVAL;
pruebas_voluntarios.insertar('Prueba 42- insertar voluntario correctamente','12345678A', 'media',true);
OID_Vol2:=SEC_VOL.CURRVAL;
pruebas_voluntarios.insertar('Prueba 43- insertar voluntario correctamente','57231289R', 'media',true);
pruebas_voluntarios.insertar('Prueba 44- insertar voluntario con dni null', NULL, 'baja',false);
pruebas_voluntarios.insertar('Prueba 45- insertar voluntario con dni con dni menor a 9 caracteres','57231289', 'media', false);
pruebas_voluntarios.insertar('Prueba 46- insertar voluntario con dos letras en su dni','123B5678A','media',false);
pruebas_voluntarios.actualizar('Prueba 47- actualizar voluntario correctamente',oid_vol,'46687881E', 'alta',true);
pruebas_voluntarios.actualizar('Prueba 48- actualizar voluntario con dni incorrecto',oid_vol, NULL,'alta',false);
pruebas_voluntarios.eliminar('Prueba 49- eliminar voluntario',oid_vol2,true);
END;
/
--PRUEBAS_PARTICIPANTES
DECLARE 
OID_Part INTEGER;
OID_Part2 INTEGER;
OID_Part3 INTEGER;
BEGIN
pruebas_participantes.inicializar;
pruebas_participantes.insertar('Prueba 50- insertar participante correctamente','23987795C', '0,4', 'alta', 2, 1,true);
OID_Part:=SEC_PART.CURRVAL;
pruebas_participantes.insertar('Prueba 51- insertar participante correctamente','66641234M', '0,6', 'media', 3, 3,true);
OID_Part2:=SEC_PART.CURRVAL;
pruebas_participantes.insertar('Prueba 52- insertar participante correctamente','89125642G', '0,6', 'alta', 3, NULL,true);
OID_Part3:=SEC_PART.CURRVAL;
pruebas_participantes.insertar('Prueba 53- insertar participante con dni null',NULL, '0,6', 'media', 3, 1, false);
pruebas_participantes.insertar('Prueba 54- insertar participante con grado de discapacidad null','89125642G', NULL, 'baja', 3, 1 ,false );
pruebas_participantes.insertar('Prueba 55- insertar participante con oid_Tut null','66641234M', '0,6', 'media',NULL , 3, false);
pruebas_participantes.actualizar('Prueba 56- actualizar participante',OID_Part2,'66641234M', '0,6', 'alta', 3, 3,true);
pruebas_participantes.actualizar('Prueba 57- actualizar participante con dni null', OID_Part3, NULL, '0,6', 'alta', 3, 1, false);
pruebas_participantes.eliminar('Prueba 58- eliminar participante', OID_Part,true);
END;
/
--PRUEBAS_INFORMESMEDICOS
DECLARE
OID_Inf INTEGER;
OID_Inf2 INTEGER;
BEGIN
pruebas_informesmedicos.inicializar;
pruebas_informesmedicos.insertar('Prueba 1- insertar informemedico correctamente', 2, 'Se trata de un paciente femenino que presenta claros sintomas...', '04/06/2017', true);
OID_Inf:=SEC_INF.CURRVAL;
pruebas_informesmedicos.insertar('Prueba 1- insertar informemedico correctamente', 3, 'Se trata de un paciente femenino que presenta claros sintomas...', '05/08/2018', true);
OID_Inf2:=SEC_INF.CURRVAL;
pruebas_informesmedicos.insertar('Prueba 1- insertar informemedico correctamente', 2,'La mejora notable de las sesiones de fisioterapia...', '23/06/2018', true);
pruebas_informesmedicos.insertar('Prueba 2- insertar informemedico con OID_Part null', NULL, 'Se trata de un paciente femenino que presenta claros sintomas...', '05/06/2018', false);
pruebas_informesmedicos.insertar('Prueba 3- insertar informemedico con descripcion null', 2,NULL, '24/01/2016',false);
pruebas_informesmedicos.insertar('Prueba 4- insertar informemedico con fecha null', 2, 'Se trata de un paciente femenino que presenta claros sintomas...', NULL, false);
pruebas_informesmedicos.actualizar('Prueba 1- actualizar informemedico',oid_Inf2, 3,'A día 01/06/2018, nos encontramos ante...', '04/06/2018', true);
pruebas_informesmedicos.actualizar('Prueba 1- actualizar informemedico con descripción null',oid_Inf2, 3,NULL, '04/06/2018', false);
pruebas_informesmedicos.eliminar('Prueba 1- eliminar informemedico',oid_Inf, true);
END;
/
--PRUEBAS_PROYECTOS
DECLARE
OID_Proj INTEGER;
OID_Proj2 INTEGER;
BEGIN
pruebas_proyectos.inicializar;
pruebas_proyectos.insertar('Prueba 1- inserción proyecto correctamente', 'Curso de Padel','Urban Padel Madrid', 1, 0, true);
OID_Proj:=SEC_PROJ.CURRVAL;
pruebas_proyectos.insertar('Prueba 2- inserción proyecto correctamente', 'Ruta Senderista Cascadas del Purgatorio', 'Valle Alto del Lozoya, Madrid', 0, 1,true);
OID_Proj2:=SEC_PROJ.CURRVAL;
pruebas_proyectos.insertar('Prueba 3- inserción proyecto correctamente', 'Esquí sobre hielo','Pabellón de Hielo de Leganés',0,1, true);
pruebas_proyectos.insertar('Prueba 4- inserción proyecto correctamente', 'Curso de Natación avanzado','Centro Deportivo Municipal Francos Rodrigez',0,1, true);
pruebas_proyectos.insertar('Prueba 5- inserción proyecto nombre null', NULL,'Pabellón de Hielo de Leganés',0,1,false);
pruebas_proyectos.insertar('Prueba 6- inserción proyecto con ubicación null', 'Torneo de Fútbol', NULL, 1, 0, false);
pruebas_proyectos.insertar('Prueba 7- inserción proyecto con esEvento null','Ruta Senderista Monte Abantos','San Lorenzo del Escorial, Madrid',NULL, 0, false);
pruebas_proyectos.insertar('Prueba 8- inserción proyecto con esProgDep null','Curso de Padel','Urban Padel Madrid',1, NULL, false);
pruebas_proyectos.actualizar('Prueba 1- actualizar proyecto correctamente', OID_Proj,'Curso de Padel','Padel Space Madrid',1,0,true);
pruebas_proyectos.actualizar('Prueba 2- actualizar proyecto con nombre null',OID_Proj2,NULL,'Valle Alto del Lozoya, Madrid',1,0, false );
pruebas_proyectos.eliminar('Prueba 1- elimiar proyecto',OID_Proj, true);
END;
/
--PRUEBAS_ENCARGADOS
DECLARE
OID_RP INTEGER;
OID_RP2 INTEGER;
BEGIN
pruebas_encargados.inicializar;
pruebas_encargados.insertar('Prueba 1- insertar encargado', 2, 2, true);
OID_RP:=SEC_RP.CURRVAL;
pruebas_encargados.insertar('Prueba 2-insertar encargado', 2, 2,true);
OID_RP2:=SEC_RP.CURRVAL;
pruebas_encargados.insertar('Prueba 3- inertar encargado', 4, 3, true);
pruebas_encargados.insertar('Prueba 4- insertar encargado con OID_Proj null',NULL, 2, false);
pruebas_encargados.insertar('Prueba 5- insertar encargado con OID_Coord null', 2, NULL, false);
pruebas_encargados.actualizar('Prueba 1- actualizar encargado con OID_RP null', NULL, 2, 2,false);
pruebas_encargados.actualizar('Prueba 2- actualizar encargado', OID_RP2, 3,2,true);
pruebas_encargados.eliminar('Prueba 1- eliminar encargado', OID_RP, true);
END;
/    
--PRUEBAS_ACTIVIDADES
DECLARE
OID_Act INTEGER;
OID_Act2 INTEGER;
BEGIN
pruebas_actividades.insertar('Prueba 1- insertar actividad', 3, 'Esquí sobre hielo', 'felicidad, diversión y compañía', '22/12/2018', '22/12/2018', '70', '70', 'deportiva', '700', '5', true);
OID_Act:=SEC_ACT.CURRVAL;
pruebas_actividades.insertar('Prueba 2- insertar actividad', 2, 'Ruta Senderista Cascadas del Purgatorio','Conocer historia y nuevos paisajes', '08/01/2017', '08/01/2017', '20', '15', 'deportiva', '360', '8', true);
OID_Act2:=Sec_ACT.CURRVAL;
pruebas_actividades.insertar('Prueba 3- insertar actividad', 4,'Curso de Natación avanzado','Mejora en las hablilidades físicas','01/02/2019','01/06/2019','10', '10', 'deportiva', '500', '0',true);
pruebas_actividades.insertar('Prueba 4- insertar actividad con nombre null', 3, NULL, 'Divertirse, aprender y hacer nuevos amigos','22/12/2018', '22/12/2018', '30', '30', 'deportiva', '200', '4', false );
pruebas_actividades.insertar('Prueba 5- insertar actividad con objetivo null', 3, 'Esquí sobre hielo', NULL, '22/12/2018', '22/12/2018', '70', '70', 'deportiva', '400', '5', false);
pruebas_actividades.insertar('Prueba 6- insertar actividad con fechaInicio null', 3, 'Esquí sobre hielo', 'felicidad, diversión y compañía', NULL, '22/12/2018', '70', '70', 'deportiva', '400', '5', false);
pruebas_actividades.insertar('Prueba 7- insertar actividad con fechaFin null', 3, 'Esquí sobre hielo', 'felicidad, diversión y compañía', '22/12/2018', NULL, '70', '70', 'deportiva', '400', '5', false);
pruebas_actividades.insertar('Prueba 8- insertar actividad con OID_Proj null', NULL, 'Ruta Senderista Cascadas del Purgatorio','Conocer historia y nuevos paisajes', '08/01/2017','08/01/2017', '20', '15', 'deportiva', '160', '8', false);
pruebas_actividades.insertar('Prueba 9- insertar actividad con numeroPlazas null',3, 'Esquí sobre hielo', 'felicidad, diversión y compañía', '22/12/2018', '22/12/2018', NULL, '70', 'deportiva', '400', '5', false);
pruebas_actividades.insertar('Prueba 10- insertar actividad con VoluntariosRequeridos null',3, 'Esquí sobre hielo', 'felicidad, diversión y compañía', '22/12/2018', '22/12/2018', '70', NULL, 'deportiva', '400', '5', false);
pruebas_actividades.insertar('Prueba 11- insertar actividad con tipo null',2, 'Ruta Senderista Cascadas del Purgatorio','Conocer historia y nuevos paisajes', '08/01/2017', '08/01/2017', '20', '15', NULL, '160', '8', false);
pruebas_actividades.insertar('Prueba 12- insertar actividad con costeTotal null',2, 'Ruta Senderista Cascadas del Purgatorio','Conocer historia y nuevos paisajes', '08/01/2017', '08/01/2017', '20', '15', 'deportiva', NULL, '8', false);
pruebas_actividades.insertar('Prueba 13- insertar actividad con costeIscripcion null', 2, 'Ruta Senderista Cascadas del Purgatorio','Conocer historia y nuevos paisajes', '08/01/2017', '08/01/2017', '20', '15', 'deportiva', '160', NULL, false);
pruebas_actividades.actualizar('Prueba 1- actualizar actividad', OID_Act2, 2, 'Ruta Senderista Cascadas del Purgatorio','Conocer historia y nuevos paisajes', '05/05/2017', '05/05/2017', '20', '15', 'deportiva', '360', '8', true);
pruebas_actividades.actualizar('Prueba 2- actualizar actividad con OID null', NULL, 3, 'Mercadillo de Navidad', 'Dar y recibir amor, felicidad y compañía', '22/12/2018', '22/12/2018', '70', '70', 'social', '600', '5', false);
pruebas_actividades.eliminar('Prueba 1- eliminar actividad', OID_Act, true);
END;
/
--PRUEBAS_ESTAINTERESADOEN
DECLARE
OID_Int INTEGER;
OID_Int2 INTEGER;
BEGIN
pruebas_estaInteresadoEn.inicializar;
pruebas_estaInteresadoEn.insertar('Prueba 1- insertar el interés de participante', 2, NULL, 2, 1,true);
OID_Int:=SEC_INT.CURRVAL;
pruebas_estaInteresadoEn.insertar('Prueba 2- insertar el interés de voluntario',NULL, 1, 2, 1,true);
OID_Int2:=SEC_INT.CURRVAL;
pruebas_estaInteresadoEn.insertar('Prueba 3- insertar el interés de participante', 3, NULL, 3, 1, true );
pruebas_estaInteresadoEn.insertar('Prueba 3- insertar el interés con OID_Act null', 2,NULL, NULL, 1, false);
pruebas_estaInteresadoEn.insertar('Prueba 4- insertar el interés con estado null',NULL, 1, 2, NULL,false);
pruebas_estaInteresadoEn.actualizar('Prueba 1- actualizar el interés',OID_Int, 2,NULL, 2, 0,true);
pruebas_estaInteresadoEn.actualizar('Prueba 2- actualizar el interés con OID null', NULL, 2,NULL, 2, 0,false);
pruebas_estaInteresadoEn.eliminar('Prueba 1- eliminar interés', OID_Int2, true); 
END;
/
--PRUEBAS_COLABORACIONES
DECLARE
OID_Colab INTEGER;
OID_Colab2 INTEGER;
BEGIN
pruebas_colaboraciones.inicializar;
pruebas_colaboraciones.insertar('Prueba 1- insertar colaboración de voluntario', 1, 2, true);
OID_Colab:=SEC_COLAB.CURRVAL;
pruebas_colaboraciones.insertar('Prueba 2- insertar colaboración de voluntario', 1, 2, true);
OID_Colab2:=SEC_COLAB.CURRVAL;
pruebas_colaboraciones.insertar('Prueba 3- insertar colaboración de voluntario', 1, 3, true);
pruebas_colaboraciones.insertar('Prueba 4- insertar colaboración de voluntario con OID_Vol null', NULL, 4, false);
pruebas_colaboraciones.insertar('Prueba 5- insertar colaboración de voluntario con OID_Act null', 1, NULL, false);
pruebas_colaboraciones.actualizar('Prueba 1- actualizar colaboración de voluntario con OID_Colab null', NULL, 3, 2, false );
pruebas_colaboraciones.actualizar('Prueba 2- actualizar colaboración de voluntario', OID_Colab2, 3, 2, true );
pruebas_colaboraciones.eliminar('Prueba 1- eliminar colaboración de voluntario', OID_Colab, true);
END;
/
--PRUEBAS_RECIBOS
DECLARE 
OID_Rec INTEGER;
OID_Rec2 INTEGER;
BEGIN
pruebas_recibos.inicializar;
pruebas_recibos.insertar('Prueba 1- insertar recibo de una actividad', 2, 2,'01/02/2017','20/04/2017', 5, 'anulado', true);
OID_Rec:=SEC_REC.CURRVAL;
pruebas_recibos.insertar('Prueba 2- insertar recibo de una actividad', 2, 3,'01/02/2017','20/04/2017', '8', 'pagado', true);
OID_Rec2:=SEC_REC.CURRVAL;
pruebas_recibos.insertar('Prueba 3- insertar recibo de una actividad', 3, 2, '01/01/2019', '31/01/2019', '0','pagado', true);
pruebas_recibos.insertar('Prueba 4- insertar recibo de una actividad', 3, 3, '01/01/2019', '31/01/2019', '0','pagado', true);
pruebas_recibos.insertar('Prueba 5- insertar recibo de una actividad con fechaEmision null',2, 2, NULL,'20/04/2017', '8', 'pagado',false);
pruebas_recibos.insertar('Prueba 6- insertar recibo de una actividad con fechaVencimiento null', 2, 2,'01/02/2017',NULL, '8', 'pagado',false);
pruebas_recibos.insertar('Prueba 7- insertar recibo de una actividad con importe null', 2, 2,'01/02/2017','01/02/2017', NULL, 'pagado',false);
pruebas_recibos.insertar('Prueba 8- insertar recibo de una actividad con estado null', 2, 2,'01/02/2017','01/02/2017', '8', NULL,false);
pruebas_recibos.actualizar('Prueba 1- actualizar recibo de una actividad',OID_Rec,2, 3,'01/02/2017','20/04/2017', '8', 'anulado', true);
pruebas_recibos.actualizar('Prueba 2- actualizar recibo de una actividad con OID null',NULL, 2, 2,'01/02/2017','20/04/2017', '8', 'pagado', false);
pruebas_recibos.eliminar('Prueba 1- eliminar recibo de una actividad', OID_Rec, true);
END;
/
--PRUEBAS_INSCRIPCIONES
DECLARE
OID_Ins INTEGER;
OID_Ins2 INTEGER;
BEGIN
pruebas_inscripciones.inicializar;
pruebas_inscripciones.insertar('Prueba 1- insertar inscripción de participante', 2, 2, 3, true);
OID_Ins:=SEC_INS.CURRVAL;
pruebas_inscripciones.insertar('Prueba 2- insertar inscripción de participante', 2, 3, 3, true);
OID_Ins2:=SEC_INS.CURRVAL;
pruebas_inscripciones.insertar('Prueba 3- insertar inscripción de participante', 3, 2, 2, true);
pruebas_inscripciones.insertar('Prueba 4- insertar inscripción de participante con OID_Part null', NULL, 2, 2,false);
pruebas_inscripciones.insertar('Prueba 5- insertar inscripción de participante con OID_Act null', 3, NULL, 2,false);
pruebas_inscripciones.actualizar('Prueba 1- actualizar inscripción de participante con OID_Ins null',NULL, 2, 3, 3, false);
pruebas_inscripciones.actualizar('Prueba 2- actualizar inscripción de participante',OID_Ins2, 3, 3, 4,true);
pruebas_inscripciones.eliminar('Prueba 1-eliminar inscripción de participante', OID_Ins, true);
END;
/
--PRUEBAS_INSTITUCIONES
BEGIN
pruebas_instituciones.inicializar;
pruebas_instituciones.insertar('Prueba 1- insertar institución correctamente','A58223209', 'Banco Santander', '678943212', 'C/ Gran Vía, 22','Madrid', 'Madrid', '28001', 'contacto@santander.com', 1, 'oro', true);
pruebas_instituciones.insertar('Prueba 2- insertar institución correctamente','A87674532', 'El Corte Inglés, S.A.', '654123987', 'C/ Preciados, 1', 'Madrid', 'Madrid', '28001', 'contacto@elcorteingles.com', 0, NULL, true);
pruebas_instituciones.insertar('Prueba 3- insertar institución correctamente','A33219876', 'BBVA', '672129086', 'C/ Colón, 2', 'Madrid', 'Madrid', '28001', 'contacto@bbva.com', 1, 'plata', true);
pruebas_instituciones.insertar('Prueba 4- insertar institución correctamente','H45681524', 'Deportiteka S.L.', '651675440', 'C/ Milagros, 74', 'Madrid', 'Madrid', '28005', 'contacto@deportiteka.com', 0, NULL, true);
pruebas_instituciones.insertar('Prueba 5- insertar institución con cif menor a 9 caracteres ', 'H4568152', 'Deportiteka S.L.', '651675440', 'C/ Milagros, 74', 'Madrid', 'Madrid', '28005', 'contacto@deportiteka.com', 1, 'plata', false);
pruebas_instituciones.insertar('Prueba 6- insertar institución con cif null',null, 'Materiales Domínguez S.L.', '639553337', 'C/ Danubio, 12, 4ºB', 'Madrid', 'Madrid', '28002', 'm_dominguez@gmail.com',1,'bronce', false);
pruebas_instituciones.insertar('Prueba 7- insertar institución con nombre null', 'B78998456', NULL, '677213157', 'C/ Vuelos Altos, 14', 'Madrid', 'Madrid', '28004', 'mail@amisa.es' ,0,NULL, false);
pruebas_instituciones.insertar('Prueba 8- insertar institución con telefono null','A33219876', 'BBVA', NULL, 'C/ Colón, 2', 'Madrid', 'Madrid', '28001', 'contacto@bbva.com', 1, 'plata',false);
pruebas_instituciones.insertar('Prueba 9- insertar institución con esPatrocinador null','B78998456', 'Fundación AMISA', '677213157', 'C/ Vuelos Altos, 14', 'Madrid', 'Madrid', '28001', 'mail@amisa.es', NULL, NULL, false);
pruebas_instituciones.actualizar('Prueba 1- actualizar institución con cif menor a 9 caracteres', 'A5822320', 'Banco Santander', '678943212', 'C/ Gran Vía, 22', 'Madrid', 'Madrid', '28001', 'contacto@santander.com', 1, 'oro', false);
pruebas_instituciones.actualizar('Prueba 2- actualizar institución con nueva dirección', 'A87674532', 'El Corte Inglés, S.A.', '654123987', 'C/ Dr. Gómez Ulla, 2', 'Madrid', 'Madrid', '28001', 'contacto@elcorteingles.com' , 1,'oro', true);
pruebas_instituciones.eliminar('Prueba 1- eliminar institución', 'A58223209', true);
END;
/
--PRUEBAS_PATROCIONIOS
DECLARE 
OID_Fin INTEGER;
OID_Fin2 INTEGER;
BEGIN
pruebas_patrocinios.inicializar;
pruebas_patrocinios.insertar('Prueba 1- insertar patrocinio','A87674532','500', 3, true);
OID_Fin:=SEC_FIN.CURRVAL;
pruebas_patrocinios.insertar('Prueba 2- insertar patrocinio', 'A33219876','100', 2, true);
OID_Fin2:=SEC_FIN.Currval;
pruebas_patrocinios.insertar('Prueba 3- insertar patrocinio con cif null', NULL,'200', 2, false);
pruebas_patrocinios.insertar('Prueba 4- insertar patrocinio con OID_Act null', 'A33219876','200',NULL, false);
pruebas_patrocinios.insertar('Prueba 5- insertar patrocinio con cantidad null', 'A33219876',NULL,2, false);
pruebas_patrocinios.actualizar('Prueba 1- actualizar patrocinio', OID_Fin2, 'A33219876', '200', 2,  true);
pruebas_patrocinios.actualizar('Prueba 2- actualizar patrocinio con OID null',NULL, 'A87674532','400', 3,false);
pruebas_patrocinios.eliminar('Prueba 1- eliminar patrocinio', OID_Fin, true);
END;
/
--PRUEBAS_TIPOSDONACIONES
DECLARE
OID_TDon INTEGER;
OID_TDon2 INTEGER;
BEGIN
pruebas_tipodonaciones.inicializar;
pruebas_tipodonaciones.insertar('Prueba 1- insertar tipodonaciones correctamente', 'Equipaciones de Esquí', 'material',true);
OID_TDon:=SEC_TDON.CURRVAL;
pruebas_tipodonaciones.insertar('Prueba 2- insertar tipodonaciones correctamente', 'Sillas de ruedas Baloncesto', 'material', true);
pruebas_tipodonaciones.insertar('Prueba 3- insertar tipodonaciones correctamente', 'Equipaciones de Golf', 'material', true);
OID_TDon2:=SEC_TDON.CURRVAL;
pruebas_tipodonaciones.insertar('Prueba 4- insertar tipodonaciones con numbre null', NULL, 'Euro', false);
pruebas_tipodonaciones.insertar('Prueba 5- insertar tipodonaciones con tipoUnidad null', 'Bicicletas adaptadas', NULL, false);
pruebas_tipodonaciones.actualizar('Prueba 1- actualizar tipodonacion correctamente', OID_TDon2, 'Conjunto de senderismo invernal', 'equipaciones', true );
pruebas_tipodonaciones.actualizar('Prueba 2- actualizar tipodonacion con oid null', NULL, 'Equipaciones de Golf', 'material', false);
pruebas_tipodonaciones.actualizar('Prueba 3- actualizar tipodonacion con nombre null', OID_TDon, NULL, 'material', false);
pruebas_tipodonaciones.actualizar('Prueba 4- actualizar tipodonacion con tipoUnidad null', OID_TDon, 'Equipaje deportivo adaptado', NULL, false);
pruebas_tipodonaciones.eliminar('Prueba 1- eliminar tipodonacion ', OID_TDon, true);
END;
/
--PRUEBAS_DONACIONES
DECLARE 
OID_Don INTEGER;
OID_Don2 INTEGER;
BEGIN
pruebas_donaciones.inicializar;
pruebas_donaciones.insertar('Prueba 1- insertar donación de persona', NULL, '13227182M', 2, '12','1200','10/12/2018', true);
OID_Don:=SEC_DON.CURRVAL;
pruebas_donaciones.insertar('Prueba 2- insertar donación de institución', 'H45681524', NULL, 3, '4', '4500','15/11/2018', true);
OID_Don2:=SEC_DON.CURRVAL;
pruebas_donaciones.insertar('Prueba 3- insertar donación con cantidad null', NULL, '13227182M', 2, NULL,'1200','07/10/2018', false);
pruebas_donaciones.insertar('Prueba 4- insertar donación con valorUnitario null', 'H45681524', NULL, 3, '4', NULL,'02/05/2017', false);
pruebas_donaciones.insertar('Prueba 5- insertar donación con OID_TDon null', 'H45681524', NULL, NULL, '4', '4500','08/04/2017', false);
pruebas_donaciones.actualizar('Prueba 1- actualizar donación de persona', OID_Don,NULL, '13227182M', 2, '10','900','26/05/2017', true);
pruebas_donaciones.actualizar('Prueba 2- actualizar donación con OID null',NULL, NULL, '13227182M', 2, '18','2500','21/12/2018', false);
pruebas_donaciones.eliminar('Prueba 1- eliminar donación', OID_Don2, true);
END;
/
--PRUEBAS_MENSAJES
DECLARE 
OID_M INTEGER;
OID_M2 INTEGER;
BEGIN
pruebas_mensajes.inicializar;
pruebas_mensajes.insertar('Prueba 1- insertar mensaje', 3, 'newsletter', '26/12/2018', '¡Llega el Mercadillo de Navidad!', 'Código HTML de la newsletter', true);
OID_M:=SEC_M.CURRVAL;
pruebas_mensajes.insertar('Prueba 2- insertar mensaje', 2, 'email', '12/05/2018', 'Recordatorio de las Actividades próximas', '¿Te gustaría participar en alguna de estás actividades?...', true);
OID_M2:=SEC_M.CURRVAL;
pruebas_mensajes.insertar('Prueba 4- insertar mensaje', 2, 'informe', '13/01/2017', 'Recuerdos del 2016', 'Comenzamos el año recordando las actividades que se realizaron en 2016...', true);
pruebas_mensajes.insertar('Prueba 5- insertar mensaje con OID_Coord null', NULL, 'informe', '13/01/2017', 'Recuerdos del 2016', 'Comenzamos el año recordando las actividades que se realizaron en 2016...', false);
pruebas_mensajes.insertar('Prueba 6- insertar mensaje con tipo null', 2, NULL, '13/01/2018', 'Recuerdos del 2017', 'Comenzamos el año recordando las actividades que se realizaron en 2017...', false);
pruebas_mensajes.insertar('Prueba 7- insertar mensaje con fechaEnvio null', 3, 'informe', NULL, 'Recuerdos del 2016', 'Comenzamos el año recordando las actividades que se realizaron en 2016...', false);
pruebas_mensajes.insertar('Prueba 8- insertar mensaje con asunto null', 2, 'informe', '13/01/2017', NULL, 'Comenzamos el año recordando las actividades que se realizaron en 2016...', false);
pruebas_mensajes.insertar('Prueba 9- insertar mensaje con contenido null', 3, 'informe', '13/01/2017', 'Recuerdos del 2016', NULL, false);
pruebas_mensajes.actualizar('Prueba 1- actualizar mensaje con OID_M null', NULL, 3, 'newsletter', '26/12/2018', '¡Llega el Mercadillo de Navidad!', 'Código HTML de la newsletter', false);
pruebas_mensajes.actualizar('Prueba 2- actualizar mensaje', OID_M, 3, 'newsletter', '26/12/2017', '¡Llega el Mercadillo de Navidad!', 'Código HTML de la newsletter', true);
pruebas_mensajes.eliminar('Prueba 1- eliminar mensaje', OID_M2, true);
END;
/
--PRUEBAS_ENVIOS
DECLARE 
OID_Env INTEGER;
OID_Env2 INTEGER;
BEGIN
pruebas_envios.inicializar;
pruebas_envios.insertar('Prueba 1- insertar un envío', 1, '66641234M', NULL, true);
OID_Env:=SEC_ENV.CURRVAL;
pruebas_envios.insertar('Prueba 2- insertar un envío', 1, NULL, 'A33219876', true);
OID_Env2:=SEC_ENV.CURRVAL;
pruebas_envios.insertar('Prueba 3- insertar un envío con OID_M null',NULL, NULL, 'A33219876', false);
pruebas_envios.actualizar('Prueba 1- actualizar un envío con OID_Env null', NULL, 3, NULL, 'A33219876', false);
pruebas_envios.actualizar('Prueba 2- actualizar un envío', OID_Env, 3, '66641234M', NULL, true);
pruebas_envios.eliminar('Prueba 1- eliminar un envío', OID_Env2, true);
END;
/
--PRUEBAS_PREGUNTAS
DECLARE 
OID_Q INTEGER;
OID_Q2 INTEGER;
BEGIN
pruebas_preguntas.inicializar;
pruebas_preguntas.insertar('Prueba 1- insertar pregunta', 'numerica', 'Valore el progama deportivo del 1 al 10', true);
OID_Q:=SEC_Q.CURRVAL;
pruebas_preguntas.insertar('Prueba 2- insertar pregunta', 'textual', '¿Qué parte de la actividad le ha gustado más?', true);
OID_Q2:=SEC_Q.CURRVAL;
pruebas_preguntas.insertar('Prueba 2- insertar pregunta', 'textual', 'Si tuviera la posibilidad, ¿Realizaría de nuevo la actividad?', true);
pruebas_preguntas.insertar('Prueba 3- insertar pregunta con tipo null', NULL, '¿Qué has aprendido en el evento?', false );
pruebas_preguntas.insertar('Prueba 4- insertar pregunta con enunciado null', 'opcional', NULL, false);
pruebas_preguntas.actualizar('Prueba 1- actualizar pregunta con OID_Q null',NULL,'textual', '¿Qué parte de la actividad le ha gustado más?', false);
pruebas_preguntas.actualizar('Prueba 2- actualizar pregunta',OID_Q2, 'textual', '¿Qué mejoraría de la actividad?', true);
pruebas_preguntas.eliminar('Prueba 1- eliminar pregunta', OID_Q, true);
END;
/
--PRUEBAS_CUESTIONARIOS
DECLARE 
OID_Cues INTEGER;
OID_Cues2 INTEGER;
BEGIN
pruebas_cuestionarios.inicializar;
pruebas_cuestionarios.insertar('Prueba 1- insertar cuestionarios', 2,'06/05/2017', true);
OID_Cues:=SEC_CUES.CURRVAL;
pruebas_cuestionarios.insertar('Prueba 2- insertar cuestionarios', 3, '02/06/2019', true);
OID_Cues2:=SEC_Cues.CURRVAL;
pruebas_cuestionarios.insertar('Prueba 3- insertar cuestionarios con fecha null', 3, NULL, false);
pruebas_cuestionarios.insertar('Prueba 4- insertar cuestionarios con OID_Act null', NULL, '02/06/2019', false);
pruebas_cuestionarios.actualizar('Prueba 1- actualizar cuestionario con OID_Cues null', 3, NULL,'02/06/2019', false);
pruebas_cuestionarios.actualizar('Prueba 2- actializar cuestionario', OID_Cues2, 3,'05/01/2019', true);
pruebas_cuestionarios.eliminar('Prueba 1- eliminar cuestionario', OID_Cues, true);
END;
/
--PRUEBAS_FORMULARIOS
DECLARE 
OID_Form INTEGER;
OID_Form2 INTEGER;
BEGIN
pruebas_formularios.inicializar;
pruebas_formularios.insertar('Prueba 1- insertar formulario',2 ,2, true);
OID_Form:=SEC_FORM.CURRVAL;
pruebas_formularios.insertar('Prueba 2- insertar formulario',2, 3,true);
OID_Form2:=SEC_FORM.CURRVAL;
pruebas_formularios.insertar('Prueba 3- insertar formulario con OID_Cues null', NULL, 2, false);
pruebas_formularios.insertar('Prueba 4- insertar formulario con OID_Q null', 2, NULL, false);
pruebas_formularios.actualizar('Prueba 1- actualizar formulario con OID_Form null', NULL,2,2, false);
pruebas_formularios.actualizar('Prueba 2- acualizar formulario', OID_Form, 2,3,true);
pruebas_formularios.eliminar('Prueba 1- eliminar formulario', OID_Form2,true);
END;
/
--PRUEBAS_RESPUESTAS
DECLARE 
OID_Ans INTEGER;
OID_Ans2 INTEGER;
BEGIN
pruebas_respuestas.inicializar;
pruebas_respuestas.insertar('Prueba 1- insertar respuesta', 1, 2, NULL, 'Sin ninguna duda volvería a realizarla', true);
OID_Ans:=SEC_ANS.CURRVAL;
pruebas_respuestas.insertar('Prueba 2- insertar respuesta', 1, NULL, 1, 'No me ha gustado, me esperaba mucho más, no volvería a hacerla', true);
OID_Ans2:=SEC_ANS.CURRVAL;
pruebas_respuestas.insertar('Prueba 3- insertar respuesta con OID_Form null', NULL, NULL, 3, 'Me ha parecido muy interesante y me encantaría repetirla con más amigos',false);
pruebas_respuestas.insertar('Prueba 3- insertar respuesta con contenido null', 1, 3, NULL, NULL ,false);
pruebas_respuestas.actualizar('Prueba 1- actualizar respuesta con OID_Ans null',NULL, 1, 2, NULL, 'Sin ninguna duda volvería a realizarla',false);
pruebas_respuestas.actualizar('Prueba 1- actualizar respuesta',OID_Ans2,1, NULL, 3, 'No me ha gustado, me esperaba mucho más, no volvería a hacerla',true);
pruebas_respuestas.eliminar('Prueba 1- eliminar respuesta', OID_Ans, true);
END;
/

-------------------------------------------------------------------------------
-- PRUEBAS de FUNCIONES
-------------------------------------------------------------------------------

-- Calcular coste de inscripción a actividad
BEGIN
DBMS_OUTPUT.PUT_LINE(calcularCosteInscripcion(1650, 45) || ' €');
END;
/

-- Calcular fecha de vencimiento de pago de recibo
BEGIN
DBMS_OUTPUT.PUT_LINE(calcularFechaVencimiento(SYSDATE));
END;
/

-------------------------------------------------------------------------------
-- PRUEBAS de PROCEDIMIENTOS
-------------------------------------------------------------------------------
EXEC Registrar_Persona('87554158T', 'María', 'López López', '08/10/1990', 'C/ Almirante Alcatraz, 45, 5ºC', 'Madrid', 'Madrid', '28023', 'malolopez@gmail', '695487265');
EXEC Registrar_Persona('52109812T', 'Juan', 'Calero Galera', '23/03/1986', 'C/ Colibrí, 12, 1ºA', 'Madrid', 'Madrid', '28023', 'juan_calega@hotmail.com', '615423515');
EXEC Registrar_Persona('12312542V', 'Pedro', 'Hidalgo Pérez', '07/08/2010', 'C/ Torreones, 16, 3ºB', 'Madrid', 'Madrid', '28023', null, '674444897');
EXEC Registrar_Persona('84478354J', 'Amaia', 'Domínguez Cordón', '29/03/1999', 'C/ Batalla de Bailén, 12, 4ºB', 'Madrid', 'Madrid', '28003', 'amaia_docor@hotmail.com', '666555848');
EXEC Registrar_Persona('45873564M', 'María Dolores', 'Cordón Durán', '23/03/1974', 'C/ Batalla de Bailén, 12, 4ºB', 'Madrid', 'Madrid', '28003', 'dolo_cduran@hotmail.com', '631554915');
EXEC Act_Persona('52109812T', 'Juan Antonio', 'Calero Galera', '23/03/1986', 'C/ Colibrí, 12, 1ºA', 'Madrid', 'Madrid', '28023', 'juan_calega@hotmail.com', '615423515');
EXEC Eliminar_Persona('87554158T');
EXEC Registrar_Coordinador('43623893B', 'Mari Carmen', 'Muñoz Jiménez', '15/08/1989', 'C/ Cerros, 62, 1ºA', 'Madrid', 'Madrid', '28023', 'mari-mimenez@deporteydesafio.com', '629123456');
EXEC Registrar_Voluntario('65971564N', 'Pablo', 'Cabello Marín', '11/11/1982', 'C/ Narciso, 46, 8ºA', 'Madrid', 'Madrid', '28015', 'cabello_marin@gmail.com', '658679123');
EXEC Registrar_Voluntario('54786321L', 'Pedro', 'Castaño Moreno', '23/11/1984', 'C/ Lorenzo, 57, 1ºA', 'Madrid', 'Madrid', '28015', 'petercamo@gmail.com', '688132231');
EXEC Registrar_TutorLegal('11123453V', 'Mateo', 'Ruiz López', '06/02/1978', 'C/ Miguel Hernández, 27, 2ºB', 'Madrid', 'Madrid', '28017', 'mateo_ruiz_lopez@gmail.com', '614888909');
EXEC Registrar_Participante('15484468E', 'Alicia', 'Torcal Molar', '17/09/2006', 'C/ Cerezo, 2, 4ºC', 'Madrid', 'Madrid', '28086', null, '623168465', '0,45', '54786321L', '11123453V');
EXEC Registrar_Institucion('A15359575', 'Animaciones Ilusiones Mágicas, S.A.', '677599884', 'C/ Malagueños, 1', 'Madrid', 'Madrid', '28001', 'info@ilusionesmagicas.com');
EXEC Act_Institucion('A87614532', 'Agencia de Seguros Eliseo, S.A.', '654123989', 'C/ Preciados, 45', 'Madrid', 'Madrid', '28001', 'info@seguros-eliseo.com');
EXEC Eliminar_Institucion('A15359575');
EXEC Registrar_Proyecto('43623893B', 'Sierra Nevada Adaptada. Temporada 2019', 'Granada', 0, 1);
EXEC Registrar_Proyecto('43623893B', 'IV Jornadas sobre la Fibrosis Quística', 'Centro Deportivo Pío Baroja, Madrid', 1, 0);
EXEC Add_Actividad('Esquí adaptado', 'Mejorar la condición física de los participantes e introducirles en el deporte adaptado de invierno', '10/01/2019', '16/01/2019', 30, 'deportiva', 2300, 9);
EXEC Add_Actividad('Jornada sobre el reto solidario 2plega2', 'Informar a los interesados sobre la iniciativa solidaria del joven jerezano.', '08/01/2019', '08/012019', 45, 'social', 100, 10);
EXEC Registrar_Patrocinador('A87984532', 'Inditex, S.A.', '654123989', 'C/ Gran Vía, 12', 'Madrid', 'Madrid', '28001', 'info@inditex.com');
EXEC Add_Patrocinio('A87984532', 14, 1800);
EXEC Registrar_Donacion('45873564M', null, 'Materiales lúdicos', 'juegos', 25, '30,90');
EXEC Add_InformeMedico(5, 'Problemas respiratorios derivados de la fibrosis quística. Debe tomar la medicación prescrita rigurosamente.');
EXEC Inscribir_Participante('15484468E', 14);
EXEC Act_EstadoRecibo(9, 'pagado');
EXEC Inscribir_Participante('15484468E', 3);
EXEC Inscribir_Voluntario('65971564N', 2);
EXEC Registrar_Mensaje('newsletter', '26/12/2018','¡Llega el Mercadillo de Navidad!', 'Código HTML de la newsletter', 2);
EXEC Registrar_Envio('84478354J', null, 1);
EXEC Registrar_Envio('65971564N', null, 1);
EXEC Registrar_Envio('11123453V', null, 1);
EXEC Registrar_Envio(null, 'A87984532', 1);
EXEC Act_Recibo(3, '31/12/2018', '10,00', 'pagado');
EXEC Registrar_Pregunta('textual', '¿Qué sugerencias haría para mejorar la actividad de cara a futuras ediciones?');
EXEC Registrar_Pregunta('numerica', 'Valore de 0 a 10 el evento');
EXEC Registrar_Cuestionario(14);
EXEC Registrar_Cuestionario(15);
EXEC Add_Formulario(6, 5);
EXEC Add_Formulario(7, 5);
EXEC Add_Formulario(7, 6);
EXEC Registrar_Respuesta(null, 5, 5, 'Aumentar el número de días de actividades en la nieve.');
EXEC Registrar_Respuesta(7, null, 6, '8');
EXEC Act_Pregunta(2, 3, 'opcional', 'Eliga los tenderetes que más le gustaron');

-------------------------------------------------------------------------------
-- PRUEBAS de CURSORES
-------------------------------------------------------------------------------
EXEC FichaParticipante(2);
EXEC FichaParticipante(5);
EXEC FichaVoluntario(1);
EXEC FichaVoluntario(7);
EXEC FichaPatrocinador('A87674532');
EXEC FichaPatrocinador('A87984532');
EXEC GET_CuestionariosPart(14);
EXEC GET_CuestionariosVol(3);
EXEC ListaDonantes;
EXEC Lista_Email('voluntarios');
EXEC Lista_Email('participantes');
EXEC Lista_VolAct(2);
EXEC Lista_VolAct(3);
EXEC Lista_HistVol(3);
EXEC Lista_HistVol(7);
EXEC Lista_PartAct(2);
EXEC Lista_PartAct(3);
EXEC Lista_HistPart(2);
EXEC Lista_HistPart(3);
EXEC Lista_PatrociniosAct(3);
EXEC Lista_PatrociniosAct(14);
EXEC Lista_DonTemp('01/01/2017','31/12/2019');
EXEC Lista_ActTemp('01/01/2019','01/03/2019');
