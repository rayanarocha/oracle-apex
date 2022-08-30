-- definindo restrições de integridade

create type address_type as object(
    hno number,
    street varchar2(40),
    city varchar2(20),
    zip varchar2(5),
    phone varchar2(10)
);

create type person_type as object(
    name varchar2(40),
    dateofbirth date,
    homeaddress address_type
);

create table persosn of person_type(
    homeaddress not null,
    constraint persons_phone_uk unique (homeaddress.phone),
    check(homeaddress.zip is not null),
    check(homeaddress.city <> 'San Francisco')
);

