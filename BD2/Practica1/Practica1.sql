set serveroutput on

-- Ejercicio 1
declare
    cursor c_tablas is
        select table_name from user_tables;
begin
    for tabla in c_tablas loop
        dbms_output.put_line('La tabla ' || tabla.table_name || ' pertenece al esquema ' || user);
    end loop;
end;
/

-- Ejercicio 2
declare
    cursor c_tablas is
        select owner, table_name from all_tables;
begin
    for tabla in c_tablas loop
        dbms_output.put_line('La tabla ' || tabla.table_name || ' pertenece al esquema ' || tabla.owner);
    end loop;
end;
/

-- Ejercicio 3 y 4
-- Si filtramos all_tables para que el owner coincida con el usuario que ejecuta el script, es basicamente hacer el ejercicio 1, usar user_tables, ya que este esta incluido en all_tables

-- Ejercicio 5
create or replace procedure recorre_tablas(p_mode in number default null) is
    cursor c_tablas is 
        select owner, table_name from all_tables where owner = decode(nvl(p_mode, -1), 0, owner, USER);
begin
    if p_mode is null then
        dbms_output.put_line('--- MANUAL DE RECORRE_TABLAS ---');
        dbms_output.put_line('0: Lista TODAS las tablas con permiso');
        dbms_output.put_line('!= 0: Lista solo tus tablas PROPIAS');
        dbms_output.put_line('NULL: Muestra este mensaje de ayuda');
    else 
        for tabla in c_tablas loop
            dbms_output.put_line('La tabla ' || tabla.table_name || ' pertenece al esquema ' || tabla.owner);
        end loop;
    end if;
end recorre_tablas;
/

execute recorre_tablas(0);
execute recorre_tablas(1);
execute recorre_tablas();
