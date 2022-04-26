alter table LOCATIONS
add department_amount number(3);

comment on column LOCATIONS.department_amount is 'Contains the amount of departments in the location';