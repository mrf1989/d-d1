
-- RF-1: FICHAS DE USUARIOS

-- PARTICIPANTES
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE FichaParticipante(w_OID_Part  participantes.oid_part%TYPE) IS
    CURSOR C IS
        SELECT * FROM PARTICIPANTES PART NATURAL JOIN PERSONAS PERS LEFT JOIN ESTAINTERESADOEN EI ON part.oid_part=ei.oid_part
        LEFT JOIN INFORMESMEDICOS IM ON part.oid_part=im.oid_part WHERE part.oid_part=w_oid_part;
        registro                C%ROWTYPE;
BEGIN 
        OPEN C;
        DBMS_OUTPUT.PUT_LINE(RPAD('DNI',25) || RPAD('NOMBRE',25) || RPAD('APELLIDOS',25) || RPAD('FECHA NACIMIENTO',25) || 
        RPAD('DIRECCIÓN',25) || RPAD('LOCALIDAD',25) || RPAD('PROVINCIA',25) || RPAD('CÓDIGO POSTAL',25) || RPAD('EMAIL',25) ||
        RPAD('TELÉFONO',25) || RPAD('GRADO DISCAPACIDAD',25) || RPAD('OID TUTOR/REPRESENTANTE',25) || 
        RPAD('OID ACTS INTERESADO',25) || RPAD('PRIORIDAD PARTICIPACIÓN',25) || RPAD('OID INF MÉDICOS',25));
        LOOP
            FETCH C INTO registro;
            EXIT WHEN C%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(RPAD(registro.dni, 25)|| RPAD(registro.nombre, 25) || RPAD(registro.apellidos, 25) || 
            RPAD(registro.fechanacimiento, 25) || RPAD(registro.direccion, 25) || RPAD(registro.localidad, 25) || 
            RPAD(registro.provincia, 25) || RPAD(registro.codigopostal, 25) || RPAD(registro.email, 25) || 
            RPAD(registro.telefono, 25) || RPAD(registro.gradodiscapacidad, 25) || RPAD(registro.oid_tut, 25) || 
            RPAD(registro.oid_act, 25) || RPAD(registro.prioridadparticipacion, 25) || RPAD(registro.oid_inf, 25));
        END LOOP;
        CLOSE C;
END;
/


-- VOLUNTARIOS
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE FichaVoluntario(w_OID_Vol  voluntarios.oid_vol%TYPE) IS
    CURSOR C IS
        SELECT * FROM VOLUNTARIOS VOL NATURAL JOIN PERSONAS PERS LEFT JOIN ESTAINTERESADOEN EI ON vol.oid_vol=ei.oid_vol
        LEFT JOIN COLABORACIONES COL ON col.oid_vol=vol.oid_vol LEFT JOIN INSCRIPCIONES INS ON ins.oid_act=col.oid_act
        WHERE vol.oid_vol=w_oid_vol;
    registro                C%ROWTYPE;
BEGIN 
        OPEN C;
        DBMS_OUTPUT.PUT_LINE(RPAD('DNI',25) || RPAD('NOMBRE',25) || RPAD('APELLIDOS',25) || RPAD('FECHA NACIMIENTO',25) || 
        RPAD('DIRECCIÓN',25) || RPAD('LOCALIDAD',25) || RPAD('PROVINCIA',25) || RPAD('CÓDIGO POSTAL',25) || RPAD('EMAIL',25) ||
        RPAD('TELÉFONO',25) || RPAD('OID ACTS INTERESADO',25) ||
        RPAD('PRIORIDAD PARTICIPACIÓN',25) || RPAD('OID PART ACOMPAÑADOS',25));
        LOOP
            FETCH C INTO registro;
            EXIT WHEN C%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(RPAD(registro.dni, 25)|| RPAD(registro.nombre, 25) || RPAD(registro.apellidos, 25) || 
            RPAD(registro.fechanacimiento, 25) || RPAD(registro.direccion, 25) || RPAD(registro.localidad, 25) || 
            RPAD(registro.provincia, 25) || RPAD(registro.codigopostal, 25) || RPAD(registro.email, 25) || 
            RPAD(registro.telefono, 25) || RPAD(registro.oid_act, 25) || RPAD(registro.prioridadparticipacion, 25));
        END LOOP;
        CLOSE C;
END;
/

-- PATROCINADORES
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE FichaPatrocinador(w_cif  patrocinios.cif%TYPE) IS
    CURSOR C IS
        SELECT * FROM PATROCINIOS NATURAL JOIN INSTITUCIONES WHERE cif=w_cif;
BEGIN 
        DBMS_OUTPUT.PUT_LINE(RPAD('CIF',25) || RPAD('NOMBRE',25) || RPAD('DIRECCIÓN',25) || RPAD('LOCALIDAD',25) || 
        RPAD('PROVINCIA',25) || RPAD('CÓDIGO POSTAL',25) || RPAD('EMAIL',25) || RPAD('TELÉFONO',25) ||
        RPAD('TIPO PATROCINADOR',25) || RPAD('OID FINANCIACIONES',25) || RPAD('OID ACTS FINANCIADAS',25));
        FOR registro IN C LOOP
            DBMS_OUTPUT.PUT_LINE(RPAD(registro.cif, 25)|| RPAD(registro.nombre, 25) ||  RPAD(registro.direccion, 25) || 
            RPAD(registro.localidad, 25) || RPAD(registro.provincia, 25) || RPAD(registro.codigopostal, 25) ||
            RPAD(registro.email, 25) || RPAD(registro.telefono, 25) || RPAD(registro.tipo, 25) || RPAD(registro.oid_fin, 25)
             || RPAD(registro.oid_act, 25));
        END LOOP;
END;
/

-- DONANTES

-- PERSONA (NO FUNCIONA)
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE FichaDonante(w_dni  personas.dni%TYPE) IS
    persona PERSONAS%ROWTYPE;    
    CURSOR C IS
        SELECT  distinct nombre, cantidad, valorunitario, 
        fecha FROM DONACIONES D LEFT JOIN PERSONAS P ON d.dni=p.dni
        LEFT JOIN TIPODONACIONES TD ON td.oid_tdon=d.oid_tdon WHERE dni=w_dni;
BEGIN 
        SELECT * INTO persona FROM PERSONAS WHERE dni=w_dni;
        
        DBMS_OUTPUT.PUT_LINE(RPAD('NOMBRE',25) || RPAD('APELLIDOS',25) || RPAD('FECHA NACIMIENTO',25) ||
            RPAD('DIRECCIÓN',40) || RPAD('LOCALIDAD',25) || RPAD('PROVINCIA',25) || RPAD('CÓDIGO POSTAL',25) ||
            RPAD('EMAIL',40) || RPAD('TELÉFONO',25));
        
        DBMS_OUTPUT.PUT_LINE(RPAD(persona.nombre, 25) || RPAD(persona.apellidos, 25) || RPAD(persona.fechanacimiento, 25) ||
            RPAD(persona.direccion, 40) || RPAD(persona.localidad, 25) || RPAD(persona.provincia, 25) || 
            RPAD(persona.codigopostal, 25) || RPAD(persona.email, 40) || RPAD(persona.telefono, 25));
            
        DBMS_OUTPUT.PUT_LINE(RPAD('TIPO DONACIÓN',25) || RPAD('CANTIDAD',25) || RPAD('VALOR UNITARIO',25) ||
            RPAD('FECHA DONACIÓN',25));    
        FOR registro IN C LOOP
            DBMS_OUTPUT.PUT_LINE(RPAD('---', 25) || RPAD(registro.cantidad, 25) ||
            RPAD(registro.valorunitario, 25) || RPAD(registro.fecha, 25));
        END LOOP;
END;
/

-- INSTITUCIÓN


-- RF-2: VALORACIÓN DE ACTIVIDADES

-- CUESTIONARIOS DE VOLUNTARIOS
-- CUESTIONARIOS DE PARTICIPANTES

-- RF-8: INFORME DE VOLUNTARIOS (FUNCIONA, EN LA PRUEBA MUESTRA EL RESULTADO PERO DA ERROR)
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE InformeVoluntarios(w_OID_Act  actividades.oid_act%TYPE) IS
    CURSOR C IS
    SELECT V.OID_VOL OID_VOL, V.DNI DNI, V.PRIORIDADPARTICIPACION PRIORIDADPARTICIPACION, P.NOMBRE NOMBRE, 
    P.APELLIDOS APELLIDOS, P.FECHANACIMIENTO FECHANACIMIENTO, P.DIRECCION DIRECCION, P.LOCALIDAD LOCALIDAD, P.PROVINCIA PROVINCIA,
    P.CODIGOPOSTAL CODIGOPOSTAL, P.EMAIL EMAIL, P.TELEFONO TELEFONO, A.OID_ACT OID_ACT
 FROM VOLUNTARIOS V LEFT JOIN PERSONAS P ON v.dni=p.dni  LEFT JOIN COLABORACIONES C ON c.oid_vol=v.oid_vol
    LEFT JOIN ACTIVIDADES A ON a.oid_act=c.oid_act WHERE a.oid_act=w_oid_act;
    actividad          ACTIVIDADES%ROWTYPE;
BEGIN 
        SELECT * INTO actividad FROM ACTIVIDADES WHERE oid_act=w_oid_act;
        DBMS_OUTPUT.PUT_LINE(RPAD('OID_ACT',25) || RPAD('NOMBRE',35) || RPAD('OBJETIVO',70) || RPAD('Nº VOLS REQUERIDOS',25) || 
            RPAD('TIPO ACTIVIDAD',25) || RPAD('COSTE TOTAL',25) || RPAD('COSTE INSCRIPCIÓN',25));
        
        DBMS_OUTPUT.PUT_LINE(RPAD(actividad.oid_act, 25)|| RPAD(actividad.nombre, 35) ||  RPAD(actividad.objetivo, 70) || 
            RPAD(actividad.voluntariosrequeridos, 25) || RPAD(actividad.tipo, 25) || RPAD(actividad.costetotal, 25) ||
            RPAD(actividad.costeinscripcion, 25));
            
        DBMS_OUTPUT.PUT_LINE(RPAD('DNI',25) || RPAD('NOMBRE',25) || RPAD('APELLIDOS',25) || RPAD('FECHA NACIMIENTO',25) || 
            RPAD('DIRECCIÓN',25) || RPAD('LOCALIDAD',25) || RPAD('PROVINCIA',25) || RPAD('CÓDIGO POSTAL',25) || RPAD('EMAIL',25) ||
            RPAD('TELÉFONO',25) || RPAD('OID ACTS INTERESADO',25) ||
        RPAD('PRIORIDAD PARTICIPACIÓN',25) || RPAD('OID PART ACOMPAÑADOS',25));
        FOR registro IN C LOOP
            DBMS_OUTPUT.PUT_LINE(RPAD(registro.dni, 25)|| RPAD(registro.nombre, 25) || RPAD(registro.apellidos, 25) || 
            RPAD(registro.fechanacimiento, 25) || RPAD(registro.direccion, 25) || RPAD(registro.localidad, 25) || 
            RPAD(registro.provincia, 25) || RPAD(registro.codigopostal, 25) || RPAD(registro.email, 25) || 
            RPAD(registro.telefono, 25) || RPAD(registro.oid_act, 25) || RPAD(registro.prioridadparticipacion, 25));
        END LOOP;
        CLOSE C;
END;
/

-- RF-9: HISTORIAL DE VOLUNTARIADO (NO FUNCIONA)
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE HistVol(w_OID_Vol voluntarios.oid_vol%TYPE) IS
    CURSOR C IS
        SELECT * FROM ACTIVIDADES A RIGHT JOIN COLABORACIONES C ON a.oid_act=c.oid_act RIGHT JOIN VOLUNTARIOS V 
        ON c.oid_vol=v.oid_vol WHERE v.oid_vol=w_oid_vol;
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

-- RF-10: INFORME DE PARTICIPANTES (NO FUNCIONA)
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE InformeParticipantes(w_OID_Act  actividades.oid_act%TYPE) IS
    CURSOR C IS
    SELECT * FROM PARTICIPANTES PA LEFT JOIN PERSONAS PE ON pa.dni=pe.dni  LEFT JOIN INSCRIPCIONES C ON c.oid_part=pa.oid_part
    LEFT JOIN ACTIVIDADES A ON a.oid_act=c.oid_act WHERE a.oid_act=w_oid_act;
    actividad          ACTIVIDADES%ROWTYPE;
BEGIN 
        SELECT * INTO actividad FROM ACTIVIDADES WHERE oid_act=w_oid_act;
        DBMS_OUTPUT.PUT_LINE(RPAD('OID_ACT',25) || RPAD('NOMBRE',35) || RPAD('OBJETIVO',70) || RPAD('Nº VOLS REQUERIDOS',25) || 
            RPAD('TIPO ACTIVIDAD',25) || RPAD('COSTE TOTAL',25) || RPAD('COSTE INSCRIPCIÓN',25));
        
        DBMS_OUTPUT.PUT_LINE(RPAD(actividad.oid_act, 25)|| RPAD(actividad.nombre, 35) ||  RPAD(actividad.objetivo, 70) || 
            RPAD(actividad.voluntariosrequeridos, 25) || RPAD(actividad.tipo, 25) || RPAD(actividad.costetotal, 25) ||
            RPAD(actividad.costeinscripcion, 25));
            
        DBMS_OUTPUT.PUT_LINE(RPAD('DNI',25) || RPAD('NOMBRE',25) || RPAD('APELLIDOS',25) || RPAD('FECHA NACIMIENTO',25) || 
            RPAD('DIRECCIÓN',25) || RPAD('LOCALIDAD',25) || RPAD('PROVINCIA',25) || RPAD('CÓDIGO POSTAL',25) || RPAD('EMAIL',25) ||
            RPAD('TELÉFONO',25) || RPAD('GRADO DISCAPACIDAD',25) || RPAD('OID TUTOR/REPRESENTANTE',25) || 
            RPAD('OID ACTS INTERESADO',25) || RPAD('PRIORIDAD PARTICIPACIÓN',25) || RPAD('OID INF MÉDICOS',25));
        FOR registro IN C LOOP
            DBMS_OUTPUT.PUT_LINE(RPAD(registro.dni, 25)|| RPAD(registro.nombre, 25) || RPAD(registro.apellidos, 25) || 
            RPAD(registro.fechanacimiento, 25) || RPAD(registro.direccion, 25) || RPAD(registro.localidad, 25) || 
            RPAD(registro.provincia, 25) || RPAD(registro.codigopostal, 25) || RPAD(registro.email, 25) || 
            RPAD(registro.telefono, 25) || RPAD(registro.gradodiscapacidad, 25) || RPAD(registro.oid_tut, 25) || 
            RPAD(registro.oid_act, 25) || RPAD(registro.prioridadparticipacion, 25) || RPAD(registro.oid_inf, 25));
        END LOOP;
        CLOSE C;
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






















