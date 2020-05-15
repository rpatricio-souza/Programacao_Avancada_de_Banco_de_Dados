/*Exibe a media salarial por cargo*/
create global temporary table JAS_JOB_AVGSALARY
on commit preserve rows
as
select job_id, department_id, AVG(salary) avg_salary
from employees join jobs using(job_id)
group by job_id, department_id
order by department_id;

select * from JAS_JOB_AVGSALARY;

truncate table JAS_JOB_AVGSALARY;
drop table JAS_JOB_AVGSALARY;


/*DESC da tabela*/
desc JAS_JOB_AVGSALARY;


/*Listar os cargos ocupados, a media salarial por departamento e o total de funcionários existentes*/
select jas.job_id, jas.avg_salary, count(e.employee_id)
from employees e, JAS_JOB_AVGSALARY jas
where e.job_id=jas.job_id
group by jas.job_id, jas.avg_salary;


/*Listar os funcionarios de um departamento e indicar se o salario e menor, igual ou maior que a media do departamento*/
SET SERVEROUTPUT ON /* Permite que o comando dbms_output.put_line funcione */

create or replace procedure avg_job_dept(dept number) is
    cursor c_jas
    is
    select first_name, e.department_id, salary, avg_salary
    from employees e join JAS_JOB_AVGSALARY using(job_id)
    where e.department_id=dept;
begin
    for v_jas in c_jas
    loop
        if(v_jas.salary<v_jas.avg_salary) then
            dbms_output.put_line(v_jas.first_name || ' has a salary of $' || v_jas.salary || ' which is lower than the avg of his/her department $' || v_jas.avg_salary);
        elsif(v_jas.salary=v_jas.avg_salary) then
            dbms_output.put_line(v_jas.first_name || ' has a salary of $' || v_jas.salary || ' which is equal the avg of his/her department $' || v_jas.avg_salary);
        else
            dbms_output.put_line(v_jas.first_name || ' has a salary of $' || v_jas.salary || ' which is higher than the avg of his/her department $' || v_jas.avg_salary);
        end if;
    end loop;
end avg_job_dept;

exec avg_job_dept(30);


/*Para todos os funcionarios, aplicar um reajuste de salario que e de 10% sobre a diferença entre o salario e a media salarial
do cargo dele no departamento.*/
declare
    cursor c_jas
    is
    select first_name, salary, avg_salary
    from employees join JAS_JOB_AVGSALARY using(job_id);
    
    new_salary employees.salary%type;
    
begin
    for v_jas in c_jas
    loop
        if(v_jas.salary<v_jas.avg_salary) then
            new_salary:=v_jas.salary+(v_jas.avg_salary-v_jas.salary)*.1;
            
            update employees
            set salary=new_salary
            where first_name=v_jas.first_name;
            
            dbms_output.put_line(v_jas.first_name || ' new salary: $' || new_salary);
            
        else
            new_salary:=v_jas.salary+(v_jas.salary-v_jas.avg_salary)*.1;
            
            update employees
            set salary=new_salary
            where first_name=v_jas.first_name;
            
            dbms_output.put_line(v_jas.first_name || ' new salary: $' || new_salary);
        end if;
    end loop;
end;
