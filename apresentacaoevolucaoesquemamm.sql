-- Alteração intra-modelo

create table funcionario1(
    nome varchar2(50),
    cpf varchar2(11),
    telefone varchar2(15)
)

alter table funcionario1 add endereco varchar2(50);
alter table funcionario1 add versao int;

--insert into funcionario1 values ('João', '07296900083', '6826630260');
--insert into funcionario1 values ('Dolli', '40084159049', '7826630260');
--insert into funcionario1 values ('Doan', '14922387080', '8826630260');
--insert into funcionario1 values ('Loel', '98188161020', '9826630260', 'Rua Paulo Torres Fausto');
insert into funcionario1 values ('Barbara', '41964896053', '3504319757', 'Dom Pedro II', '0');
insert into funcionario1 values ('Kean', '05686118027', '9504319757', 'Castro Alves', '0');

select * from funcionario1;

drop table funcionario1