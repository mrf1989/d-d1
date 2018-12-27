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

-------------------------------------------------------------------------------
-- PAQUETES (especificaciones)
-------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE PRUEBAS_PERSONAS AS 
    PROCEDURE inicializar;
    PROCEDURE insertar (nombre_prueba VARCHAR2, w_dni CHAR, w_nombre VARCHAR2, w_apellidos VARCHAR2, w_fechaNacimiento VARCHAR2, w_direccion VARCHAR2,
        w_localidad VARCHAR2, w_provincia VARCHAR2, w_codigoPostal CHAR, w_email VARCHAR2, w_telefono CHAR, salidaEsperada BOOLEAN);
    PROCEDURE actualizar (nombre_prueba VARCHAR2, w_dni CHAR, w_nombre VARCHAR2, w_apellidos VARCHAR2, w_fechaNacimiento VARCHAR2,
        w_direccion VARCHAR2, w_localidad VARCHAR2, w_provincia VARCHAR2, w_codigoPostal CHAR, w_email VARCHAR2, w_telefono CHAR, salidaEsperada BOOLEAN);
    PROCEDURE eliminar (nombre_prueba VARCHAR2, w_dni CHAR, salidaEsperada BOOLEAN);
END PRUEBAS_PERSONAS;
/

-------------------------------------------------------------------------------
-- PAQUETES (cuerpos)
-------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY PRUEBAS_PERSONAS AS
    PROCEDURE inicializar AS
    BEGIN
        DELETE FROM PERSONAS;
    END inicializar;

    PROCEDURE insertar (nombre_prueba VARCHAR2, w_dni CHAR, w_nombre VARCHAR2, w_apellidos VARCHAR2, w_fechaNacimiento VARCHAR2, w_direccion VARCHAR2,
        w_localidad VARCHAR2, w_provincia VARCHAR2, w_codigoPostal CHAR, w_email VARCHAR2, w_telefono CHAR, salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    persona PERSONAS%ROWTYPE;
    BEGIN
        INSERT INTO PERSONAS VALUES(w_dni, w_nombre, w_apellidos, w_fechaNacimiento, w_direccion, w_localidad, w_provincia,
            w_codigoPostal, w_email, w_telefono);
        SELECT * INTO persona FROM PERSONAS WHERE dni=w_dni;
        IF (persona.dni<>w_dni) THEN
            salida := false;
        END IF;
        COMMIT WORK;
    
        DBMS_OUTPUT.PUT_LINE(nombre_prueba || ':' || ASSERT_EQUALS(salida,salidaEsperada));
    
        EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(nombre_prueba || ':' || ASSERT_EQUALS(false,salidaEsperada));
        ROLLBACK;
    END insertar;

    PROCEDURE actualizar (nombre_prueba VARCHAR2, w_dni CHAR, w_nombre VARCHAR2, w_apellidos VARCHAR2, w_fechaNacimiento VARCHAR2,
        w_direccion VARCHAR2, w_localidad VARCHAR2, w_provincia VARCHAR2, w_codigoPostal CHAR, w_email VARCHAR2, w_telefono CHAR, salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    persona PERSONAS%ROWTYPE;
    BEGIN
        UPDATE PERSONAS SET nombre=w_nombre, apellidos=w_apellidos, fechaNacimiento=w_fechaNacimiento, direccion=w_direccion, localidad=w_localidad,
            provincia=w_provincia, codigoPostal=w_codigoPostal, email=w_email, telefono=w_telefono WHERE dni=w_dni;
        SELECT * INTO persona FROM PERSONAS WHERE dni=w_dni;
        IF (persona.nombre<>w_nombre AND persona.apellidos<>w_apellidos AND persona.fechaNacimiento<>w_fechaNacimiento AND persona.direccion<>w_direccion
            AND persona.localidad<>w_localidad AND persona.provincia<>w_provincia AND persona.codigoPostal<>w_codigoPostal AND persona.email<>w_email
            AND persona.telefono<>w_telefono) THEN
            salida := false;
        END IF;
        COMMIT WORK;
    
        DBMS_OUTPUT.PUT_LINE(nombre_prueba || ':' || ASSERT_EQUALS(salida,salidaEsperada));
    
        EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(nombre_prueba || ':' || ASSERT_EQUALS(false,salidaEsperada));
        ROLLBACK;
    END actualizar;

    PROCEDURE eliminar (nombre_prueba VARCHAR2, w_dni CHAR, salidaEsperada BOOLEAN) AS
        salida BOOLEAN := true;
        n_personas INTEGER;
    BEGIN
        DELETE FROM PERSONAS WHERE dni=w_dni;
        SELECT COUNT(*) INTO n_personas FROM PERSONAS WHERE dni=w_dni;
        IF (n_personas<>0) THEN
            salida := false;
        END IF;
        COMMIT WORK;
    
        DBMS_OUTPUT.PUT_LINE(nombre_prueba || ':' || ASSERT_EQUALS(salida,salidaEsperada));
    
        EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(nombre_prueba || ':' || ASSERT_EQUALS(false,salidaEsperada));
        ROLLBACK;
    END eliminar;
END PRUEBAS_PERSONAS;
/

-------------------------------------------------------------------------------
-- PRUEBAS de PAQUETES
-------------------------------------------------------------------------------

-- Tabla PERSONAS
BEGIN
    pruebas_personas.inicializar;
    pruebas_personas.insertar('Prueba 1', '47339192V', 'Mario', 'Ruano Fernández', '01/11/1989', 'C/ San Antonio, 17', 'Fuentes de Andalucía', 'Sevilla', '41420', 'mrf1989@hotmail.com', '615337550', true);
    pruebas_personas.insertar('Prueba 2', '12345678A', 'María', 'Núñez Ortiz', '12/10/1990', 'Avd. Kansas City, 12, 4ºC', 'Sevilla', 'Sevilla', '41007', 'm_nuor@gmail.com', '645234184', true);
    pruebas_personas.insertar('Prueba 3', '89321345', 'Pedro', 'López Durán', '23/03/1986', 'C/ Laurel, 23, 1ºB', 'Sevilla', 'Sevilla', '41005', 'pedro86_lodu@hotmail.com', '611765473', false);    
    pruebas_personas.actualizar('Prueba actualizar 1', '12345678A', 'Manuel', 'Núñez Ortiz', '12/10/1990', 'Avd. Kansas City, 12, 4ºC', 'Sevilla', 'Sevilla', '41007', 'm_nuor@gmail.com', '645234184', true);
    pruebas_personas.eliminar('Prueba eliminar 1', '47339192V', true);
    -- ...
END;
/
