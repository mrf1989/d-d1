-------------------------------------------------------------------------------
-- CURSORES y LISTAS
-------------------------------------------------------------------------------

-- RF-1. Fichas de usuarios

-- PARTICIPANTES
CREATE OR REPLACE PROCEDURE FichaParticipante(w_OID_Part PARTICIPANTES.OID_Part%TYPE) IS
    CURSOR C_Participante IS
        SELECT * FROM PARTICIPANTES NATURAL JOIN PERSONAS WHERE OID_Part=w_OID_Part;
    CURSOR C_Intereses IS
        SELECT nombre FROM ACTIVIDADES NATURAL JOIN ESTAINTERESADOEN WHERE OID_Part=w_OID_Part AND estado=1;
    CURSOR C_InformesMedicos IS
        SELECT * FROM INFORMESMEDICOS WHERE OID_Part=w_OID_Part;
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
        DBMS_OUTPUT.PUT_LINE('FICHA DE PARTICIPANTE');
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
    DBMS_OUTPUT.PUT_LINE('Información médica');
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
END;
/

-- VOLUNTARIOS
CREATE OR REPLACE PROCEDURE FichaVoluntario(w_OID_Vol VOLUNTARIOS.OID_Vol%TYPE) IS
    CURSOR C_Voluntario IS
        SELECT * FROM VOLUNTARIOS NATURAL JOIN PERSONAS WHERE OID_Vol=w_OID_Vol;
    CURSOR C_Intereses IS
    /*  ESTO NO ESTA MAL, PERO NO ES NECESARIO HACERLO ASI
    
        SELECT nombre FROM ACTIVIDADES ACT LEFT JOIN ESTAINTERESADOEN EI ON ACT.OID_Act=EI.OID_Act
            LEFT JOIN VOLUNTARIOS VOL ON VOL.OID_Vol=EI.OID_Vol;
    */
        SELECT nombre FROM ACTIVIDADES NATURAL JOIN ESTAINTERESADOEN NATURAL JOIN VOLUNTARIOS WHERE estado=1;
BEGIN 
    FOR REG_Vol IN C_Voluntario LOOP
        DBMS_OUTPUT.PUT_LINE('========================================================================');
        DBMS_OUTPUT.PUT_LINE('FICHA DE VOLUNTARIO');
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
END;
/

-- PATROCINADORES
CREATE OR REPLACE PROCEDURE FichaPatrocinador(w_cif INSTITUCIONES.cif%TYPE) IS
    CURSOR C_Patrocinador IS
        SELECT * FROM INSTITUCIONES WHERE cif=w_cif AND esPatrocinador=1;
    CURSOR C_Patrocinios IS
        SELECT cantidad, nombre FROM ACTIVIDADES NATURAL JOIN PATROCINIOS WHERE cif=w_cif;
BEGIN
    FOR REG_Ins IN C_Patrocinador LOOP
        DBMS_OUTPUT.PUT_LINE('========================================================================');
        DBMS_OUTPUT.PUT_LINE('FICHA DE PATROCINADOR');
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
END;
/

-- DONANTES

-- RF-2: VALORACIÓN DE ACTIVIDADES
-- CUESTIONARIOS DE VOLUNTARIOS
-- CUESTIONARIOS DE PARTICIPANTES

-- RF-8. Lista de VOLUNTARIOS en ACTIVIDAD
CREATE OR REPLACE PROCEDURE Lista_VolAct(w_OID_Act ACTIVIDADES.OID_Act%TYPE) IS
    CURSOR C_Actividad IS
        SELECT * FROM ACTIVIDADES WHERE OID_Act=w_OID_Act;
    CURSOR C_Voluntarios IS
        SELECT * FROM PERSONAS NATURAL JOIN VOLUNTARIOS V LEFT JOIN COLABORACIONES C ON V.OID_Vol=C.OID_Vol WHERE OID_Act=w_OID_Act;
BEGIN
    DBMS_OUTPUT.PUT_LINE(RPAD('OID_ACT',10) || RPAD('ACTIVIDAD',35) || RPAD('Nº VOL REQUERIDOS',20) || 
        RPAD('TIPO',20) || RPAD('COSTE TOTAL',20) || RPAD('COSTE INSCRIPCIÓN',20));
    FOR REG_Act IN C_Actividad LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(REG_Act.OID_Act,10) || RPAD(REG_Act.nombre,35) || RPAD(REG_Act.voluntariosRequeridos,20) || 
            RPAD(REG_Act.tipo,20) || RPAD(REG_Act.costeTotal || ' €',20) || RPAD(REG_Act.costeInscripcion || ' €',20)); 
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('=======================================================================================================================');
    DBMS_OUTPUT.PUT_LINE('VOLUNTARIOS DE LA ACTIVIDAD');
    DBMS_OUTPUT.PUT_LINE('=======================================================================================================================');
    DBMS_OUTPUT.PUT_LINE(RPAD('DNI',15) || RPAD('Nombre',30) || RPAD('Nacimiento',12) || 
        RPAD('Email',25) || RPAD('Teléfono',15));
    FOR REG_Vol IN C_Voluntarios LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(REG_Vol.dni,15) || RPAD(REG_Vol.nombre || ' ' || REG_Vol.apellidos,30) || RPAD(REG_Vol.fechaNacimiento,12) || 
            RPAD(REG_Vol.email,25) || RPAD(REG_Vol.telefono,15));
    END LOOP;
END;
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
            WHERE OID_Vol=w_OID_Vol;
BEGIN
    DBMS_OUTPUT.PUT_LINE(RPAD('OID_VOL',10) || RPAD('DNI',15) || RPAD('NOMBRE',35) || RPAD('EMAIL',25) || RPAD('TELEFONO',15));
    FOR REG_Vol IN C_Voluntario LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(REG_Vol.OID_Vol,10) || RPAD(REG_Vol.dni,15) || RPAD(REG_Vol.nombre || ' ' || REG_Vol.apellidos,35) ||
            RPAD(REG_Vol.email,25) || RPAD(REG_Vol.telefono,15));
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('=======================================================================================================================');
    DBMS_OUTPUT.PUT_LINE('HISTORIAL DE VOLUNTARIADO');
    DBMS_OUTPUT.PUT_LINE('=======================================================================================================================');
    DBMS_OUTPUT.PUT_LINE(RPAD('Proyecto',40) || RPAD('OID_Act',10) || RPAD('Nombre',40) || RPAD('Inicio',15) || RPAD('Fin',15));
    FOR REG_Colab IN C_Colaboraciones LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(REG_Colab.Proj_nombre,40) || RPAD(REG_Colab.OID_Act,10) || RPAD(REG_Colab.Act_nombre,40) || 
            RPAD(REG_Colab.Act_fInicio,15) || RPAD(REG_Colab.Act_fFin,15));
    END LOOP;
END;
/

-- RF-10 Lista de PARTICIPANTES en ACTIVIDAD
CREATE OR REPLACE PROCEDURE Lista_PartAct(w_OID_Act ACTIVIDADES.OID_Act%TYPE) IS
    CURSOR C_Actividad IS
        SELECT * FROM ACTIVIDADES WHERE OID_Act=w_OID_Act;
    CURSOR C_Participantes IS
        --SELECT * FROM PERSONAS NATURAL JOIN PARTICIPANTES P LEFT JOIN INSCRIPCIONES I ON P.OID_Part=I.OID_Part WHERE OID_Act=w_OID_Act;
        SELECT PER1.dni AS Part_dni, PER1.nombre AS Part_nombre, PER1.apellidos AS Part_apellidos, PER1.fechaNacimiento AS Part_fechaNacimiento,
            PART.gradoDiscapacidad AS gradoDiscapacidad, PER2.nombre AS Tut_nombre, PER2.apellidos AS Tut_apellidos, PER2.email AS Tut_email,
            PER2.telefono AS Tut_telefono FROM PERSONAS PER1
            LEFT JOIN PARTICIPANTES PART ON PER1.dni=PART.dni
            LEFT JOIN INSCRIPCIONES I ON PART.OID_Part=I.OID_Part
            LEFT JOIN TUTORESLEGALES T ON T.OID_Tut=PART.OID_Tut
            LEFT JOIN PERSONAS PER2 ON T.dni=PER2.dni
            WHERE OID_Act=w_OID_Act;
BEGIN
    DBMS_OUTPUT.PUT_LINE(RPAD('OID_ACT',10) || RPAD('ACTIVIDAD',35) || RPAD('Nº VOL REQUERIDOS',20) || 
        RPAD('TIPO',20) || RPAD('COSTE TOTAL',20) || RPAD('COSTE INSCRIPCIÓN',20));
    FOR REG_Act IN C_Actividad LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(REG_Act.OID_Act,10) || RPAD(REG_Act.nombre,35) || RPAD(REG_Act.voluntariosRequeridos,20) || 
            RPAD(REG_Act.tipo,20) || RPAD(REG_Act.costeTotal || ' €',20) || RPAD(REG_Act.costeInscripcion || ' €',20)); 
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('=======================================================================================================================');
    DBMS_OUTPUT.PUT_LINE('PARTICIPANTES DE LA ACTIVIDAD');
    DBMS_OUTPUT.PUT_LINE('=======================================================================================================================');
    DBMS_OUTPUT.PUT_LINE(RPAD('DNI',15) || RPAD('Nombre',30) || RPAD('Nacimiento',12) || RPAD('% discapacidad', 15) || RPAD('|',2) ||
        RPAD('Tutor Legal', 35) || RPAD('Teléfono', 12) || RPAD('Email',25));
    FOR REG_Part IN C_Participantes LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(REG_Part.Part_dni,15) || RPAD(REG_Part.Part_nombre || ' ' || REG_Part.Part_apellidos,30) ||
            RPAD(REG_Part.Part_fechaNacimiento,12) || RPAD(REG_Part.gradoDiscapacidad * 100 || ' %', 15) || RPAD('|',2) ||
            RPAD(REG_Part.Tut_nombre || ' ' || REG_Part.Tut_apellidos,35) || RPAD(REG_Part.Tut_telefono, 12) || RPAD(REG_Part.Tut_email,25));
    END LOOP;
END;
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
            WHERE OID_Part=w_OID_Part;
BEGIN
    DBMS_OUTPUT.PUT_LINE(RPAD('OID_PART',10) || RPAD('DNI',15) || RPAD('NOMBRE',35) || RPAD('TELEFONO',15) || RPAD('EMAIL',25));
    FOR REG_Vol IN C_Participante LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(REG_Vol.OID_Vol,10) || RPAD(REG_Vol.dni,15) || RPAD(REG_Vol.nombre || ' ' || REG_Vol.apellidos,35) ||
            RPAD(REG_Vol.telefono,15) || RPAD(REG_Vol.email,25));
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('=======================================================================================================================');
    DBMS_OUTPUT.PUT_LINE('HISTORIAL DE PARTICIPACIÓN');
    DBMS_OUTPUT.PUT_LINE('=======================================================================================================================');
    DBMS_OUTPUT.PUT_LINE(RPAD('Proyecto',40) || RPAD('OID_Act',10) || RPAD('Nombre',40) || RPAD('Inicio',15) || RPAD('Fin',15));
    FOR REG_Ins IN C_Inscripciones LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(REG_Ins.Proj_nombre,40) || RPAD(REG_Ins.OID_Act,10) || RPAD(REG_Ins.Act_nombre,40) || 
            RPAD(REG_Ins.Act_fInicio,15) || RPAD(REG_Ins.Act_fFin,15));
    END LOOP;
END;
/

-- RF-12 Lista de PATROCINIOS de ACTIVIDAD
CREATE OR REPLACE PROCEDURE Lista_PatrociniosAct(w_OID_Act ACTIVIDADES.OID_Act%TYPE) IS
    CURSOR C_Actividad IS
        SELECT * FROM ACTIVIDADES WHERE OID_Act=w_OID_Act;
    CURSOR C_Patrocinios IS
        SELECT * FROM PATROCINIOS NATURAL JOIN INSTITUCIONES WHERE OID_Act=w_OID_Act;
BEGIN
    DBMS_OUTPUT.PUT_LINE(RPAD('OID_ACT',10) || RPAD('ACTIVIDAD',35) || RPAD('Nº VOL REQUERIDOS',20) || 
        RPAD('TIPO',20) || RPAD('COSTE TOTAL',20) || RPAD('COSTE INSCRIPCIÓN',20));
    FOR REG_Act IN C_Actividad LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(REG_Act.OID_Act,10) || RPAD(REG_Act.nombre,35) || RPAD(REG_Act.voluntariosRequeridos,20) || 
            RPAD(REG_Act.tipo,20) || RPAD(REG_Act.costeTotal || ' €',20) || RPAD(REG_Act.costeInscripcion || ' €',20)); 
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('=======================================================================================================================');
    DBMS_OUTPUT.PUT_LINE('PATROCINIOS DE LA ACTIVIDAD');
    DBMS_OUTPUT.PUT_LINE('=======================================================================================================================');
    DBMS_OUTPUT.PUT_LINE(RPAD('OID_Fin',8) || RPAD('Cantidad',15) || RPAD('Patrocinador',50) || RPAD('Tipo',15) || RPAD('Email', 35) || RPAD('Teléfono',15));
    FOR REG_Fin IN C_Patrocinios LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(REG_Fin.OID_Fin,8) || RPAD(REG_Fin.cantidad || ' €',15) || RPAD(REG_Fin.nombre,50) || RPAD(REG_Fin.tipo,15) ||
            RPAD(REG_Fin.email, 35) || RPAD(REG_Fin.telefono,15));
    END LOOP;
END;
/

-- RF-13: INFORME DE DONACIONES POR AÑO
SET SERVEROUTPUT ON
CREATE OR REPLACE PROCEDURE DonacionesPorFecha(f1 date, f2 date) IS
    CURSOR C IS
        SELECT * FROM DONACIONES NATURAL JOIN  TIPODONACIONES
        WHERE fecha BETWEEN f1 and f2;
BEGIN 
        DBMS_OUTPUT.PUT_LINE(RPAD('OID DONACIÓN',25) || RPAD('CANTIDAD DONADA',25) || RPAD('VALOR UNITARIO',25) || RPAD('FECHA',25) ||
        RPAD('TIPO DONACIÓN',25) || RPAD('ID DONANTE',25));
        FOR registro IN C LOOP
            DBMS_OUTPUT.PUT_LINE(RPAD(registro.oid_don, 25)|| RPAD(registro.cantidad, 25)|| RPAD(registro.valorunitario, 25) ||
            RPAD(registro.fecha, 25) || RPAD(registro.nombre, 25) || RPAD(registro.dni, 25) || registro.cif);
        END LOOP;
END;
/

-- RF-14: INFORME DE ACTIVIDADES POR AÑO
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE ActsPorFecha(f1 date, f2 date) IS
    CURSOR C IS
        SELECT * FROM ACTIVIDADES WHERE fechainicio BETWEEN f1 and f2;
BEGIN 
        DBMS_OUTPUT.PUT_LINE(RPAD('OID_ACT',25) || RPAD('NOMBRE',35) || RPAD('OBJETIVO',70) || RPAD('Nº VOLS REQUERIDOS',25) || 
        RPAD('TIPO ACTIVIDAD',25) || RPAD('COSTE TOTAL',25) || RPAD('COSTE INSCRIPCIÓN',25));
        FOR registro IN C LOOP
            DBMS_OUTPUT.PUT_LINE(RPAD(registro.oid_act, 25)|| RPAD(registro.nombre, 35) ||  RPAD(registro.objetivo, 70) || 
            RPAD(registro.voluntariosrequeridos, 25) || RPAD(registro.tipo, 25) || RPAD(registro.costetotal, 25) ||
            RPAD(registro.costeinscripcion, 25));
        END LOOP;
    
END;
/






















