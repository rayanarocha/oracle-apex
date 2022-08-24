
-- Object types
create TYPE endereco_type as object (
    rua varchar(20),
    cidade varchar(10),
    estado char(2),
    cep varchar(10)
);
/

create type fone_lista_type as varray(10) of varchar(20);
/

create type cliente_type as object (
    codigo number,
    nome varchar(80),
    endereco endereco_type,
    listafone fone_lista_type
)not final;
/

create type fone_lista_type as varray(10) of varchar(20);
/

create type cliente_vip_type under cliente_type (
    pontos integer,
    desconto number
);
/

create type cliente_especial_type under cliente_type (
    desconto number
);
/

create type produto_type as object (
    codigo number,
    preco number,
    taxa number
);
/

create type item_type as object (
    codigo number,
    produto ref produto_type,
    quantidade integer,
    desconto number
);
/

create type item_lista_type as table of item_type;
/

create type pedido_type as object (
    codigo number,
    cliente ref cliente_type,
    data date,
    dataentrega date,
    listaitens item_lista_type,
    enderecoentrega endereco_type
);

----------------------------------------- CREATE SEQUENCE -----------------------------------------
-- ID INCREMENTAL
CREATE SEQUENCE cliente_seq
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 
 CREATE SEQUENCE produto_seq
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 
CREATE SEQUENCE item_seq
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

----------------------------------------- CREATE TABLE --------------------------------------------
create table endereco of endereco_type;

create table cliente of cliente_type;

create table cliente_vip of cliente_vip_type;

create table cliente_especial of cliente_especial_type;

create table produto of produto_type;

create table item of item_type;

create table pedido of pedido_type;

----------------------------------------- DROP TABLE --------------------------------------------

drop table endereco;

drop table cliente;

drop sequence cliente_seq;

drop table cliente_vip;

drop table cliente_especial;

drop table produto;

drop table item;

----------------------------------------- INSERTS --------------------------------------------

insert into endereco values (endereco_type('Rua Beco sem saída', 'Coxixola', 'PB', '58000000'));

insert into cliente values (cliente_seq.nextval, 'Severino Biu', endereco_type('Rua Beco sem saída', 'Coxixola', 'PB', '58000000'), fone_lista_type('839912349876'));
insert into cliente values (cliente_type(cliente_seq.nextval, 'Ana Maria', endereco_type('Rua Beco sem saída', 'Coxixola', 'PB', '58000000'), fone_lista_type('839912349876')));

insert into cliente_vip values (cliente_seq.nextval, 'João José', endereco_type('Rua Beco sem saída', 'Coxixola', 'PB', '58000000'), fone_lista_type('839912349876'), 10, 5);

insert into cliente_especial values (cliente_seq.nextval, 'Pedro Paulo', endereco_type('Rua Beco sem saída', 'Coxixola', 'PB', '58000000'), fone_lista_type('839912349876'), 10);

insert into produto values (produto_type(produto_seq.nextval, 100, 10));

select * from endereco;

----------------------------------------- QUERYS --------------------------------------------

-- Consulta a tabela toda
select * from cliente;
-- Consulta cada atributo individualmente para mostrar os atributos que são dos tipos de objetos criados
select c.codigo, c.nome, c.endereco.rua, c.endereco.cidade, c.endereco.estado, c.endereco.cep, c.listafone from cliente c;

select * from cliente_vip;

select * from cliente_especial;

select * from produto;

----------------------------------------------------------------------------------------------

describe cliente_especial;

