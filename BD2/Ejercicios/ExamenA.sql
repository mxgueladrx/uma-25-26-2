-- Tabla de categorías de objetos (Espadas, Pociones, Armaduras...)
CREATE TABLE CATEGORIA (
    ID_CAT NUMBER PRIMARY KEY,
    NOMBRE_CAT VARCHAR2(50) NOT NULL
);

-- Tabla principal de objetos del juego
CREATE TABLE OBJETO (
    ID_OBJ NUMBER PRIMARY KEY,
    NOMBRE VARCHAR2(50),
    NIVEL_REQUERIDO NUMBER, -- Este será el campo para el Trigger
    PRECIO NUMBER(10,2),
    ID_CAT NUMBER,
    CONSTRAINT FK_CAT FOREIGN KEY (ID_CAT) REFERENCES CATEGORIA(ID_CAT)
);

-- Inserciones básicas
INSERT INTO CATEGORIA VALUES (1, 'ARMAS');
INSERT INTO CATEGORIA VALUES (2, 'POCIONES');
COMMIT;

/* 1. Cree un trigger llamado TR_VALIDA_NIVEL que se dispare antes de insertar 
o actualizar en la tabla OBJETO. El trigger debe comprobar que el NIVEL_REQUERIDO 
esté siempre entre 1 y 100. Si el valor está fuera de ese rango, debe lanzar la 
excepción de aplicación -20010 con el mensaje 'NIVEL FUERA DE RANGO'. */

CREATE OR REPLACE TRIGGER TR_VALIDA_NIVEL
BEFORE INSERT OR UPDATE ON OBJETO
FOR EACH ROW
BEGIN
    IF :NEW.NIVEL_REQUERIDO < 1 OR :NEW.NIVEL_REQUERIDO > 100 THEN
        RAISE_APPLICATION_ERROR(-20010, 'NIVEL FUERA DE RANGO');  
    END IF;
END;
/

/* 2. PR_ALTA_OBJETO: Recibe los datos de un objeto. Si el ID_OBJ ya existe, debe 
lanzar la excepción personalizada -20011 (OBJETO_DUPLICADO). Si no existe, realiza 
la inserción. */

CREATE OR REPLACE PROCEDURE PR_ALTA_OBJETO (P_ID_OBJ NUMBER, P_NOMBRE VARCHAR2, 
    P_NIVEL_REQUERIDO NUMBER, P_PRECIO NUMBER, P_ID_CAT NUMBER) IS

    V_CONT NUMBER;
BEGIN
    SELECT COUNT(*) INTO V_CONT FROM OBJETO WHERE P_ID_OBJ = ID_OBJ;
    IF V_CONT = 0 THEN
        INSERT INTO OBJETO VALUES (P_ID_OBJ, P_NOMBRE, P_NIVEL_REQUERIDO, P_PRECIO, P_ID_CAT);
    ELSE
        RAISE_APPLICATION_ERROR(-20011, 'OBJETO_DUPLICADO');
    END IF;
END;
/

/* 3. PR_ACTUALIZA_O_INSERTA: Recibe los datos de un objeto. Si el ID_OBJ existe, actualiza su
nombre, precio y nivel con los nuevos parámetros. Si no existe, lo inserta de cero. */

CREATE OR REPLACE PROCEDURE PR_ACTUALIZA_O_INSERTA (P_ID_OBJ NUMBER, P_NOMBRE VARCHAR2, 
    P_NIVEL_REQUERIDO NUMBER, P_PRECIO NUMBER, P_ID_CAT NUMBER) IS

    V_CONT NUMBER;
BEGIN
    SELECT COUNT(*) INTO V_CONT FROM OBJETO WHERE P_ID_OBJ = ID_OBJ;
    IF V_CONT = 0 THEN
        INSERT INTO OBJETO VALUES (P_ID_OBJ, P_NOMBRE, P_NIVEL_REQUERIDO, P_PRECIO, P_ID_CAT);
    ELSE
        UPDATE OBJETO
        SET NOMBRE = P_NOMBRE, PRECIO = P_PRECIO, NIVEL_REQUERIDO = P_NIVEL_REQUERIDO
        WHERE ID_OBJ = P_ID_OBJ;
    END IF;
END;
/

/* 4. PR_BORRADO_SEGURO: Recibe un ID_OBJ. Si el objeto existe, lo borra. Si no existe, lanza 
la excepción -20012 (ERROR_BORRADO_INEXISTENTE). */

CREATE OR REPLACE PROCEDURE PR_BORRADO_SEGURO (P_ID_OBJ NUMBER) IS

    V_CONT NUMBER;
BEGIN
    SELECT COUNT(*) INTO V_CONT FROM OBJETO WHERE P_ID_OBJ = ID_OBJ;
    IF V_CONT = 0 THEN
        RAISE_APPLICATION_ERROR(-20012, 'ERROR_BORRADO_INEXISTENTE');
    ELSE
        DELETE FROM OBJETO WHERE ID_OBJ = P_ID_OBJ;
    END IF;
END;
/

/* 5. PR_INFORME_CATEGORIAS (El del Cursor): Este procedimiento debe usar obligatoriamente un 
cursor para recorrer la tabla CATEGORIA. Para cada categoría, debe contar cuántos objetos hay 
asociados en la tabla OBJETO e imprimir por pantalla (usando DBMS_OUTPUT) una frase tipo: "La 
categoría [Nombre] tiene [X] objetos".*/

SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE PR_INFORME_CATEGORIAS IS

    CURSOR C_CATEGORIA IS SELECT * FROM CATEGORIA;
    V_CONT NUMBER;
BEGIN
    FOR C IN C_CATEGORIA LOOP
        SELECT COUNT(*) INTO V_CONT FROM OBJETO WHERE ID_CAT = C.ID_CAT;
        DBMS_OUTPUT.PUT_LINE('La categoría ' || C.NOMBRE_CAT || ' tiene ' || V_CONT || ' objetos');
    END LOOP;
END;
/

/* 6. Cree una función llamada FN_CONTAR_CAROS que reciba un PRECIO_MINIMO (un número) y 
devuelva el número total de objetos en la tabla OBJETO cuyo precio sea estrictamente mayor 
al parámetro recibido. */

CREATE OR REPLACE FUNCTION FN_CONTAR_CAROS (P_PRECIO_MINIMO NUMBER) RETURN NUMBER IS

    V_CONT NUMBER := 0;
BEGIN
    SELECT COUNT(*) INTO V_CONT FROM OBJETO WHERE PRECIO > P_PRECIO_MINIMO;
    RETURN V_CONT;
END;
/
