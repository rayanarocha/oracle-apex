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

----------------------------------------------------------------------------------------

-- Questionário A6Q1

create type membro_type as object (
    cpf integer,
    nome varchar2(30),
    sexo char(1),
    nasc date
) not final;

drop type membro_type;
drop table membro_tab;

create or replace type docente_type under membro_type (
    siape integer,
    admissao date,
    overriding member function calculatempo return integer
);

create type discente_type under membro_type (
    matricula integer,
    curso varchar2(20)
);

create table membro_tab of membro_type (primary key (cpf));

insert into membro_tab values (docente_type(73635526728, 'PEDRO', 'M', to_date('11-JAN-1972'), 1477839, to_date('19-JAN-1996')));
insert into membro_tab values (docente_type(11165527828, 'JOANA', 'F', to_date('20-JUN-1962'), 8276151, to_date('16-NOV-2000')));
insert into membro_tab values (discente_type(73688876721, 'SANDRA', 'F', to_date('17-JAN-2000'), 201928726, 'COMPUTACAO'));
insert into membro_tab values (discente_type(22225526726, 'RENATO', 'M', to_date('30-JUN-1999'), 202018736, 'ELETRICA'));

alter type membro_type add member function calculatempo return integer cascade;

CREATE OR REPLACE TYPE BODY membro_type AS
    MEMBER FUNCTION calculatempo RETURN INTEGER IS
        idade INTEGER;
        BEGIN
            SELECT (sysdate - m.nasc)/365 INTO idade FROM membro_tab m WHERE m.CPF = self.CPF;
            RETURN idade;
        END;
END;

select m.nome, m.calculatempo() as idade from membro_tab m;

CREATE OR REPLACE TYPE BODY docente_type AS
    overriding MEMBER FUNCTION calculatempo RETURN INTEGER IS
        idade INTEGER;
        BEGIN
            SELECT (sysdate - m.nasc)/365 INTO idade FROM membro_tab m WHERE m.CPF = self.CPF;
            RETURN idade;
        END;
END;

select m.nome, m.calculatempo() as idade from membro_tab m;

----------------------------------------------------------------------------------------

-- Questionário A7Q1

create type dimensao_type as object (
    comprimento number,
    largura number,
    altura number
);

create type produto_type2 as object (
    id number,
    nome varchar2(20),
    dimensao dimensao_type,
    cor varchar2(15)
);

-- criando restrição de integridade com a cláusula check
create table produto_tab of produto_type2 (
    primary key(id),
    nome not null,
    constraint ck_comprimento check(dimensao.comprimento > 0),
    constraint ck_altura check(dimensao.altura > 0),
    constraint ck_largura check(dimensao.largura > 0)
);

describe produto_tab;

insert into produto_tab values(100, 'mesa', (dimensao_type(3, 1, 1)), 'marrom');
insert into produto_tab values(102, 'sofa', (dimensao_type(4, 2, 2)), 'cinza');
insert into produto_tab values(101, 'mesa', null, 'preta');

--Atualize as dimensões do produto 102 para comprimento = 3, largura = 1 e altura = 1.

update produto_tab set dimensao = dimensao_type(3,1,1) where id=102;

select * from produto_tab;

--Exiba o OID dos objetos contidos em Produto_tab cuja altura é igual a 1.
select ref(p) from produto_tab p
where p.dimensao.altura = 1;

alter type produto_type2 add member function area return number cascade;

create or replace type body produto_type2 as
member function area return number is
    begin
        return dimensao.comprimento * dimensao.altura * dimensao.largura;
    end;
end;

select p.nome, p.area() as area from produto_tab p
order by p.area() desc;

----------------------------------------------------------------------------------------

-- Questionário A8Q1

--Crie o Object Type Lider_Type com os atributos: codigo INTEGER, nome VARCHAR2(20).

create type lider_type as object (
    codigo integer,
    nome varchar2(20)
);

--Crie a Object Table Lider_Tab usando como molde o Object Type lider_type. A coluna codigo deve ser chave primária.

create table lider_tab of lider_type(primary key (codigo));

--(c) Insira os seguintes objetos na Object Table lider_tab:

--10, José
--20, Maria

insert into lider_tab values (10, 'José');
insert into lider_tab values (20, 'Maria');

--Crie o Object Type Integrante_Type com os atributos: codigo INTEGER, nome VARCHAR2(20) e lider REF lider_type.

create type integrante_type as object (
    codigo integer,
    nome varchar2(20),
    lider ref lider_type
);

--Crie a Object Table Integrante_Tab usando como molde o Object Type Intregrante_type. 
--A coluna codigo deve ser chave primária. A coluna lider deve ser uma chave estrangeira de Lider_Tab.

create table integrante_tab of integrante_type (
    primary key (codigo),
    constraint fk_lider foreign key(lider) references lider_tab
);

--Insira os seguintes objetos na Object Table integrante_tab:

insert into integrante_tab values (integrante_type(100, 'Pedro',(select ref(l) from lider_tab l where l.nome = 'José')));
insert into integrante_tab values (integrante_type(200, 'Paula',(select ref(l) from lider_tab l where l.nome = 'Maria')));
insert into integrante_tab values (integrante_type(300, 'Marta',(select ref(l) from lider_tab l where l.nome = 'Maria')));

--Elabore uma consulta SQL para mostrar o nome dos líderes e o nome dos respectivos integrantes.

select i.lider.nome as lider, i.nome as integrante from integrante_tab i;

--Crie o Object Type Integrante2_Type com os atributos: codigo INTEGER e nome VARCHAR2(20).

create type integrante2_type as object (
    codigo integer,
    nome varchar2(20)
);

--Crie o OBJECT TYPE Integrantes_Type como uma lista de integrantes2. Use: AS TABLE OF.

create type integrantes_type as table of integrante2_type;

--Crie o OBJECT TYPE Lider2_Type com os seguintes atributos: codigo INTEGER, nome VARCHAR2(20) e integrantes Integrantes_Type.

create type lider2_type as object (
    codigo integer,
    nome varchar2(20),
    integrantes integrantes_type
);

--Crie a OBJECT TABLE Lider2_Tab usando como molde o Object Type Lider2_Type. A coluna codigo deve ser chave primária.

create table lider2_tab of lider2_type(primary key(codigo))
nested table integrantes store as interantes_nt;

drop table lider2_tab;

--Insira os seguintes objetos na Object Table lider2_tab:

--10, José, <(100, Pedro)>
--20, Maria, <(200, Paula),(300, Marta)>

INSERT INTO lider2_tab VALUES (lider2_type(
10, 'José',
integrantes_type (
integrante2_type (100, 'Pedro')
)
));

insert into lider2_tab 
values(lider2_type(20, 'Maria', integrantes_type(integrante2_type(200, 'Paula'), integrante2_type(300, 'Marta'))));

--Elabore uma consulta SQL para mostrar o nome dos líderes e o nome dos respectivos integrantes.

select l.nome, i.* 
from lider2_tab l, table(l.integrantes) i;

----------------------------------------------------------------------------------------

-- Questionário A1011Q1

create type secretario_type as object(
    contador integer,
    nomes varchar2(20)
);

create type secretarios_list as table of ref secretario_type;

create type telefone_type as object(
    numero varchar2(11)
);

create type telefone_varray as varray(3) of telefone_type;

create type assessores_type as object(
    codigo integer,
    nome varchar2(20),
    telefones telefone_varray,
    secretarios secretarios_list
);

drop type politico_type force;

create type assessores_list as table of ref assessores_type;

create type politico_type as object(
    matricula integer,
    nomep varchar2(20),
    nascimento date,
    telefones telefone_varray,
    assessores assessores_list
);

create table politico_table of politico_type(
    primary key(matricula),
    nomep not null,
    nascimento not null)
nested table assessores store as assessores_nt
(nested table secretarios store as secretarios_nt);
