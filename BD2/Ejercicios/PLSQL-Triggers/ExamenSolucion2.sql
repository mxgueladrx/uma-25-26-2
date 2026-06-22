/* Cree dos tablas:

·MOVIMIENTOS con el siguiente esquema:

Pieza: número de la pieza
Fecha: fecha del movimiento. La clave primaria es pieza y Fecha
Almacen: VARCHAR2(15)

·COPIA_MOVIMIENTOS que tenga el mismo esquema pero sin clave primaria */

CREATE TABLE MOVIMIENTOS (PIEZA NUMBER, FECHA DATE, ALMACEN VARCHAR2(15), PRIMARY KEY (PIEZA, FECHA));

CREATE TABLE COPIA_MOVIMIENTOS (PIEZA NUMBER, FECHA DATE, ALMACEN VARCHAR2(15));

/* Cree una vista MOVIMIENTOS_HOY con los movimientos que se han realizado en el día de hoy (día mes y año) */

CREATE OR REPLACE VIEW MOVIMIENTOS_HOY AS
SELECT * FROM MOVIMIENTOS WHERE FECHA = SYSDATE;

/* 1.Cree un trigger llamado TR_COPIA_MOV que mantenga una copia de las filas que se van actualizando en la 
tabla de MOVIMIENTOS. Es decir, cada vez que se inserte, borre o actualice MOVIMIENTOS se hará también 
sobre COPIA_MOVIMIENTOS. */

CREATE OR REPLACE TRIGGER TR_COPIA_MOV
AFTER INSERT OR UPDATE OR DELETE ON MOVIMIENTOS
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO COPIA_MOVIMIENTOS VALUES (:NEW.PIEZA, :NEW.FECHA, :NEW.ALMACEN);
    ELSIF UPDATING THEN
        UPDATE COPIA_MOVIMIENTOS SET PIEZA = :NEW.PIEZA, FECHA = :NEW.FECHA, ALMACEN = :NEW.ALMACEN WHERE PIEZA = :OLD.PIEZA AND FECHA = :OLD.FECHA;
    ELSE
        DELETE FROM COPIA_MOVIMIENTOS WHERE PIEZA = :OLD.PIEZA AND FECHA = :OLD.FECHA;
    END IF;
END;
/

/* 2.Cree un trigger de sustitución TR_VISTA sobre la vista MOVIMIENTOS_HOY que inserte, borre o actualice 
sobre COPIA_MOVIMIENTOS en lugar de sobre la vista. */

CREATE OR REPLACE TRIGGER TR_VISTA
INSTEAD OF INSERT OR UPDATE OR DELETE ON MOVIMIENTOS_HOY
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO COPIA_MOVIMIENTOS VALUES (:NEW.PIEZA, :NEW.FECHA, :NEW.ALMACEN);
    ELSIF UPDATING THEN
        UPDATE COPIA_MOVIMIENTOS SET PIEZA = :NEW.PIEZA, FECHA = :NEW.FECHA, ALMACEN = :NEW.ALMACEN WHERE PIEZA = :OLD.PIEZA AND FECHA = :OLD.FECHA;
    ELSE
        DELETE FROM COPIA_MOVIMIENTOS WHERE PIEZA = :OLD.PIEZA AND FECHA = :OLD.FECHA;
    END IF;
END;
/

-- -----------------------------------------------------------------------------------------------------

/* Cree dos tablas, una llamada INFO_TRIGGERS que tenga el siguiente esquema:

NOMBRE: Nombre del TRIGGER PRIMARY KEY
TABLA: Nombre de la tabla desde donde se dispara
VALIDO: CHAR(1) Indica si el TRIGGER está activo CHECK (CAMBIADO IN ('S','N'))

Nota: Observe que bajo diferentes acciones, desde una misma tabla pueden dispararse varios TRIGGERS.

y otra llamada INFO_TABLAS que tenga el siguiente esquema:

NOMBRE Nombre de la tabla PRIMARY KEY */

CREATE TABLE INFO_TABLAS (NOMBRE VARCHAR2(20) PRIMARY KEY);
CREATE TABLE INFO_TRIGGERS (NOMBRE VARCHAR2(20) PRIMARY KEY, TABLA VARCHAR2(20), FOREIGN KEY (TABLA) REFERENCES INFO_TABLAS(NOMBRE), VALIDO CHAR(1) CHECK (VALIDO IN ('S', 'N')));

/* Cree un paquete llamado PKG_MANIPULA que tiene dos procedimientos: */

/* ·PR_INSERTA_TRIGGER (P_NOMBRE IN VARCHAR2, P_TABLA IN VARCHAR2, P_VALIDO IN VARCHAR2) que realiza una 
inserción en la tabla INFO_TRIGGERS con esos tres parámetros. Realice la confirmación de la transacción en 
el mismo procedimiento. El procedimiento no tiene control de errores. */

/* ·Dé de alta una restricción de FOREIGN KEY desde el atributo TABLA de INFO_TRIGGERS hacia INFO_TABLA. 
Añada un procedimiento al paquete llamado PR_INSERTA_TRIGGER_2 (P_NOMBRE IN VARCHAR2, P_TABLA IN VARCHAR2, 
P_VALIDO IN VARCHAR2) que trata de insertar sobre INFO_TRIGGERS pero si falla la inserción por violación de 
la clave foránea anterior, entonces pasa a la sección de excepciones, donde se insertará la tabla en INFO_TABLA 
y luego se llamará al procedimiento PR_INSERTA_TRIGGER para reintentar la inserción, esta vez sin control de 
excepciones. El procedimiento PR_INSERTA_TRIGGER_2 sólo debe controlar los errores producidos por violación de 
la restricción señalada, dejando que se propague el resto. */

CREATE OR REPLACE PACKAGE PKG_MANIPULA AS
    PROCEDURE PR_INSERTA_TRIGGER (P_NOMBRE VARCHAR2, P_TABLA VARCHAR2, P_VALIDO VARCHAR2);
    PROCEDURE PR_INSERTA_TRIGGER_2 (P_NOMBRE VARCHAR2, P_TABLA VARCHAR2, P_VALIDO VARCHAR2);
END;
/

CREATE OR REPLACE PACKAGE BODY PKG_MANIPULA AS
    PROCEDURE PR_INSERTA_TRIGGER (P_NOMBRE VARCHAR2, P_TABLA VARCHAR2, P_VALIDO VARCHAR2) IS
    BEGIN
        INSERT INTO INFO_TRIGGERS VALUES (P_NOMBRE, P_TABLA, P_VALIDO);
        COMMIT;
    END;

    PROCEDURE PR_INSERTA_TRIGGER_2 (P_NOMBRE VARCHAR2, P_TABLA VARCHAR2, P_VALIDO VARCHAR2) IS
    BEGIN
        INSERT INTO INFO_TRIGGERS VALUES (P_NOMBRE, P_TABLA, P_VALIDO);
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE = -02291 THEN
                INSERT INTO INFO_TABLAS VALUES (P_TABLA);
                PR_INSERTA_TRIGGER(P_NOMBRE, P_TABLA, P_VALIDO);
            ELSE
                RAISE;
            END IF;
    END;
END;
/