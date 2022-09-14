create type area_type as object(
    idarea integer,
    nome varchar2(20)
);

create type aluno_type as object(
    idaluno varchar2(20),
    nome varchar2(20)
);

create type alunos_list as table of ref aluno_type;

create type professor_type as object(
    idprofessor varchar2(20),
    nome varchar2(20),
    area area_type,
    lista_alunos alunos_list
);

create table aluno_tab of aluno_type(primary key(idaluno));

create table professor_tab of professor_type(primary key(idprofessor));

drop table professor_tab;

insert into aluno_tab values (aluno_type(1, 'Gustavo'));
insert into aluno_tab values (aluno_type(2, 'Felipe'));

select * from aluno_tab;

select ref(a) from aluno_tab a where idaluno = '1';

insert into professor_tab 
values (professor_type(1, 'Gabriel', (area_type(1, 'Banco de Dados', 'Banco de dados')), alunos_list(select ref(a) from aluno_tab a where idaluno = '1')));

