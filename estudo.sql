create type departments_obj as object (
    iddepartments integer,
    nomedepartamento varchar2(10)
);

drop type departments_obj;

create table departments_tab of departments_obj (primary key (iddepartments));

insert into departments_tab values (departments_obj(1, 'RH'));
insert into departments_tab values (departments_obj(2, null));

alter type departments_obj add static function conta_dep return integer cascade;

drop table departments_tab;

describe departments_obj;

create or replace type body departments_obj as
static function conta_dep return integer is
    total integer;
begin
    select count(*) into total from departments_tab d where d.nomedepartamento = null;
    return total;
end;
end;


SELECT DEPARTMENTS_OBJ.conta_dep() FROM dual;



CREATE OR REPLACE TYPE BODY DEPARTMENTS_OBJ AS
    STATIC FUNCTION conta_dep RETURN INTEGER IS
        total INTEGER;
        BEGIN
            SELECT COUNT(*) INTO total FROM DEPARTMENTS_TAB WHERE id IS NULL;
            return total;
        END;
END;



