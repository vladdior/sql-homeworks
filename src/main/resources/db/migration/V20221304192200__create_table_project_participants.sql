create table project_participants
(
    emp_id number(6),
    proj_id number(6),
    hours_worked number(4),
    constraint fk_pr_part_emp FOREIGN KEY (emp_id) references EMPLOYEES(EMPLOYEE_ID),
    constraint fk_pr_part_proj FOREIGN KEY (proj_id) references PROJECTS(PROJECTID)
)