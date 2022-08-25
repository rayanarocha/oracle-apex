CREATE TYPE person_typ AS OBJECT (
    idno NUMBER,
    first_name VARCHAR2(20),
    last_name VARCHAR2(25),
    email VARCHAR2(25),
    phone VARCHAR2(20),
    MAP MEMBER FUNCTION get_idno RETURN NUMBER,
    MEMBER PROCEDURE display_details(SELF IN OUT person_typ)
) not final;
    
-- overloadable do construtor

create type t_person2 as object (
    id integer,
    first_name varchar2(10),
    last_name varchar2(10),
    dob date,
    phone varchar2(12),
    constructor function t_person2(p_id integer, p_first_name varchar2, p_last_name varchar2) 
    return self as result
);

create or replace type body t_person2 as
constructor function t_person2 (
    p_id integer,
    p_first_name varchar2,
    p_last_name varchar2
) return self as result is
begin
    self.id := p_id;
    self.first_name := p_first_name;
    self.last_name := p_last_name;
    self.dob := sysdate;
    self.phone := '5551212';
    return;
end;
end;

create table object_customers2 of t_person2;

insert into object_customers2 values (t_person2(person2_seq.nextval, 'Jeff', 'Jones'));

insert into object_customers2 values (t_person2(person2_seq.nextval, 'Mary', 'Jones', '01-JAN-2012','8887-9876'));

CREATE SEQUENCE person_seq
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 
CREATE SEQUENCE person2_seq
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

create table person_tab of person_typ;
drop table person_tab;

insert into person_tab values (person_typ(person_seq.nextval, 'José', 'Silva', 'jose@empresa.com', '88737390'));

CREATE TYPE BODY person_typ AS
    MAP MEMBER FUNCTION get_idno RETURN NUMBER IS
    BEGIN
        RETURN idno;
    END;
    MEMBER PROCEDURE display_details ( SELF IN OUT NOCOPY person_typ ) IS
    BEGIN
        -- printar na tela
        DBMS_OUTPUT.PUT_LINE(TO_CHAR(idno) || ' ' || first_name || ' ' || last_name);
        DBMS_OUTPUT.PUT_LINE(email || ' ' || phone);
    END;
END;

select p.get_idno()
from person_tab p;

create or replace type body t_person2 as
constructor function t_person2 (
    p_id integer,
    p_first_name varchar2,
    p_last_name varchar2
) return self as result is
begin
    self.id := p_id;
    self.first_name := p_first_name;
    self.last_name := p_last_name;
    self.dob := sysdate;
    self.phone := '5551212';
    return;
end;
end;