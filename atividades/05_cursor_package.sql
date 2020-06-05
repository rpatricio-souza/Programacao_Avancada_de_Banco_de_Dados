create or replace package atividade_05 as
    type rt_employees is ref cursor;
    
    procedure raise_emp_salary_10(ct_employees in out rt_employees);
    procedure print_emp_salary_dept;
end;
/

create or replace package body atividade_05 as

--1a PROCEDURE: aumenta o salario de todos os funcionarios em 10%
    procedure raise_emp_salary_10(ct_employees in out rt_employees) is
        empregados copy_employees%rowtype;
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
    end raise_emp_salary_10;
   
--2a PROCEDURE: chama a 1a procedure e imprime os valores na tela
    procedure print_emp_salary_dept is
        ct_employees rt_employees;
        
        nome varchar(45);
        sal copy_employees.salary%type;
        dept departments.department_name%type;
        
    begin
        raise_emp_salary_10(ct_employees);
        dbms_output.put_line('-----------------------------------------------');
        dbms_output.put_line('    Name     |    Salary     |    Deparment    ');
        dbms_output.put_line('-----------------------------------------------');
        loop
            fetch ct_employees into nome, sal, dept;
            exit when ct_employees%NOTFOUND;
            dbms_output.put_line(nome||' '||sal||' '||dept);
        end loop;
    end print_emp_salary_dept;
    
end atividade_05;
/