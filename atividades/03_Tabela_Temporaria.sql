desc employees;
desc jobs;

/*Exibe a media salarial por departamento*/
select d.department_id,d.department_name, AVG(e.salary)
from employees e, departments d
where e.department_id=d.department_id
group by d.department_id,d.department_name
order by d.department_id;

/*Exibe os cargos por cada departamento*/
select d.department_id, d.department_name, j.job_id
from departments d, employees e, jobs j
where e.department_id=d.department_id and e.job_id=j.job_id
order by d.department_id;

/*Exibe a media salarial por cargo*/
select j.job_id, e.department_id, AVG(e.salary)
from employees e, jobs j
where e.job_id=j.job_id
group by j.job_id, e.department_id
order by e.department_id, j.job_id;

create global temporary table JAS_JOB_AVGSALARY(
    JAS_ID varchar2(10),
    JAS_DPT_ID number(4),
    JAS_AVGSALARY number(8,2),
    CONSTRAINT JAS_JOB_AVGSALARY_PK PRIMARY KEY (JAS_ID)/*,
    CONSTRAINT JAS_JOB_AVGSALARY_FK FOREIGN KEY (JAS_ID) REFERENCES JOBS (JOB_ID)*/
);

insert into JAS_JOB_AVGSALARY(JAS_ID,JAS_DPT_ID,JAS_AVGSALARY) values('AD_ASST',10,4400);
insert into JAS_JOB_AVGSALARY(JAS_ID,JAS_DPT_ID,JAS_AVGSALARY) values('MK_MAN',20,13000);
insert into JAS_JOB_AVGSALARY(JAS_ID,JAS_DPT_ID,JAS_AVGSALARY) values('MK_REP',20,6000);
insert into JAS_JOB_AVGSALARY(JAS_ID,JAS_DPT_ID,JAS_AVGSALARY) values('PU_CLERK',30,2780);
insert into JAS_JOB_AVGSALARY(JAS_ID,JAS_DPT_ID,JAS_AVGSALARY) values('PU_MAN',30,11000);
insert into JAS_JOB_AVGSALARY(JAS_ID,JAS_DPT_ID,JAS_AVGSALARY) values('HR_REP',40,6500);
insert into JAS_JOB_AVGSALARY(JAS_ID,JAS_DPT_ID,JAS_AVGSALARY) values('SH_CLERK',50,3215);
insert into JAS_JOB_AVGSALARY(JAS_ID,JAS_DPT_ID,JAS_AVGSALARY) values('ST_CLERK',50,2785);
insert into JAS_JOB_AVGSALARY(JAS_ID,JAS_DPT_ID,JAS_AVGSALARY) values('ST_MAN',50,7280);
insert into JAS_JOB_AVGSALARY(JAS_ID,JAS_DPT_ID,JAS_AVGSALARY) values('IT_PROG',60,5760);
insert into JAS_JOB_AVGSALARY(JAS_ID,JAS_DPT_ID,JAS_AVGSALARY) values('PR_REP',70,10000);
insert into JAS_JOB_AVGSALARY(JAS_ID,JAS_DPT_ID,JAS_AVGSALARY) values('SA_MAN',80,12200);
insert into JAS_JOB_AVGSALARY(JAS_ID,JAS_DPT_ID,JAS_AVGSALARY) values('SA_REP',80,8396.55);
insert into JAS_JOB_AVGSALARY(JAS_ID,JAS_DPT_ID,JAS_AVGSALARY) values('AD_PRES',90,24000);
insert into JAS_JOB_AVGSALARY(JAS_ID,JAS_DPT_ID,JAS_AVGSALARY) values('AD_VP',90,17000);
insert into JAS_JOB_AVGSALARY(JAS_ID,JAS_DPT_ID,JAS_AVGSALARY) values('FI_ACCOUNT',100,7920);
insert into JAS_JOB_AVGSALARY(JAS_ID,JAS_DPT_ID,JAS_AVGSALARY) values('FI_MGR',100,12008);
insert into JAS_JOB_AVGSALARY(JAS_ID,JAS_DPT_ID,JAS_AVGSALARY) values('AC_ACCOUNT',110,8300);
insert into JAS_JOB_AVGSALARY(JAS_ID,JAS_DPT_ID,JAS_AVGSALARY) values('AC_MGR',110,12008);
insert into JAS_JOB_AVGSALARY(JAS_ID,JAS_DPT_ID,JAS_AVGSALARY) values('SA_REP',null,7000);

/*DESC da tabela*/
desc JAS_JOB_AVGSALARY;

/*Listar os cargos ocupados, a media salarial por departamento e o total de funcionários existentes*/
select jas.jas_id, jas.jas_avgsalary, count(e.employee_id)
from employees e, JAS_JOB_AVGSALARY jas
where e.job_id=jas.jas_id
group by jas.jas_id, jas.jas_avgsalary;

/*Listar os funcionarios de um departamento e indicar se o salario e menor, igual ou maior que a media do departamento*/
select e.first_name, e.job_id, e.department_id, e.salary, jas.jas_avgsalary
from employees e, JAS_JOB_AVGSALARY jas
where e.job_id=jas.jas_id;

/*Para todos os funcionarios, aplicar um reajuste de salario que e de 10% sobre a diferença entre o salario e a media salarial
do cargo dele no departamento.*/
