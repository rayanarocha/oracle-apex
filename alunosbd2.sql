create or replace type alunosbd2_typ as object(
    matricula number,
    nome varchar(20),
    semestre number,
    ano number,
    static procedure atualiza (p_semestre in number),
    static function total return integer
);

CREATE SEQUENCE alunosbd2_seq
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 
create table alunosbd2_tab of alunosbd2_typ;

drop table alunosbd2_tab;

insert into alunosbd2_tab values (alunosbd2_typ(alunosbd2_seq.nextval,'JOSE',20101,null));
insert into alunosbd2_tab values (alunosbd2_typ(alunosbd2_seq.nextval,'MARIA',20111,null));
insert into alunosbd2_tab values (alunosbd2_typ(alunosbd2_seq.nextval,'PEDRO',20111,null));

create or replace type body alunosbd2_typ as
    static procedure atualiza (p_semestre in number) is
    begin
        update alunosbd2_tab
        set ano = to_number(substr(to_char(semestre), 1, 4))
        where semestre = p_semestre;
    end;
    static function total return integer
    is
        v_total integer;
        begin
            select count(*) into v_total from alunosbd2_tab;
            return v_total;
        end;
    end;
    
declare 
    v_total integer;
begin
    alunosbd2_typ.atualiza(20111);
    v_total := alunosbd2_typ.total();
    dbms_output.put_line(v_total);
end;
