-------------------------------------------------------------------------------
-- Proyecto: Deporte y Desafío
-- ID Proyecto: IS-G1-SSR_dep&des
-- Grupo de trabajo:
-- Mario Ruano Fernández
-- María Elena Molino Peña
-- Alejandro José Muñoz Aranda
-- Juan Carlos Cortés Muñoz

-- script: 3_cursores_IS-G1-SSR_dep&des.sql
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- CURSORES y LISTAS
-------------------------------------------------------------------------------

-- RF-1. Fichas de PARTICIPANTES
CREATE OR REPLACE PROCEDURE FichaParticipante(w_OID_Part PARTICIPANTES.OID_Part%TYPE) IS
    CURSOR C_Participante IS
        SELECT * FROM PARTICIPANTES NATURAL JOIN PERSONAS WHERE OID_Part=w_OID_Part;
    CURSOR C_Intereses IS
        SELECT nombre FROM ACTIVIDADES NATURAL JOIN ESTAINTERESADOEN WHERE OID_Part=w_OID_Part AND estado=1
            ORDER BY fechaInicio ASC;
    CURSOR C_InformesMedicos IS
        SELECT * FROM INFORMESMEDICOS WHERE OID_Part=w_OID_Part ORDER BY fecha DESC;
    CURSOR C_Voluntario IS
        SELECT P.dni, P.nombre, P.apellidos FROM PARTICIPANTES PART 
            LEFT JOIN VOLUNTARIOS VOL ON PART.OID_Vol=VOL.OID_Vol
            LEFT JOIN PERSONAS P ON P.dni=VOL.dni WHERE OID_Part=w_OID_Part;
    CURSOR C_TutorLegal IS
        SELECT P.dni, P.nombre, P.apellidos, P.telefono FROM PARTICIPANTES PART 
            LEFT JOIN TUTORESLEGALES TUT ON PART.OID_Tut=TUT.OID_Tut
            LEFT JOIN PERSONAS P ON P.dni=TUT.dni WHERE OID_Part=w_OID_Part;
    w_gradoDiscapacidad PARTICIPANTES.gradoDiscapacidad%TYPE;
BEGIN
    FOR REG_Part IN C_Participante LOOP
        DBMS_OUTPUT.PUT_LINE('========================================================================');
        DBMS_OUTPUT.PUT_LINE('  FICHA DE PARTICIPANTE');
        DBMS_OUTPUT.PUT_LINE('========================================================================');
        DBMS_OUTPUT.PUT_LINE('- Participante: ' || REG_Part.nombre || ' ' || REG_Part.apellidos);
        DBMS_OUTPUT.PUT_LINE('- DNI: ' || REG_Part.dni);
        DBMS_OUTPUT.PUT_LINE('- Fecha de nacimiento: ' || REG_Part.fechaNacimiento);
        DBMS_OUTPUT.PUT_LINE('- Email: ' || REG_Part.email);
        DBMS_OUTPUT.PUT_LINE('- Teléfono: ' || REG_Part.telefono);
        DBMS_OUTPUT.PUT_LINE('- Dirección: ' || REG_Part.direccion || ', ' || REG_Part.localidad || ', ' ||
            REG_Part.codigoPostal || ', ' || REG_Part.provincia);
        DBMS_OUTPUT.PUT_LINE('- Prioridad de participación: ' || REG_Part.prioridadParticipacion);
        w_gradoDiscapacidad:=REG_Part.gradoDiscapacidad * 100;
    END LOOP;
    FOR REG_Tut IN C_TutorLegal LOOP
        DBMS_OUTPUT.PUT_LINE('- Tutor legal: ' || REG_Tut.nombre || ' ' || REG_Tut.apellidos || ' ' ||
            '(' || REG_Tut.dni || ')' || ' - Teléfono: ' || REG_Tut.telefono);
    END LOOP;
    FOR REG_Vol IN C_Voluntario LOOP
        DBMS_OUTPUT.PUT_LINE('- Voluntario asignado: ' || REG_Vol.nombre || ' ' || REG_Vol.apellidos || ' ' ||
            '(' || REG_Vol.dni || ')');
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Informes médicos');
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('- GRADO DE DISCAPACIDAD: ' || w_gradoDiscapacidad || '%');
    FOR REG_Inf IN C_InformesMedicos LOOP
        DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------------');
        DBMS_OUTPUT.PUT_LINE('- Nº Informe: ' || REG_Inf.OID_Inf);
        DBMS_OUTPUT.PUT_LINE('- Fecha: ' || REG_Inf.fecha);
        DBMS_OUTPUT.PUT_LINE('- Descripción: ' || REG_Inf.descripcion);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Actividades de interés');
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------------');
    FOR REG_Int IN C_Intereses LOOP
        DBMS_OUTPUT.PUT_LINE('- ' || REG_Int.nombre);
    END LOOP;
END FichaParticipante;
/

-- RF-1. Fichas de VOLUNTARIOS
CREATE OR REPLACE PROCEDURE FichaVoluntario(w_OID_Vol VOLUNTARIOS.OID_Vol%TYPE) IS
    CURSOR C_Voluntario IS
        SELECT * FROM VOLUNTARIOS NATURAL JOIN PERSONAS WHERE OID_Vol=w_OID_Vol;
    CURSOR C_Intereses IS
        SELECT nombre FROM ACTIVIDADES NATURAL JOIN ESTAINTERESADOEN WHERE OID_Vol=w_OID_Vol AND estado=1
            ORDER BY fechaInicio ASC;
BEGIN 
    FOR REG_Vol IN C_Voluntario LOOP
        DBMS_OUTPUT.PUT_LINE('========================================================================');
        DBMS_OUTPUT.PUT_LINE('  FICHA DE VOLUNTARIO');
        DBMS_OUTPUT.PUT_LINE('========================================================================');
        DBMS_OUTPUT.PUT_LINE('- Voluntario: ' || REG_Vol.nombre || ' ' || REG_Vol.apellidos);
        DBMS_OUTPUT.PUT_LINE('- DNI: ' || REG_Vol.dni);
        DBMS_OUTPUT.PUT_LINE('- Fecha de nacimiento: ' || REG_Vol.fechaNacimiento);
        DBMS_OUTPUT.PUT_LINE('- Email: ' || REG_Vol.email);
        DBMS_OUTPUT.PUT_LINE('- Teléfono: ' || REG_Vol.telefono);
        DBMS_OUTPUT.PUT_LINE('- Dirección: ' || REG_Vol.direccion || ', ' || REG_Vol.localidad || ', ' ||
            REG_Vol.codigoPostal || ', ' || REG_Vol.provincia);
        DBMS_OUTPUT.PUT_LINE('- Prioridad de voluntariado: ' || REG_Vol.prioridadParticipacion);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Actividades de interés');
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------------');
    FOR REG_Int IN C_Intereses LOOP
        DBMS_OUTPUT.PUT_LINE('- ' || REG_Int.nombre);
    END LOOP;
END FichaVoluntario;
/

-- RF-1. Fichas de PATROCINADORES
CREATE OR REPLACE PROCEDURE FichaPatrocinador(w_cif INSTITUCIONES.cif%TYPE) IS
    CURSOR C_Patrocinador IS
        SELECT * FROM INSTITUCIONES WHERE cif=w_cif AND esPatrocinador=1;
    CURSOR C_Patrocinios IS
        SELECT cantidad, nombre FROM ACTIVIDADES NATURAL JOIN PATROCINIOS WHERE cif=w_cif ORDER BY cantidad DESC;
BEGIN
    FOR REG_Ins IN C_Patrocinador LOOP
        DBMS_OUTPUT.PUT_LINE('========================================================================');
        DBMS_OUTPUT.PUT_LINE('  FICHA DE PATROCINADOR');
        DBMS_OUTPUT.PUT_LINE('========================================================================');
        DBMS_OUTPUT.PUT_LINE('- Patrocinador: ' || REG_Ins.nombre);
        DBMS_OUTPUT.PUT_LINE('- CIF: ' || REG_Ins.cif);
        DBMS_OUTPUT.PUT_LINE('- Tipo de patrocinador: ' || REG_Ins.tipo);
        DBMS_OUTPUT.PUT_LINE('- Email: ' || REG_Ins.email);
        DBMS_OUTPUT.PUT_LINE('- Teléfono: ' || REG_Ins.telefono);
        DBMS_OUTPUT.PUT_LINE('- Dirección: ' || REG_Ins.direccion || ', ' || REG_Ins.localidad || ', ' ||
            REG_Ins.codigoPostal || ', ' || REG_Ins.provincia);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Patrocinios');
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------------');
    FOR REG_Fin IN C_Patrocinios LOOP
        DBMS_OUTPUT.PUT_LINE('- ' || RPAD(' (' || REG_Fin.cantidad ||' euros)',20) || REG_Fin.nombre);
    END LOOP;
END FichaPatrocinador;
/

-- RF-2. Valoración de ACTIVIDADES mediante CUESTIONARIOS contestados por PARTICIPANTES
-- Procedimiento auxiliar que obtiene las valoraciones de un CUESTIONARIO contestado por un PARTICIPANTE
CREATE OR REPLACE PROCEDURE GET_ValoracionesPart(w_OID_Cues CUESTIONARIOS.OID_Cues%TYPE, w_OID_Part PARTICIPANTES.OID_Part%TYPE) IS
    CURSOR C_Formularios IS
        SELECT P.enunciado AS enunciado, R.contenido AS respuesta FROM FORMULARIOS F
            LEFT JOIN RESPUESTAS R ON F.OID_Form=R.OID_Form
            LEFT JOIN PREGUNTAS P ON F.OID_Q=P.OID_Q
            WHERE F.OID_Cues=w_OID_Cues AND R.OID_Part=w_OID_Part;
    CURSOR C_Participante IS
        SELECT * FROM PERSONAS NATURAL JOIN PARTICIPANTES WHERE OID_Part=w_OID_Part;
BEGIN
    FOR REG_Part IN C_Participante LOOP
        DBMS_OUTPUT.PUT_LINE('- PARTICIPANTE: ' || REG_Part.nombre || ' ' || REG_Part.apellidos || ' (' || REG_Part.dni || ')');   
    END LOOP;
    FOR REG_Form IN C_Formularios LOOP
        DBMS_OUTPUT.PUT_LINE('- ' || REG_Form.enunciado);
        DBMS_OUTPUT.PUT_LINE('---> ' || REG_Form.respuesta);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------------');
END GET_ValoracionesPart;
/
CREATE OR REPLACE PROCEDURE GET_CuestionariosPart(w_OID_Act ACTIVIDADES.OID_Act%TYPE) IS
    CURSOR C_Cuestionarios IS
        SELECT DISTINCT C.OID_Cues AS OID_Cues, I.OID_Part AS OID_Part FROM ACTIVIDADES A LEFT JOIN CUESTIONARIOS C ON A.OID_Act=C.OID_Act
            LEFT JOIN INSCRIPCIONES I ON A.OID_Act=I.OID_Act LEFT JOIN RESPUESTAS R ON I.OID_Part=R.OID_Part WHERE A.OID_Act=w_OID_Act
            AND EXISTS (SELECT * FROM RESPUESTAS WHERE R.OID_Part=I.OID_Part);
    actividad ACTIVIDADES%ROWTYPE;
BEGIN
    SELECT * INTO actividad FROM ACTIVIDADES WHERE OID_Act=w_OID_Act;
    DBMS_OUTPUT.PUT_LINE('========================================================================');
    DBMS_OUTPUT.PUT_LINE('  CUESTIONARIOS DE ACTIVIDAD - VALORACIONES DE PARTICIPANTES');
    DBMS_OUTPUT.PUT_LINE('========================================================================');
    DBMS_OUTPUT.PUT_LINE('- Actividad: ' || actividad.nombre);
    DBMS_OUTPUT.PUT_LINE('- Objetivo: ' || actividad.objetivo);
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------------');
    FOR REG_Cues IN C_Cuestionarios LOOP
        GET_ValoracionesPart(REG_Cues.OID_Cues, REG_Cues.OID_Part);
    END LOOP;
END GET_CuestionariosPart;
/

-- RF-2. Valoración de ACTIVIDADES mediante CUESTIONARIOS contestados por VOLUNTARIOS
-- Procedimiento auxiliar que obtiene las valoraciones de un CUESTIONARIO contestado por un VOLUNTARIO
CREATE OR REPLACE PROCEDURE GET_ValoracionesVol(w_OID_Cues CUESTIONARIOS.OID_Cues%TYPE, w_OID_Vol VOLUNTARIOS.OID_Vol%TYPE) IS
    CURSOR C_Formularios IS
        SELECT P.enunciado AS enunciado, R.contenido AS respuesta FROM FORMULARIOS F
            LEFT JOIN RESPUESTAS R ON F.OID_Form=R.OID_Form
            LEFT JOIN PREGUNTAS P ON F.OID_Q=P.OID_Q
            WHERE F.OID_Cues=w_OID_Cues AND R.OID_Vol=w_OID_Vol;
    CURSOR C_Voluntario IS
        SELECT * FROM PERSONAS NATURAL JOIN VOLUNTARIOS WHERE OID_Vol=w_OID_Vol;
BEGIN
    FOR REG_Vol IN C_Voluntario LOOP
        DBMS_OUTPUT.PUT_LINE('- VOLUNTARIO: ' || REG_Vol.nombre || ' ' || REG_Vol.apellidos || ' (' || REG_Vol.dni || ')');   
    END LOOP;
    FOR REG_Form IN C_Formularios LOOP
        DBMS_OUTPUT.PUT_LINE('- ' || REG_Form.enunciado);
        DBMS_OUTPUT.PUT_LINE('---> ' || REG_Form.respuesta);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------------');
END GET_ValoracionesVol;
/
CREATE OR REPLACE PROCEDURE GET_CuestionariosVol(w_OID_Act ACTIVIDADES.OID_Act%TYPE) IS
    CURSOR C_Cuestionarios IS
        SELECT DISTINCT C.OID_Cues AS OID_Cues, CO.OID_Vol AS OID_Vol FROM ACTIVIDADES A LEFT JOIN CUESTIONARIOS C ON A.OID_Act=C.OID_Act
            LEFT JOIN COLABORACIONES CO ON A.OID_Act=CO.OID_Act LEFT JOIN RESPUESTAS R ON CO.OID_Vol=R.OID_Vol WHERE A.OID_Act=w_OID_Act
            AND EXISTS (SELECT * FROM RESPUESTAS WHERE R.OID_Vol=CO.OID_Vol);
    actividad ACTIVIDADES%ROWTYPE;
BEGIN
    SELECT * INTO actividad FROM ACTIVIDADES WHERE OID_Act=w_OID_Act;
    DBMS_OUTPUT.PUT_LINE('========================================================================');
    DBMS_OUTPUT.PUT_LINE('  CUESTIONARIOS DE ACTIVIDAD - VALORACIONES DE VOLUNTARIOS');
    DBMS_OUTPUT.PUT_LINE('========================================================================');
    DBMS_OUTPUT.PUT_LINE('- Actividad: ' || actividad.nombre);
    DBMS_OUTPUT.PUT_LINE('- Objetivo: ' || actividad.objetivo);
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------------');
    FOR REG_Cues IN C_Cuestionarios LOOP
        GET_ValoracionesVol(REG_Cues.OID_Cues, REG_Cues.OID_Vol);
    END LOOP;
END GET_CuestionariosVol;
/

-- RF-6. Lista de DONANTES
CREATE OR REPLACE PROCEDURE ListaDonantes IS
    CURSOR C_DonantesP IS
        SELECT dni, nombre, apellidos, direccion, localidad, codigoPostal, provincia, telefono, COUNT(*) AS n_donaciones
            FROM PERSONAS NATURAL JOIN DONACIONES
            GROUP BY dni, nombre, apellidos, direccion, localidad, codigoPostal, provincia, telefono
            ORDER BY n_donaciones DESC;
    CURSOR C_DonantesI IS
        SELECT cif, nombre, direccion, localidad, codigoPostal, provincia, telefono, COUNT(*) AS n_donaciones
            FROM INSTITUCIONES NATURAL JOIN DONACIONES
            GROUP BY cif, nombre, direccion, localidad, codigoPostal, provincia, telefono
            ORDER BY n_donaciones DESC;
BEGIN
    DBMS_OUTPUT.PUT_LINE('========================================================================');
    DBMS_OUTPUT.PUT_LINE('  LISTA DE DONANTES');
    DBMS_OUTPUT.PUT_LINE('========================================================================');
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('-- Donantes particulares');
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE(RPAD('DNI',15) || RPAD('Nº DONACIONES',16) || RPAD('NOMBRE',35) || RPAD('DIRECCION',60) || RPAD('TELEFONO',15));
    FOR REG_DonP IN C_DonantesP LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(REG_DonP.dni,15) || RPAD(REG_DonP.n_donaciones,16) || RPAD(REG_DonP.nombre || ' ' || REG_DonP.apellidos,35) ||
            RPAD(REG_DonP.direccion || ', ' || REG_DonP.localidad || ', ' || REG_DonP.codigoPostal || ', ' || REG_DonP.provincia,60) ||
            RPAD(REG_DonP.telefono,15));
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('-- Donantes institucionales');
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE(RPAD('CIF',15) || RPAD('Nº DONACIONES',16) || RPAD('NOMBRE',35) || RPAD('DIRECCION',60) || RPAD('TELEFONO',15));
    FOR REG_DonI IN C_DonantesI LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(REG_DonI.cif,15) || RPAD(REG_DonI.n_donaciones,16) || RPAD(REG_DonI.nombre,35) ||
            RPAD(REG_DonI.direccion || ', ' || REG_DonI.localidad || ', ' || REG_DonI.codigoPostal || ', ' || REG_DonI.provincia,60) ||
            RPAD(REG_DonI.telefono,15));
    END LOOP;
END ListaDonantes;
/

-- RF-7. Lista de correos electrónicos según grupo de destinatarios ('participantes', 'voluntarios' 'tutores', 'patrocinadores')
CREATE OR REPLACE PROCEDURE Lista_Email(grupo VARCHAR2) IS
    CURSOR C_Participantes IS
        SELECT email, nombre, apellidos FROM PERSONAS NATURAL JOIN PARTICIPANTES WHERE email IS NOT NULL ORDER BY apellidos;
    CURSOR C_Voluntarios IS
        SELECT email, nombre, apellidos FROM PERSONAS NATURAL JOIN VOLUNTARIOS WHERE email IS NOT NULL ORDER BY apellidos;
    CURSOR C_TutoresLegales IS
        SELECT email, nombre, apellidos FROM PERSONAS NATURAL JOIN TUTORESLEGALES WHERE email IS NOT NULL ORDER BY apellidos;
    CURSOR C_Patrocinadores IS
        SELECT email, nombre FROM INSTITUCIONES WHERE email IS NOT NULL AND esPatrocinador=1;
BEGIN
    DBMS_OUTPUT.PUT_LINE('========================================================================');
    DBMS_OUTPUT.PUT_LINE('  LISTA DE CORREO DE ' || UPPER(grupo));
    DBMS_OUTPUT.PUT_LINE('========================================================================');
    DBMS_OUTPUT.PUT_LINE(RPAD('EMAIL',35) || RPAD('NOMBRE',50));
    IF (LOWER(grupo)='participantes') THEN
        FOR REG_Part IN C_Participantes LOOP
            DBMS_OUTPUT.PUT_LINE(RPAD(REG_Part.email,35) || RPAD(REG_Part.apellidos || ', ' || REG_Part.nombre,50));
        END LOOP;
    ELSIF (LOWER(grupo)='voluntarios') THEN
        FOR REG_Vol IN C_Voluntarios LOOP
            DBMS_OUTPUT.PUT_LINE(RPAD(REG_Vol.email,35) || RPAD(REG_Vol.apellidos || ', ' || REG_Vol.nombre,50));
        END LOOP;
    ELSIF (LOWER(grupo)='tutores') THEN
        FOR REG_Tut IN C_TutoresLegales LOOP
            DBMS_OUTPUT.PUT_LINE(RPAD(REG_Tut.email,35) || RPAD(REG_Tut.apellidos || ', ' || REG_Tut.nombre,50));
        END LOOP;
    ELSIF (LOWER(grupo)='patrocinadores') THEN
        FOR REG_Ins IN C_Patrocinadores LOOP
            DBMS_OUTPUT.PUT_LINE(RPAD(REG_Ins.email,35) || RPAD(REG_Ins.nombre, 50));
        END LOOP;
    ELSE
        raise_application_error(-20600, 'No existe ningún grupo de destinatarios con ese nombre.');
    END IF;
END Lista_Email;
/

-- RF-8. Lista de VOLUNTARIOS en ACTIVIDAD
CREATE OR REPLACE PROCEDURE Lista_VolAct(w_OID_Act ACTIVIDADES.OID_Act%TYPE) IS
    CURSOR C_Actividad IS
        SELECT * FROM ACTIVIDADES WHERE OID_Act=w_OID_Act;
    CURSOR C_Voluntarios IS
        SELECT * FROM PERSONAS NATURAL JOIN VOLUNTARIOS V LEFT JOIN COLABORACIONES C ON V.OID_Vol=C.OID_Vol
            WHERE OID_Act=w_OID_Act ORDER BY apellidos;
BEGIN
    DBMS_OUTPUT.PUT_LINE(RPAD('OID_ACT',10) || RPAD('ACTIVIDAD',35) || RPAD('Nº VOL REQUERIDOS',20) || 
        RPAD('TIPO',20) || RPAD('COSTE TOTAL',20) || RPAD('COSTE INSCRIPCIÓN',20));
    FOR REG_Act IN C_Actividad LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(REG_Act.OID_Act,10) || RPAD(REG_Act.nombre,35) || RPAD(REG_Act.voluntariosRequeridos,20) || 
            RPAD(REG_Act.tipo,20) || RPAD(REG_Act.costeTotal || ' €',20) || RPAD(REG_Act.costeInscripcion || ' €',20)); 
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('=======================================================================================================================');
    DBMS_OUTPUT.PUT_LINE('  VOLUNTARIOS DE LA ACTIVIDAD');
    DBMS_OUTPUT.PUT_LINE('=======================================================================================================================');
    DBMS_OUTPUT.PUT_LINE(RPAD('DNI',15) || RPAD('Nombre',30) || RPAD('Nacimiento',12) || 
        RPAD('Email',25) || RPAD('Teléfono',15));
    FOR REG_Vol IN C_Voluntarios LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(REG_Vol.dni,15) || RPAD(REG_Vol.nombre || ' ' || REG_Vol.apellidos,30) || RPAD(REG_Vol.fechaNacimiento,12) || 
            RPAD(REG_Vol.email,25) || RPAD(REG_Vol.telefono,15));
    END LOOP;
END Lista_VolAct;
/

-- RF-9. Historial de VOLUNTARIADO
CREATE OR REPLACE PROCEDURE Lista_HistVol(w_OID_Vol VOLUNTARIOS.OID_Vol%TYPE) IS
    CURSOR C_Voluntario IS
        SELECT * FROM PERSONAS NATURAL JOIN VOLUNTARIOS WHERE OID_Vol=w_OID_Vol;
    CURSOR C_Colaboraciones IS
        SELECT P.nombre AS Proj_nombre, A.OID_Act AS OID_Act, A.nombre AS Act_nombre, A.fechaInicio AS Act_fInicio, A.fechaFin AS Act_fFin
            FROM PERSONAS NATURAL JOIN VOLUNTARIOS NATURAL JOIN COLABORACIONES C
            LEFT JOIN ACTIVIDADES A ON A.OID_Act=C.OID_Act
            LEFT JOIN PROYECTOS P ON P.OID_Proj=A.OID_Proj
            WHERE OID_Vol=w_OID_Vol ORDER BY A.fechaInicio DESC;
BEGIN
    DBMS_OUTPUT.PUT_LINE(RPAD('OID_VOL',10) || RPAD('DNI',15) || RPAD('NOMBRE',35) || RPAD('EMAIL',35) || RPAD('TELEFONO',15));
    FOR REG_Vol IN C_Voluntario LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(REG_Vol.OID_Vol,10) || RPAD(REG_Vol.dni,15) || RPAD(REG_Vol.nombre || ' ' || REG_Vol.apellidos,35) ||
            RPAD(REG_Vol.email,35) || RPAD(REG_Vol.telefono,15));
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('=======================================================================================================================');
    DBMS_OUTPUT.PUT_LINE('  HISTORIAL DE VOLUNTARIADO');
    DBMS_OUTPUT.PUT_LINE('=======================================================================================================================');
    DBMS_OUTPUT.PUT_LINE(RPAD('Proyecto',40) || RPAD('OID_Act',10) || RPAD('Actividad',45) || RPAD('Inicio',15) || RPAD('Fin',15));
    FOR REG_Colab IN C_Colaboraciones LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(REG_Colab.Proj_nombre,40) || RPAD(REG_Colab.OID_Act,10) || RPAD(REG_Colab.Act_nombre,45) || 
            RPAD(REG_Colab.Act_fInicio,15) || RPAD(REG_Colab.Act_fFin,15));
    END LOOP;
END Lista_HistVol;
/

-- RF-10. Lista de PARTICIPANTES en ACTIVIDAD
CREATE OR REPLACE PROCEDURE Lista_PartAct(w_OID_Act ACTIVIDADES.OID_Act%TYPE) IS
    CURSOR C_Actividad IS
        SELECT * FROM ACTIVIDADES WHERE OID_Act=w_OID_Act;
    CURSOR C_Participantes IS
        SELECT PER1.dni AS Part_dni, PER1.nombre AS Part_nombre, PER1.apellidos AS Part_apellidos, PER1.fechaNacimiento AS Part_fechaNacimiento,
            PART.gradoDiscapacidad AS gradoDiscapacidad, PER2.nombre AS Tut_nombre, PER2.apellidos AS Tut_apellidos, PER2.email AS Tut_email,
            PER2.telefono AS Tut_telefono FROM PERSONAS PER1
            LEFT JOIN PARTICIPANTES PART ON PER1.dni=PART.dni
            LEFT JOIN INSCRIPCIONES I ON PART.OID_Part=I.OID_Part
            LEFT JOIN TUTORESLEGALES T ON T.OID_Tut=PART.OID_Tut
            LEFT JOIN PERSONAS PER2 ON T.dni=PER2.dni
            WHERE OID_Act=w_OID_Act ORDER BY PER1.apellidos;
BEGIN
    DBMS_OUTPUT.PUT_LINE(RPAD('OID_ACT',10) || RPAD('ACTIVIDAD',40) || RPAD('Nº VOL REQUERIDOS',20) || 
        RPAD('TIPO',20) || RPAD('COSTE TOTAL',20) || RPAD('COSTE INSCRIPCIÓN',20));
    FOR REG_Act IN C_Actividad LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(REG_Act.OID_Act,10) || RPAD(REG_Act.nombre,40) || RPAD(REG_Act.voluntariosRequeridos,20) || 
            RPAD(REG_Act.tipo,20) || RPAD(REG_Act.costeTotal || ' €',20) || RPAD(REG_Act.costeInscripcion || ' €',20)); 
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('=======================================================================================================================');
    DBMS_OUTPUT.PUT_LINE('  PARTICIPANTES DE LA ACTIVIDAD');
    DBMS_OUTPUT.PUT_LINE('=======================================================================================================================');
    DBMS_OUTPUT.PUT_LINE(RPAD('DNI',15) || RPAD('Nombre',45) || RPAD('Nacimiento',12) || RPAD('% discapacidad', 15) || RPAD('|',2) ||
        RPAD('Tutor Legal', 35) || RPAD('Teléfono', 12) || RPAD('Email',25));
    FOR REG_Part IN C_Participantes LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(REG_Part.Part_dni,15) || RPAD(REG_Part.Part_nombre || ' ' || REG_Part.Part_apellidos,45) ||
            RPAD(REG_Part.Part_fechaNacimiento,12) || RPAD(REG_Part.gradoDiscapacidad * 100 || ' %', 15) || RPAD('|',2) ||
            RPAD(REG_Part.Tut_nombre || ' ' || REG_Part.Tut_apellidos,35) || RPAD(REG_Part.Tut_telefono, 12) || RPAD(REG_Part.Tut_email,25));
    END LOOP;
END Lista_PartAct;
/

-- RF-11. Historial de PARTICIPACION
CREATE OR REPLACE PROCEDURE Lista_HistPart(w_OID_Part PARTICIPANTES.OID_Part%TYPE) IS
    CURSOR C_Participante IS
        SELECT * FROM PERSONAS NATURAL JOIN PARTICIPANTES WHERE OID_Part=w_OID_Part;
    CURSOR C_Inscripciones IS
        SELECT P.nombre AS Proj_nombre, A.OID_Act AS OID_Act, A.nombre AS Act_nombre, A.fechaInicio AS Act_fInicio, A.fechaFin AS Act_fFin
            FROM PERSONAS NATURAL JOIN PARTICIPANTES NATURAL JOIN INSCRIPCIONES I
            LEFT JOIN ACTIVIDADES A ON A.OID_Act=I.OID_Act
            LEFT JOIN PROYECTOS P ON P.OID_Proj=A.OID_Proj
            WHERE OID_Part=w_OID_Part ORDER BY A.fechaInicio DESC;
BEGIN
    DBMS_OUTPUT.PUT_LINE(RPAD('OID_PART',10) || RPAD('DNI',15) || RPAD('NOMBRE',35) || RPAD('TELEFONO',15) || RPAD('EMAIL',35));
    FOR REG_Vol IN C_Participante LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(REG_Vol.OID_Vol,10) || RPAD(REG_Vol.dni,15) || RPAD(REG_Vol.nombre || ' ' || REG_Vol.apellidos,35) ||
            RPAD(REG_Vol.telefono,15) || RPAD(REG_Vol.email,35));
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('=======================================================================================================================');
    DBMS_OUTPUT.PUT_LINE('  HISTORIAL DE PARTICIPACIÓN');
    DBMS_OUTPUT.PUT_LINE('=======================================================================================================================');
    DBMS_OUTPUT.PUT_LINE(RPAD('Proyecto',40) || RPAD('OID_Act',10) || RPAD('Actividad',45) || RPAD('Inicio',15) || RPAD('Fin',15));
    FOR REG_Ins IN C_Inscripciones LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(REG_Ins.Proj_nombre,40) || RPAD(REG_Ins.OID_Act,10) || RPAD(REG_Ins.Act_nombre,45) || 
            RPAD(REG_Ins.Act_fInicio,15) || RPAD(REG_Ins.Act_fFin,15));
    END LOOP;
END Lista_HistPart;
/

-- RF-12. Lista de PATROCINIOS de ACTIVIDAD
CREATE OR REPLACE PROCEDURE Lista_PatrociniosAct(w_OID_Act ACTIVIDADES.OID_Act%TYPE) IS
    CURSOR C_Actividad IS
        SELECT * FROM ACTIVIDADES WHERE OID_Act=w_OID_Act;
    CURSOR C_Patrocinios IS
        SELECT * FROM PATROCINIOS NATURAL JOIN INSTITUCIONES WHERE OID_Act=w_OID_Act ORDER BY cantidad DESC;
BEGIN
    DBMS_OUTPUT.PUT_LINE(RPAD('OID_ACT',10) || RPAD('ACTIVIDAD',35) || RPAD('Nº VOL REQUERIDOS',20) || 
        RPAD('TIPO',20) || RPAD('COSTE TOTAL',20) || RPAD('COSTE INSCRIPCIÓN',20));
    FOR REG_Act IN C_Actividad LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(REG_Act.OID_Act,10) || RPAD(REG_Act.nombre,35) || RPAD(REG_Act.voluntariosRequeridos,20) || 
            RPAD(REG_Act.tipo,20) || RPAD(REG_Act.costeTotal || ' €',20) || RPAD(REG_Act.costeInscripcion || ' €',20)); 
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('=======================================================================================================================');
    DBMS_OUTPUT.PUT_LINE('  PATROCINIOS DE LA ACTIVIDAD');
    DBMS_OUTPUT.PUT_LINE('=======================================================================================================================');
    DBMS_OUTPUT.PUT_LINE(RPAD('OID_Fin',8) || RPAD('Cantidad',15) || RPAD('Patrocinador',50) || RPAD('Tipo',15) || RPAD('Email', 35) || RPAD('Teléfono',15));
    FOR REG_Fin IN C_Patrocinios LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(REG_Fin.OID_Fin,8) || RPAD(REG_Fin.cantidad || ' €',15) || RPAD(REG_Fin.nombre,50) || RPAD(REG_Fin.tipo,15) ||
            RPAD(REG_Fin.email, 35) || RPAD(REG_Fin.telefono,15));
    END LOOP;
END Lista_PatrociniosAct;
/

-- RF-13. Lista de DONACIONES en intervalo temporal
CREATE OR REPLACE PROCEDURE Lista_DonTemp(f1 DATE, f2 DATE) IS
    CURSOR C_Donaciones IS
        SELECT * FROM DONACIONES NATURAL JOIN TIPODONACIONES
            WHERE fecha BETWEEN f1 AND f2
            ORDER BY fecha ASC;
BEGIN
    IF (f1 < f2) THEN
        DBMS_OUTPUT.PUT_LINE('=======================================================================================================================');
        DBMS_OUTPUT.PUT_LINE('  DONACIONES REALIZADAS ENTRE EL ' || f1 || ' Y EL ' || f2);
        DBMS_OUTPUT.PUT_LINE('=======================================================================================================================');
        DBMS_OUTPUT.PUT_LINE(RPAD('OID_DON',10) || RPAD('DONACIÓN',30) || RPAD('CANTIDAD DONADA',25) || RPAD('VALOR UNITARIO',20) ||
            RPAD('FECHA',15) || RPAD('ID DONANTE',20));
        FOR REG_Don IN C_Donaciones LOOP
            DBMS_OUTPUT.PUT_LINE(RPAD(REG_Don.OID_Don,10) || RPAD(REG_Don.nombre,30) || RPAD(REG_Don.cantidad || ' ' || REG_Don.tipoUnidad,25)||
                RPAD(REG_Don.valorUnitario || ' €', 20) || RPAD(REG_Don.fecha, 15) || RPAD(REG_Don.dni || REG_Don.cif, 20));
        END LOOP;
    ELSE
        raise_application_error(-20600, 'La fecha f1 debe ser anterior a la fecha f2.');
    END IF;
END Lista_DonTemp;
/

-- RF-14. Lista de ACTIVIDADES en intervalo temporal
CREATE OR REPLACE PROCEDURE Lista_ActTemp(f1 DATE, f2 DATE) IS
    CURSOR C_Actividades IS
            SELECT P.nombre AS Proj_nombre, A.* FROM PROYECTOS P LEFT JOIN ACTIVIDADES A ON P.OID_Proj=A.OID_Proj
            WHERE A.fechaInicio BETWEEN f1 AND f2 ORDER BY A.fechaInicio ASC;
BEGIN
    IF (f1 < f2) THEN
        DBMS_OUTPUT.PUT_LINE('=======================================================================================================================');
        DBMS_OUTPUT.PUT_LINE('  ACTIVIDADES REALIZADAS ENTRE EL ' || f1 || ' Y EL ' || f2);
        DBMS_OUTPUT.PUT_LINE('=======================================================================================================================');
        DBMS_OUTPUT.PUT_LINE(RPAD('PROYECTO',37) || RPAD('OID_ACT',10) || RPAD('ACTIVIDAD',40) || RPAD('TIPO ACTIVIDAD',18) ||
            RPAD('Nº MAX. PART',15) || RPAD('Nº VOL REQU.',15) || RPAD('COSTE TOTAL',20) || RPAD('COSTE INSCRIPCIÓN',20));
        FOR REG_Act IN C_Actividades LOOP
            DBMS_OUTPUT.PUT_LINE(RPAD(REG_Act.Proj_nombre,37) || RPAD(REG_Act.OID_Act,10) || RPAD(REG_Act.nombre,40) ||
                RPAD(REG_Act.tipo,18) || RPAD(REG_Act.numeroPlazas,15) || RPAD(REG_Act.voluntariosRequeridos,15) ||
                RPAD(REG_Act.costeTotal || ' €',20) || RPAD(REG_Act.costeInscripcion || ' €',20));
        END LOOP;
    ELSE
        raise_application_error(-20600, 'La fecha f1 debe ser anterior a la fecha f2.');
    END IF;
END Lista_ActTemp;
/
