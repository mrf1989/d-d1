-------------------------------------------------------------------------------
-- TRIGGERS asociados a reglas de negocio
-------------------------------------------------------------------------------

-- RN-1 y RN-2. Prioridad de participación
CREATE OR REPLACE TRIGGER PRIORIDAD_PARTICIPACION
BEFORE UPDATE ON ESTAINTERESADOEN
FOR EACH ROW
DECLARE
    w_OID_Part PARTICIPANTES.OID_Part%TYPE;
    w_OID_Act ACTIVIDADES.OID_Act%TYPE;
    n_ins3Meses INTEGER;
    n_ins INTEGER;
BEGIN
    w_OID_Part:=:OLD.OID_Part;
    w_OID_Act:=:OLD.OID_Act;
    SELECT COUNT(*) INTO n_ins3Meses FROM INSCRIPCIONES NATURAL JOIN ACTIVIDADES WHERE OID_Part=w_OID_Part AND fechaInicio BETWEEN ADD_MONTHS(SYSDATE, -3) AND SYSDATE;
    SELECT COUNT(*) INTO n_ins FROM INSCRIPCIONES NATURAL JOIN ACTIVIDADES WHERE OID_Part=w_OID_Part;
    IF (n_ins3Meses > 0) THEN
        UPDATE PARTICIPANTES SET prioridadParticipacion='baja' WHERE OID_Part=w_OID_Part;
    ELSIF (n_ins > 0) THEN
        UPDATE PARTICIPANTES SET prioridadParticipacion='media' WHERE OID_Part=w_OID_Part;
    END IF;
END PRIORIDAD_PARTICIPACION;
/

CREATE OR REPLACE TRIGGER PARTICIPANTE_INSCRITO
BEFORE INSERT ON INSCRIPCIONES
FOR EACH ROW
BEGIN
    UPDATE PARTICIPANTES SET prioridadParticipacion='baja' WHERE OID_Part=:NEW.OID_Part;
END PARTICIPANTE_INSCRITO;
/

-- RN-3. Pagos pendientes
CREATE OR REPLACE TRIGGER PAGOS_PENDIENTES
BEFORE INSERT ON INSCRIPCIONES
FOR EACH ROW
DECLARE 
    CURSOR C_PAGOS IS SELECT * FROM RECIBOS WHERE OID_Part=:NEW.OID_Part;
BEGIN
    FOR recibo IN C_PAGOS LOOP
        IF (recibo.estado = 'pendiente') THEN 
            raise_application_error(-20600, 'El participante tiene pagos pendientes');
        END IF;
    END LOOP;
END PAGOS_PENDIENTES;
/

-- RN-4. Representante legal
CREATE OR REPLACE TRIGGER REPRESENTANTE_LEGAL
BEFORE INSERT ON PARTICIPANTES
FOR EACH ROW
DECLARE
    w_dni PARTICIPANTES.dni%TYPE;
    w_fechaNacimiento PERSONAS.fechaNacimiento%TYPE;
    w_gradoDiscapacidad PARTICIPANTES.gradoDiscapacidad%TYPE;
    w_OID_Tut TUTORESLEGALES.OID_Tut%TYPE;
BEGIN
    w_dni:=:NEW.dni;
    SELECT fechaNacimiento INTO w_fechaNacimiento FROM PERSONAS WHERE dni=w_dni;
    w_gradoDiscapacidad:=:NEW.gradoDiscapacidad;
    w_OID_Tut:=:NEW.OID_Tut;
    IF (w_OID_Tut IS NULL AND NOT esMayorDeEdad(w_fechaNacimiento) OR w_gradoDiscapacidad > 0.5) THEN
        raise_application_error(-20600, 'Si el participante es menor de edad o tiene un grado de discapacidad superior al 50% debe tener asignado un tutor legal.');
    END IF;
END REPRESENTANTE_LEGAL;
/

-- RN-5. Información médica
CREATE OR REPLACE TRIGGER INFORMACION_MEDICA
BEFORE INSERT ON INSCRIPCIONES
FOR EACH ROW
DECLARE 
    n_informes INTEGER;
BEGIN
    SELECT COUNT(*) INTO n_informes FROM INFORMESMEDICOS WHERE OID_Part=:NEW.OID_Part;
    IF (n_informes=0) THEN
        raise_application_error(-20600, 'El participante debe tener asociado al menos un informe m�dico.');
    END IF;
END INFORMACION_MEDICA;
/

-- RN-6. Prioridad de voluntariado
CREATE OR REPLACE TRIGGER PRIORIDAD_VOLUNTARIADO
BEFORE UPDATE ON ESTAINTERESADOEN
FOR EACH ROW
DECLARE
    w_OID_Vol VOLUNTARIOS.OID_Vol%TYPE;
    w_OID_Act ACTIVIDADES.OID_Act%TYPE;
    n_ins3Meses INTEGER;
    n_ins INTEGER;
BEGIN
    w_OID_Vol:=:OLD.OID_Vol;
    w_OID_Act:=:OLD.OID_Act;
    SELECT COUNT(*) INTO n_ins3Meses FROM COLABORACIONES NATURAL JOIN ACTIVIDADES WHERE OID_Vol=w_OID_Vol AND fechaInicio BETWEEN ADD_MONTHS(SYSDATE, -3) AND SYSDATE;
    SELECT COUNT(*) INTO n_ins FROM COLABORACIONES NATURAL JOIN ACTIVIDADES WHERE OID_Vol=w_OID_Vol;
    IF (n_ins3Meses > 0) THEN
        UPDATE VOLUNTARIOS SET prioridadParticipacion='alta' WHERE OID_Vol=w_OID_Vol;
    ELSIF (n_ins > 0) THEN
        UPDATE VOLUNTARIOS SET prioridadParticipacion='media' WHERE OID_Vol=w_OID_Vol;
    END IF;
END PRIORIDAD_VOLUNTARIADO;
/

CREATE OR REPLACE TRIGGER VOLUNTARIO_INSCRITO
BEFORE INSERT ON COLABORACIONES
FOR EACH ROW
BEGIN
    UPDATE VOLUNTARIOS SET prioridadParticipacion='alta' WHERE OID_Vol=:NEW.OID_Vol;
END VOLUNTARIO_INSCRITO;
/

-- RN-7. Estado de interés en actividades
CREATE OR REPLACE TRIGGER ESTADO_INTERES_ACT
AFTER INSERT ON ACTIVIDADES
FOR EACH ROW
DECLARE
    w_OID_Part PARTICIPANTES.OID_Part%TYPE;
    w_OID_Act ACTIVIDADES.OID_Act%TYPE;
    CURSOR C_PARTICIPANTES IS SELECT OID_Part FROM PARTICIPANTES;
BEGIN
    w_OID_Act:=:NEW.OID_Act;
    FOR participante IN C_PARTICIPANTES LOOP
        w_OID_Part:=participante.OID_Part;
        INSERT INTO ESTAINTERESADOEN(OID_Vol, OID_Part, OID_Act, estado) VALUES (null, w_OID_Part, w_OID_Act, 0);
    END LOOP;
END ESTADO_INTERES_ACT;
/

-- RN-8. Envío de mensajes
CREATE OR REPLACE TRIGGER ENVIO_MENSAJE
BEFORE INSERT ON ENVIOS
FOR EACH ROW
DECLARE
    mensaje MENSAJES%ROWTYPE;
BEGIN
    SELECT * INTO mensaje FROM MENSAJES WHERE OID_M=:NEW.OID_M;
    IF (mensaje.tipo='informe' AND :NEW.dni IS NOT NULL) THEN
        raise_application_error(-20600, 'S�lo los patrocinadores pueden recibir informes.');
    END IF;
END ENVIO_MENSAJE;
/

-- RN-9. Tipo de patrocinador
CREATE OR REPLACE TRIGGER TIPO_PATROCINADOR
AFTER INSERT ON PATROCINIOS
FOR EACH ROW
DECLARE
    w_OID_Proj INTEGER;
    w_OID_Act INTEGER;
    costeTotalProj ACTIVIDADES.costeTotal%TYPE;
    proyecto PROYECTOS%ROWTYPE;
BEGIN
    SELECT :NEW.OID_Act INTO w_OID_Act FROM DUAL;
    SELECT OID_Proj INTO w_OID_Proj FROM ACTIVIDADES WHERE OID_Act=w_OID_Act;
    SELECT * INTO proyecto FROM PROYECTOS WHERE OID_Proj=w_OID_Proj;
    SELECT SUM(costeTotal) INTO costeTotalProj FROM ACTIVIDADES WHERE OID_Proj=w_OID_Proj;
    IF (:NEW.cantidad >= costeTotalProj) THEN
        UPDATE INSTITUCIONES SET tipo='oro' WHERE cif=:NEW.cif;
    ELSIF (:NEW.cantidad < costeTotalProj AND proyecto.esProgDep = 1) THEN
        UPDATE INSTITUCIONES SET tipo='plata' WHERE cif=:NEW.cif;
    ELSIF (:NEW.cantidad < costeTotalProj AND proyecto.esEvento = 1) THEN
        UPDATE INSTITUCIONES SET tipo='bronce' WHERE cif=:NEW.cif;
    END IF;
END TIPO_PATROCINADOR;
/

-- RN-11. Coste de inscripciones
CREATE OR REPLACE TRIGGER COSTE_INSCRIPCION
AFTER INSERT ON PATROCINIOS
FOR EACH ROW
DECLARE
    w_OID_Act INTEGER;
    costesIns ACTIVIDADES.costeTotal%TYPE;
    actividad ACTIVIDADES%ROWTYPE;
BEGIN
    SELECT :NEW.OID_Act INTO w_OID_Act FROM DUAL;
    SELECT * INTO actividad FROM ACTIVIDADES WHERE OID_Act=w_OID_Act;
    IF (:NEW.cantidad > actividad.costeTotal) THEN
        UPDATE ACTIVIDADES SET costeInscripcion=0 WHERE OID_Act=w_OID_Act;
    ELSE
        costesIns:=actividad.costeTotal - :NEW.cantidad;
        UPDATE ACTIVIDADES SET costeInscripcion=calcularCosteInscripcion(costesIns, actividad.numeroPlazas) WHERE OID_Act=w_OID_Act;
    END IF;
END COSTE_INSCRIPCION;
/

-- RN-12. Plazas de inscripciones
CREATE OR REPLACE TRIGGER PLAZAS_INSCRIPCIONES
BEFORE INSERT ON INSCRIPCIONES
FOR EACH ROW
DECLARE
    n_inscritos INTEGER;
    w_numeroPlazas ACTIVIDADES.numeroPlazas%TYPE;
BEGIN
    SELECT numeroPlazas INTO w_numeroPlazas FROM ACTIVIDADES WHERE OID_Act=:NEW.OID_Act;
    SELECT COUNT(OID_Part) INTO n_inscritos FROM INSCRIPCIONES WHERE OID_Act=:NEW.OID_Act;
    IF (n_inscritos = w_numeroPlazas) THEN
        raise_application_error(-20600, 'No hay m�s plazas de inscripci�n disponibles');
    END IF;
END PLAZAS_INSCRIPCIONES;
/

-- RN-13. Plazo de respuesta de cuestionario
CREATE OR REPLACE TRIGGER PLAZO_CUESTIONARIO
BEFORE INSERT ON RESPUESTAS
FOR EACH ROW
DECLARE
    w_fechaCreacion DATE;
BEGIN
    SELECT fechaCreacion INTO w_fechaCreacion FROM FORMULARIOS NATURAL JOIN CUESTIONARIOS WHERE OID_Form=:NEW.OID_Form;
    IF (SYSDATE NOT BETWEEN w_fechaCreacion AND w_fechaCreacion+15) THEN
        raise_application_error(-20602, 'Solo puede responderse al formulario durante los primeros 15 d�as desde su fecha de creaci�n.');
    END IF;
END PLAZO_CUESTIONARIO;
/


