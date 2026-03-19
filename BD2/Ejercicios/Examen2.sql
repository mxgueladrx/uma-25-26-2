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
    IF :NEW.NUEVO = "ERROR" THEN
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

CREATE PACKAGE PK_ESTILO AS
    PROCEDURE PR_RENOMBRA_TABLAS;
END;
/

CREATE PACKAGE BODY PK_ESTILO AS
    PROCEDURE PR_RENOMBRA_TABLAS IS
        CURSOR TABLAS IS SELECT ANTERIOR FROM TB_TABLAS FOR UPDATE;
    BEGIN
        FOR C IN TABLAS LOOP
            
        END LOOP;

    END PR_RENOMBRA_TABLAS;

END;
/