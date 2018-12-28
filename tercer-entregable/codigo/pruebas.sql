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

-- Tabla COORDINADORES
CREATE OR REPLACE PACKAGE PRUEBAS_COORDINADORES AS
    PROCEDURE inicializar;
    PROCEDURE insertar (nombre_prueba VARCHAR2, w_dni CHAR, salidaEsperada BOOLEAN);
    PROCEDURE actualizar (nombre_prueba VARCHAR2, w_OID_Coord INTEGER, w_dni CHAR, salidaEsperada BOOLEAN);
    PROCEDURE eliminar (nombre_prueba VARCHAR2, w_OID_Coord INTEGER, salidaEsperada BOOLEAN);
END PRUEBAS_COORDINADORES;
/

-- Tabla PERSONAS
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

-- Tabla COORDINADORES
CREATE OR REPLACE PACKAGE BODY PRUEBAS_COORDINADORES AS
    PROCEDURE inicializar AS
    BEGIN
        DELETE FROM COORDINADORES;
    END inicializar;

    PROCEDURE insertar (nombre_prueba VARCHAR2, w_dni CHAR, salidaEsperada BOOLEAN) AS
    salida BOOLEAN := true;
    coordinador COORDINADORES%ROWTYPE;
    w_OID_Coord INTEGER;
    BEGIN
        INSERT INTO COORDINADORES(dni) VALUES(w_dni);
        w_OID_Coord := SEC_Coord.CURRVAL;
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

    PROCEDURE eliminar (nombre_prueba VARCHAR2, w_OID_Coord INTEGER, salidaEsperada BOOLEAN) AS
        salida BOOLEAN := true;
        n_coordinadores INTEGER;
    BEGIN
        DELETE FROM COORDINADORES WHERE OID_Coord=w_OID_Coord;
        SELECT COUNT(*) INTO n_coordinadores FROM COORDINADORES WHERE OID_Coord=w_OID_Coord;
        IF (n_coordinadores<>0) THEN
            salida := false;
        END IF;
        COMMIT WORK;
    
        DBMS_OUTPUT.PUT_LINE(nombre_prueba || ':' || ASSERT_EQUALS(salida,salidaEsperada));
    
        EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(nombre_prueba || ':' || ASSERT_EQUALS(false,salidaEsperada));
        ROLLBACK;
    END eliminar;
END PRUEBAS_COORDINADORES;
/

-- Tabla PERSONAS
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

-- Tabla COORDINADORES
BEGIN
    pruebas_coordinadores.inicializar;
    pruebas_coordinadores.insertar('Prueba 1', '12345678A', true);
END;
/

-------------------------------------------------------------------------------
-- PRUEBAS de FUNCIONES
-------------------------------------------------------------------------------

-- Calcular coste de inscripción a actividad
BEGIN
DBMS_OUTPUT.PUT_LINE(calcularCosteInscripcion(1500, 45));
END;

-- Calcular fecha de vencimiento de pago de recibo
BEGIN
DBMS_OUTPUT.PUT_LINE(calcularFechaVencimiento(SYSDATE));
END;

-------------------------------------------------------------------------------
-- PRUEBAS de PROCEDIMIENTOS
-------------------------------------------------------------------------------

EXEC Registrar_Persona('12345678A', 'María', 'Núñez Ortiz', '12/10/1990', 'Avd. Kansas City, 12, 4ºC', 'Sevilla', 'Sevilla', '41007', 'm_nuor@gmail.com', '645234184');
EXEC Registrar_Persona('89321345B', 'Pedro', 'López Durán', '23/03/1986', 'C/ Laurel, 23, 1ºB', 'Sevilla', 'Sevilla', '41005', 'pedro86_lodu@hotmail.com', '611765473');
EXEC Act_Persona('12345678A', 'María', 'Núñez Ortiz', '22/10/1990', 'Avd. Kansas City, 12, 4ºC', 'Sevilla', 'Sevilla', '41007', 'maria_nuo@gmail.com', '645234184');
EXEC Eliminar_Persona('89321345B');
EXEC Registrar_Coordinador('98385816W', 'Cristina', 'Caro Caro', '15/08/1991', 'C/ Vallehermoso, 62, 1ºA', 'Madrid', 'Madrid', '28023', 'ccaroc@deporteydesafio.com', '629123456');
EXEC Registrar_Voluntario('23987795C', 'Pablo', 'Cabello Marín', '11/11/1982', 'C/ Narciso, 46, 8ºA', 'Madrid', 'Madrid', '28015', 'cabello_marin@gmail.com', '658679123', 'alta');
EXEC Registrar_TutorLegal('57153559V', 'Mateo', 'Ruiz López', '06/02/1978', 'C/ Miguel Hernández, 27, 2ºB', 'Madrid', 'Madrid', '28017', 'mateo_ruiz_lopez@gmail.com', '614888909');
EXEC Registrar_Participante('64090012E', 'Alicia', 'Torcal Molar', '17/09/2004', 'C/ Cerezo, 2, 4ºC', 'Madrid', 'Madrid', '28086', null, '623168465', '0,45', 'alta', '23987795C', '57153559V');
EXEC Registrar_Institucion('A87674532', 'El Corte Inglés, S.A.', '654123987', 'C/ Preciados, 1', 'Madrid', 'Madrid', '28001', 'contacto@elcorteingles.com');
EXEC Act_Institucion('A87674532', 'El Corte Inglés, S.A.', '654123989', 'C/ Preciados, 1', 'Madrid', 'Madrid', '28001', 'info@elcorteingles.com');
EXEC Eliminar_Institucion('A87674532');
EXEC Registrar_Proyecto('98385816W', 'Mercadillo de Navidad', 'Mercado de Canal, Madrid', 1, 0);
EXEC Registrar_Proyecto('98385816W', 'Baloncesto Adaptado 2018', 'Centro Deportivo Pío Baroja, Madrid', 0, 1);
EXEC Add_Actividad('Mercadillo de Navidad', 'Mejorar la integración social de las personas con discapacidad', '27/12/2018', '27/12/2018', 30, 'social', 0, 1);
EXEC Add_Actividad('Campeonato 3x3 Basket adaptado', 'Ayudar a la mejora de la condición física de los participantes', '28/12/2018', '23/12/2018', 45, 'deportiva', 750, 2);
EXEC Registrar_Patrocinador('A87674532', 'El Corte Inglés, S.A.', '654123989', 'C/ Preciados, 1', 'Madrid', 'Madrid', '28001', 'info@elcorteingles.com', 'oro');
EXEC Add_Patrocinio('A87674532', 2, 500);
EXEC Registrar_Donacion('12345678A', null, 'Equipaciones de esquí', 'equipaciones', 10, '49,90');
EXEC Inscribir_Participante('64090012E', 1);
EXEC Inscribir_Participante('64090012E', 2);
EXEC Inscribir_Voluntario('23987795C', 2);
EXEC Add_InteresVoluntariado('23987795C', 1, 1);
EXEC Add_InteresVoluntariado('23987795C', 2, 1);
EXEC Act_InteresVoluntariado('23987795C', 1, 0);
EXEC Add_InteresParticipante('64090012E', 1, 1);
EXEC Add_InteresParticipante('64090012E', 2, 0);
EXEC Act_InteresParticipante('64090012E', 2, 1);
EXEC Registrar_Mensaje('newsletter', '26/12/2018','¡Llega el Mercadillo de Navidad!', 'Código HTML de la newsletter', 1);
EXEC Registrar_Envio('12345678A', null, 1);
EXEC Registrar_Envio('23987795C', null, 1);
EXEC Registrar_Envio('57153559V', null, 1);
EXEC Registrar_Envio(null, 'A87674532', 1);
EXEC Add_InformeMedico('Descripción del informe médico completa', '14/05/2018', 1);
EXEC Act_Recibo(1, '28/02/2019', '10,00', 'pagado');
EXEC Registrar_Pregunta('textual', '¿Qué sugerencias haría para mejorar la actividad de cara a futuras ediciones?');
EXEC Registrar_Pregunta('numerica', 'Valore de 0 a 10 el evento');
EXEC Registrar_Cuestionario(1);
EXEC Registrar_Cuestionario(2);
EXEC Add_Formulario(1, 1);
EXEC Add_Formulario(2, 1);
EXEC Add_Formulario(2, 2);
EXEC Registrar_Respuesta(1, null, 1, 'Contar con una segunda pista de baloncesto para poder tener a más equipos jugando al mismo tiempo.');
EXEC Registrar_Respuesta(null, 1, 2, '8');
EXEC Act_Pregunta(1, 2, 'opcional', 'Eliga los tenderetes que más le gustaron');