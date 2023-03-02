-- Alteração intra-modelo

create table funcionario1(
    nome varchar2(50),
    cpf varchar2(11),
    telefone varchar2(15)
)

alter table funcionario1 add endereco varchar2(50);

insert into funcionario1 values ('João', '07296900083', '6826630260');
insert into funcionario1 values ('Dolli', '40084159049', '7826630260');
insert into funcionario1 values ('Doan', '14922387080', '8826630260');
insert into funcionario1 values ('Loel', '98188161020', '9826630260', 'Rua Paulo Torres Fausto');

select * from funcionario1 where funcionario1.nome = 'Loel';