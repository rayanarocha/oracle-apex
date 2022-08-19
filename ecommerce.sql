
-- Object type, tabela, drop, sequence, insert e select referente ao Endereço
create TYPE endereco_type as object (
    rua varchar(20),
    cidade varchar(10),
    estado char(2),
    cep varchar(10)
);
/

create table endereco of endereco_type;
drop table endereco;

insert into endereco values (endereco_type('Rua Beco sem saída', 'Coxixola', 'PB', '58000000'));
select * from endereco;

-----------------------------------------------------------------------------------------------

-- Cria coleção de telefone
create type fone_lista_type as varray(10) of varchar(20);
/
------------------------------------------------------------------------------------------------

-- Object type, tabela, drop, sequence, insert e select referente ao Cliente
create type cliente_type as object (
    codigo number,
    nome varchar(80),
    endereco endereco_type,
    listafone fone_lista_type
)not final;
/

create table cliente of cliente_type;
drop table cliente;

CREATE SEQUENCE cliente_seq
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 
drop sequence cliente_seq;

insert into cliente values (cliente_seq.nextval, 'Severino Biu', endereco_type('Rua Beco sem saída', 'Coxixola', 'PB', '58000000'), fone_lista_type('839912349876'));
insert into cliente values (cliente_type(cliente_seq.nextval, 'Ana Maria', endereco_type('Rua Beco sem saída', 'Coxixola', 'PB', '58000000'), fone_lista_type('839912349876')));
-- Consulta a tabela toda
select * from cliente;
-- Consulta cada atributo individualmente para mostrar os atributos que são dos tipos de objetos criados
select c.codigo, c.nome, c.endereco.rua, c.endereco.cidade, c.endereco.estado, c.endereco.cep, c.listafone from cliente c;
---------------------------------------------------------------------------------------------------------------------------------------------

-- Object type, tabela, drop, insert e select referente ao Cliente Vip
create type cliente_vip_type under cliente_type (
    pontos integer,
    desconto number
);
/

create table cliente_vip of cliente_vip_type;
drop table cliente_vip;

insert into cliente_vip values (cliente_seq.nextval, 'João José', endereco_type('Rua Beco sem saída', 'Coxixola', 'PB', '58000000'), fone_lista_type('839912349876'), 10, 5);
select * from cliente_vip;
-----------------------------------------------------------------------------------------------------

-- Object type, tabela, drop, insert e select referente ao Cliente Especial
create type cliente_especial_type under cliente_type (
    desconto number
);
/

create table cliente_especial of cliente_especial_type;
drop table cliente_especial;
describe cliente_especial;

insert into cliente_especial values (cliente_seq.nextval, 'Pedro Paulo', endereco_type('Rua Beco sem saída', 'Coxixola', 'PB', '58000000'), fone_lista_type('839912349876'), 10);
select * from cliente_especial;
-----------------------------------------------------------------------------------------------------

-- Object type, tabela, drop, sequence, insert e select referente ao Produto
create type produto_type as object (
    codigo number,
    preco number,
    taxa number
);
/

create table produto of produto_type;
drop table produto;

CREATE SEQUENCE produto_seq
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 
insert into produto values (produto_type(produto_seq.nextval, 100, 10));
select * from produto;
-----------------------------------------------------------------------------------------------------

create type item_type as object (
    codigo number,
    produto ref produto_type,
    quantidade integer,
    desconto number
);
/

create table item of item_type;
drop table item;

CREATE SEQUENCE item_seq
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 
insert into item values (item_type(item_seq.nextval, (produto_type(1, 1, 1)), 10, 10));
 
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

create table pedido of pedido_type;
