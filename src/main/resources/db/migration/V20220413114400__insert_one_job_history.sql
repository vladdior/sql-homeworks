insert into JOBS
values ('IT_DEV', 'Developer', 2000, 10000);

insert into REGIONS
values (20, 'New-York State');
insert into COUNTRIES
values ('US', 'United States', '20');
insert into LOCATIONS
values (900, '42 st.', '200500', 'New-York', '20', 'US');
insert into DEPARTMENTS
values (50, 'IT department', null, 900);

insert into EMPLOYEES (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID, DEPARTMENT_ID)
values (100, 'Matt', 'Roy', 'mroy@mail.com', '13-sep-2009', 'IT_DEV', 50);

insert into JOB_HISTORY
values (100, '13-sep-2009', '28-may-2013', 'IT_DEV', 50);