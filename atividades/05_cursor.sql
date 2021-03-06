SET SERVEROUTPUT ON;

create table copy_employees as
select * from employees;

desc copy_employees;

declare
    type rt_employees is ref cursor;
    ct_employees rt_employees;

    empregados copy_employees%rowtype;
    
    nome varchar(45);
    sal copy_employees.salary%type;
    dept departments.department_name%type;
    
begin
    
    --Seleciona todo o conteudo da tabela e joga no cursor
	open ct_employees for
    select * from copy_employees;
    --Atualizacao do salario dos empregados
    loop
        fetch ct_employees into empregados;
        exit when ct_employees%notfound;
        update copy_employees set salary=empregados.salary*1.1
        where employee_id=empregados.employee_id;
    end loop;
    
    --Seleciona o nome completo, salario e departamento de cada funcionario e coloca no cursor
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
