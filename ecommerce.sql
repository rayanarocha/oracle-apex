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