create or replace package atividade_procedure_function as
    procedure raise_salary(dno number, percentage number DEFAULT 0.5);
    function employee_total(dept_name varchar2) return number;
end;
