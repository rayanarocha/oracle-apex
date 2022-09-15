drop type aluno
drop type alunos_varr
drop type alunos_nt_typ
drop type professores_varr
drop type professor
drop type orientadores

create type professor as object(
    id_prof integer,
    nome_prof varchar2(20),
    area varchar2(20)
);

create type orientadores as varray(2) of ref professor;

create type aluno as object(
    id_aluno integer,
    nome_aluno varchar2(20),
    orientadores_ orientadores
);

create type orientandos as varray(8) of ref aluno;

alter type professor add attribute orientandos_ orientandos cascade;

create table professores_tab of professor;

create table alunos_tab of aluno;

insert into alunos_tab(id_aluno, nome_aluno) values (1, 'carlos');
insert into alunos_tab(id_aluno, nome_aluno) values (2, 'maria');
insert into alunos_tab(id_aluno, nome_aluno) values (3, 'joao');

insert into professores_tab(id_prof, nome_prof) values(1, 'fernando');
insert into professores_tab(id_prof, nome_prof) values(2, 'monica');

update alunos_tab set orientadores_ = orientadores((select ref(p) from professores_tab p where p.id_prof=1)) where id_aluno = 1;
update alunos_tab set orientadores_ = orientadores((select ref(p) from professores_tab p where p.id_prof=1), (select ref(p) from professores_tab p where p.id_prof=2)) where id_aluno = 2;

select a.nome_aluno , deref(value(o)).nome_prof from alunos_tab a, table(a.orientadores_) o;