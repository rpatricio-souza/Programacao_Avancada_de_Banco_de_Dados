SET SERVEROUTPUT ON /* Permite que o comando dbms_output.put_line funcione */

DECLARE
    cursor c_das
    is
    select d.department_id,d.department_name, AVG(e.salary) avg
    from employees e, departments d
    where e.department_id=d.department_id
    group by d.department_id,d.department_name
    order by d.department_id;
begin
    for v_das in c_das
    loop
        dbms_output.put_line(v_das.department_name || ' has an average salary of $' || v_das.avg);
    end loop;
end;