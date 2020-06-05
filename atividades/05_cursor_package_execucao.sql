SET SERVEROUTPUT ON;

create table copy_employees as
select * from employees;

begin
    atividade_05.print_emp_salary_dept;
end;
/
select * from copy_employees;
rollback;