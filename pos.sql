create type area_type as object(
    idarea integer,
    nome varchar2(20),
    descricao varchar2(30)
);

create or replace type aluno as object(
    idaluno varchar2(20),
    nome varchar2(20)
);

create or replace type alunos_list as varray(8) of aluno;

drop type area_type;

create or replace type professor_type as object(
    idprofessor varchar2(20),
    nome varchar2(20),
    area area_type,
    lista_alunos alunos_list
);

create table area_tab of area_type(primary key(idarea));

create 