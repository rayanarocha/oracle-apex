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


----------------------------------------------------------------------------------------

-- Questionário A5Q2

create type empresa_type as object (
    cnpj integer,
    nome_fantasia varchar2(30),
    pais varchar2(25),
    fundacao date
);

create type funcionario_type as object (
    cpf integer,
    nome varchar2(30), 
    sexo char(1),
    nasc date,
    empresa ref empresa_type
);

create table empresa_tab of empresa_type(primary key(cnpj));

create table funcionario_tab of funcionario_type(
    primary key(cpf),
    constraint fk_empresa foreign key(empresa) references empresa_tab);
    
insert into empresa_tab values (123456, 'Armazem Paraiba', 'Brasil', TO_DATE('20/02/1987'));
insert into empresa_tab values (987654, 'Magalu', 'Brasil', TO_DATE('01/07/1998'));

insert into funcionario_tab values (1234, 'Zé', 'M', to_date('28/08/1980'), (select ref(e) from empresa_tab e where e.cnpj = 123456));
insert into funcionario_tab values (5678, 'Zé', 'M', to_date('28/08/1980'), (select ref(e) from empresa_tab e where e.cnpj = 987654));
insert into funcionario_tab values (9874, 'João', 'M', to_date('28/08/1980'), (select ref(e) from empresa_tab e where e.cnpj = 987654));

select * from funcionario_tab;

alter type empresa_type add member function contaempregados return integer cascade;

CREATE OR REPLACE TYPE BODY EMPRESA_TYPE AS
    MEMBER FUNCTION contaempregados RETURN INTEGER IS
        total_empregados INTEGER;
    BEGIN
        SELECT COUNT(*) INTO total_empregados FROM funcionario_tab f WHERE f.empresa.cnpj = self.cnpj;
        RETURN total_empregados;
    END;
END;

SELECT e.nome_fantasia, e.contaempregados() FROM empresa_tab e;
