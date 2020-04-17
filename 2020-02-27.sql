SET SERVEROUTPUT ON /* Permite que o comando dbms_output.put_line funcione */

DESC HR.EMPLOYEES;

SELECT FIRST_NAME, SALARY, DEPARTMENT_ID FROM HR.EMPLOYEES
ORDER BY DEPARTMENT_ID;

SELECT COUNT(*) "NUMERO DE FUNCIONARIOS"
FROM HR.EMPLOYEES
WHERE DEPARTMENT_ID=20;


EXEC HR.raise_salary(20, 0)


create or replace procedure HR.raise_salary(dno number, percentage number DEFAULT 0.5) is
    cursor emp_cur (dept_no number) is select SALARY from HR.employees 
        where DEPARTMENT_ID = dept_no for update of SALARY;
    empsal number(8,2);
    
begin
    open emp_cur(dno); /* Aqui dept_no recebe dno */
    loop
        fetch emp_cur into empsal;
        exit when emp_cur%NOTFOUND;
        update HR.employees set SALARY = empsal * ((100 + percentage)/100) 
            where current of emp_cur;
        dbms_output.put_line(empsal);
    end loop;
    close emp_cur;
    commit;
end raise_salary;