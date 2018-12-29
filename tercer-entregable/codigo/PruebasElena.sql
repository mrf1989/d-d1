-----------------------------------
--FUNCIÓN AUXILIAR ASSERT_EQUALS
-----------------------------------
create or replace
FUNCTION ASSERT_EQUALS (salida BOOLEAN, salidaEsperada BOOLEAN) RETURN VARCHAR2 AS
BEGIN 
    IF(salida = salidaEsperada) THEN
        RETURN 'EXITO';
    ELSE 
        RETURN 'FALLO';
    END IF;
END ASSERT_EQUALS;

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
--PRUEBAS_COORDINADORES
create or replace
PACKAGE PRUEBAS_COORDINADORES AS
    PROCEDURE inicializar;
    PROCEDURE insertar 
        (nombre_prueba VARCHAR2, w_dni CHAR, salidaEsperada BOOLEAN);
    PROCEDURE eliminar
        (nombre_prueba VARCHAR2, w_OID_Coord INTEGER, salidaEsperada BOOLEAN);
END PRUEBAS_COORDINADORES;
--PRUEBAS_TUTORESLEGALES
create or replace
PACKAGE PRUEBAS_TUTORESLEGALES AS
    PROCEDURE inicializar;
    PROCEDURE insertar 
        (nombre_prueba VARCHAR2, w_dni CHAR, salidaEsperada BOOLEAN);
    PROCEDURE eliminar
        (nombre_prueba VARCHAR2, w_OID_Tut INTEGER, salidaEsperada BOOLEAN);
END PRUEBAS_TUTORESLEGALES;
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
--PRUEBAS_PARTICIPANTES
--PRUEBAS_INFORMESMEDICOS
--PRUEBAS_ESTAINTERESADOEN
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
--PRUEBAS_PATROCINADORES
--PRUEBAS_EVENTOS
--PRUEBAS_PROGRAMASDEPORTIVOS
--PRUEBAS_ACTIVIDADES
--PRUEBAS_ENCARGADOS
--PRUEBAS_COLABORACIONES
--PRUEBAS_INSCRIPCIONES
--PRUEBAS_PATROCIONIOS
--PRUEBAS_TIPOSDONACIONES
--PRUEBAS_DONACIONES
--PRUEBAS_RECIBOS
--PRUEBAS_MENSAJES
--PRUEBAS_ENVIOS
--PRUEBAS_CUESTIONARIOS
--PRUEBAS_PREGUNTAS
--PRUEBAS_RESPUESTAS
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
        IF (persona.dni<>w_dni or persona.nombre<>w_nombre or persona.apellidos<>w_apellidos or persona.fechaNacimiento<>w_fechaNacimiento or persona.direccion<>w_direccion
            or persona.localidad<>w_localidad or persona.provincia<>w_provincia or persona.codigoPostal<>w_codigoPostal or persona.email<>w_email
            or persona.telefono<>w_telefono) THEN
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
    UPDATE PERSONAS SET nombre=w_nombre, apellidos=w_apellidos, fechaNacimiento=w_fechaNacimiento, direccion=w_direccion, localidad=w_localidad,
    provincia=w_provincia, codigoPostal=w_codigoPostal, email=w_email, telefono=w_telefono WHERE dni=w_dni;
    SELECT * INTO persona FROM PERSONAS WHERE dni= w_dni;
    IF (persona.dni<>w_dni or persona.nombre<>w_nombre or persona.apellidos<>w_apellidos or persona.fechaNacimiento<>w_fechaNacimiento or persona.direccion<>w_direccion
            or persona.localidad<>w_localidad or persona.provincia<>w_provincia or persona.codigoPostal<>w_codigoPostal or persona.email<>w_email
            or persona.telefono<>w_telefono) THEN
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
        INSERT INTO COORDINADORES VALUES(sec_Coord.nextval, w_dni);
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
        INSERT INTO TUTORESLEGALES VALUES(sec_Tut.nextval, w_dni);
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

--PRUEBAS_VOLUNTARIOS
--ME DA ERROR!!!!!! :(
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
        INSERT INTO VOLUNTARIOS VALUES(w_dni, w_prioridadParticipacion);
        SELECT * INTO voluntario FROM VOLUNTARIOS WHERE OID_Vol= w_OID_Vol;
        IF (voluntario.dni<>w_dni and voluntario.prioridadParticipacion<>w_prioridadParticipacion ) THEN
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
--PRUEBAS_PARTICIPANTES
--PRUEBAS_INFORMESMEDICOS
--PRUEBAS_ESTAINTERESADOEN
--PRUEBAS_INSTITUCIONES
create or replace 
PACKAGE BODY PRUEBAS_INSTITUCIONES AS
    PROCEDURE inicializar AS
    BEGIN
        DELETE FROM INSTITUCIONES;
    END inicializar;
    
    PROCEDURE insertar(nombre_prueba VARCHAR2, w_cif CHAR, w_nombre VARCHAR2, w_telefono CHAR, w_direccion VARCHAR2, w_localidad VARCHAR2, w_provincia VARCHAR2,
        w_codigoPostal CHAR, w_email VARCHAR2, w_esPatrocinador SMALLINT, w_tipo VARCHAR2, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    institucion INSTITUCIONES%ROWTYPE;
    BEGIN 
        INSERT INTO INSTITUCIONES VALUES( w_cif, w_nombre, w_telefono, w_direccion, w_localidad, w_provincia, w_codigoPostal, w_email, w_esPatrocinador, w_tipo);
        SELECT * INTO institucion FROM INSTITUCIONES WHERE cif=w_cif;
        IF (institucion.cif<>w_cif or institucion.nombre<>w_nombre or institucion.telefono<>w_telefono or institucion.direccion<>w_direccion or institucion.localidad<>w_localidad 
            or institucion.provincia<>w_provincia or institucion.codigoPostal<>w_codigoPostal or institucion.email<>w_email or institucion.esPatrocinador<>w_esPatrocinador or
            institucion.tipo<>w_tipo) THEN
            salida:=false;
        END IF;
        COMMIT WORK;
        
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
        
        EXCEPTION 
        WHEN OTHERS THEN 
            DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
            ROLLBACK;
    END insertar;
    
    PROCEDURE actualizar(nombre_prueba VARCHAR2, w_cif CHAR, w_nombre VARCHAR2, w_telefono CHAR, w_direccion VARCHAR2, w_localidad VARCHAR2, w_provincia VARCHAR2,
        w_codigoPostal CHAR, w_email VARCHAR2, w_esPatrocinador SMALLINT, w_tipo VARCHAR2, salidaEsperada BOOLEAN) AS
    salida BOOLEAN:=true;
    institucion INSTITUCIONES%ROWTYPE;
    BEGIN  
    UPDATE INSTITUCIONES SET nombre=w_nombre, telefono=w_telefono, direccion=w_direccion, localidad=w_localidad,
    provincia=w_provincia, codigoPostal=w_codigoPostal, email=w_email, esPatrocinador=w_esPatrocinador, tipo=w_tipo WHERE cif=w_cif;
    SELECT * INTO institucion FROM INSTITUCIONES WHERE cif= w_cif;
    IF (institucion.cif<>w_cif or institucion.nombre<>w_nombre or institucion.telefono<>w_telefono or institucion.direccion<>w_direccion or institucion.localidad<>w_localidad 
            or institucion.provincia<>w_provincia or institucion.codigoPostal<>w_codigoPostal or institucion.email<>w_email or institucion.esPatrocinador<>w_esPatrocinador or
            institucion.tipo<>w_tipo) THEN
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
--PRUEBAS_PATROCINADORES
--PRUEBAS_EVENTOS
--PRUEBAS_PROGRAMASDEPORTIVOS
--PRUEBAS_ACTIVIDADES
--PRUEBAS_ENCARGADOS
--PRUEBAS_COLABORACIONES
--PRUEBAS_INSCRIPCIONES
--PRUEBAS_PATROCIONIOS
--PRUEBAS_TIPOSDONACIONES
--PRUEBAS_DONACIONES
--PRUEBAS_RECIBOS
--PRUEBAS_MENSAJES
--PRUEBAS_ENVIOS
--PRUEBAS_CUESTIONARIOS
--PRUEBAS_PREGUNTAS
--PRUEBAS_RESPUESTAS
-----------------------------------
--PRUEBAS
-----------------------------------  
SET SERVEROUTPUT ON;
DECLARE
OID_Coord INTEGER;
OID_Tut INTEGER;
OID_Vol INTEGER;
BEGIN
--PRUEBAS_PERSONAS--SEMI PERFE
pruebas_personas.inicializar;
pruebas_personas.insertar('Prueba 1- inserción persona correctamente','47339192V', 'Mario', 'Ruano Fernández', '01/11/1989', 'C/ San Antonio, 17', 'Fuentes de Andalucía', 'Sevilla', '41420', 'mrf1989@hotmail.com', '615337550', true);
pruebas_personas.insertar('Prueba 2-inserción persona con dni menor a 9 caracteres', '89321345', 'Pedro', 'López Durán', '23/03/1986', 'C/ Laurel, 23, 1ºB', 'Sevilla', 'Sevilla', '41005', 'pedro86_lodu@hotmail.com', '611765473', false);
pruebas_personas.insertar('Prueba 3-inserción persona con dni null', NULL, 'Pedro', 'López Durán', '23/03/1986', 'C/ Laurel, 23, 1ºB', 'Sevilla', 'Sevilla', '41005', 'pedro86_lodu@hotmail.com', '611765473', false);
pruebas_personas.insertar('Prueba 4-inserción persona con nombre null','43761927D', NULL, 'Ramirez Doblado', '08/01/1998', 'C/ Militante, 12', 'Alcorcón', 'Madrid', '23104', 'glorado1998@gmail.com', '642132534', false);
pruebas_personas.insertar('Prueba 5-inserción persona con fecha de nacimiento null','43761927D', 'Gloria', 'Ramirez Doblado', NULL, 'C/ Militante, 12', 'Alcorcón', 'Madrid', '23104', 'glorado1998@gmail.com', '642132534', false);
pruebas_personas.insertar('Prueba 6-inserción persona con teléfono null','43761927D', 'Gloria', 'Ramirez Doblado', '08/01/1998', 'C/ Militante, 12', 'Alcorcón', 'Madrid', '23104', 'glorado1998@gmail.com', NULL, false);
pruebas_personas.actualizar('Prueba 1-actualizar persona con dni menor a 9 caracteres', '12345678', 'Manuel', 'Núñez Ortiz', '12/10/1990', 'Avd. Kansas City, 12, 4ºC', 'Sevilla', 'Sevilla', '41007', 'm_nuor@gmail.com', '645234184', false);
pruebas_personas.actualizar('Prueba 2-actualizar persona', '12345678A', 'Manuel', 'Núñez Ortiz', '12/10/1990', 'Avd. Kansas City, 12, 4ºC', 'Sevilla', 'Sevilla', '41007', 'm_nuor@gmail.com', '645234184', true);
pruebas_personas.eliminar('Prueba 1-eliminar persona', '47339192V', true);
--PRUEBAS_COORDINADORES--ERROREEEEES
pruebas_coordinadores.inicializar;
pruebas_coordinadores.insertar('Prueba 1- inserción coordinador correctamente', '98385816W', true);
pruebas_coordinadores.insertar('Prueba 2-PRUEBA inserción coordinador correctamente', '954877629', true);--Prueba
pruebas_coordinadores.insertar('Prueba 3- inserción coordinador con dni menor a 9 caracteres', '98385816', false);
pruebas_coordinadores.insertar('Prueba 4- inserción coordinador con dni null', NULL, false);
pruebas_coordinadores.eliminar('Prueba 1- eliminar coordinador', oid_coord,true);

--PRUEBAS_TUTORESLEGALES--ERROREES
pruebas_tutoreslegales.inicializar;
pruebas_tutoreslegales.insertar('Prueba 1- inserción tutor legal correctamente', '38656621L',true);
pruebas_tutoreslegales.insertar('Prueba 2- inserción tutor legal con dni menor a 9 caracteres', '38656621',false);
pruebas_tutoreslegales.insertar('Prueba 3- inserción tutor legal con dni null', NULL, false);
pruebas_tutoreslegales.insertar('Prueba 4- inserción tutor legal con dos letras en su dni', '89321A45B',false);
pruebas_tutoreslegales.eliminar('Prueba 1- eliminar tutor legal', oid_tut, true);

--PRUEBAS_VOLUNTARIOS--TOOOOOOOMAL
pruebas_voluntarios.inicializar;
pruebas_voluntarios.insertar('Prueba 1- inseción voluntario correctamente','47339192V', 'alta',true);
pruebas_voluntarios.insertar('Prueba 2- inserción voluntario con dni null', NULL, 'baja',false);
pruebas_voluntarios.insertar('Prueba 3- inserción voluntario con dni con dni menor a 9 caracteres','57231289', 'media', false);
pruebas_voluntarios.insertar('Prueba 4- inserción voluntario con dos letras en su dni','123B5678A','media',false);
pruebas_voluntarios.actualizar('Prueba 1- actualizar voluntario correctamente',oid_vol,'72556794F', 'alta',true);
pruebas_voluntarios.actualizar('Preuba 2- actualizar voluntario con dni incorrecto',oid_vol, NULL,'alta',false);
pruebas_voluntarios.eliminar('Prueba 1- eliminar voluntario',oid_vol,true);
--PRUEBAS_PARTICIPANTES
--PRUEBAS_INFORMESMEDICOS
--PRUEBAS_ESTAINTERESADOEN
--PRUEBAS_INSTITUCIONES--PERFE
pruebas_instituciones.inicializar;
pruebas_instituciones.insertar('Prueba 1- inserción institución correctamente','A87674532', 'El Corte Inglés, S.A.', '654123987', 'C/ Preciados, 1', 'Madrid', 'Madrid', '28001', 'contacto@elcorteingles.com', 0, NULL, true);
pruebas_instituciones.insertar('Prueba 2-inserción institución con cif menor a 9 caracteres ', 'H4568152', 'Deportiteka S.L.', '651675440', 'C/ Milagros, 74', 'Madrid', 'Madrid', '28005', 'contacto@deportiteka.com', 1, 'plata', false);
pruebas_instituciones.insertar('Prueba 3-inserción institución con cif null',null, 'Materiales Domínguez S.L.', '639553337', 'C/ Danubio, 12, 4ºB', 'Madrid', 'Madrid', '28002', 'm_dominguez@gmail.com',1,'bronce', false);
pruebas_instituciones.insertar('Prueba 4-inserción institución con nombre null', 'B78998456', NULL, '677213157', 'C/ Vuelos Altos, 14', 'Madrid', 'Madrid', '28004', 'mail@amisa.es' ,0,NULL, false);
pruebas_instituciones.insertar('Prueba 5-inserción institución con telefono null','A33219876', 'BBVA', NULL, 'C/ Colón, 2', 'Madrid', 'Madrid', '28001', 'contacto@bbva.com', 1, 'plata',false);
pruebas_instituciones.insertar('Prueba 6-inserción institución con esPatrocinador null','B78998456', 'Fundación AMISA', '677213157', 'C/ Vuelos Altos, 14', 'Madrid', 'Madrid', '28001', 'mail@amisa.es', NULL, NULL, false);
pruebas_instituciones.actualizar('Prueba 1-actualizar institución con cif menor a 9 caracteres', 'A5822320', 'Banco Santander', '678943212', 'C/ Gran Vía, 22', 'Madrid', 'Madrid', '28001', 'contacto@santander.com', 1, 'oro', false);
pruebas_instituciones.actualizar('Prueba 2-actualizar institución con nueva dirección', 'A87674532', 'El Corte Inglés, S.A.', '654123987', 'C/ Dr. Gómez Ulla, 2', 'Madrid', 'Madrid', '28001', 'contacto@elcorteingles.com' , 1,'oro', true);
pruebas_instituciones.eliminar('Prueba 1-eliminar institución', 'A87674532', true);
--PRUEBAS_PATROCINADORES
--PRUEBAS_EVENTOS
--PRUEBAS_PROGRAMASDEPORTIVOS
--PRUEBAS_ACTIVIDADES
--PRUEBAS_ENCARGADOS
--PRUEBAS_COLABORACIONES
--PRUEBAS_INSCRIPCIONES
--PRUEBAS_PATROCIONIOS
--PRUEBAS_TIPOSDONACIONES
--PRUEBAS_DONACIONES
--PRUEBAS_RECIBOS
--PRUEBAS_MENSAJES
--PRUEBAS_ENVIOS
--PRUEBAS_CUESTIONARIOS
--PRUEBAS_PREGUNTAS
--PRUEBAS_RESPUESTAS
END;
