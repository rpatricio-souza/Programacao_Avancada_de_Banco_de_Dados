SET SERVEROUTPUT ON;

begin
    DBMS_OUTPUT.PUT_LINE(atividade_procedure_function.employee_total('IT'));
end;

begin
   atividade_procedure_function.raise_salary(40,0);
end;
