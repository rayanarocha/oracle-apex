
-- Object types
create type endereco_type as object (
    rua varchar(20),
    cidade varchar(10),
    estado char(2),
    cep varchar(10)
);

create type fone_lista_type as varray(10) of varchar(20);

create type cliente_type as object (
    codigo number,
    nome varchar(80),
    endereco endereco_type,
    listafone fone_lista_type
)not final;

create type fone_lista_type as varray(10) of varchar(20);

create type cliente_vip_type under cliente_type (
    pontos integer,
    desconto number
);

create type cliente_especial_type under cliente_type (
    desconto number
);

create type produto_type as object (
    codigo number,
    preco number,
    taxa number
);

create type item_type as object (
    codigo number,
    produto ref produto_type,
    quantidade integer,
    desconto number
);

insert into item 
values (item_type(item_seq.nextval, (select ref(p) from produto p where p.codigo = '3'), 10, 5 ));

create type item_lista_type as table of item_type;

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
insert into endereco values (endereco_type('Rua Túnel do tempo', 'Coxixola', 'PB', '58000011'));
insert into endereco values (endereco_type('Rua José V. Silva', 'Mossoró', 'RN', '58000001'));
insert into endereco values (endereco_type('Rua Francisco Motta', 'Mossoró', 'RN', '58000000'));

insert into cliente values (cliente_seq.nextval, 'Severino Biu', endereco_type('Rua Beco sem saída', 'Coxixola', 'PB', '58000000'), fone_lista_type('839912349876'));
insert into cliente values (cliente_type(cliente_seq.nextval, 'Ana Maria', endereco_type('Rua Beco sem saída', 'Coxixola', 'PB', '58000000'), fone_lista_type('839912349876')));
insert into cliente values (cliente_seq.nextval, 'Manel', endereco_type('Rua José V. Silva', 'Mossoró', 'RN', '58000011'), fone_lista_type('839912349876'));

insert into cliente_vip values (cliente_seq.nextval, 'Bastião', endereco_type('Rua Francisco Motta', 'Mossoró', 'RN', '58000000'), fone_lista_type('839912349876'), 10, 5);

insert into cliente_especial values (cliente_seq.nextval, 'Pedro Paulo', endereco_type('Rua Beco sem saída', 'Coxixola', 'PB', '58000000'), fone_lista_type('839912349876'), 10);

insert into produto values (produto_type(produto_seq.nextval, 100, 10));


----------------------------------------- QUERYS --------------------------------------------

select * from endereco;
-- Consulta a tabela toda
select * from cliente;
-- Consulta cada atributo individualmente para mostrar os atributos que são dos tipos de objetos criados
select c.codigo, c.nome, c.endereco.rua, c.endereco.cidade, c.endereco.estado, c.endereco.cep, c.listafone from cliente c;

select * from cliente_vip;

select * from cliente_especial;

select * from produto;

select cli.ende.rua, cli.ende.cidade, cli.ende.estado, cli.ende.cep
from cliente cli
order by ende desc;

-- select pra pegar o OID do objeto
select ref(c)
from cliente c
where c.nome = 'Severino Biu';

select ref(p) 
from produto p 
where p.codigo = '3';

select i.codigo, i.produto, i.quantidade, i.desconto from item i;

-------------------------------- OUTROS COMANDOS ---------------------------------------------
-- Comando pra ver a estrutura física da tabela
describe cliente_especial;

-- Comando para limpar as tabelas
truncate table endereco;

--------------------------------------- MÉTODOS ----------------------------------------------

ALTER TYPE endereco_type ADD MAP MEMBER FUNCTION compara RETURN varchar2 cascade;

CREATE TYPE BODY endereco_type AS
  MAP MEMBER FUNCTION compara RETURN varchar2 IS
  BEGIN
    RETURN self.rua || ' ' || self.bairro;
  END;
END;

ALTER TYPE endereco_type DROP MAP MEMBER FUNCTION compara RETURN varchar2 CASCADE;

ALTER TYPE endereco_type add order member function ordena (e_ende IN endereco_type) return integer cascade;

CREATE OR REPLACE TYPE BODY endereco_type AS
  ORDER MEMBER FUNCTION ordena (e_ende IN endereco_type) RETURN INTEGER IS
  BEGIN
    IF self.estado = e_ende.estado THEN
      RETURN 0;
    ELSIF self.cep > e_ende.cep THEN
      RETURN 1;
    ELSE
      RETURN -1;
    END IF;    
  END;
END;

