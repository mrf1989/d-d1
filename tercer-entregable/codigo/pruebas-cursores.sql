SET SERVEROUTPUT ON;
EXEC FichaParticipante(1);
EXEC FichaParticipante(3);
EXEC FichaVoluntario(1);
EXEC FichaVoluntario(2);
EXEC FichaPatrocinador('A87674532');
EXEC FichaPatrocinador('A33219876');
EXEC GET_CuestionariosPart(1);
EXEC GET_CuestionariosVol(1);
EXEC ListaDonantes;
EXEC Lista_Email('voluntarios');
EXEC Lista_Email('participantes');
EXEC Lista_VolAct(1);
EXEC Lista_VolAct(2);
EXEC Lista_HistVol(1);
EXEC Lista_HistVol(2);
EXEC Lista_PartAct(1);
EXEC Lista_PartAct(2);
EXEC Lista_HistPart(1);
EXEC Lista_HistPart(2);
EXEC Lista_PatrociniosAct(1);
EXEC Lista_PatrociniosAct(2);
EXEC Lista_DonTemp('01/01/2018','31/12/2018');
EXEC Lista_ActTemp('01/01/2018','31/12/2018');