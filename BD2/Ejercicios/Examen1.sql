/* Crea las TABLAS:

CREATE TABLE USUARIO( NOMBRE VARCHAR2(16) PRIMARY KEY, CLAVE VARCHAR2(16) );

CREATE TABLE HISTORIAL( NOMBRE VARCHAR2(16), CLAVE VARCHAR2(16), BAJA DATE);

CREATE TABLE VULNERABLE(NOMBRE VARCHAR2(16), FOREIGN KEY (NOMBRE) REFERENCES
USUARIO(NOMBRE)); */

DROP TABLE VULNERABLE;
DROP TABLE USUARIO;
DROP TABLE HISTORIAL;

CREATE TABLE USUARIO(NOMBRE VARCHAR2(16) PRIMARY KEY, CLAVE VARCHAR2(16));

CREATE TABLE HISTORIAL(NOMBRE VARCHAR2(16), CLAVE VARCHAR2(16), BAJA DATE);

CREATE TABLE VULNERABLE(NOMBRE VARCHAR2(16), FOREIGN KEY (NOMBRE) REFERENCES
USUARIO(NOMBRE));

/* 1. Crear un trigger que al borrar o actualizar en usuario introduzca en la tabla historial el
valor de la fila eliminada o el valor previo de la fila a la actualización, además se
incluirá como tercer atributo la fecha y hora del sistema. */

CREATE OR REPLACE TRIGGER TR_USUARIO_HISTORIAL
AFTER DELETE OR UPDATE ON USUARIO
FOR EACH ROW
BEGIN
    INSERT INTO HISTORIAL VALUES (:OLD.NOMBRE, OLD.CLAVE, SYSDATE);
END;
/

/* 2. Crear una función denominada CLAVE_VULNERABLE que recibe como argumento el
nombre de un usuario y determine si dicho usuario está repitiendo la clave actual
(coincide con una que quedó registrada en el historial). Si el usuario no está presente
en la tabla HISTORIAL se deberá lanzar la excepción de usuario (-20001,
USUARIO_INICIAL). Supondremos que este procedimiento siempre será invocado con
un usuario que existe en la tabla USUARIO. */

CREATE OR REPLACE FUNCTION CLAVE_VULNERABLE(P_NOMBRE VARCHAR2) RETURN BOOLEAN IS
    V_OLD NUMBER;
    V_NEW VARCHAR2(16);
    V_CONT NUMBER;
BEGIN
    SELECT COUNT(*) INTO V_CONT FROM HISTORIAL WHERE HISTORIAL.NOMBRE = P_NOMBRE;
    IF V_CONT <> 0 THEN
        SELECT CLAVE INTO V_NEW FROM USUARIO WHERE USUARIO.NOMBRE = P_NOMBRE;
        SELECT COUNT(*) INTO V_OLD FROM HISTORIAL WHERE HISTORIAL.NOMBRE = P_NOMBRE AND HISTORIAL.CLAVE = V_NEW;

        IF V_OLD <> 0 THEN
            RETURN TRUE;
        ELSE
            RETURN FALSE;
        END IF;
    ELSE
        RAISE_APPLICATION_ERROR(-20001, 'USUARIO_INICIAL');
    END IF;
END;
/

/* 3. Crear un procedimiento denominado DETECTA_VULNERABLE que borre toda la
información de la tabla VULNERABLE y rellene dicha tabla con la lista de usuarios que
están repitiendo claves. Este procedimiento debe hacer uso obligatorio de la función
CLAVE_VULNERABLE y si recibe la excepción USUARIO_INICIAL no debe incluirlo en la
tabla VULNERABLE (se considera que no está repitiendo clave), y debe continuar
procesando el resto de los usuarios (la excepción no debe detener el bucle de
recorrido de los usuarios). */

CREATE OR REPLACE PROCEDURE DETECTA_VULNERABLE IS
    CURSOR C_USUARIOS IS SELECT NOMBRE FROM USUARIO;
BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE VULNERABLE';
    FOR C IN C_USUARIOS LOOP
        BEGIN
            IF CLAVE_VULNERABLE(C.NOMBRE) THEN
                INSERT INTO VULNERABLE VALUES (C.NOMBRE);
            END IF;
        EXCEPTION
            WHEN OTHERS THEN
                NULL;
        END;
    END LOOP;
END;
/

/* 4. Crear un paquete denominado EXAMEN 
5. Crear un procedimiento denominado ELIMINA_USUARIO en el paquete EXAMEN que
reciba como argumento el nombre de un USUARIO y que realice las siguientes
operaciones:
a. Si el usuario no existe debe lanzar la excepción de usuario (-20002,
    USUARIO_DESCONOCIDO).
b. Desactive el trigger del punto 1. (Nota: la sentencia ALTER TRIGGER puede
    habilitar o deshabilitar un trigger con la cláusula ENABLE o DISABLE).
c. Borre el usuario de las tres tablas (cuidado con el orden de eliminación).
d. Reactive el trigger del punto 1. */

CREATE OR REPLACE PACKAGE EXAMEN AS
    PROCEDURE ELIMINA_USUARIO(P_NOMBRE VARCHAR2);
END;
/

CREATE OR REPLACE PACKAGE BODY EXAMEN AS
    PROCEDURE ELIMINA_USUARIO(P_NOMBRE VARCHAR2) IS
        V_CONT NUMBER;
    BEGIN
        SELECT COUNT(*) INTO V_CONT FROM USUARIO WHERE USUARIO.NOMBRE = P_NOMBRE;

        IF V_CONT = 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'USUARIO_DESCONOCIDO');
        END IF;

        EXECUTE IMMEDIATE 'ALTER TRIGGER TR_USUARIO_HISTORIAL DISABLE';

        DELETE FROM VULNERABLE WHERE NOMBRE = P_NOMBRE;
        DELETE FROM HISTORIAL WHERE NOMBRE = P_NOMBRE;
        DELETE FROM USUARIO WHERE NOMBRE = P_NOMBRE;

        EXECUTE IMMEDIATE 'ALTER TRIGGER TR_USUARIO_HISTORIAL ENABLE';
    END;
END;
/