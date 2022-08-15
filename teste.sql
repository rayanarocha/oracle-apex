create type person_typ as object (
    idno number,
    first_name varchar(20),
    last_name varchar(25),
    email varchar(25),
    phone varchar(20),
    map member function get_idno return number,
    member procedure display_detais (self in out nocopy person_typ)
);
/