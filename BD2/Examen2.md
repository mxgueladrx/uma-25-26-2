## 1. TABLESPACES Y DATAFILES

### Crear un tablespace

```sql
CREATE TABLESPACE nombre
  DATAFILE 'algo.dbf' SIZE 5M
  AUTOEXTEND ON NEXT 1M MAXSIZE 100M;
```

**Explicación:**

- `DATAFILE 'algo.dbf'`: el fichero físico que contendrá los datos del tablespace.
- `SIZE 5M`: tamaño inicial del fichero (5 megabytes).
- `AUTOEXTEND ON`: permite que el fichero crezca automáticamente cuando se quede sin espacio.
- `NEXT 1M`: cada vez que se autoextiende, crece 1 MB.
- `MAXSIZE 100M`: límite máximo de crecimiento (100 MB). Si quieres que no tenga límite, se usa `MAXSIZE UNLIMITED`.

### Cambiar estado (temporal/permanente)

```sql
ALTER TABLESPACE nombre {TEMPORARY | PERMANENT};
```

**Explicación:** cambia si el tablespace es temporal (para operaciones de ordenación, no admite objetos permanentes) o permanente (para tablas, índices, etc.).

### Añadir un datafile a un tablespace existente

```sql
ALTER TABLESPACE nombre ADD DATAFILE 'algo2.dbf' SIZE 1M AUTOEXTEND ON NEXT 1M MAXSIZE 200M;
```

**Explicación:** se usa cuando el tablespace se queda sin espacio y quieres ampliarlo añadiendo otro fichero físico, en vez de agrandar el que ya existe.

### Poner un tablespace en solo lectura

```sql
ALTER TABLESPACE nombre READ ONLY;
-- para revertir:
ALTER TABLESPACE nombre READ WRITE;
```

**Explicación:** útil para datos históricos que no cambian; evita tener que hacer backups continuos de esa parte de la BD.

### Poner un tablespace online / offline

```sql
ALTER TABLESPACE nombre ONLINE;
ALTER TABLESPACE nombre OFFLINE;
```

**Explicación:** `OFFLINE` hace que los datos de ese tablespace no estén accesibles para los usuarios (por ejemplo, durante un mantenimiento), sin afectar al resto de la base de datos.

### Borrar un tablespace

```sql
DROP TABLESPACE nombre [INCLUDING CONTENTS [AND DATAFILES]];
```

**Explicación:** elimina el tablespace. Si tiene objetos dentro (tablas, índices) hay que usar `INCLUDING CONTENTS`; si además quieres borrar físicamente los ficheros .dbf del disco, se añade `AND DATAFILES`.

### Cambiar el tamaño de un datafile

```sql
ALTER DATABASE DATAFILE 'algo.dbf' RESIZE 50M;
```

**Explicación:** modifica el tamaño del fichero de datos directamente (forma manual de agrandar/reducir, alternativa al autoextend).

### Renombrar / mover un datafile

```sql
ALTER TABLESPACE nombre RENAME DATAFILE 'antiguo.dbf' TO 'nuevo.dbf';
```

---

## 2. TABLAS

### Crear tabla con PCTFREE

```sql
CREATE TABLE nombre (n NUMBER) PCTFREE 20;
```

**Explicación:**

- `PCTFREE 20`: reserva el 20% del bloque/página como espacio libre, destinado a futuras actualizaciones (`UPDATE`) de las filas que ya están en esa página, no a nuevas filas.
- Complementario a `PCTUSED` (no se crea con sintaxis propia, se configura igual): porcentaje a partir del cual el bloque vuelve a aceptar `INSERT`.

```sql
CREATE TABLE nombre (n NUMBER) PCTFREE 20 PCTUSED 40;
```

### Tabla temporal (datos viven con la sesión o la transacción)

```sql
CREATE GLOBAL TEMPORARY TABLE nombre (
  col1 NUMBER
) ON COMMIT {DELETE | PRESERVE} ROWS;
```

**Explicación:**

- `ON COMMIT DELETE ROWS`: los datos se borran al hacer `COMMIT` (duran solo la transacción).
- `ON COMMIT PRESERVE ROWS`: los datos se mantienen hasta que termine la sesión.
- Los metadatos (estructura) de la tabla son permanentes; los datos son privados de cada sesión (cada usuario ve solo lo suyo).

### Tabla externa (lee datos de un fichero del SO)

```sql
CREATE TABLE nombre (
  col1 VARCHAR2(50),
  col2 NUMBER
)
ORGANIZATION EXTERNAL (
  TYPE ORACLE_LOADER
  DEFAULT DIRECTORY directorio_dato
  ACCESS PARAMETERS (
    RECORDS DELIMITED BY NEWLINE
    FIELDS TERMINATED BY ','
  )
  LOCATION ('fichero.csv')
);
```

**Explicación:** solo se guardan los metadatos en la BD; los datos siguen estando en un fichero externo del sistema operativo. Es muy usado para importar/leer datos sin cargarlos físicamente.

### Tabla IOT (Index-Organized Table)

```sql
CREATE TABLE nombre (
  id NUMBER PRIMARY KEY,
  dato VARCHAR2(50)
) ORGANIZATION INDEX;
```

**Explicación:** las filas se almacenan directamente en la estructura del índice, ordenadas por la PK (que es obligatoria). No tiene ROWID como las tablas normales.

### Modificar y borrar tablas

```sql
ALTER TABLE nombre ADD (col3 NUMBER);
ALTER TABLE nombre MODIFY (col1 VARCHAR2(100));
ALTER TABLE nombre DROP COLUMN col3;
DROP TABLE nombre [CASCADE CONSTRAINTS] [PURGE];
```

**Explicación:**

- `CASCADE CONSTRAINTS`: borra también las claves foráneas de otras tablas que dependan de ésta.
- `PURGE`: elimina la tabla definitivamente sin pasarla a la papelera de reciclaje (`RECYCLEBIN`).

### Columnas virtuales

```sql
CREATE TABLE nombre (
  precio NUMBER,
  cantidad NUMBER,
  total NUMBER GENERATED ALWAYS AS (precio * cantidad)
);
```

**Explicación:** la columna no ocupa espacio de almacenamiento; su valor se calcula al vuelo a partir de otras columnas.

---

## 3. ÍNDICES

### Índice B-Tree (estándar, para columnas de alta cardinalidad)

```sql
CREATE INDEX idx_nombre_indice
ON nombre_tabla(nombre_columna)
TABLESPACE ts_indices;
```

**Explicación:** estructura en árbol balanceado, eficiente para búsquedas, rangos y ordenaciones en columnas con muchos valores distintos (ej. DNI, ID). Se recomienda crearlo en un tablespace distinto al de la tabla para mejorar el rendimiento (separa la E/S de disco).

### Índice basado en función

```sql
CREATE INDEX idx
ON table_1 (a + b * (c - 1), a, b)
TABLESPACE ts_indices;

CREATE INDEX uppercase_idx
ON Pieza (UPPER(Nombre));
```

**Explicación:** se indexa el resultado de una expresión o función (determinista) en lugar de la columna directa. Muy útil cuando las búsquedas usan funciones, por ejemplo `WHERE UPPER(Nombre) = 'PACO'`, ya que si no existiera este índice, Oracle no podría usar un índice normal sobre `Nombre`.

### Índice de mapa de bits (Bitmap)

```sql
CREATE BITMAP INDEX idx_nombre
ON tabla (columna);
```

**Explicación:** asigna un mapa de bits por cada valor distinto de la columna; cada bit indica si esa fila tiene ese valor. Eficiente para columnas de **baja cardinalidad** (pocos valores distintos, como sexo, estado civil, sí/no). No recomendable para tablas con muchas escrituras concurrentes.

### Índice único

```sql
CREATE UNIQUE INDEX idx_nombre
ON tabla(columna);
```

**Explicación:** garantiza que no haya valores duplicados en la columna indexada (se crea automáticamente al definir una `PRIMARY KEY` o `UNIQUE`).

### Comprobar si se usa un índice (plan de ejecución)

```sql
EXPLAIN PLAN FOR
SELECT * FROM tabla WHERE UPPER(Nombre) = 'PACO';

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
```

### Borrar / reconstruir un índice

```sql
DROP INDEX idx_nombre;
ALTER INDEX idx_nombre REBUILD;
```

**Explicación:** `REBUILD` regenera el índice (por ejemplo, cuando está fragmentado tras muchos `DELETE`), sin tener que borrarlo y crearlo de nuevo.

---

## 4. CLUSTERS

```sql
CREATE CLUSTER nombre_cluster (col1 NUMBER)
SIZE 512
TABLESPACE ts_cluster;

CREATE INDEX idx_cluster ON CLUSTER nombre_cluster;

CREATE TABLE tabla1 (col1 NUMBER, ...) CLUSTER nombre_cluster (col1);
CREATE TABLE tabla2 (col1 NUMBER, ...) CLUSTER nombre_cluster (col1);
```

**Explicación:** agrupa físicamente filas de varias tablas que comparten valor en la columna del cluster (por ejemplo, empleados y departamentos con el mismo `dept_id`), guardándolas en el mismo bloque. Mejora el rendimiento cuando esas tablas se consultan siempre juntas (evita saltos de bloque).

- **Cluster de índice**: se accede mediante un índice B-tree normal sobre la clave del cluster.
- **Cluster hash**: se accede mediante una función hash en lugar de un índice (más rápido para igualdad exacta, no para rangos).

---

## 5. GESTIÓN DE USUARIOS Y PERFILES

### Crear un perfil

```sql
CREATE PROFILE Perfil_1 LIMIT
  SESSIONS_PER_USER 3
  CONNECT_TIME UNLIMITED
  IDLE_TIME 10
  FAILED_LOGIN_ATTEMPTS 4
  PASSWORD_LIFE_TIME 90
  PASSWORD_GRACE_TIME 3;
```

**Explicación línea a línea:**

- `SESSIONS_PER_USER 3`: el usuario solo puede tener 3 sesiones simultáneas abiertas.
- `CONNECT_TIME UNLIMITED`: no hay límite de duración de la conexión.
- `IDLE_TIME 10`: si la sesión está inactiva más de 10 minutos, se cierra automáticamente.
- `FAILED_LOGIN_ATTEMPTS 4`: tras 4 intentos fallidos de login, la cuenta se bloquea.
- `PASSWORD_LIFE_TIME 90`: la contraseña caduca cada 90 días.
- `PASSWORD_GRACE_TIME 3`: tras caducar, da 3 días de margen antes de bloquear definitivamente la cuenta.

### Modificar / borrar un perfil

```sql
ALTER PROFILE Perfil_1 LIMIT IDLE_TIME 20;
DROP PROFILE Perfil_1 [CASCADE];
```

**Explicación:** `CASCADE` es necesario si hay usuarios que todavía tienen asignado ese perfil; reasigna esos usuarios al perfil `DEFAULT`.

### Crear un usuario

```sql
CREATE USER Pepe IDENTIFIED BY Clave_Pepe
  TEMPORARY TABLESPACE temp_ts
  DEFAULT TABLESPACE data_ts
  QUOTA 100M ON test_ts
  QUOTA 500K ON data_ts
  PROFILE Perfil_1;
```

**Explicación:**

- `IDENTIFIED BY Clave_Pepe`: define la contraseña.
- `TEMPORARY TABLESPACE`: dónde se crean los segmentos temporales de sus consultas (ordenaciones, etc.).
- `DEFAULT TABLESPACE`: dónde se guardan por defecto los objetos que cree (tablas, índices) si no se especifica otro.
- `QUOTA 100M ON test_ts`: límite de espacio que puede ocupar en ese tablespace concreto (sin quota, no puede crear nada ahí aunque tenga permisos).
- `PROFILE Perfil_1`: le asigna las restricciones de recursos del perfil creado antes.

> ⚠️ Un usuario recién creado **no tiene ningún privilegio**, ni siquiera el de conectarse (`CREATE SESSION`).

### Dar permiso mínimo para conectarse

```sql
GRANT CREATE SESSION TO Pepe;
```

### Modificar usuario

```sql
ALTER USER Pepe IDENTIFIED BY NuevaClave;
ALTER USER Pepe ACCOUNT LOCK;     -- bloquea la cuenta
ALTER USER Pepe ACCOUNT UNLOCK;   -- la desbloquea
ALTER USER Pepe DEFAULT TABLESPACE otro_ts;
ALTER USER Pepe QUOTA UNLIMITED ON data_ts;
```

### Borrar usuario

```sql
DROP USER Pepe [CASCADE];
```

**Explicación:** `CASCADE` borra también todos los objetos (tablas, vistas...) que ese usuario tenga en su esquema. Sin `CASCADE`, si el usuario tiene objetos, dará error.

---

## 6. ROLES

### Crear un rol

```sql
CREATE ROLE nombre_role
  [NOT IDENTIFIED |
   IDENTIFIED { BY password |
                USING [schema.]package |
                EXTERNALLY |
                GLOBALLY }];

CREATE ROLE Gestor IDENTIFIED BY 123;
CREATE ROLE USUARIO_NORMAL;
```

**Explicación:**

- Un rol se crea vacío; luego se le asignan permisos y/o otros roles con `GRANT`.
- `IDENTIFIED BY password`: para activar el rol (`SET ROLE`) hay que dar la contraseña.
- `EXTERNALLY`: la autenticación del rol depende del sistema operativo.
- `GLOBALLY`: gestionado por un servicio externo (ej. directorio LDAP/Oracle Internet Directory).

### Activar un rol protegido por contraseña en la sesión

```sql
SET ROLE nombre_role IDENTIFIED BY password;
```

**Explicación:** un rol con contraseña no está activo automáticamente al conectarse; el usuario debe activarlo explícitamente en su sesión con esta sentencia para poder usar sus privilegios.

### Activar/desactivar todos los roles

```sql
SET ROLE ALL;
SET ROLE NONE;
```

### Borrar un rol

```sql
DROP ROLE nombre_role;
```

---

## 7. PERMISOS (GRANT / REVOKE)

### Sintaxis general

```sql
GRANT lista_permisos [ON objeto] TO lista_usuarios_o_roles [WITH {GRANT | ADMIN} OPTION];
REVOKE lista_permisos [ON objeto] FROM usuario_o_rol;
```

**Explicación:**

- Tipos de permiso sobre objetos: `SELECT`, `INSERT`, `DELETE`, `UPDATE`, `ALTER`, `INDEX`, `REFERENCES`, `EXECUTE`, `ALL`.
- `WITH GRANT OPTION`: permite que el usuario que recibe el permiso pueda a su vez cederlo a otros (se usa con permisos **de objeto**).
- `WITH ADMIN OPTION`: equivalente a `GRANT OPTION` pero para permisos **de sistema** y roles.
- **Permisos de sistema**: no van ligados a un objeto concreto (ej. `CREATE USER`, `CREATE SESSION`, `CREATE ANY TABLE`).
- **Política Least Privilege**: dar siempre el mínimo permiso necesario, nunca más de lo que se necesita.

### Ejemplos

```sql
GRANT CONNECT, Rol_Programador TO Araujo;
-- Da el rol predefinido CONNECT y un rol propio a un usuario

GRANT CREATE USER, ALTER USER, DROP USER TO Nous, Zeus WITH ADMIN OPTION;
-- Permisos de sistema, y pueden cederlos a otros (ADMIN OPTION)

GRANT CREATE ANY PROCEDURE, CREATE TRIGGER TO Apolonio;
-- Permisos de sistema para crear procedimientos/triggers en cualquier esquema

GRANT ALL ON Empleados TO Casandra WITH GRANT OPTION;
-- Todos los permisos sobre la tabla, y puede cederlos

GRANT SELECT ON Empleados TO PUBLIC;
-- PUBLIC = todos los usuarios de la BD

GRANT REFERENCES (DNI), UPDATE (Salario, Cta_Banco) ON Empleados TO Rol_Nominas;
-- Permisos a nivel de columna concreta, no sobre toda la tabla

REVOKE CREATE SESSION FROM Usuario1, Usuario2;
-- Revoca el permiso de conectarse
```

### Flujo completo rol con contraseña (típico de examen)

```sql
CREATE ROLE pruebarole IDENTIFIED BY 123;
GRANT SELECT ON mitabla TO pruebarole;
GRANT pruebarole TO unalumno;

-- Sin activar el rol, falla:
SELECT * FROM ESC.mitabla;  -- ORA-00942: table or view does not exist

-- Activando el rol:
SET ROLE pruebarole IDENTIFIED BY 123;
SELECT * FROM ESC.mitabla;  -- Ahora funciona
```

**Por qué falla antes de `SET ROLE`:** aunque el rol esté concedido al usuario, si fue creado con contraseña no se activa automáticamente al iniciar sesión, hay que activarlo a mano.

---

## 8. VISTAS

### Crear vista

```sql
CREATE [OR REPLACE] [[NO] FORCE] VIEW nombre [(atributos)]
AS (consulta)
[WITH READ ONLY];
```

**Explicación:**

- `OR REPLACE`: si ya existe, la sobreescribe (evita tener que `DROP` antes).
- `FORCE`: crea la vista aunque las tablas base no existan todavía o el usuario no tenga permisos sobre ellas (quedará inválida hasta que se resuelva).
- `WITH READ ONLY`: impide hacer `INSERT/UPDATE/DELETE` a través de la vista.

```sql
CREATE OR REPLACE VIEW SumiNombres AS
  (SELECT NombreS, NombreP
   FROM Suministros SP, Suministrador S, Pieza P
   WHERE SP.S#=S.S# AND SP.P#=P.P#);

CREATE OR REPLACE VIEW Cantidad (NombreS, NumPiezas) AS
  (SELECT NombreS, COUNT(*)
   FROM Suministros SP, Suministrador S
   WHERE SP.P#=S.P#
   GROUP BY NombreS);
```

**Condiciones para poder escribir (INSERT/UPDATE) sobre una vista:** que se base en **una sola tabla**, sin funciones de agregación (`COUNT`, `SUM`...) ni `GROUP BY`, y que todas las columnas no incluidas sean `NULL`-ables (admitan nulos).

**Utilidad de las vistas:**

- Seguridad: restringir el acceso a ciertas filas o columnas.
- Ocultar la complejidad de joins/cálculos.
- Presentar los datos de otra forma sin duplicarlos.
- Independencia de las aplicaciones frente a cambios en la tabla base.
- Permitir consultas (ej. con agregaciones anidadas) que de otro modo no serían directas.

### Borrar vista

```sql
DROP VIEW nombre;
```

---

## 9. SINÓNIMOS

```sql
CREATE [PUBLIC] SYNONYM nombre FOR objeto;

CREATE SYNONYM pventa FOR Paco.Proyecto_Venta;
-- Sinónimo PRIVADO (por defecto): solo lo ve quien lo crea (o a quien se le dé acceso)

CREATE PUBLIC SYNONYM Prod FOR Scott.Prod@Ventas;
-- Sinónimo PÚBLICO: todos los usuarios de la BD pueden usarlo
-- @Ventas indica que el objeto está en una BD remota (vía DB LINK llamado Ventas)
```

**Explicación:** un sinónimo es un alias para referirse a un objeto sin tener que conocer su nombre real ni su propietario. Aporta seguridad (oculta la estructura real) e independencia (si el objeto se mueve de esquema, solo hay que cambiar el sinónimo).

```sql
DROP [PUBLIC] SYNONYM nombre;
```

---

## 10. VISTAS MATERIALIZADAS

```sql
CREATE MATERIALIZED VIEW nombre clausulas AS consulta;
```

**Explicación:** a diferencia de una vista normal, una vista materializada **almacena físicamente** el resultado de la consulta (como una "foto"), por lo que el acceso es mucho más rápido para consultas pesadas, pero los datos pueden quedar desactualizados hasta el siguiente refresco.

**Requisitos:** permiso de `CREATE TABLE` y `CREATE MATERIALIZED VIEW`, acceso a las tablas base, y espacio suficiente en el tablespace.

**Cláusulas principales:**

- `BUILD IMMEDIATE` (se rellena al crearla) o `BUILD DEFERRED` (se rellena en el primer `REFRESH`).
- `REFRESH FAST` (solo aplica los cambios, necesita un _log_ de la tabla base) | `COMPLETE` (recalcula todo) | `FORCE` (intenta FAST, si no puede hace COMPLETE).
- `ON COMMIT` (se actualiza con cada commit de la tabla base) | `ON DEMAND` (solo cuando se ejecuta `REFRESH` manualmente).
- `START WITH fecha NEXT fecha`: programación automática de refrescos.

```sql
CREATE MATERIALIZED VIEW Ventas.Clientes_Recientes AS
SELECT * FROM Ventas.Clientes@dbs1.uma.es C
WHERE EXISTS (
  SELECT * FROM Ventas.Ordenes@dbs1.uma.es O
  WHERE C.DNI = O.DNI_Cliente
);

CREATE MATERIALIZED VIEW sales_emp
TABLESPACE Mi_Tablespace
REFRESH FAST START WITH SYSDATE NEXT SYSDATE + 7
AS SELECT * FROM Patricia.Cosas@Granada
   UNION
   SELECT * FROM Miriam.Cosas@Malaga;
```

### Refrescar manualmente

```sql
EXEC DBMS_MVIEW.REFRESH('nombre_vista', 'C'); -- C = complete, F = fast
```

### Borrar

```sql
DROP MATERIALIZED VIEW nombre;
```

---

## 11. SEGURIDAD AVANZADA

### Encriptación con DBMS_CRYPTO (a medida)

```sql
DECLARE
  clave RAW(32);
  encriptado RAW(2000);
BEGIN
  clave := DBMS_CRYPTO.RANDOMBYTES(32);
  encriptado := DBMS_CRYPTO.ENCRYPT(
    src => UTL_I18N.STRING_TO_RAW('texto secreto', 'AL32UTF8'),
    typ => DBMS_CRYPTO.AES_CBC_PKCS5,
    key => clave
  );
END;
```

**Explicación:** paquete que permite cifrar/descifrar datos manualmente con `.ENCRYPT` y `.DECRYPT`, y generar claves aleatorias con `.RANDOMBYTES`. Se usa cuando necesitas control total sobre el algoritmo (a nivel de aplicación).

### TDE — Transparent Data Encryption (a nivel de columna)

```sql
CREATE TABLE employee (
  first_name VARCHAR2(128),
  last_name  VARCHAR2(128),
  empID      NUMBER,
  salary     NUMBER(6) ENCRYPT
);
```

**Explicación:** `ENCRYPT` por defecto usa AES de 192 bits con MAC (código de autenticación) y salt. Se puede personalizar:

```sql
col1 VARCHAR2(50) ENCRYPT USING 'AES256' NO SALT;
```

Es "transparente" porque la aplicación no nota nada: Oracle cifra/descifra automáticamente al escribir/leer en disco. Solo afecta a cómo se **almacena** físicamente, no a cómo se consulta.

### TDE a nivel de tablespace completo

```sql
CREATE TABLESPACE ts_seguro
DATAFILE 'ts_seguro.dbf' SIZE 100M
ENCRYPTION USING 'AES256'
DEFAULT STORAGE(ENCRYPT);
```

### Oracle Virtual Private Database (VPD) — seguridad a nivel de fila

```sql
GRANT EXECUTE ON DBMS_RLS TO usuario;

BEGIN
  DBMS_RLS.ADD_POLICY(
    object_schema   => 'USUARIO',
    object_name     => 'DEPARTAMENTOS',
    policy_name     => 'POL_DEPTO_30',
    function_schema => 'USUARIO',
    policy_function => 'SOLO_DEPTO_30',
    statement_types => 'SELECT, UPDATE, DELETE'
  );
END;
```

**Explicación:** añade automáticamente una cláusula `WHERE` (definida en una función PL/SQL) a todas las sentencias indicadas, sin que la aplicación lo sepa. Por ejemplo, restringe que cada usuario solo vea las filas de su departamento.

```sql
-- Desactivar una política sin borrarla
BEGIN
  DBMS_RLS.ENABLE_POLICY(
    object_schema => 'esquema',
    object_name   => 'tabla',
    policy_name   => 'nombre_politica',
    enable        => FALSE
  );
END;

-- Borrar una política
BEGIN
  DBMS_RLS.DROP_POLICY(
    object_schema => 'esquema',
    object_name   => 'tabla',
    policy_name   => 'nombre_politica'
  );
END;
```

### Oracle Label Security

**Explicación:** protege filas asignando **etiquetas** (niveles de sensibilidad) a cada fila, y a cada usuario se le asignan las etiquetas a las que tiene acceso. Más granular que VPD para jerarquías de clasificación (ej. público/confidencial/secreto).

### Oracle Database Vault

**Explicación:** restringe el acceso a los datos **incluso a los administradores** (SYS y SYSTEM no pueden ver ciertos datos ni crear usuarios libremente). Requiere roles separados: un _Account Manager_ (gestiona usuarios) y un _DB Vault Owner_ (gestiona las reglas de protección). Útil para cumplir normativas de separación de funciones.

---

## 12. SQL INJECTION Y BIND VARIABLES

### El problema (concatenación de cadenas)

```sql
query := 'SELECT value FROM secret_records
WHERE user_name=''' || vuser || ''' AND service_type=''' || vservice || '''';
```

Si el atacante introduce:

```
vuser = 'Anybody'' OR 1=1 --'
```

la consulta resultante se convierte en:

```sql
SELECT value FROM secret_records
WHERE user_name='Anybody' OR 1=1 --' AND service_type='Anything';
```

El `--` comenta el resto de la sentencia y `OR 1=1` siempre es verdadero, así que **devuelve todas las filas**, sin restricción.

### Destrucción de datos por inyección

```sql
sentencia := 'BEGIN UPDATE productos SET precio = precio*1.1 WHERE NOMBRE=''' || p_nombre || '''; END;';
```

Con `p_nombre := 'zzzz''; DELETE FROM productos WHERE ''a''=''a'`, se ejecutan **dos sentencias**: el `UPDATE` original y un `DELETE` que borra toda la tabla.

### La solución: Bind Variables

```sql
query := 'SELECT value FROM secret_records WHERE user_name = :a AND service_type = :b';
EXECUTE IMMEDIATE query INTO rec USING vuser, vservice;
```

**Explicación:** con bind variables (`:a`, `:b`), el valor introducido por el usuario **se trata siempre como un literal de texto**, nunca como código SQL. Aunque el atacante meta comillas o `--`, Oracle los busca literalmente como parte del string, no los interpreta como sintaxis SQL. Es la defensa estándar contra inyección SQL, separando claramente el **código** (la consulta) de los **datos** (los valores).

---

## 13. CONSULTAS AL DICCIONARIO DE DATOS / METADATOS

> `USER_*` (solo tus objetos), `ALL_*` (tus objetos + a los que tienes acceso) y `DBA_*` (todos los de la BD, requiere privilegios de administrador). Las dinámicas `V$*` muestran el estado en tiempo real de la instancia.

### Tablespaces y almacenamiento físico

```sql
SELECT * FROM DBA_TABLESPACES;          -- Todos los tablespaces de la BD
SELECT * FROM USER_TABLESPACES;         -- (no siempre existe, mejor usar DBA_ o ALL_)
SELECT * FROM DBA_DATA_FILES;           -- Datafiles asociados a cada tablespace
SELECT * FROM DBA_TEMP_FILES;           -- Ficheros de tablespaces temporales
SELECT * FROM DBA_FREE_SPACE;           -- Espacio libre por tablespace/fichero
SELECT tablespace_name, SUM(bytes)/1024/1024 AS MB_libres
FROM DBA_FREE_SPACE GROUP BY tablespace_name;  -- Espacio libre en MB, agrupado
```

### Segmentos y extensiones

```sql
SELECT * FROM DBA_SEGMENTS WHERE segment_name = 'MITABLA';
SELECT * FROM USER_SEGMENTS;
SELECT * FROM DBA_EXTENTS WHERE segment_name = 'MITABLA';
```

**Explicación:** `DBA_SEGMENTS` indica en qué tablespace está cada objeto y cuánto espacio ocupa; `DBA_EXTENTS` desglosa ese espacio en las extensiones físicas concretas.

### Tablas y columnas

```sql
SELECT * FROM USER_TABLES;                       -- Tus tablas
SELECT * FROM ALL_TABLES;                         -- Tablas a las que tienes acceso
SELECT * FROM DBA_TABLES;                         -- Todas (admin)                 

SELECT * FROM USER_CONSTRAINTS WHERE table_name='MITABLA';  -- PK, FK, CHECK, UNIQUE...
SELECT * FROM USER_CONS_COLUMNS WHERE table_name='MITABLA'; -- Columnas de cada constraint
```

### Índices

```sql
SELECT * FROM USER_INDEXES WHERE table_name='MITABLA';
SELECT * FROM USER_IND_COLUMNS WHERE table_name='MITABLA';  -- Qué columnas componen cada índice
SELECT * FROM DBA_INDEXES WHERE owner='PEPE';
```

### Vistas, sinónimos y vistas materializadas

```sql
SELECT * FROM USER_VIEWS;

SELECT * FROM USER_SYNONYMS;
SELECT * FROM ALL_SYNONYMS WHERE synonym_name='PROD';
SELECT * FROM USER_MVIEWS;                          -- Vistas materializadas propias
SELECT * FROM USER_MVIEW_REFRESH_TIMES;             -- Cuándo se refrescaron
```

### Usuarios, perfiles y privilegios

```sql
SELECT * FROM USER_USERS;
SELECT * FROM DBA_USERS;                     -- Todos los usuarios de la BD
SELECT username, account_status, profile FROM DBA_USERS;
SELECT * FROM DBA_PROFILES;                  -- Perfiles existentes y sus límites
SELECT * FROM USER_ROLE_PRIVS;               -- Roles que me han asignado a mí
SELECT * FROM DBA_ROLE_PRIVS WHERE grantee='PEPE';  -- Roles asignados a un usuario concreto
SELECT * FROM ROLE_SYS_PRIVS;                -- Privilegios de sistema de un rol
SELECT * FROM ROLE_TAB_PRIVS;                -- Privilegios de objeto de un rol
SELECT * FROM USER_SYS_PRIVS;                -- Privilegios de sistema directos del usuario actual
SELECT * FROM USER_TAB_PRIVS;                -- Privilegios de objeto que tengo concedidos
SELECT * FROM DBA_TAB_PRIVS WHERE grantee='PEPE';   -- Privilegios de objeto de un usuario (admin)
SELECT * FROM DBA_SYS_PRIVS WHERE grantee='PEPE';   -- Privilegios de sistema de un usuario (admin)
SELECT * FROM USER_TS_QUOTAS;                -- Cuotas asignadas en cada tablespace
```

### Vistas dinámicas de rendimiento e instancia (V$)

```sql
SELECT * FROM V$PROCESS;     -- Procesos activos de la instancia
SELECT * FROM V$SESSION;     -- Sesiones actuales conectadas
SELECT * FROM V$INSTANCE;    -- Información general de la instancia
SELECT * FROM V$DATABASE;    -- Información general de la BD
SELECT * FROM V$DATAFILE;    -- Datafiles a nivel de instancia
SELECT * FROM V$LOG;
SELECT * FROM V$TABLESPACE;  -- Tablespaces a nivel de instancia
SELECT * FROM V$SGA;         -- Tamaño de las áreas de la SGA
SELECT * FROM V$PARAMETER WHERE name LIKE '%memory%';  -- Parámetros de configuración
SHOW SGA;                    -- Forma rápida de ver el tamaño de la SGA
SHOW PARAMETER db_block_size; -- Ver un parámetro de inicialización concreto
```

### Objeto genérico (saber qué es algo y de quién es)

```sql
SELECT * FROM USER_OBJECTS;                       -- Todos tus objetos (tablas, vistas, índices...)
SELECT * FROM ALL_OBJECTS WHERE object_name = 'MITABLA';
SELECT * FROM DBA_OBJECTS WHERE owner = 'PEPE';
```

### Diccionario de diccionarios (metaconsulta)

```sql
SELECT * FROM DICTIONARY;            -- Lista TODAS las vistas del diccionario de datos y su descripción
SELECT * FROM DICT WHERE table_name LIKE '%TABLESPACE%';  -- Sinónimo de DICTIONARY, buscar por nombre
SELECT * FROM DICT_COLUMNS WHERE table_name = 'DBA_USERS'; -- Columnas de una vista del diccionario
```

**Explicación:** si en examen no recuerdas el nombre exacto de una vista, `SELECT * FROM DICT WHERE table_name LIKE '%PALABRA%';` te ayuda a encontrarla por aproximación (ej. buscando `%INDEX%`, `%USER%`, etc.).

---

## 14. COMANDOS ADICIONALES MUY USADOS (NO EN APUNTES)
### Crear una base de datos

```sql
CREATE DATABASE nombre_bd
  USER SYS IDENTIFIED BY clave_sys
  USER SYSTEM IDENTIFIED BY clave_system
  LOGFILE GROUP 1 ('redo01.log') SIZE 50M,
          GROUP 2 ('redo02.log') SIZE 50M
  DATAFILE 'system01.dbf' SIZE 200M
  SYSAUX DATAFILE 'sysaux01.dbf' SIZE 100M;
```

### Conexión como SYSDBA / SYSOPER

```sql
CONNECT usuario/clave AS SYSDBA;
CONNECT usuario/clave AS SYSOPER;
```

**Explicación:** `SYSDBA` da todos los privilegios posibles (incluida la creación de la BD); `SYSOPER` permite operaciones de administración básicas (arrancar/parar, backup) pero no crear BD ni ver datos de usuario con privilegios totales.

### Tablespace por defecto y temporal de toda la BD

```sql
ALTER DATABASE DEFAULT TABLESPACE nombre_ts;
ALTER DATABASE DEFAULT TEMPORARY TABLESPACE nombre_temp_ts;
```

### Bloqueo de cuentas y gestión de contraseñas

```sql
ALTER USER Pepe PASSWORD EXPIRE;          -- Obliga a cambiar la clave en el próximo login
ALTER PROFILE Perfil_1 LIMIT PASSWORD_REUSE_TIME 30 PASSWORD_REUSE_MAX 5;
-- No se puede reutilizar una contraseña de los últimos 30 días o de las últimas 5 usadas
ALTER PROFILE Perfil_1 LIMIT PASSWORD_VERIFY_FUNCTION mi_funcion_complejidad;
-- Asocia una función PL/SQL que valida la complejidad de la contraseña
```

### Auditoría (muy típico en seguridad)

```sql
AUDIT SELECT ON Empleados BY ACCESS;       -- Audita cada SELECT sobre la tabla
AUDIT INSERT, UPDATE, DELETE ON Empleados; -- Audita operaciones de escritura
AUDIT CREATE SESSION;                      -- Audita los inicios de sesión (logins)
NOAUDIT SELECT ON Empleados;               -- Desactiva la auditoría
SELECT * FROM DBA_AUDIT_TRAIL;             -- Consultar el registro de auditoría clásico
SELECT * FROM UNIFIED_AUDIT_TRAIL;         -- Registro de auditoría unificado (versiones modernas)
```

**Explicación:** la auditoría es el tercer pilar de seguridad junto a autenticación y autorización: permite saber **quién hizo qué y cuándo**.

### FLASHBACK (recuperación lógica, muy usado en examen para "deshacer" sin backup)

```sql
SELECT * FROM Empleados
AS OF TIMESTAMP (SYSTIMESTAMP - INTERVAL '10' MINUTE);
-- Ver cómo estaba la tabla hace 10 minutos

FLASHBACK TABLE Empleados TO BEFORE DROP;
-- Recupera una tabla borrada (de la papelera de reciclaje)

SELECT * FROM RECYCLEBIN;
-- Ver objetos borrados pendientes de purgar

PURGE TABLE Empleados;
-- Elimina definitivamente una tabla de la papelera (libera el espacio)
```

### Comprobar privilegios efectivos rápidamente (muy usado para depurar exámenes)

```sql
SELECT * FROM SESSION_PRIVS;     -- Privilegios activos en tu sesión actual
SELECT * FROM SESSION_ROLES;     -- Roles activos en tu sesión actual
```

---

## 15. CHULETA RÁPIDA (CHEATSHEET FINAL)

|Necesito...|Comando|
|---|---|
|Crear tablespace|`CREATE TABLESPACE n DATAFILE 'f.dbf' SIZE 5M AUTOEXTEND ON NEXT 1M MAXSIZE 100M;`|
|Tablespace solo lectura|`ALTER TABLESPACE n READ ONLY;`|
|Crear usuario completo|`CREATE USER u IDENTIFIED BY pwd DEFAULT TABLESPACE ts QUOTA 10M ON ts PROFILE p;`|
|Dar permiso de conexión|`GRANT CREATE SESSION TO u;`|
|Crear perfil con límites|`CREATE PROFILE p LIMIT IDLE_TIME 10 FAILED_LOGIN_ATTEMPTS 4;`|
|Crear rol con contraseña|`CREATE ROLE r IDENTIFIED BY pwd;`|
|Activar rol con contraseña|`SET ROLE r IDENTIFIED BY pwd;`|
|Dar permiso sobre tabla|`GRANT SELECT, UPDATE ON tabla TO usuario;`|
|Dar permiso con cesión|`GRANT SELECT ON tabla TO usuario WITH GRANT OPTION;`|
|Quitar permiso|`REVOKE SELECT ON tabla FROM usuario;`|
|Crear vista|`CREATE OR REPLACE VIEW v AS SELECT ...;`|
|Vista de solo lectura|`... AS SELECT ... WITH READ ONLY;`|
|Sinónimo público|`CREATE PUBLIC SYNONYM s FOR esquema.tabla;`|
|Vista materializada con refresco|`CREATE MATERIALIZED VIEW v REFRESH FAST START WITH SYSDATE NEXT SYSDATE+7 AS SELECT...;`|
|Cifrar columna|`col NUMBER ENCRYPT;`|
|Política VPD|`DBMS_RLS.ADD_POLICY(...);`|
|Evitar inyección SQL|usar `:variable` + `EXECUTE IMMEDIATE ... USING ...;`|
|Índice B-tree|`CREATE INDEX i ON tabla(col);`|
|Índice por función|`CREATE INDEX i ON tabla(UPPER(col));`|
|Índice bitmap|`CREATE BITMAP INDEX i ON tabla(col);`|
|Ver plan de ejecución|`EXPLAIN PLAN FOR SELECT...; SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);`|
|Ver tablespaces (admin)|`SELECT * FROM DBA_TABLESPACES;`|
|Ver mis tablas|`SELECT * FROM USER_TABLES;`|
|Ver roles que tengo|`SELECT * FROM USER_ROLE_PRIVS;`|
|Ver privilegios de un rol|`SELECT * FROM ROLE_SYS_PRIVS; / ROLE_TAB_PRIVS;`|
|Buscar una vista del diccionario|`SELECT * FROM DICT WHERE table_name LIKE '%PALABRA%';`|
|Recuperar tabla borrada|`FLASHBACK TABLE t TO BEFORE DROP;`|
|Ver datos de hace X tiempo|`SELECT * FROM t AS OF TIMESTAMP (SYSTIMESTAMP - INTERVAL '10' MINUTE);`|
|Auditar accesos|`AUDIT SELECT ON tabla BY ACCESS;`|
