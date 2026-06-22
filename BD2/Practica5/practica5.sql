-- 2
DECLARE
    V_CONT NUMBER;
BEGIN
    SELECT COUNT(*) INTO V_CONT FROM DBA_TABLESPACES WHERE TABLESPACE_NAME = 'TS_PAU';
    IF V_CONT = 0 THEN
        EXECUTE IMMEDIATE 'CREATE TABLESPACE TS_PAU DATAFILE ''ts_pau_admin.dbf'' SIZE 10M AUTOEXTEND ON';
    END IF;
END;
/

-- 3
CREATE PROFILE PERF_ADMINISTRATIVO LIMIT
    FAILED_LOGIN_ATTEMPTS 3
    IDLE_TIME 5;
    
-- 4
CREATE PROFILE PERF_USUARIO LIMIT
    SESSIONS_PER_USER 4
    PASSWORD_LIFE_TIME 30;
    
-- 5
ALTER SYSTEM SET RESOURCE_LIMIT = TRUE;
/* Me he asegurado activando el parámetro global RESOURCE_LIMIT. 
Sin esto, el IDLE_TIME o las SESSIONS_PER_USER serían ignorados */

-- 6
CREATE ROLE R_ADMINISTRADOR_SUPER;
GRANT CREATE SESSION, CREATE TABLE TO R_ADMINISTRADOR_SUPER;

-- 7
CREATE USER USUARIO1 IDENTIFIED BY usuariospractica 
    PROFILE PERF_ADMINISTRATIVO 
    DEFAULT TABLESPACE TS_PAU 
    QUOTA 1M ON TS_PAU;

CREATE USER USUARIO2 IDENTIFIED BY usuariospractica 
    PROFILE PERF_ADMINISTRATIVO 
    DEFAULT TABLESPACE TS_PAU 
    QUOTA 1M ON TS_PAU;

GRANT R_ADMINISTRADOR_SUPER TO USUARIO1, USUARIO2;

-- 8
-- Como USUARIO1
CREATE TABLE TABLA2(
    CODIGO NUMBER   
);
-- Como USUARIO2
CREATE TABLE TABLA2(
    CODIGO NUMBER   
);

-- 9
CREATE OR REPLACE PROCEDURE USUARIO1.PR_INSERTA_TABLA2 (P_CODIGO IN NUMBER) AS
BEGIN
      INSERT INTO TABLA2 VALUES (P_CODIGO);
END PR_INSERTA_TABLA2;
/

-- 10
-- Como USUARIO1
BEGIN
   USUARIO1.PR_INSERTA_TABLA2(1);
END;
/ 
/* Si funciona */

-- 11
GRANT EXECUTE ON USUARIO1.PR_INSERTA_TABLA2 TO USUARIO2;

-- 12
-- Como USUARIO2
BEGIN
   USUARIO1.PR_INSERTA_TABLA2(2);
END;
/
COMMIT;
/* Si funciona */

-- 13
/* El dato se inserta en la tabla de USUARIO1. Por defecto, los procedimientos en Oracle se ejecutan con 
los permisos y en el esquema de quien los creó, no de quien los ejecuta */

-- 14
CREATE OR REPLACE PROCEDURE USUARIO1.PR_INSERTA_TABLA2 (P_CODIGO IN NUMBER) AS
BEGIN
    EXECUTE IMMEDIATE 'INSERT INTO TABLA2 VALUES ('||P_CODIGO||')';
END PR_INSERTA_TABLA2;
/

-- 15
-- Como USUARIO1
BEGIN
   USUARIO1.PR_INSERTA_TABLA2(3);
END;
/

-- 16
-- Como USUARIO2
BEGIN
   USUARIO1.PR_INSERTA_TABLA2(4);
END;
/

-- 17
CREATE OR REPLACE PROCEDURE USUARIO1.PR_CREA_TABLA (P_TABLA IN VARCHAR2, P_ATRIBUTO IN VARCHAR2) AS
BEGIN
    EXECUTE IMMEDIATE 'CREATE TABLE '||P_TABLA||'('||P_ATRIBUTO||' NUMBER(9))';
END PR_CREA_TABLA;
/

-- 18
-- Como USUARIO1
BEGIN
   USUARIO1.PR_CREA_TABLA('tabla', 'nombre');
END;
/
/* Falla. Los permisos otorgados vía ROL no funcionan dentro de procedimientos. El permiso CREATE TABLE le llega por el rol 
R_ADMINISTRADOR_SUPER, pero para que funcione en un procedimiento necesita el permiso explícito 
(GRANT CREATE TABLE TO USUARIO1) */

-- 19
GRANT CREATE TABLE TO USUARIO1;

GRANT EXECUTE ON USUARIO1.PR_CREA_TABLA TO USUARIO2;

-- 20
-- Como USUARIO2
BEGIN
   USUARIO1.PR_CREA_TABLA('TABLA_DESDE_U2', 'COLUMNA1');
END;
/
/* SÍ. Ahora USUARIO1 tiene el permiso CREATE TABLE de forma directa (no por rol), lo que permite que su procedimiento ejecute DDL */

-- 21
SELECT * FROM DBA_USERS_WITH_DEFPWD;
/* Si hay una */
SELECT USERNAME, ACCOUNT_STATUS FROM DBA_USERS;
/* Con esto se comprueba si están bloqueados o no */

-- 22
-- 1. Consultar parámetros actuales
SELECT RESOURCE_NAME, LIMIT 
FROM DBA_PROFILES 
WHERE PROFILE = 'DEFAULT';

-- 2. Modificar parámetros del perfil DEFAULT
ALTER PROFILE DEFAULT LIMIT 
    FAILED_LOGIN_ATTEMPTS 4 
    PASSWORD_GRACE_TIME 5;

-- 3. Probar con USUARIO1
ALTER USER USUARIO1 PROFILE DEFAULT;
/* Oracle lanzará el error ORA-28000: the account is locked. El perfil permite 4 intentos; al introducir la quinta
contraseña mal, el sistema bloquea preventivamente la cuenta */

-- 4
ALTER USER USUARIO1 ACCOUNT UNLOCK;

-- 5
/* FAILED_LOGIN_ATTEMPTS: bloquea la cuenta del usuario en la base de datos hasta que un administrador la desbloquee
sec_max_failed_login_attempts: tras X intentos fallidos en una misma conexión, Oracle "cuelga" (desconecta) al cliente 
para evitar que un script automático sature el servidor, pero no necesariamente bloquea la cuenta de usuario para siempre */

-- 6
DROP PROFILE PERF_ADMINISTRATIVO CASCADE;
DROP PROFILE PERF_USUARIO CASCADE;
/* No. El perfil DEFAULT de Oracle no se puede borrar. Es el perfil de "seguridad" que garantiza que todo usuario tenga siempre, 
como mínimo, unas reglas asignadas */

---------------
/* Parámetros Dinámicos: Se pueden cambiar mientras la base de datos está encendida mediante ALTER SYSTEM SET .... El cambio puede ser inmediato 
(en memoria) o para el futuro (en el fichero de configuración)
Parámetros Estáticos: No se pueden cambiar con la base de datos funcionando. Debes modificarlos en el fichero de parámetros (SPFILE) y 
reiniciar la base de datos para que surtan efecto */