CREATE TABLE REGIONS (
    REGION_ID NUMBER NOT NULL,
    REGION_NAME VARCHAR2(25),
    CONSTRAINT PK_REGIONS PRIMARY KEY (REGION_ID)
);

CREATE TABLE JOBS (
    JOB_ID VARCHAR2(10) NOT NULL,
    JOB_TITLE VARCHAR2(35) NOT NULL,
    MIN_SALARY NUMBER(6),
    MAX_SALARY NUMBER(6),
    CONSTRAINT PK_JOBS PRIMARY KEY (JOB_ID)
);

CREATE TABLE COUNTRIES (
    COUNTRY_ID CHAR(2) NOT NULL,
    COUNTRY_NAME VARCHAR2(40),
    REGION_ID NUMBER,
    CONSTRAINT PK_COUNTRIES PRIMARY KEY (COUNTRY_ID),
    CONSTRAINT FK_COUNTRIES_REGIONS FOREIGN KEY (REGION_ID) REFERENCES REGIONS(REGION_ID)
);

CREATE TABLE LOCATIONS (
    LOCATION_ID NUMBER(4) NOT NULL,
    STREET_ADDRESS VARCHAR2(40),
    POSTAL_CODE VARCHAR2(12),
    CITY VARCHAR2(30) NOT NULL,
    STATE_PROVINCE VARCHAR2(25),
    COUNTRY_ID CHAR(2),
    CONSTRAINT PK_LOCATIONS PRIMARY KEY (LOCATION_ID),
    CONSTRAINT FK_LOCATIONS_COUNTRIES FOREIGN KEY (COUNTRY_ID) REFERENCES COUNTRIES(COUNTRY_ID)
);

CREATE TABLE DEPARTMENTS (
    DEPARTMENT_ID NUMBER(4) NOT NULL,
    DEPARTMENT_NAME VARCHAR2(30) NOT NULL,
    MANAGER_ID NUMBER(6),
    LOCATION_ID NUMBER(4),
    CONSTRAINT PK_DEPARTMENTS PRIMARY KEY (DEPARTMENT_ID),
    CONSTRAINT FK_DEPARTMENTS_LOCATIONS FOREIGN KEY (LOCATION_ID) REFERENCES LOCATIONS(LOCATION_ID)
);

CREATE TABLE EMPLOYEES (
    EMPLOYEE_ID NUMBER(6) NOT NULL,
    FIRST_NAME VARCHAR2(20),
    LAST_NAME VARCHAR2(25) NOT NULL,
    EMAIL VARCHAR2(25) NOT NULL,
    PHONE_NUMBER VARCHAR2(20),
    HIRE_DATE DATE NOT NULL,
    JOB_ID VARCHAR2(10) NOT NULL,
    SALARY NUMBER(8,2),
    COMMISSION_PCT NUMBER(2,2),
    MANAGER_ID NUMBER(6),
    DEPARTMENT_ID NUMBER(4),
    CONSTRAINT PK_EMPLOYEES PRIMARY KEY (EMPLOYEE_ID),
    CONSTRAINT FK_EMPLOYEES_JOBS FOREIGN KEY (JOB_ID) REFERENCES JOBS(JOB_ID),
    CONSTRAINT FK_EMPLOYEES_DEPT FOREIGN KEY (DEPARTMENT_ID) REFERENCES DEPARTMENTS(DEPARTMENT_ID),
    CONSTRAINT FK_EMPLOYEES_MGR FOREIGN KEY (MANAGER_ID) REFERENCES EMPLOYEES(EMPLOYEE_ID)
);

CREATE TABLE JOB_HISTORY (
    EMPLOYEE_ID NUMBER(6) NOT NULL,
    START_DATE DATE NOT NULL,
    END_DATE DATE NOT NULL,
    JOB_ID VARCHAR2(10) NOT NULL,
    DEPARTMENT_ID NUMBER(4),
    CONSTRAINT PK_JOB_HISTORY PRIMARY KEY (EMPLOYEE_ID, START_DATE),
    CONSTRAINT FK_JH_EMPLOYEES FOREIGN KEY (EMPLOYEE_ID) REFERENCES EMPLOYEES(EMPLOYEE_ID),
    CONSTRAINT FK_JH_JOBS FOREIGN KEY (JOB_ID) REFERENCES JOBS(JOB_ID),
    CONSTRAINT FK_JH_DEPT FOREIGN KEY (DEPARTMENT_ID) REFERENCES DEPARTMENTS(DEPARTMENT_ID)
);

/* 1. Se desea generar automáticamente ciertos valores de columna para las filas
recién insertadas. Por ejemplo, la tabla EMPLOYEES incluye un campo de
fecha que desea que se rellena con la fecha actual cuando se inserta un dato.
Generar el Trigger necesario para ello. */

CREATE OR REPLACE TRIGGER TR_EMPLOYEES
AFTER INSERT ON EMPLOYEES
FOR EACH ROW
BEGIN
    :NEW.HIRE_DATE := SYSDATE;
END;
/

/* 2. Se quiere mantener los valores relacionados en sincronía que pasan a ser
almacenada en tablas separadas. Por ejemplo, digamos que se está actualizando el
nivel de salario por un número de puestos de trabajo dentro de la tabla JOBS. Sin
embargo, al hacer esto, tendrá que actualizar los salarios dentro de la tabla
EMPLEADOS para los empleados que tienen esos trabajos. En resumen, si se
actualiza el rango de salario para un trabajo, entonces usted desea actualizar
automáticamente los salarios para garantizar que caen dentro de la nueva gama.
Realizar el Disparador que realice esta tarea de forma automática y probarlo con
las siguientes sentencias: */

CREATE OR REPLACE TRIGGER TR_JOBS
AFTER UPDATE ON JOBS
FOR EACH ROW
DECLARE
    CURSOR C_EMPLOYEES IS SELECT * FROM EMPLOYEES 
    WHERE JOB_ID = :NEW.JOB_ID AND (SALARY < :NEW.MIN_SALARY OR SALARY > :NEW.MAX_SALARY)
    FOR UPDATE;
BEGIN
    FOR C IN C_EMPLOYEES LOOP
        IF C.SALARY < :NEW.MIN_SALARY THEN
            UPDATE EMPLOYEES
            SET SALARY = :NEW.MIN_SALARY
            WHERE CURRENT OF C_EMPLOYEES;
        ELSE
            UPDATE EMPLOYEES
            SET SALARY = :NEW.MAX_SALARY
            WHERE CURRENT OF C_EMPLOYEES;
        END IF;
    END LOOP;
END;
/

/* 3. Se desea actualizar automáticamente algunos valores particulares de una tabla
basada en otra actualización que se ha hecho en una columna específica de la otra
tabla. Por ejemplo, supongamos que la dirección ha decidido cambiar algunas
posiciones en torno de la organización. Un nuevo gerente accede a uno de los
puestos de gerente, por lo que varios empleados recibirán un nuevo gerente.
Encontrar una manera de actualizar varios registros de los empleados al cambiar
de gestor. */

CREATE OR REPLACE TRIGGER TR_DEPARTMENTS
AFTER UPDATE OF MANAGER_ID ON DEPARTMENTS
FOR EACH ROW
DECLARE
    CURSOR C_EMPLOYEES IS SELECT * FROM EMPLOYEES
    WHERE MANAGER_ID = :OLD.MANAGER_ID
    FOR UPDATE;
BEGIN
    FOR C IN C_EMPLOYEES LOOP
        UPDATE EMPLOYEES
        SET MANAGER_ID = :NEW.MANAGER_ID
        WHERE CURRENT OF C_EMPLOYEES;
    END LOOP;
END;
/

/* 4. Queremos evitar que los emails de los empleados contengan el nombre del
dominio que se supone el mismo para todos los empleados, siendo este el de la
empresa. Por tanto, queremos desarrollar un Trigger que evite que se inserten
empleados cuyo email contenga la “@”. La función INSTR devuelve la posición
en la que el segundo parámetro aparece en el primero. */

CREATE OR REPLACE TRIGGER TR_EMAIL
BEFORE INSERT ON EMPLOYEES
FOR EACH ROW
BEGIN
    IF :NEW.EMAIL LIKE '%@%' THEN
        RAISE_APPLICATION_ERROR(-20001, 'EMAIL INVALIDO');
    END IF;
END;
/

/* 5. Se quiere asegurar que el email sigue el formato: primera letra del nombre +
apellido. Si ese email existe se le añade un número (1 a la primera repetición, 2 a
la segunda, etc.). */

