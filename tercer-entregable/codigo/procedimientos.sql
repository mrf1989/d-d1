-------------------------------------------------------------------------------
-- FUNCIONES y PROCEDIMIENTOS
-------------------------------------------------------------------------------

-- Registro de COORDINADORES en el sistema de información
CREATE OR REPLACE PROCEDURE Registrar_Coordinador (w_dni IN PERSONAS.dni%TYPE, w_nombre IN PERSONAS.nombre%TYPE,
    w_apellidos IN PERSONAS.apellidos%TYPE, w_fechaNacimiento IN PERSONAS.fechaNacimiento%TYPE, w_direccion IN
    PERSONAS.direccion%TYPE, w_localidad IN PERSONAS.localidad%TYPE, w_provincia IN PERSONAS.provincia%TYPE,
    w_codigoPostal IN PERSONAS.codigoPostal%TYPE, w_email IN PERSONAS.email%TYPE, w_telefono IN PERSONAS.telefono%TYPE) IS
BEGIN
    INSERT INTO PERSONAS (dni, nombre, apellidos, fechaNacimiento, direccion, localidad, provincia, codigoPostal,
        email, telefono) VALUES (w_dni, w_nombre, w_apellidos, w_fechaNacimiento, w_direccion, w_localidad, 
        w_provincia, w_codigoPostal, w_email, w_telefono);
    INSERT INTO COORDINADORES (dni) VALUES (w_dni);
    COMMIT WORK;
END Registrar_Coordinador;
/

-- Registro de VOLUNTARIOS en el sistema de información
CREATE OR REPLACE PROCEDURE Registrar_Voluntario (w_dni IN PERSONAS.dni%TYPE, w_nombre IN PERSONAS.nombre%TYPE,
    w_apellidos IN PERSONAS.apellidos%TYPE, w_fechaNacimiento IN PERSONAS.fechaNacimiento%TYPE, w_direccion IN
    PERSONAS.direccion%TYPE, w_localidad IN PERSONAS.localidad%TYPE, w_provincia IN PERSONAS.provincia%TYPE,
    w_codigoPostal IN PERSONAS.codigoPostal%TYPE, w_email IN PERSONAS.email%TYPE, w_telefono IN PERSONAS.telefono%TYPE,
    w_prioridadParticipacion IN VOLUNTARIOS.prioridadParticipacion%TYPE) IS
BEGIN
    INSERT INTO PERSONAS (dni, nombre, apellidos, fechaNacimiento, direccion, localidad, provincia, codigoPostal,
        email, telefono) VALUES (w_dni, w_nombre, w_apellidos, w_fechaNacimiento, w_direccion, w_localidad, 
        w_provincia, w_codigoPostal, w_email, w_telefono);
    INSERT INTO VOLUNTARIOS (dni, prioridadParticipacion) VALUES (w_dni, w_prioridadParticipacion);
    COMMIT WORK;
END Registrar_Voluntario;
/

-- Registro de TUTORES LEGALES en el sistema de información
CREATE OR REPLACE PROCEDURE Registrar_TutorLegal (w_dni IN PERSONAS.dni%TYPE, w_nombre IN PERSONAS.nombre%TYPE,
    w_apellidos IN PERSONAS.apellidos%TYPE, w_fechaNacimiento IN PERSONAS.fechaNacimiento%TYPE, w_direccion IN
    PERSONAS.direccion%TYPE, w_localidad IN PERSONAS.localidad%TYPE, w_provincia IN PERSONAS.provincia%TYPE,
    w_codigoPostal IN PERSONAS.codigoPostal%TYPE, w_email IN PERSONAS.email%TYPE, w_telefono IN PERSONAS.telefono%TYPE) IS
BEGIN
    INSERT INTO PERSONAS (dni, nombre, apellidos, fechaNacimiento, direccion, localidad, provincia, codigoPostal,
        email, telefono) VALUES (w_dni, w_nombre, w_apellidos, w_fechaNacimiento, w_direccion, w_localidad, 
        w_provincia, w_codigoPostal, w_email, w_telefono);
    INSERT INTO TUTORESLEGALES (dni) VALUES (w_dni);
    COMMIT WORK;
END Registrar_TutorLegal;
/

-- Registro de PARTICIPANTES en el sistema de información
CREATE OR REPLACE PROCEDURE Registrar_Participante (w_dni IN PERSONAS.dni%TYPE, w_nombre IN PERSONAS.nombre%TYPE,
    w_apellidos IN PERSONAS.apellidos%TYPE, w_fechaNacimiento IN PERSONAS.fechaNacimiento%TYPE, w_direccion IN
    PERSONAS.direccion%TYPE, w_localidad IN PERSONAS.localidad%TYPE, w_provincia IN PERSONAS.provincia%TYPE,
    w_codigoPostal IN PERSONAS.codigoPostal%TYPE, w_email IN PERSONAS.email%TYPE, w_telefono IN PERSONAS.telefono%TYPE,
    w_gradoDiscapacidad IN PARTICIPANTES.gradoDiscapacidad%TYPE, w_prioridadParticipacion IN PARTICIPANTES.prioridadParticipacion%TYPE,
    w_OID_Vol IN PARTICIPANTES.OID_Vol%TYPE, w_OID_Tut IN PARTICIPANTES.OID_Tut%TYPE) IS
BEGIN
    INSERT INTO PERSONAS (dni, nombre, apellidos, fechaNacimiento, direccion, localidad, provincia, codigoPostal,
        email, telefono) VALUES (w_dni, w_nombre, w_apellidos, w_fechaNacimiento, w_direccion, w_localidad, 
        w_provincia, w_codigoPostal, w_email, w_telefono);
    INSERT INTO PARTICIPANTES (dni, gradoDiscapacidad, prioridadParticipacion, OID_Vol, OID_Tut)
        VALUES (w_dni, w_gradoDiscapacidad, w_prioridadParticipacion, w_OID_Vol, w_OID_Tut);
    COMMIT WORK;
END Registrar_Participante;
/

-- Registro de mensajes en el sistema de información
CREATE OR REPLACE PROCEDURE Registrar_Mensaje (w_tipo IN MENSAJES.tipo%TYPE, w_fechaEnvio IN MENSAJES.fechaEnvio%TYPE,
    w_asunto IN MENSAJES.asunto%TYPE, w_contenido IN MENSAJES.contenido%TYPE, w_OID_Coord IN COORDINADORES.OID_Coord%TYPE) IS
BEGIN
    INSERT INTO MENSAJES (tipo, fechaEnvio, asunto, contenido, OID_Coord) VALUES (w_tipo, w_fechaEnvio, w_asunto, w_contenido, w_OID_Coord);
    COMMIT WORK;
END Registrar_Mensaje;
/

-- Registro de los envíos de mensajes en el sistema de información
CREATE OR REPLACE PROCEDURE Registrar_Envio (w_dni IN PERSONAS.dni%TYPE, w_cif IN INSTITUCIONES.cif%TYPE,
    w_OID_M IN MENSAJES.OID_M%TYPE) IS
BEGIN
    INSERT INTO ENVIOS (OID_M, dni, cif) VALUES (w_OID_M, w_dni, w_cif);
    COMMIT WORK;
END Registrar_Envio;
/

-- Registro de los informes médicos asociados a un participante en el sistema de información
CREATE OR REPLACE PROCEDURE Registrar_InformeMedico (w_descripcion IN INFORMESMEDICOS.descripcion%TYPE,
    w_fecha IN INFORMESMEDICOS.fecha%TYPE, w_OID_Part IN INFORMESMEDICOS.OID_Part%TYPE) IS
BEGIN
    INSERT INTO INFORMESMEDICOS (descripcion, fecha, OID_Part) VALUES (w_descripcion, w_fecha, w_OID_Part);
    COMMIT WORK;
END Registrar_InformeMedico;
/

