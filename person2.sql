create or replace type person_typ as object(
    idno number,
    name varchar2(30),
    phone varchar (20),
    final map member function get_idno return number
) not final;

CREATE TYPE employee_typ UNDER person_typ (
    depto_id NUMBER,
    funcao VARCHAR2(30),
    salario NUMBER
) FINAL;

CREATE TYPE professor_typ UNDER person_typ (
    dept_id NUMBER,
    speciality VARCHAR2(30)
) FINAL;

CREATE TYPE student_typ UNDER person_typ (
    registration NUMBER
) NOT FINAL;

CREATE TYPE monitor_typ UNDER
    student_typ (
    year NUMBER
) FINAL;

describe person_typ;

describe employee_typ;
