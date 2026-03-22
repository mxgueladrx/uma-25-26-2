/* 1. Cree una tabla llamada TB_OBJETOS con los siguientes atributos: NOMBRE, CODIGO, FECHA_CREACION, 
FECHA_MODIFICACION, TIPO, ESQUEMA_ORIGINAL. Recorra la vista ALL_OBJECTS y rellene esta tabla con 
los datos que se aportan en la vista. Use un cursor y no una única sentencia INSERT. */

DROP TABLE TB_OBJETOS;
CREATE TABLE TB_OBJETOS (NOMBRE VARCHAR2(50), CODIGO VARCHAR2(50), FECHA_CREACION DATE, 
FECHA_MODIFICACION DATE, TIPO VARCHAR2(50), ESQUEMA_ORIGINAL VARCHAR2(50));

/* 2. Cree una tabla TB_ESTILO con los siguientes atributos: TIPO_OBJETO, PREFIJO. En esta tabla se guardan 
unas normas de estilo de modo que a cada tipo de objeto le corresponde un prefijo en su identificador. 
Así por ejemplo guardamos la tupla ('PROCEDURE','PR_') para indicar que un nombre correcto de 
procedimiento es PR_HOLA_MUNDO. Pruebe con VIEW, V_, TRIGGER, TR_ y SEQUENCE, SQ_. */

DROP TABLE TB_ESTILO;
CREATE TABLE TB_ESTILO (TIPO_OBJETO VARCHAR2(50), PREFIJO VARCHAR2(50));

INSERT INTO TB_ESTILO VALUES ('PROCEDURE', 'PR_');
INSERT INTO TB_ESTILO VALUES ('VIEW', 'V_');
INSERT INTO TB_ESTILO VALUES ('TRIGGER', 'TR_');
INSERT INTO TB_ESTILO VALUES ('SEQUENCE', 'SQ_');
COMMIT;

/* 3. Cree un procedimiento llamado PR_COMPROBAR(P_ESQUEMA IN VARCHAR2) que recorre la tabla TB_OBJETOS y 
comprueba si se cumplen las normas de estilo según la tabla TB_ESTILO. El parámetro que recibe es el 
identificador del esquema sobre el que queremos comprobar las normas. Si no se especifica, se comprueba
en todos. Extienda el esquema de la tabla TB_OBJETOS en dos atributos: ESTADO y NOMBRE_CORRECTO de modo
que se pueda guardar si un objeto es CORRECTO o INCORRECTO según las normas de estilo y dando en el caso
de que no sea correcto un identificador con el prefijo adecuado. El nuevo identificador se calcula 
anteponiendo el prefijo correcto al identificador antiguo. Si el identificador nuevo excede el tamaño
del OBJECT_NAME de Oracle, entonces pode el nuevo identificador por la derecha. Use un cursor de 
actualización para realizar este procedimiento. */

SELECT * FROM ALL_TABLES;

CREATE OR REPLACE PROCEDURE PR_COMPROBAR(P_ESQUEMA VARCHAR2) IS
BEGIN

END;

/* 4. Crear un procedimiento llamado PR_COMPROBAR_INCORRECTO(P_ESQUEMA IN VARCHAR2), similar al anterior pero 
que cumple las siguiente condición adicional. Únicamente insertará en TB_OBJETOS aquellos objetos que 
requieren ser renombrados. Además NO realizará un commit final. */



/* 5. Genere un procedimiento nuevo denominado PR_SEGURO(P_ESQUEMA IN VARCHAR2). Este procedimiento comenzará 
obligatoriamente lanzando un commit. Posteriormente comprueba que P_ESQUEMA existe. Si no es así lanza 
una excepción de código (-20016,'Esquema no existe'). Si por otro lado P_ESQUEMA sí existe, debe borrar 
TB_OBJETOS, invocar a PR_COMPROBAR_INCORRECTO, comprobar si TB_OBJETOS tiene algún objeto que requiera 
ser renombrado. Si no es necesario renombrar nada realizamos un rollback y finalizamos normalmente. Si sí 
es necesario renombrar algo entonces realizamos un rollback y lanzamos una excepción con código 
(-20017,'Existen objetos por renombrar'). */

