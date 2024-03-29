---------------CRIANDO AS TABELAS------------------------

create table pessoa(
    cpf number(11) not null unique,
    nome varchar2(40) 
); 

create table funcionario(
    cod_funcionario int primary key not null,  
    turno varchar2(40),
    cpf integer not null,
    constraint fk_cpf_funcionario foreign key (cpf) references pessoa(cpf)
); 

create table cliente(
    cod_cliente integer primary key not null,
    data_cadastro date,
    telefone1 varchar2(12),
    telefone2 varchar2(12),
    cpf integer not null,
    constraint fk_cod_cliente foreign key (cpf) references pessoa(cpf)
);

create table livro( 
    cod_livro integer primary key not null,  
    autor varchar2(40),  
    titulo varchar2(40)  
); 

create table exemplar( 
    cod_exemplar integer primary key not null,  
    data_compra date,
    cod_livro integer not null,
    constraint fk_cod_livro foreign key (cod_livro) references livro(cod_livro)
); 

create table locacao(
    data_locacao date,
    cod_cliente integer not null,
    cod_exemplar integer not null,
    constraint cod_cliente_fk foreign key (cod_cliente) references cliente(cod_cliente),
    constraint cod_exemplar_fk foreign key (cod_exemplar) references exemplar(cod_exemplar)
);

---------------INSERT------------------------

insert into pessoa values (123456789, 'Pratik Skaggs');
insert into pessoa values (012345678, 'Uehudah Hack');
insert into pessoa values (987654321, 'Edison Drye');
insert into pessoa values (098765432, 'Mihoko Scholl');
insert into pessoa values (012345679, 'Ajani Harding');

insert into funcionario values (100, 'manh�', 123456789);
insert into funcionario values (101, 'tarde', 012345678);
insert into funcionario values (102, 'manh�', 987654321);
insert into funcionario values (103, 'noite', 098765432);
insert into funcionario values (104, 'manh�', 012345679);

insert into cliente values (200, sysdate, 988745641, 999456350, 123456789);
insert into cliente values (201, sysdate + 1, 996587441, 987456210, 012345678);
insert into cliente values (202, sysdate + 2, 37889839, 34273226, 987654321);
insert into cliente values (203, sysdate + 3, 26615109, 24531220, 098765432);
insert into cliente values (204, sysdate + 4, 32336348, 33569377, 012345679);

insert into livro values (400, 'Ruthie Coco', 'A ARCA DE NO?');
insert into livro values (401, 'Orazio Hart', 'A RAINHA DA NEVE');
insert into livro values (402, 'Vinaya Justus', 'ALADIM E A LAMPADA MARAVILHOSA');
insert into livro values (403, 'Tristan Karns', 'CACHINHOS DE OURO');
insert into livro values (404, 'Ardath Enriquez', 'CHAPEUZINHO E O LOBO MAU');

insert into exemplar values (300, sysdate, 400);
insert into exemplar values (301, sysdate + 1, 401);
insert into exemplar values (302, sysdate + 2, 402);
insert into exemplar values (303, sysdate + 3, 403);
insert into exemplar values (304, sysdate + 4, 404);

insert into locacao values (sysdate, 200, 300);
insert into locacao values (sysdate + 1, 201, 301);
insert into locacao values (sysdate + 2, 202, 302);
insert into locacao values (sysdate + 3, 203, 303);
insert into locacao values (sysdate + 4, 204, 304);

---------------SELECT------------------------

select * from pessoa;
select * from funcionario;
select * from cliente;
select * from exemplar;
select * from locacao;
select * from livro;

--Para cada um dos dois esquemas criados, escreva uma consulta que mostre o nome do cliente e o t?tulo dos livros que ele locou com a 
--respectiva data de loca??o. Mostre as consultas e o resultado de cada uma. Obviamente, os resultados devem ser iguais.

select p.nome, l.titulo, loc.data_locacao 
from cliente c
inner join pessoa p using(cpf)
inner join locacao loc using(cod_cliente)
inner join exemplar e using(cod_exemplar)
inner join livro l using(cod_livro);

---------------DROP------------------------
drop table pessoa force;
drop table funcionario force;
drop table cliente force;
drop table exemplar force;
drop table locacao force;
drop table livro force;

delete from pessoa;
delete from funcionario;
delete from cliente;
delete from exemplar;
delete from locacao;
delete from livro;