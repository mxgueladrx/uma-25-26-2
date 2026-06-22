------------------------- EJECUTAR COMO SYSTEM -------------------------

-- Ejercicio 1

SHOW USER;

CREATE USER DBA_MIGUEL IDENTIFIED BY "dba_miguel";
GRANT DBA TO DBA_MIGUEL;

------------------------- EJECUTAR COMO DBA_MIGUEL -------------------------

SHOW USER;

-- Ejercicio 2

CREATE TABLE PRUEBA(
    CLAVE NUMBER(16, 0) PRIMARY KEY,
    DISPERSO NUMBER(16, 0),
    CONCENTRADO NUMBER(16, 0),
    IDISPERSO NUMBER(16, 0),
    ICONCENTRADO NUMBER(16, 0),
    BCONCENTRADO NUMBER(16, 0)
);

DECLARE
    I NUMBER(16, 0);
    R NUMBER(16, 0);
BEGIN
    FOR I IN 1..500000 LOOP
        R := DBMS_RANDOM.VALUE(1, 1000000000);
        INSERT INTO PRUEBA VALUES(
            I, 
            R, 
            MOD(R, 11), 
            1000000000 - R, 
            MOD(1000000000 - R, 11),
            MOD(2000000000 - R, 11)
        );
    END LOOP;
END;
/

COMMIT;

-- Ejercicio 3

CREATE INDEX PID ON PRUEBA(IDISPERSO);
CREATE INDEX PIC ON PRUEBA(ICONCENTRADO);
CREATE BITMAP INDEX PBC ON PRUEBA(BCONCENTRADO);

SET AUTOTRACE ON;
ALTER SESSION SET STATISTICS_LEVEL='ALL';

-- Ejercicio 4

ALTER SYSTEM FLUSH SHARED_POOL;
ALTER SYSTEM FLUSH BUFFER_CACHE;
SELECT COUNT(*) FROM PRUEBA WHERE CLAVE = 50000;

ALTER SYSTEM FLUSH SHARED_POOL;
ALTER SYSTEM FLUSH BUFFER_CACHE;
SELECT COUNT(*) FROM PRUEBA WHERE DISPERSO = 50000;

ALTER SYSTEM FLUSH SHARED_POOL;
ALTER SYSTEM FLUSH BUFFER_CACHE;
SELECT COUNT(*) FROM PRUEBA WHERE CONCENTRADO = 5;

ALTER SYSTEM FLUSH SHARED_POOL;
ALTER SYSTEM FLUSH BUFFER_CACHE;
SELECT COUNT(*) FROM PRUEBA WHERE IDISPERSO = 50000;

ALTER SYSTEM FLUSH SHARED_POOL;
ALTER SYSTEM FLUSH BUFFER_CACHE;
SELECT COUNT(*) FROM PRUEBA WHERE ICONCENTRADO = 5;

ALTER SYSTEM FLUSH SHARED_POOL;
ALTER SYSTEM FLUSH BUFFER_CACHE;
SELECT COUNT(*) FROM PRUEBA WHERE BCONCENTRADO = 5;

/*
 SELECT COUNT(*) FROM PRUEBA WHERE... | CLAVE = 50000;                 | DISPERSO = 50000;          | CONCENTRADO = 5;           | IDISPERSO = 50000;     | ICONCENTRADO = 5;      | BCONCENTRADO = 5;
--------------------------------------|-------------------------------|----------------------------|----------------------------|------------------------|------------------------|----------------------------------------------------------
 PLAN                                 | INDEX UNIQUE SCAN | PRUEBA_PK | TABLE ACCESS FULL | PRUEBA | TABLE ACCESS FULL | PRUEBA | INDEX RANGE SCAN | PID | INDEX RANGE SCAN | PIC | BITMAP CONVERSION COUNT, BITMAP INDEX SINGLE VALUE | PBC
 A-Time                               | 00:00:00.01                   | 00:00:00.07                | 00:00:00.06                | 00:00:00.01            | 00:00:00.02            | 00:00:00.01
 Reads                                | 37                            | 101                        | 101                        | 37                     | 126                    | 44
 "consistent gets"                    | 110                           | 2445                       | 2445                       | 110                    | 199                    | 117
 "physical read total bytes"          | 352256                        | 18980864                   | 18980864                   | 352256                 | 1081344                | 409600
*/

-- Ejercicio 5

/*
La consulta m�s r�pida es CLAVE porque el coste de acceso es m�nimo gracias al �ndice �nico. Las m�s lentas son 
DISPERSO y CONCENTRADO porque el "castigo" de no tener �ndice obliga a leer toda la estructura f�sica de la tabla, 
aumentando dr�sticamente los consistent gets y el tiempo de respuesta.
*/

-- Ejercicio 6

ALTER SYSTEM FLUSH SHARED_POOL;
ALTER SYSTEM FLUSH BUFFER_CACHE;
UPDATE PRUEBA SET DISPERSO = DISPERSO + 7;

ALTER SYSTEM FLUSH SHARED_POOL;
ALTER SYSTEM FLUSH BUFFER_CACHE;
UPDATE PRUEBA SET IDISPERSO = IDISPERSO + 7;

/*
Las m�tricas de IDISPERO se han disparado a diferencia del DISPERSO. En DISPERSO solo cambia la tabla, en IDISPERSO
cambia la tabla y adem�s los �ndices. En resumen, aumenta la lectura pero disminuye la escritura.
*/

-- Ejercicio 7

ALTER SYSTEM FLUSH SHARED_POOL;
ALTER SYSTEM FLUSH BUFFER_CACHE;
SELECT COUNT(*) FROM PRUEBA WHERE IDISPERSO BETWEEN 10000 AND 20000;

-- Ejercicio 8

ALTER SYSTEM FLUSH SHARED_POOL;
ALTER SYSTEM FLUSH BUFFER_CACHE;
SELECT COUNT(*) FROM PRUEBA WHERE IDISPERSO+ICONCENTRADO BETWEEN 10000 AND 20000;

/*
El �ndice guarda valores, no resultados de operaciones. Al aplicar una suma en el WHERE, no se puede comparar ese 
resultado con la estructura ordenada del �ndice. Por tanto, se tiene que leer la tabla entera (Full Table Scan) 
para calcular la suma fila por fila y verificar si cumple la condici�n.
*/

-- Ejercicio 9

CREATE INDEX FIX ON PRUEBA(IDISPERSO + ICONCENTRADO);

-- Ejercicio 10

ALTER SYSTEM FLUSH SHARED_POOL;
ALTER SYSTEM FLUSH BUFFER_CACHE;
SELECT COUNT(*) FROM PRUEBA WHERE IDISPERSO+ICONCENTRADO BETWEEN 10000 AND 20000;

-- Ejercicio 11

/*
Al crear el �ndice de funci�n FIX, ya no se escanea la tabla completa porque ya tiene los resultados de la suma 
pre-calculados y ordenados en el �ndice. Esto reduce dr�sticamente las m�tricas.
*/

-- Ejercicio 12

ALTER SYSTEM FLUSH SHARED_POOL;
ALTER SYSTEM FLUSH BUFFER_CACHE;
UPDATE PRUEBA SET IDISPERSO = IDISPERSO + 7;

-- Ejercicio 13

/*
La escritura se ha vuelto m�s lenta porque hemos a�adidos m�s �ndices. Cuantos m�s �ndices, m�s penalizamos el 
rendimiento de cualquier UPDATE sobre ella, ya que se debe mantener todas esas estructuras sincronizadas en
tiempo real.
*/