SET SERVEROUTPUT ON;
EXEC FichaParticipante(1);
EXEC FichaVoluntario(1);
EXEC FichaPatrocinador('A87674532');
EXEC FichaDonante('57153559V');
EXEC DonacionesPorFecha('01/01/2018','31/12/2018');
EXEC ActsPorFecha('01/01/2018','31/12/2018');
EXEC Lista_VolAct(2);
EXEC Lista_PartAct(2);
EXEC Lista_HistVol(1);
EXEC Lista_HistPart(1);
EXEC Lista_PatrociniosAct(1);