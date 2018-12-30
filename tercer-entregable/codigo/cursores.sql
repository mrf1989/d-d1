
-- RF-1: FICHAS DE USUARIOS

-- PARTICIPANTES
SET SERVEROUTPUT ON
DECLARE
    CURSOR CUR_Part IS
        SELECT * FROM PARTICIPANTES PART NATURAL JOIN PERSONAS PERS LEFT JOIN ESTAINTERESADOEN EI ON part.oid_part=ei.oid_part
        LEFT JOIN INFORMESMEDICOS IM ON part.oid_part=im.oid_part;
        registro                CUR_Part%ROWTYPE;
BEGIN 
        OPEN CUR_Part;
        DBMS_OUTPUT.PUT_LINE(RPAD('DNI',25) || RPAD('NOMBRE',25) || RPAD('APELLIDOS',25) || RPAD('FECHA NACIMIENTO',25) || 
        RPAD('DIRECCIÓN',25) || RPAD('LOCALIDAD',25) || RPAD('PROVINCIA',25) || RPAD('CÓDIGO POSTAL',25) || RPAD('EMAIL',25) ||
        RPAD('TELÉFONO',25) || RPAD('GRADO DISCAPACIDAD',25) || RPAD('OID TUTOR/REPRESENTANTE',25) || 
        RPAD('OID ACTS INTERESADO',25) || RPAD('PRIORIDAD PARTICIPACIÓN',25) || RPAD('OID INF MÉDICOS',25));
        LOOP
            FETCH CUR_Part INTO registro;
            EXIT WHEN CUR_Part%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(RPAD(registro.dni, 25)|| RPAD(registro.nombre, 25) || RPAD(registro.apellidos, 25) || 
            RPAD(registro.fechanacimiento, 25) || RPAD(registro.direccion, 25) || RPAD(registro.localidad, 25) || 
            RPAD(registro.provincia, 25) || RPAD(registro.codigopostal, 25) || RPAD(registro.email, 25) || 
            RPAD(registro.telefono, 25) || RPAD(registro.gradodiscapacidad, 25) || RPAD(registro.oid_tut, 25) || 
            RPAD(registro.oid_act, 25) || RPAD(registro.prioridadparticipacion, 25) || RPAD(registro.oid_inf, 25));
        END LOOP;
        CLOSE CUR_Part;
END;
/

-- VOLUNTARIOS
SET SERVEROUTPUT ON
DECLARE
    CURSOR CUR_Vol IS
        SELECT * FROM VOLUNTARIOS VOL NATURAL JOIN PERSONAS PERS LEFT JOIN ESTAINTERESADOEN EI ON vol.oid_vol=ei.oid_vol
        LEFT JOIN COLABORACIONES COL ON col.oid_vol=vol.oid_vol LEFT JOIN INSCRIPCIONES INS ON ins.oid_act=col.oid_act;
        registro                CUR_Vol%ROWTYPE;
BEGIN 
        OPEN CUR_Vol;
        DBMS_OUTPUT.PUT_LINE(RPAD('DNI',25) || RPAD('NOMBRE',25) || RPAD('APELLIDOS',25) || RPAD('FECHA NACIMIENTO',25) || 
        RPAD('DIRECCIÓN',25) || RPAD('LOCALIDAD',25) || RPAD('PROVINCIA',25) || RPAD('CÓDIGO POSTAL',25) || RPAD('EMAIL',25) ||
        RPAD('TELÉFONO',25) || RPAD('OID ACTS INTERESADO',25) ||
        RPAD('PRIORIDAD PARTICIPACIÓN',25) || RPAD('OID PART ACOMPAÑADOS',25));
        LOOP
            FETCH CUR_Vol INTO registro;
            EXIT WHEN CUR_Vol%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(RPAD(registro.dni, 25)|| RPAD(registro.nombre, 25) || RPAD(registro.apellidos, 25) || 
            RPAD(registro.fechanacimiento, 25) || RPAD(registro.direccion, 25) || RPAD(registro.localidad, 25) || 
            RPAD(registro.provincia, 25) || RPAD(registro.codigopostal, 25) || RPAD(registro.email, 25) || 
            RPAD(registro.telefono, 25) || RPAD(registro.oid_act, 25) || RPAD(registro.prioridadparticipacion, 25));
        END LOOP;
        CLOSE CUR_Vol;
END;
/

-- PATROCINADORES
SET SERVEROUTPUT ON
DECLARE
    CURSOR CUR_Patr IS
        SELECT * FROM PATROCINIOS NATURAL JOIN INSTITUCIONES;
        registro                CUR_Patr%ROWTYPE;
BEGIN 
        OPEN CUR_Patr;
        DBMS_OUTPUT.PUT_LINE(RPAD('CIF',25) || RPAD('NOMBRE',25) || RPAD('DIRECCIÓN',25) || RPAD('LOCALIDAD',25) || 
        RPAD('PROVINCIA',25) || RPAD('CÓDIGO POSTAL',25) || RPAD('EMAIL',25) || RPAD('TELÉFONO',25) ||
        RPAD('TIPO PATROCINADOR',25) || RPAD('OID FINANCIACIONES',25) || RPAD('OID ACTS FINANCIADAS',25));
        WHILE CUR_Patr%FOUND LOOP
            FETCH CUR_Patr INTO registro;
            EXIT WHEN CUR_Patr%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(RPAD(registro.cif, 25)|| RPAD(registro.nombre, 25) ||  RPAD(registro.direccion, 25) || 
            RPAD(registro.localidad, 25) || RPAD(registro.provincia, 25) || RPAD(registro.codigopostal, 25) ||
            RPAD(registro.email, 25) || RPAD(registro.telefono, 25) || RPAD('*falta', 25) || RPAD(registro.oid_fin, 25)
             || RPAD(registro.oid_act, 25));
        END LOOP;
        CLOSE CUR_Patr;
END;
/


-- RF-13: INFORME DE DONACIONES POR AÑO
SET SERVEROUTPUT ON
DECLARE
    CURSOR CUR_Don IS
        SELECT * FROM DONACIONES D NATURAL JOIN TIPODONACIONES TD LEFT JOIN PERSONAS  P ON d.dni=p.dni 
        LEFT JOIN INSTITUCIONES I ON d.cif=i.cif WHERE d.fecha BETWEEN '01/01/2018' AND '31/12/2018';
        registro                CUR_Act%ROWTYPE;
BEGIN 
        OPEN CUR_Don;
        DBMS_OUTPUT.PUT_LINE(RPAD('OID DONACIÓN',25) || RPAD('CANTIDAD DONADA',25) || RPAD('VALOR UNITARIO',25) || RPAD('FECHA',25) ||
        RPAD('TIPO DONACIÓN',25) || RPAD('ID DONANTE',25));
        WHILE CUR_Don%FOUND LOOP
            FETCH CUR_Don INTO registro;
            EXIT WHEN CUR_Don%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(RPAD(registro.oid_don, 25)|| RPAD(registro.cantidad, 25)|| RPAD(registro.valorunitario, 25) ||
            RPAD(registro.fecha, 25) || RPAD(registro.nombre, 25) || RPAD(registro.dni, 25) || registro.cif);
        END LOOP;
        CLOSE CUR_Don;
END;
/

-- RF-14: INFORME DE ACTIVIDADES POR AÑO
SET SERVEROUTPUT ON
DECLARE
    CURSOR CUR_Act IS
        SELECT * FROM ACTIVIDADES WHERE fechainicio BETWEEN '01/01/2018' AND '31/12/2018';
        registro                CUR_Act%ROWTYPE;
BEGIN 
        OPEN CUR_Act;
        DBMS_OUTPUT.PUT_LINE(RPAD('OID_ACT',25) || RPAD('NOMBRE',25) || RPAD('OBJETIVO',25) || RPAD('Nº VOLUNTARIOS REQUERIDOS',25) || 
        RPAD('TIPO ACTIVIDAD',25) || RPAD('COSTE TOTAL',25) || RPAD('COSTE INSCRIPCIÓN',25));
        WHILE CUR_Act%FOUND LOOP
            FETCH CUR_Act INTO registro;
            EXIT WHEN CUR_Act%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(RPAD(registro.oid_act, 25)|| RPAD(registro.nombre, 25) ||  RPAD(registro.objetivo, 25) || 
            RPAD(registro.voluntariosrequeridos, 25) || RPAD(registro.tipo, 25) || RPAD(registro.costetotal, 25) ||
            RPAD(registro.costeinscripcion, 25));
        END LOOP;
        CLOSE CUR_Act;
END;
/






















