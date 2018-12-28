-------------------------------------------------------------------------------
-- PROCEDIMIENTOS y FUNCIONES
-------------------------------------------------------------------------------

-- Registrar COORDINADOR en el sistema de información
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

-- Registrar VOLUNTARIO en el sistema de información
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

-- Registrar TUTOR LEGAL en el sistema de información
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

-- Registrar PARTICIPANTE en el sistema de información
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

-- Registrar PATROCINADOR en el sistema de información
CREATE OR REPLACE PROCEDURE Registrar_Patrocinador (w_cif IN INSTITUCIONES.cif%TYPE, w_nombre IN INSTITUCIONES.nombre%TYPE,
    w_telefono IN INSTITUCIONES.telefono%TYPE, w_direccion IN INSTITUCIONES.direccion%TYPE, w_localidad IN INSTITUCIONES.localidad%TYPE,
    w_provincia IN INSTITUCIONES.provincia%TYPE, w_codigoPostal IN INSTITUCIONES.codigoPostal%TYPE, w_email IN INSTITUCIONES.email%TYPE,
    w_tipo IN INSTITUCIONES.tipo%TYPE) IS
BEGIN
    INSERT INTO INSTITUCIONES VALUES (w_cif, w_nombre, w_telefono, w_direccion, w_localidad, w_provincia, w_codigoPostal, w_email, 1, w_tipo);
    COMMIT WORK;
END Registrar_Patrocinador;
/

-- Registrar DONACION en el sistema de información
CREATE OR REPLACE PROCEDURE Registrar_Donacion (w_dni IN PERSONAS.dni%TYPE, w_cif IN INSTITUCIONES.cif%TYPE, w_nombre IN TIPODONACIONES.nombre%TYPE,
    w_tipoUnidad IN TIPODONACIONES.tipoUnidad%TYPE, w_cantidad IN DONACIONES.cantidad%TYPE, w_valorUnitario IN DONACIONES.valorUnitario%TYPE) IS
    tipoDonacion TIPODONACIONES%ROWTYPE;
    w_OID_TDon INTEGER;
BEGIN
    SELECT OID_TDon INTO w_OID_TDon FROM TIPODONACIONES WHERE nombre=w_nombre AND tipoUnidad=w_tipoUnidad;
    IF (w_OID_TDon>0) THEN
        INSERT INTO DONACIONES(cantidad, valorUnitario, dni, cif, OID_TDon) VALUES (w_cantidad, w_valorUnitario, w_dni, w_cif, w_OID_TDon);
    END IF;
    COMMIT WORK;
    
    EXCEPTION
    WHEN OTHERS THEN
        INSERT INTO TIPODONACIONES(nombre, tipoUnidad) VALUES (w_nombre, w_tipoUnidad);
        SELECT OID_TDon INTO w_OID_TDon FROM TIPODONACIONES WHERE nombre=w_nombre AND tipoUnidad=w_tipoUnidad;
        INSERT INTO DONACIONES(cantidad, valorUnitario, dni, cif, OID_TDon) VALUES (w_cantidad, w_valorUnitario, w_dni, w_cif, w_OID_TDon);
    COMMIT WORK;
END Registrar_Donacion;
/

-- Registrar PROYECTO por un COORDINADOR en el sistema de información
CREATE OR REPLACE PROCEDURE Registrar_Proyecto (w_dni IN PERSONAS.dni%TYPE, w_nombre IN PROYECTOS.nombre%TYPE, w_ubicacion IN PROYECTOS.ubicacion%TYPE,
    w_esEvento IN PROYECTOS.esEvento%TYPE, w_esProgDep IN PROYECTOS.esProgDep%TYPE) IS
    w_OID_Coord INTEGER;
    w_OID_Proj INTEGER;
BEGIN
    INSERT INTO PROYECTOS(nombre, ubicacion, esEvento, esProgDep) VALUES (w_nombre, w_ubicacion, w_esEvento, w_esProgDep);
    w_OID_Proj := SEC_Proj.CURRVAL;
    w_OID_Coord := SEC_Coord.CURRVAL;
    INSERT INTO ENCARGADOS(OID_Proj, OID_Coord) VALUES (w_OID_Proj, w_OID_Coord);
    COMMIT WORK;
END Registrar_Proyecto;
/

-- Eliminar PERSONA (con efecto cascada) en el sistema de información
CREATE OR REPLACE PROCEDURE Eliminar_Persona (w_dni IN PERSONAS.dni%TYPE) IS
    persona PERSONAS%ROWTYPE;
BEGIN
    SELECT * INTO persona FROM PERSONAS WHERE dni=w_dni;
    IF (persona.dni=w_dni) THEN
        DELETE FROM PERSONAS WHERE dni=w_dni;
    END IF;
    COMMIT WORK;
END Eliminar_Persona;
/

-- Eliminar PATROCINADOR en el sistema de información
CREATE OR REPLACE PROCEDURE Eliminar_Patrocinador (w_cif IN INSTITUCIONES.cif%TYPE) IS
    patrocinador INSTITUCIONES%ROWTYPE;
BEGIN
    SELECT * INTO patrocinador FROM INSTITUCIONES WHERE cif=w_cif;
    IF (patrocinador.cif=w_cif) THEN
        DELETE FROM INSTITUCIONES WHERE cif=w_cif;
    END IF;
    COMMIT WORK;
END Eliminar_Patrocinador;
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

