update LOCATIONS set DEPARTMENT_AMOUNT = 0;

create or replace trigger update_dept_amount
    after INSERT or DELETE
    on DEPARTMENTS
    for each row
declare
BEGIN
    if inserting then
        update LOCATIONS set DEPARTMENT_AMOUNT = DEPARTMENT_AMOUNT + 1 where LOCATION_ID = :new.LOCATION_ID;
    end if;
    if deleting then
        update LOCATIONS set DEPARTMENT_AMOUNT = DEPARTMENT_AMOUNT - 1 where LOCATION_ID = :old.LOCATION_ID;
    end if;
end;