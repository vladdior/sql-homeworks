-- Write a query to display: 
-- 1. the first name, last name, salary, and job grade for all employees.
SELECT first_name, last_name, salary, job_title
FROM employees
         LEFT JOIN jobs USING (job_id);

-- 2. the first and last name, department, city, and state province for each employee.
select FIRST_NAME, LAST_NAME, DEPARTMENT_ID, CITY, STATE_PROVINCE
from EMPLOYEES
         left join DEPARTMENTS using (department_id)
         left join LOCATIONS using (location_id);

-- 3. the first name, last name, department number and department name, for all employees for departments 80 or 40.
select FIRST_NAME, LAST_NAME, DEPARTMENT_ID, DEPARTMENT_NAME
from EMPLOYEES
         left join DEPARTMENTS using (DEPARTMENT_ID)
where DEPARTMENT_ID in (80, 40);

-- 4. those employees who contain a letter z to their first name and also display their last name, department, city, and state province.
select FIRST_NAME, LAST_NAME, DEPARTMENT_ID, CITY, STATE_PROVINCE
from EMPLOYEES
         left join DEPARTMENTS using (department_id)
         left join LOCATIONS using (location_id)
where lower(FIRST_NAME) like '%z%';

-- 5. the first and last name and salary for those employees who earn less than the employee earn whose number is 182.
SELECT FIRST_NAME, LAST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY < (SELECT SALARY FROM EMPLOYEES WHERE EMPLOYEE_ID = 182);

-- 6. the first name of all employees including the first name of their manager.
SELECT e.FIRST_NAME, m.FIRST_NAME
from EMPLOYEES e
         inner join EMPLOYEES m ON m.EMPLOYEE_ID = e.MANAGER_ID;

-- 7. the first name of all employees and the first name of their manager including those who does not working under any manager.
SELECT e.FIRST_NAME, m.FIRST_NAME
from EMPLOYEES e
         LEFT JOIN EMPLOYEES m ON m.EMPLOYEE_ID = e.MANAGER_ID;

-- 8. the details of employees who manage a department.
SELECT e.FIRST_NAME,
       e.LAST_NAME,
       e.EMAIL,
       e.EMAIL,
       e.JOB_ID,
       e.HIRE_DATE,
       e.SALARY,
       e.MANAGER_ID,
       d.DEPARTMENT_NAME
from EMPLOYEES e
         inner join DEPARTMENTS d ON e.EMPLOYEE_ID = d.MANAGER_ID;

-- 9. the first name, last name, and department number for those employees who works in the same department as the employee who holds the last name as Taylor.
SELECT FIRST_NAME,
       LAST_NAME,
       DEPARTMENT_ID
from EMPLOYEES
         left join DEPARTMENTS using (department_id)
where DEPARTMENT_ID in (select DEPARTMENT_ID from EMPLOYEES where trim(lower(LAST_NAME)) = 'taylor');

--10. the department name and number of employees in each of the department.
select DEPARTMENT_NAME, count(EMPLOYEE_ID) as employees_count
from DEPARTMENTS
         left join EMPLOYEES using (DEPARTMENT_ID)
group by DEPARTMENT_NAME;

--11. the name of the department, average salary and number of employees working in that department who got commission.
select DEPARTMENT_NAME, avg(SALARY) as avg_salary, count(EMPLOYEE_ID) as emp_count
from DEPARTMENTS
         left join EMPLOYEES using (DEPARTMENT_ID)
where COMMISSION_PCT IS NOT NULL
group by DEPARTMENT_NAME;

--12. job title and average salary of employees.
select JOB_TITLE, avg(SALARY)
from JOBS
         join EMPLOYEES using (JOB_ID)
group by JOB_TITLE;

--13. the country name, city, and number of those departments where at least 2 employees are working.
select COUNTRY_NAME, CITY, DEPARTMENT_ID
from COUNTRIES
         left join LOCATIONS using (COUNTRY_ID)
         left join DEPARTMENTS using (location_id)
where DEPARTMENT_ID in (select DEPARTMENT_ID
                        from DEPARTMENTS
                                 left join EMPLOYEES using (DEPARTMENT_ID)
                        group by DEPARTMENT_ID
                        having (count(EMPLOYEE_ID) >= 2));

--14. the employee ID, job name, number of days worked in for all those jobs in department 80.
select EMPLOYEE_ID, JOB_TITLE, sum(END_DATE - START_DATE) as days_worked
from JOBS
         left join JOB_HISTORY using (JOB_ID)
         left join EMPLOYEES e using (EMPLOYEE_ID)
         left join DEPARTMENTS d on e.DEPARTMENT_ID = d.DEPARTMENT_ID
where d.DEPARTMENT_ID = 80
group by EMPLOYEE_ID, JOB_TITLE;

--15. the name ( first name and last name ) for those employees who gets more salary than the employee whose ID is 163.
select FIRST_NAME, LAST_NAME
from EMPLOYEES
where SALARY < (select SALARY from EMPLOYEES where EMPLOYEE_ID = 163);

--16. the employee id, employee name (first name and last name ) for all employees who earn more than the average salary.
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME
from EMPLOYEES
where SALARY > (select avg(SALARY) from EMPLOYEES);

--17. the employee name ( first name and last name ), employee id and salary of all employees who report to Payam.
select e.FIRST_NAME, e.LAST_NAME, e.EMPLOYEE_ID, e.SALARY
from EMPLOYEES e
         left join EMPLOYEES m
                   on e.MANAGER_ID = m.EMPLOYEE_ID
where trim(lower(m.FIRST_NAME)) = 'payam';

--18. the department number, name ( first name and last name ), job and department name for all employees in the Finance department.
select DEPARTMENT_ID, FIRST_NAME, LAST_NAME, JOB_TITLE, DEPARTMENT_NAME
from DEPARTMENTS
         left join EMPLOYEES using (department_id)
         left join jobs using (JOB_ID)
where trim(lower(DEPARTMENT_NAME)) = 'finance';

--19. all the information of an employee whose id is any of the number 134, 159 and 183.
select *
from EMPLOYEES
where EMPLOYEE_ID in (134, 159, 183);

--20. all the information of the employees whose salary is within the range of smallest salary and 2500.
select *
from EMPLOYEES
where SALARY between (select min(SALARY) from EMPLOYEES) and 2500;

--21. all the information of the employees who does not work in those departments where some employees works whose id within the range 100 and 200.
select *
from EMPLOYEES
where DEPARTMENT_ID not in (select DEPARTMENT_ID
                            from EMPLOYEES
                                     inner join DEPARTMENTS using (DEPARTMENT_ID)
                            where EMPLOYEE_ID between 100 and 200);

--22. all the information for those employees whose id is any id who earn the second highest salary.
select *
from EMPLOYEES
where SALARY = (select max(SALARY) from EMPLOYEES where EMPLOYEE_ID <> (select max(SALARY) from EMPLOYEES));

--23. the employee name( first name and last name ) and hiredate for all employees in the same department as Clara. Exclude Clara.
select e.FIRST_NAME, e.LAST_NAME, j.START_DATE
from EMPLOYEES e
         left join DEPARTMENTS d on e.DEPARTMENT_ID = d.DEPARTMENT_ID
         LEFT JOIN JOB_HISTORY j on e.EMPLOYEE_ID = j.EMPLOYEE_ID
where d.DEPARTMENT_ID = (select DEPARTMENT_ID
                         from DEPARTMENTS
                                  left join EMPLOYEES using (DEPARTMENT_ID)
                         where trim(lower(FIRST_NAME)) = 'clara')
  and trim(lower(FIRST_NAME)) <> 'clara';

--24. the employee number and name( first name and last name ) for all employees who work in a department with any employee whose name contains a T.
select e.EMPLOYEE_ID, e.FIRST_NAME, e.LAST_NAME, d.DEPARTMENT_ID
from EMPLOYEES e
         left join DEPARTMENTS d on e.DEPARTMENT_ID = d.DEPARTMENT_ID
where d.DEPARTMENT_ID in (select DEPARTMENT_ID
                          from DEPARTMENTS
                                   left join EMPLOYEES using (DEPARTMENT_ID)
                          where trim(FIRST_NAME) like '%T%'
                             or trim(LAST_NAME) like '%T%');

--25. full name(first and last name), job title, starting and ending date of last jobs for those employees with worked without a commission percentage.
select e.EMPLOYEE_ID, e.FIRST_NAME, e.LAST_NAME, j.JOB_TITLE, jh.START_DATE, jh.END_DATE
from EMPLOYEES e
         left join JOBS j on e.JOB_ID = j.JOB_ID
         inner join JOB_HISTORY jh on e.EMPLOYEE_ID = jh.EMPLOYEE_ID
where COMMISSION_PCT is null
  and START_DATE = (select max(START_DATE) from JOB_HISTORY where e.EMPLOYEE_ID = EMPLOYEE_ID);

--26. the employee number, name( first name and last name ), and salary for all employees who earn more than the average salary and who work in a department with any employee with a J in their name.
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY
from EMPLOYEES
         left join DEPARTMENTS using (DEPARTMENT_ID)
where SALARY > (select avg(SALARY) from EMPLOYEES)
  and DEPARTMENT_ID in (select DEPARTMENT_ID
                        from DEPARTMENTS
                                 left join EMPLOYEES using (DEPARTMENT_ID)
                        where trim(FIRST_NAME) like '%J%'
                           or trim(LAST_NAME) like '%J%');

--27. the employee number, name( first name and last name ) and job title for all employees whose salary is smaller than any salary of those employees whose job title is MK_MAN.
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY, JOB_TITLE
from EMPLOYEES
         left join JOBS using (JOB_ID)
where SALARY < (select min(SALARY) from EMPLOYEES where trim(lower(JOB_ID)) = 'mk_man');

--28. the employee number, name( first name and last name ) and job title for all employees whose salary is smaller than any salary of those employees whose job title is MK_MAN. Exclude Job title MK_MAN.
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY, JOB_TITLE
from EMPLOYEES
         left join JOBS using (JOB_ID)
where SALARY < (select min(SALARY) from EMPLOYEES where trim(lower(JOB_ID)) = 'mk_man')
  and trim(lower(JOB_ID)) <> 'mk_man';

--29. all the information of those employees who did not have any job in the past.
select *
from EMPLOYEES
         left join JOB_HISTORY using (EMPLOYEE_ID)
where END_DATE is null;

--30. the employee number, name( first name and last name ) and job title for all employees whose salary is more than any average salary of any department.
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, JOB_TITLE
from EMPLOYEES
         left join JOBS using (JOB_ID)
where SALARY > any (select avg(SALARY)
                    from EMPLOYEES
                             inner join DEPARTMENTS USING (DEPARTMENT_ID)
                    group by DEPARTMENT_ID);

--31. the employee id, name ( first name and last name ) and the job id column with a modified title SALESMAN for those employees whose job title is ST_MAN and DEVELOPER for whose job title is IT_PROG.
select EMPLOYEE_ID,
       FIRST_NAME,
       LAST_NAME,
       case JOB_ID
           when 'ST_MAN' then 'SALESMAN'
           when 'IT_PROG' then 'DEVELOPER'
           else JOB_ID
           end as JOB_ID
from EMPLOYEES;

--32. the employee id, name ( first name and last name ), salary and the SalaryStatus column with a title HIGH and LOW respectively for those employees whose salary is more than and less than the average salary of all employees.
select EMPLOYEE_ID,
       FIRST_NAME,
       LAST_NAME,
       SALARY,
       case
           when SALARY <= (select avg(SALARY) from EMPLOYEES) then 'LOW'
           else 'HIGH'
           end as SalaryStatus
from EMPLOYEES;

--33. the employee id, name ( first name and last name ), SalaryDrawn, AvgCompare (salary - the average salary of all employees)
-- and the SalaryStatus column with a title HIGH and LOW respectively for those employees whose salary is more than and less than
-- the average salary of all employees.
select EMPLOYEE_ID,
       FIRST_NAME,
       LAST_NAME,
       SALARY                                                 AS salarydrown,
       trunc(SALARY - (select avg(SALARY) from EMPLOYEES), 2) as avgcompare,
       case
           when SALARY <= (select avg(SALARY) from EMPLOYEES) then 'LOW'
           else 'HIGH'
           end                                                as SalaryStatus
from EMPLOYEES;

--34. all the employees who earn more than the average and who work in any of the IT departments.
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY
from EMPLOYEES
         left join DEPARTMENTS using (DEPARTMENT_ID)
where trim(lower(DEPARTMENT_NAME)) like '%it%'
  and SALARY > (select avg(SALARY) from EMPLOYEES);

--35. who earns more than Mr. Ozer.
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY
from EMPLOYEES
where SALARY > (select SALARY from EMPLOYEES where trim(lower(LAST_NAME)) = 'ozer');

--36. which employees have a manager who works for a department based in the US.
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME
from EMPLOYEES
         left join DEPARTMENTS using (DEPARTMENT_ID)
         left join LOCATIONS using (LOCATION_ID)
where COUNTRY_ID = 'US';

--37. the names of all employees whose salary is greater than 50% of their department’s total salary bill.
select e.FIRST_NAME, e.LAST_NAME
from EMPLOYEES e
where SALARY > (select sum(SALARY) * 0.5 from EMPLOYEES e1 where e.DEPARTMENT_ID = e1.DEPARTMENT_ID);

--38. the employee id, name ( first name and last name ), salary, department name and city for all
--the employees who gets the salary as the salary earn by the employee which is maximum within the joining person January 1st, 2002 and December 31st, 2003.
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_NAME, CITY
from EMPLOYEES
         left join DEPARTMENTS using (DEPARTMENT_ID)
         left join LOCATIONS using (LOCATION_ID)
where SALARY = (select max(SALARY) from EMPLOYEES where HIRE_DATE between '01-jan-2002' AND '31-dec-2003');

--39. the first and last name, salary, and department ID for all those employees who earn more than the average salary and arrange the list in descending order on salary.
select FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
from EMPLOYEES
         left join DEPARTMENTS using (DEPARTMENT_ID)
where SALARY > (select avg(SALARY) from EMPLOYEES)
order by SALARY DESC;

--40. the first and last name, salary, and department ID for those employees who earn more than the maximum salary of a department which ID is 40.
select FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
from EMPLOYEES
         left join DEPARTMENTS using (DEPARTMENT_ID)
where SALARY > all (select SALARY from EMPLOYEES where DEPARTMENT_ID = 40);

--41. the department name and Id for all departments where they located, that Id is equal to the Id for the location where department number 30 is located.
select DEPARTMENT_NAME, DEPARTMENT_ID
from DEPARTMENTS
where LOCATION_ID = (select LOCATION_ID from DEPARTMENTS where DEPARTMENT_ID = 30);

--42. the first and last name, salary, and department ID for all those employees who work in that department where the employee works who hold the ID 201.
select FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
from EMPLOYEES
where DEPARTMENT_ID = (select DEPARTMENT_ID from EMPLOYEES where EMPLOYEE_ID = 201);

--43. the first and last name, salary, and department ID for those employees whose salary is equal to the salary of the employee who works in that department which ID is 40.
select FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
from EMPLOYEES
where SALARY = (select SALARY from EMPLOYEES where DEPARTMENT_ID = 40);

--44. the first and last name, salary, and department ID for those employees who earn more than the minimum salary of a department which ID is 40.
select FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
from EMPLOYEES
where SALARY > (select min(SALARY) from EMPLOYEES where DEPARTMENT_ID = 40);

--45. the first and last name, salary, and department ID for those employees who earn less than the minimum salary of a department which ID is 70.
select FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
from EMPLOYEES
where SALARY < (select min(SALARY) from EMPLOYEES where DEPARTMENT_ID = 70);

--46. the first and last name, salary, and department ID for those employees who earn less than the average salary, and also work at the department where the employee Laura is working as a first name holder.
select FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
from EMPLOYEES
where SALARY < (select avg(SALARY) from EMPLOYEES)
  and DEPARTMENT_ID = (select DEPARTMENT_ID from EMPLOYEES where trim(lower(FIRST_NAME)) = 'laura');

--47. the full name (first and last name) of manager who is supervising 4 or more employees.
select FIRST_NAME, LAST_NAME
from EMPLOYEES
where EMPLOYEE_ID = any (select MANAGER_ID
                         from EMPLOYEES
                         group by MANAGER_ID
                         having count(*) >= 4);

--48. the details of the current job for those employees who worked as a Sales Representative in the past.
select *
from JOBS j
         left join EMPLOYEES e on j.JOB_ID = e.JOB_ID
         left join JOB_HISTORY jh on e.EMPLOYEE_ID = jh.EMPLOYEE_ID
where jh.JOB_ID = 'SA_REP';

--49. all the infromation about those employees who earn second lowest salary of all the employees.
select *
from EMPLOYEES
where SALARY = (select min(SALARY) from EMPLOYEES where SALARY <> (select min(SALARY) from EMPLOYEES));

--50. the department ID, full name (first and last name), salary for those employees who is highest salary drawar in a department.
select DEPARTMENT_ID, FIRST_NAME, LAST_NAME, SALARY
from EMPLOYEES e
where SALARY = (select max(SALARY) from EMPLOYEES where e.DEPARTMENT_ID = DEPARTMENT_ID);