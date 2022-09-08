create type telefone_obj_type as object(
    pais char(3),
    ddd char(2),
    numero char(9)
);

create type endereco_obj_type as object(
    rua varchar2(20),
    complemento varchar2(5),
    bairro varchar2(10),
    cidade varchar2(20),
    estado char(2)
);

create type contribuinte_obj_type as object(
    cpf varchar2(11),
    nome varchar2(30),
    nascimento date,
    telefone telefone_obj_type,
    endereco endereco_obj_type
);

create table contribuinte_obj_table of contribuinte_obj_type;

desc contribuinte_obj_table;

insert into contribuinte_obj_table 
values (contribuinte_obj_type('123', 'Maria', TO_DATE('20/02/1987'), telefone_obj_type('+55', '83', '789456'), endereco_obj_type('Rua A', 'casa', 'bairro', 'cidade', 'pb')));

alter type contribuinte_obj_type add member procedure format_phone cascade;

create or replace type body contribuinte_obj_type as member procedure format_phone (self in out contribuinte_obj_type) is

begin
    dbms_output.put_line(self.telefone.pais || '( ' || self.telefone.ddd || ') ' || self.telefone.numero);
end;
end;

SELECT c.format_phone as telefone
FROM contribuinte_obj_table c;

drop type telefone_obj_type;

drop table contribuinte_obj_table;

select c.telefone.pais from contribuinte_obj_table c;