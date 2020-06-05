SET SERVEROUTPUT ON;

begin
    atividade_05.print_emp_salary_dept;
end;
/
select * from copy_employees;
rollback;