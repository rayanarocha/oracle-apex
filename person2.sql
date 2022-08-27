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

CREATE SEQUENCE person_seq
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 
CREATE SEQUENCE dpto_seq
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 
describe person_typ;

describe employee_typ;

CREATE TABLE person_tab OF person_typ;
CREATE TABLE student_tab OF student_typ;
CREATE TABLE monitor_tab OF monitor_typ;

drop TABLE person_tab;
drop TABLE student_tab;
drop TABLE monitor_tab;

INSERT INTO person_tab VALUES (person_typ(person_seq.nextval,'JOSE', '88839098'));
INSERT INTO student_tab VALUES(student_typ(person_seq.nextval,'MARIA','33372298', 20000));
INSERT INTO monitor_tab VALUES(monitor_typ(person_seq.nextval,'EICKMANN','33362288', 30000, 2010));

SELECT p.*
FROM person_tab p;

SELECT s.*
FROM student_tab s;

SELECT m.*
FROM monitor_tab m;

-- Como visualizar todas as pessoas usando uma única consulta?
SELECT p.name FROM person_tab p
UNION
SELECT s.name FROM student_tab s
UNION
SELECT m.name FROM monitor_tab m;

