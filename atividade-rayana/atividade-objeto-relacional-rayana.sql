
-----------------TYPES-----------------------

create or replace type pessoa_type as object (
    cpf number(11),
    nome varchar2(30)
)not final;

create or replace type telefones_list as varray(3) of varchar2(15);

create or replace type cliente_type under pessoa_type (
    cod_cliente integer,
    data_cadastro date,
    telefones telefones_list
);

create or replace type funcionario_type under pessoa_type (
    cod_funcionario integer,
    turno varchar2(10)
);

create or replace type livro_type as object (
    cod_livro integer,
    autor varchar2(50),
    titulo varchar2(50)
);

create or replace type exemplar_type as object (
    cod_exemplar integer,
    data_compra date,
    livro ref livro_type
);

create type exemplar_nested as table of exemplar_type;

create or replace type locacao_type as object (
    cliente ref pessoa_type,
    data_locacao date,
    exemplar exemplar_nested
);

---------------------TABLES---------------------

create table pessoa_table of pessoa_type (
    cpf not null unique,
    nome not null
);

create table funcionario_table of funcionario_type (
    cod_funcionario primary key not null,
    turno not null
);

create table livro_table of livro_type (
   cod_livro primary key not null,
   autor not null,
   titulo not null
);

create table exemplar_table of exemplar_type (
    cod_exemplar primary key not null,
    data_compra not null,
    livro not null
);

create table locacao_table of locacao_type (
    data_locacao not null
)nested table exemplar store as nt_exemplar;

---------------------------INSERT-------------------------

insert into pessoa_table values (cliente_type(123456789, 'Pratik Skaggs', 001, sysdate, (telefones_list('37598727', '3726-2243'))));
insert into pessoa_table values (cliente_type(012345678, 'Uehudah Hack', 002, sysdate + 1, (telefones_list('37598727', '3726-2243'))));
insert into pessoa_table values (cliente_type(987654321, 'Edison Drye', 003, sysdate + 2, (telefones_list('37598727', '3726-2243'))));
insert into pessoa_table values (cliente_type(098765432, 'Mihoko Scholl', 004, sysdate + 3, (telefones_list('37598727', '3726-2243'))));
insert into pessoa_table values (cliente_type(012345679, 'Ajani Harding', 005, sysdate + 4, (telefones_list('37598727', '3726-2243'))));

insert into funcionario_table values (funcionario_type(95408175014, 'Carolyn Maddox', 100, 'manhã'));
insert into funcionario_table values (funcionario_type(22964743061, 'Charles Friedman', 101, 'manhã'));
insert into funcionario_table values (funcionario_type(28979047045, 'Pedro Jones', 102, 'manhã'));
insert into funcionario_table values (funcionario_type(09004167005, 'James Welch', 103, 'manhã'));
insert into funcionario_table values (funcionario_type(48203813003, 'Virginia Fisher', 104, 'manhã'));

insert into livro_table values (livro_type(400, 'Ruthie Coco', 'A ARCA DE NOÉ'));
insert into livro_table values (livro_type(401, 'Orazio Hart', 'A RAINHA DA NEVE'));
insert into livro_table values (livro_type(402, 'Vinaya Justus', 'ALADIM E A LAMPADA MARAVILHOSA'));
insert into livro_table values (livro_type(403, 'Tristan Karns', 'CACHINHOS DE OURO'));
insert into livro_table values (livro_type(404, 'Ardath Enriquez', 'CHAPEUZINHO E O LOBO MAU'));

insert into exemplar_table values (exemplar_type(300, sysdate, (select ref(e) from livro_table e WHERE cod_livro=400)));
insert into exemplar_table values (exemplar_type(301, sysdate + 1, (select ref(e) from livro_table e WHERE cod_livro=401)));
insert into exemplar_table values (exemplar_type(302, sysdate + 2, (select ref(e) from livro_table e WHERE cod_livro=402)));
insert into exemplar_table values (exemplar_type(303, sysdate + 3, (select ref(e) from livro_table e WHERE cod_livro=403)));
insert into exemplar_table values (exemplar_type(304, sysdate + 4, (select ref(e) from livro_table e WHERE cod_livro=404)));

insert into locacao_table values 
    (locacao_type(
        (select ref(p) from pessoa_table p WHERE cpf = 123456789), sysdate, exemplar_nested(
            exemplar_type(300, sysdate, (select ref(e) from livro_table e WHERE cod_livro=400)))));
            
insert into locacao_table values 
    (locacao_type(
        (select ref(p) from pessoa_table p WHERE cpf = 012345678), sysdate + 1, exemplar_nested(
            exemplar_type(301, sysdate, (select ref(e) from livro_table e WHERE cod_livro=401)))));

insert into locacao_table values 
    (locacao_type(
        (select ref(p) from pessoa_table p WHERE cpf = 987654321), sysdate + 2, exemplar_nested(
            exemplar_type(302, sysdate, (select ref(e) from livro_table e WHERE cod_livro=402)))));
            
insert into locacao_table values 
    (locacao_type(
        (select ref(p) from pessoa_table p WHERE cpf = 098765432), sysdate + 3, exemplar_nested(
            exemplar_type(303, sysdate, (select ref(e) from livro_table e WHERE cod_livro=403)))));
            
insert into locacao_table values 
    (locacao_type(
        (select ref(p) from pessoa_table p WHERE cpf = 012345679), sysdate + 4, exemplar_nested(
            exemplar_type(304, sysdate, (select ref(e) from livro_table e WHERE cod_livro=404)))));


-----------------SELECT--------------------

select * from pessoa_table;
select * from exemplar_table;
select * from locacao_table;
select * from livro_table;

--Para cada um dos dois esquemas criados, escreva uma consulta que mostre o nome do cliente e o título dos livros que ele locou com a 
--respectiva data de locação. Mostre as consultas e o resultado de cada uma. Obviamente, os resultados devem ser iguais.

select loc.cliente.nome as CLIENTE, loc.livro.titulo as TÍTULO, loc.data_locacao
from locacao_table loc, table (loc.exemplar) loc;

-----------------DROP TYPE AND TABLES--------------------
drop type pessoa_type force;
drop type telefones_list force;
drop type cliente_type force;
drop type funcionario_type force;
drop type livro_type force;
drop type exemplar_type force;
drop type exemplar_nested force;
drop type locacao_type force;

drop table pessoa_table;
drop table livro_table;
drop table exemplar_table;
drop table locacao_table;

delete from pessoa_table;
delete from livro_table;
delete from exemplar_table;
delete from locacao_table;