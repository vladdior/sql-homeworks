create or replace procedure log_emp(f_name varchar2, l_name varchar2,
                                    status varchar2)
    is
begin
    insert into employment_logs
    (FIRST_NAME, LAST_NAME, EMPLOYMENT_ACTION, EMPLOYMENT_STATUS_UPDTD_TMSTMP)
    values (f_name, l_name, status, SYSDATE);
end;
