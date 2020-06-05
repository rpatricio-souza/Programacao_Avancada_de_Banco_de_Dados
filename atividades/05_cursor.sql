SET SERVEROUTPUT ON;

create table copy_employees as
select * from employees;

desc copy_employees;

declare
    registro_cursor copy_employees%rowtype;
    type rt_employees is ref cursor/* return registro_cursor*/;
    ct_employees rt_employees;
    --emp_cur rt_employees;

    cursor emp_cur is
    select salary from copy_employees
    for update of salary;

    empsal copy_employees.salary%type;
    
    nome varchar(45);
    sal copy_employees.salary%type;
    dept departments.department_name%type;
    
begin
    /*open ct_employees for
    select salary from copy_employees
    for update of salary;*/
    
    open emp_cur;
    loop
        fetch emp_cur into empsal;
        exit when emp_cur%NOTFOUND;
        update copy_employees set salary=empsal*1.1
            where current of emp_cur;
        --dbms_output.put_line(empsal*1.1);
    end loop;
    close emp_cur;
    
    open ct_employees for
    select first_name || ' ' || last_name full_name, salary, department_name
    from copy_employees join departments using(department_id);
    
    loop
        fetch ct_employees into nome, sal, dept;
        exit when ct_employees%NOTFOUND;
        dbms_output.put_line(nome||' '||sal||' '||dept);
    end loop;
end;
/

select * from copy_employees;
rollback;
