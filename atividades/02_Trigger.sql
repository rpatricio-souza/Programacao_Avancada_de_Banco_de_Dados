/*  Caso o c�digo do departamento do empregado n�o seja informado no insert
    ou caso ele n�o exista na tabela hr.departments, atribuir a ele o valor padr�o 20; */

create or replace trigger insert_default_department
before insert on employees
for each row
enable

declare
    dept_id departments.department_id%type;
    
begin
    if(:new.department_id is null) then
        :new.department_id:=20;
        dbms_output.put_line('O departamento foi colocado com o valor padrao de 20.');
    else 
        begin
            select department_id into dept_id
            from departments
            where department_id=:new.department_id;
            
            exception
                when no_data_found then
                :new.department_id:=20;
        end;
        
    end if; 
end insert_default_department;
