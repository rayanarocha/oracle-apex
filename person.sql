CREATE TYPE person_typ AS OBJECT (
    idno NUMBER,
    first_name VARCHAR2(20),
    last_name VARCHAR2(25),
    email VARCHAR2(25),
    phone VARCHAR2(20),
    MAP MEMBER FUNCTION get_idno RETURN NUMBER,
    MEMBER PROCEDURE display_details(SELF IN OUT person_typ)
) not final;
    
CREATE SEQUENCE person_seq
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