/* 1. Crea una tabla que se llame PIEZA (codigo number, nombre varchar2(50), descripcion 
varchar2(100), peso number(5,2)); */

CREATE TABLE PIEZA (CODIGO NUMBER, 
                    NOMBRE VARCHAR2(50), 
                    DESCRIPCION VARCHAR2(100),
                    PESO NUMBER(5,2));

/* 2. Crea un trigger que cuando se inserte o actualice PIEZA comprueba que peso es mayor 
que 0. Si no es así lanza la excepción de aplicación (-20007, 'PESO NEGATIVO'). */

CREATE OR REPLACE TRIGGER TR_PIEZA
BEFORE INSERT OR UPDATE ON PIEZA
FOR EACH ROW
BEGIN
    IF :NEW.PESO <= 0 THEN
        RAISE_APPLICATION_ERROR(-20007, 'PESO NEGATIVO');
    END IF;
END;
/

INSERT INTO PIEZA VALUES (1, 'PIEZA1', 'PIEZA1', 5);
INSERT INTO PIEZA VALUES (1, 'PIEZA1', 'PIEZA1', -5);
TRUNCATE TABLE PIEZA;

/* 3. Crea un procedimiento PR_INSERTA_PIEZA que recibe como parámetro los valores de la 
pieza. Si el peso es 0, el procedimiento lanza la excepción de aplicación (-20008, 'PESO 
CERO INCORRECTO'). En otro caso, inserta una fila en la tabla PIEZA. Si se proceduce la 
excepción que intente insertar con el valor de peso multiplicado por -1.  */

CREATE OR REPLACE PROCEDURE PR_INSERTA_PIEZA(P_CODIGO NUMBER, P_NOMBRE VARCHAR2, P_DESCRIPCION VARCHAR2, P_PESO NUMBER) IS
BEGIN
    IF P_PESO = 0 THEN
        RAISE_APPLICATION_ERROR(-20008, 'PESO CERO INCORRECTO');
    ELSE
        INSERT INTO PIEZA VALUES (P_CODIGO, P_NOMBRE, P_DESCRIPCION, P_PESO);
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -20007 THEN
            INSERT INTO PIEZA VALUES (P_CODIGO, P_NOMBRE, P_DESCRIPCION, P_PESO * -1);
        ELSE
            RAISE;
        END IF;
END;
/

TRUNCATE TABLE PIEZA;
EXECUTE PR_INSERTA_PIEZA(1, 'PIEZA1', 'PIEZA1', 5);
EXECUTE PR_INSERTA_PIEZA(1, 'PIEZA1', 'PIEZA1', 0);
EXECUTE PR_INSERTA_PIEZA(2, 'PIEZA2', 'PIEZA2', -8);
SELECT * FROM PIEZA;