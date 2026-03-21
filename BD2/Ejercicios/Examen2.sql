/* Crea las siguientes tablas:

CREATE TABLE TB_TABLAS (ANTERIOR VARCHAR2(30) PRIMARY KEY, NUEVO
VARCHAR2(30), FECHA DATE);

CREATE TABLE TB_VISTAS (ANTERIOR VARCHAR2(30) PRIMARY KEY, NUEVO
VARCHAR2(30), FECHA DATE);

CREATE TABLE TB_ERRORES (USUARIO VARCHAR2(30), OBJETO
VARCHAR2(30), FECHA DATE);

CREATE TABLE A1 (CODIGO NUMBER PRIMARY KEY, NOMBRE
VARCHAR2(50));

CREATE TABLE A2 (CODIGO NUMBER PRIMARY KEY, NOMBRE
VARCHAR2(50));

CREATE TABLE A3 (CODIGO NUMBER PRIMARY KEY, NOMBRE
VARCHAR2(50));

Ejecuta:

Insert into TB_TABLAS(anterior) values 'A1';
Insert into TB_TABLAS(anterior) values 'A3';
Insert into TB_TABLAS(anterior) values 'A2';
COMMIT; */

DROP TABLE TB_TABLAS;
DROP TABLE TB_VISTAS;
DROP TABLE TB_ERRORES;
DROP TABLE A1;
DROP TABLE A2;
DROP TABLE A3;

CREATE TABLE TB_TABLAS (ANTERIOR VARCHAR2(30) PRIMARY KEY, NUEVO
VARCHAR2(30), FECHA DATE);

CREATE TABLE TB_VISTAS (ANTERIOR VARCHAR2(30) PRIMARY KEY, NUEVO
VARCHAR2(30), FECHA DATE);

CREATE TABLE TB_ERRORES (USUARIO VARCHAR2(30), OBJETO
VARCHAR2(30), FECHA DATE);

CREATE TABLE A1 (CODIGO NUMBER PRIMARY KEY, NOMBRE
VARCHAR2(50));

CREATE TABLE A2 (CODIGO NUMBER PRIMARY KEY, NOMBRE
VARCHAR2(50));

CREATE TABLE A3 (CODIGO NUMBER PRIMARY KEY, NOMBRE
VARCHAR2(50));

INSERT INTO TB_TABLAS(anterior) values ('A1');
INSERT INTO TB_TABLAS(anterior) values ('A3');
INSERT INTO TB_TABLAS(anterior) values ('A2');
COMMIT;

/* Ejercicio 1 (1 puntos). Crea un trigger que cuando se modifique la columna NUEVO de la tabla
TB_VISTAS con la palabra ERROR, se inserte en la tabla TB_ERRORES el usuario que ha
ejecutado la operación, el nombre de la vista (contenido de la columna ANTERIOR) y la fecha
del sistema. */

CREATE OR REPLACE TRIGGER TR_VISTAS_ERRORES
AFTER UPDATE OF NUEVO ON TB_VISTAS
FOR EACH ROW
BEGIN
    IF :NEW.NUEVO = 'ERROR' THEN
        INSERT INTO TB_ERRORES VALUES (USER, :OLD.ANTERIOR, SYSDATE);
    END IF;
END;
/

/* Ejercicio 2 (1 puntos). Crea un paquete denominado PK_ESTILO con un procedimiento
denominado PR_RENOMBRA_TABLAS que no recibe parámetros. El procedimiento debe
recorrer la tabla TB_TABLAS y buscar la tabla que aparece en la columna ANTERIOR. Si la
cadena no comienza con las letras TB_ entonces el procedimiento debe renombrarla
poniéndole el prefijo TB_. Así, por ejemplo, si aparece A1, debe ejecutar la instrucción RENAME
A1 TO TB_A1. Además, en la tabla TB_TABLAS se guardará el nombre nuevo y la fecha en
la que se ha hecho el cambio. */

/* Ejercicio 3 (1 puntos). Dentro del paquete PK_ESTILO crea con un procedimiento similar al
anterior denominado PR_DESHACER que no recibe parámetros. El procedimiento debe
recorrer la tabla TB_TABLAS y buscar la tabla que aparece en la columna NUEVO. El
procedimiento debe renombrarla con el nombre anterior. Así, por ejemplo, si aparece C1 en
anterior y TB_C1 en nuevo, debe ejecutar la instrucción RENAME TB_C1 TO C1. Además,
en la tabla TB_TABLAS el valor NUEVO se pondrá a NULL y se almacena la fecha en la que se
ha hecho el cambio. Si el cambio no se puede hacer, se controlará la excepción y se modificará
la columna NUEVO con palabra ‘ERROR’ en la fila correspondiente a la vista que ha dado el
error. */

CREATE OR REPLACE PACKAGE PK_ESTILO AS
    PROCEDURE PR_RENOMBRA_TABLAS;
    PROCEDURE PR_DESHACER;
END;
/

CREATE OR REPLACE PACKAGE BODY PK_ESTILO AS
    PROCEDURE PR_RENOMBRA_TABLAS IS
        CURSOR C_TABLAS IS SELECT * FROM TB_TABLAS;
        V_NUEVO VARCHAR2(30);
    BEGIN
        FOR C IN C_TABLAS LOOP
            IF C.ANTERIOR NOT LIKE 'TB_%' AND C.NUEVO IS NULL THEN
                V_NUEVO := 'TB_' || C.ANTERIOR;
                EXECUTE IMMEDIATE 'RENAME ' || C.ANTERIOR || ' TO ' || V_NUEVO;

                UPDATE TB_TABLAS
                SET NUEVO = V_NUEVO, FECHA = SYSDATE
                WHERE ANTERIOR = C.ANTERIOR;
                COMMIT;
            END IF;
        END LOOP;
    END PR_RENOMBRA_TABLAS;

    PROCEDURE PR_DESHACER IS
        CURSOR C_TABLAS IS SELECT * FROM TB_TABLAS;
    BEGIN
        FOR C IN C_TABLAS LOOP
            BEGIN
                EXECUTE IMMEDIATE 'RENAME ' || C.NUEVO || ' TO ' || C.ANTERIOR;

                UPDATE TB_TABLAS
                SET NUEVO = NULL, FECHA = SYSDATE
                WHERE ANTERIOR = C.ANTERIOR;
            EXCEPTION
                WHEN OTHERS THEN
                    UPDATE TB_TABLAS
                    SET NUEVO = 'ERROR', FECHA = SYSDATE
                    WHERE ANTERIOR = C.ANTERIOR;
            END;
            COMMIT;
        END LOOP;
    END PR_DESHACER;
END;
/

SELECT * FROM TB_TABLAS;
SELECT * FROM USER_TABLES;
EXECUTE PK_ESTILO.PR_RENOMBRA_TABLAS;
EXECUTE PK_ESTILO.PR_DESHACER;