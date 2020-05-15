desc departments;
select department_name from departments;
desc employees;

select count(e.employee_id)
from departments d, employees e
where d.department_id=e.department_id and d.department_name='IT';


create function employee_total(dept_name varchar2) return number
is
    total number;
begin
    select count(e.employee_id)
    into total
    from departments d, employees e
    where d.department_id=e.department_id and d.department_name=dept_name;
return total;
end employee_total;


select employee_total('IT')
from dual;