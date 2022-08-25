create type solid_typ as object (
        len integer,
        wth integer,
        hgt integer,
        member function volume return integer,
        member function surface return integer,
        member procedure display (self in out solid_typ)
);

CREATE TYPE BODY solid_typ AS
    MEMBER FUNCTION volume RETURN INTEGER IS
    BEGIN
        RETURN len * wth * hgt;
        -- RETURN SELF.len * SELF.wth * SELF.hgt; -- equivalent to previous line
    END;
    MEMBER FUNCTION surface RETURN INTEGER IS
    BEGIN -- not necessary to include SELF prefix in following line
        RETURN 2 * (len * wth + len * hgt + wth * hgt);
    END;
    MEMBER PROCEDURE display (SELF IN OUT solid_typ) IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Length: ' || len || ' - ' || 'Width: ' || wth || ' - ' || 'Height: ' || hgt);
        DBMS_OUTPUT.PUT_LINE('Volume: ' || volume() || ' - ' || 'Surface area: ' || surface());
    END;
END;


CREATE SEQUENCE solid_seq
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 
create table solid_tab of solid_typ;

insert into solid_tab values (solid_typ(2, 2, 2));

select s.volume() as volume, s.surface() as superficie
from solid_tab s;

declare
    obj_solid solid_typ := solid_typ(2, 2, 2);
begin
    obj_solid.display();
end;