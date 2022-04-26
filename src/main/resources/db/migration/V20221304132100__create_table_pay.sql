create table pay
(
    cardNr         number(16),
    salary         number(8, 2),
    commission_pct number(2, 2),
    constraint pk_pay primary key (cardNr)
);

alter table EMPLOYEES
    add cardNr number(16)
        constraint fk_emp_cardNr references pay (cardNr) on delete cascade;

alter table EMPLOYEES
    add constraint unique_emp_cardNr unique (cardNr);

insert into pay (cardNr)
values (5555555555554444);

update EMPLOYEES
set cardNr         = 5555555555554444,
    SALARY         = 7000,
    COMMISSION_PCT = 0.25
where EMPLOYEE_ID = 100;

update pay p
set salary         = (select SALARY from EMPLOYEES e where p.cardNr = e.cardNr),
    commission_pct = (select COMMISSION_PCT from EMPLOYEES e where p.cardNr = e.cardNr);