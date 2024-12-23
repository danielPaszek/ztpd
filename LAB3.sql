CREATE TABLE DOKUMENTY (
  ID NUMBER(12) PRIMARY KEY,
  DOKUMENT CLOB
);

DECLARE 
X CLOB;
BEGIN
    FOR I IN 1..10000 LOOP
        X := X || 'Oto tekst. ';
    END LOOP;
    INSERT INTO DOKUMENTY VALUES (1, X);
END;

SELECT * FROM DOKUMENTY;
SELECT UPPER(DOKUMENT) FROM DOKUMENTY;
SELECT LENGTH(DOKUMENT) FROM DOKUMENTY;
SELECT DBMS_LOB.GETLENGTH(DOKUMENT) FROM DOKUMENTY;
SELECT SUBSTR(DOKUMENT, 5, 1000) FROM DOKUMENTY;
SELECT DBMS_LOB.SUBSTR(DOKUMENT, 1000, 5) FROM DOKUMENTY;

INSERT INTO DOKUMENTY VALUES (2, EMPTY_CLOB());

INSERT INTO DOKUMENTY VALUES (3, NULL);

DECLARE
V_BFILE BFILE;
V_CLOB CLOB;
V_LEN NUMBER;
V_OFFSET NUMBER := 1;
V_OFFSET2 NUMBER := 1;
V_LANG INTEGER := 0;
V_WARN INTEGER := NULL;
BEGIN
    SELECT DOKUMENT INTO V_CLOB FROM DOKUMENTY WHERE ID = 2 FOR UPDATE;
    V_BFILE := BFILENAME('TPD_DIR', 'dokument.txt');
    DBMS_LOB.OPEN(v_bfile, DBMS_LOB.LOB_READONLY);
    V_LEN := DBMS_LOB.GETLENGTH(v_bfile);
    DBMS_LOB.LOADCLOBFROMFILE(V_CLOB, V_BFILE, V_LEN, V_OFFSET, V_OFFSET2, 0, V_LANG, V_WARN);
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('OK');
END;
SELECT * FROM DOKUMENTY;

UPDATE DOKUMENTY SET DOKUMENT = TO_CLOB(BFILENAME('TPD_DIR', 'dokument.txt')) WHERE ID = 3;

SELECT * FROM DOKUMENTY;
SELECT ID, LENGTH(DOKUMENT) FROM DOKUMENTY;

DROP TABLE DOKUMENTY;

CREATE OR REPLACE PROCEDURE CLOB_CENSOR(
    P_CLOB IN OUT CLOB,
    P_TEXT IN VARCHAR2
) AS
    V_POS INTEGER;
BEGIN
    LOOP
        V_POS := INSTR(P_CLOB, P_TEXT);
        EXIT WHEN V_POS = 0;
        DBMS_LOB.WRITE(P_CLOB, LENGTH(P_TEXT), V_POS, RPAD('.', LENGTH(P_TEXT), '.'));
    END LOOP;
END;

DECLARE
ASD CLOB := TO_CLOB('ASDDDDD');
BEGIN
CLOB_CENSOR(ASD, 'D');
DBMS_OUTPUT.PUT_LINE(ASD);
END;

CREATE TABLE BIOGRAPHIES_COPY AS SELECT * FROM ZTPD.BIOGRAPHIES;
DECLARE
  V_CLOB CLOB;
BEGIN
    SELECT BIO INTO V_CLOB FROM BIOGRAPHIES_COPY WHERE PERSON = 'Jara Cimrman' FOR UPDATE;
    CLOB_CENSOR(V_CLOB, 'Cimrman');
    UPDATE BIOGRAPHIES_COPY SET BIO = V_CLOB WHERE PERSON = 'Jara Cimrman';
    COMMIT;
END;

SELECT * FROM BIOGRAPHIES_COPY;
DROP TABLE BIOGRAPHIES_COPY;


