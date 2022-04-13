create or replace trigger log_emp_trigger
    after insert or delete
    on EMPLOYEES
    for each row
begin
    if inserting then
        log_emp(:new.FIRST_NAME, :new.LAST_NAME, 'HIRED');
    end if;
    if deleting then
        log_emp(:old.FIRST_NAME, :old.LAST_NAME, 'FIRED');
    end if;
end;