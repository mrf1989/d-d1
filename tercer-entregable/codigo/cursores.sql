
-- RF-1: FICHAS DE USUARIOS

-- PARTICIPANTES
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE FichaParticipante(w_OID_Part  participantes.oid_part%TYPE) IS
    CURSOR CUR_Part IS
        SELECT * FROM PARTICIPANTES PART NATURAL JOIN PERSONAS PERS LEFT JOIN ESTAINTERESADOEN EI ON part.oid_part=ei.oid_part
        LEFT JOIN INFORMESMEDICOS IM ON part.oid_part=im.oid_part WHERE part.oid_part=w_oid_part;
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
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE FichaVoluntario(w_OID_Vol  voluntarios.oid_vol%TYPE) IS
    CURSOR CUR_Vol IS
        SELECT * FROM VOLUNTARIOS VOL NATURAL JOIN PERSONAS PERS LEFT JOIN ESTAINTERESADOEN EI ON vol.oid_vol=ei.oid_vol
        LEFT JOIN COLABORACIONES COL ON col.oid_vol=vol.oid_vol LEFT JOIN INSCRIPCIONES INS ON ins.oid_act=col.oid_act
        WHERE vol.oid_vol=w_oid_vol;
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
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE FichaPatrocinador(w_cif  patrocinios.cif%TYPE) IS
    CURSOR CUR_Patr IS
        SELECT * FROM PATROCINIOS NATURAL JOIN INSTITUCIONES WHERE cif=w_cif;
BEGIN 
        DBMS_OUTPUT.PUT_LINE(RPAD('CIF',25) || RPAD('NOMBRE',25) || RPAD('DIRECCIÓN',25) || RPAD('LOCALIDAD',25) || 
        RPAD('PROVINCIA',25) || RPAD('CÓDIGO POSTAL',25) || RPAD('EMAIL',25) || RPAD('TELÉFONO',25) ||
        RPAD('TIPO PATROCINADOR',25) || RPAD('OID FINANCIACIONES',25) || RPAD('OID ACTS FINANCIADAS',25));
        FOR registro IN CUR_Patr LOOP
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
    nombre_persona          personas.nombre%TYPE;
    nombre_tipo_donacion    tipodonaciones.nombre%TYPE;
    
    CURSOR C_DonP IS
        SELECT cantidad, valorunitario, fecha, apellidos, fechanacimiento, direccion, localidad, codigopostal, email, telefono
        FROM DONACIONES D NATURAL JOIN PERSONAS P LEFT JOIN TIPODONACIONES TD ON d.oid_tdon=td.oid_tdon WHERE p.dni=w_dni;
BEGIN 
        nombre_persona := P.NOMBRE;
        nombre_tipo_donacion := TD.NOMBRE;
        DBMS_OUTPUT.PUT_LINE(RPAD('TIPO DONACIÓN',25) || RPAD('CANTIDAD',25) || RPAD('VALOR UNITARIO',25) || RPAD('FECHA DONACIÓN',25) ||
        RPAD('NOMBRE',25) || RPAD('APELLIDOS',25) || RPAD('FECHA NACIMIENTO',25) || RPAD('DIRECCIÓN',25) ||
        RPAD('LOCALIDAD',25) || RPAD('PROVINCIA',25) || RPAD('CÓDIGO POSTAL',25) || RPAD('EMAIL',25) ||
        RPAD('TELÉFONO',25));
        FOR registro IN C_DonP LOOP
            DBMS_OUTPUT.PUT_LINE(RPAD(nombre_tipo_donacion, 25) || RPAD(registro.cantidad, 25) || RPAD(registro.valorunitario, 25) || RPAD(registro.fecha, 25) ||
            RPAD(nombre_persona, 25) || RPAD(registro.apellidos, 25) || RPAD(registro.fechanacimiento, 25) ||
            RPAD(registro.direccion, 25) || RPAD(registro.localidad, 25) || RPAD(registro.provincia, 25) || 
            RPAD(registro.codigopostal, 25) || RPAD(registro.email, 25) || RPAD(registro.telefono, 25));
        END LOOP;
END;
/


-- RF-2: VALORACIÓN DE ACTIVIDADES

-- CUESTIONARIOS DE VOLUNTARIOS
-- CUESTIONARIOS DE PARTICIPANTES


-- RF-13: INFORME DE DONACIONES POR AÑO
SET SERVEROUTPUT ON
CREATE OR REPLACE PROCEDURE DonacionesPorFecha(f1 date, f2 date) IS
    CURSOR CUR_Don IS
        SELECT * FROM DONACIONES NATURAL JOIN  TIPODONACIONES
        WHERE fecha BETWEEN f1 and f2;
BEGIN 
        DBMS_OUTPUT.PUT_LINE(RPAD('OID DONACIÓN',25) || RPAD('CANTIDAD DONADA',25) || RPAD('VALOR UNITARIO',25) || RPAD('FECHA',25) ||
        RPAD('TIPO DONACIÓN',25) || RPAD('ID DONANTE',25));
        FOR registro IN CUR_Don LOOP
            DBMS_OUTPUT.PUT_LINE(RPAD(registro.oid_don, 25)|| RPAD(registro.cantidad, 25)|| RPAD(registro.valorunitario, 25) ||
            RPAD(registro.fecha, 25) || RPAD(registro.nombre, 25) || RPAD(registro.dni, 25) || registro.cif);
        END LOOP;
END;
/

-- RF-14: INFORME DE ACTIVIDADES POR AÑO
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE ActsPorFecha(f1 date, f2 date) IS
    CURSOR CUR_Act IS
        SELECT * FROM ACTIVIDADES WHERE fechainicio BETWEEN f1 and f2;
BEGIN 
        DBMS_OUTPUT.PUT_LINE(RPAD('OID_ACT',25) || RPAD('NOMBRE',35) || RPAD('OBJETIVO',70) || RPAD('Nº VOLS REQUERIDOS',25) || 
        RPAD('TIPO ACTIVIDAD',25) || RPAD('COSTE TOTAL',25) || RPAD('COSTE INSCRIPCIÓN',25));
        FOR registro IN CUR_Act LOOP
            DBMS_OUTPUT.PUT_LINE(RPAD(registro.oid_act, 25)|| RPAD(registro.nombre, 35) ||  RPAD(registro.objetivo, 70) || 
            RPAD(registro.voluntariosrequeridos, 25) || RPAD(registro.tipo, 25) || RPAD(registro.costetotal, 25) ||
            RPAD(registro.costeinscripcion, 25));
        END LOOP;
    
END;
/






















