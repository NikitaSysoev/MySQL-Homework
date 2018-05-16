use employees;
# 1. Реализовать практические задания на примере других таблиц и запросов.
start transaction;

savepoint stage0;

delete from dept_manager where emp_no = '110085';

savepoint stage1;

update salaries set salary = salary - 10000 where emp_no = '110085';

commit;


# 2. Подумать, какие операции являются транзакционными, и написать несколько примеров с транзакционными запросами.
drop trigger addbonus;

alter table salaries change emp_no emp_no int(11) auto_increment;

start transaction;

savepoint stage0;

insert into employees (birth_date, first_name, last_name, gender, hire_date) values ('1985-12-10', 'Riley', 'Ried', 'F', '1996-11-12');

savepoint stage1;

insert into salaries (salary, from_date, to_date)
    values (10000, now(), adddate(now(), interval 1 year));

commit;

select * from employees order by emp_no desc;

select * from salaries order by from_date desc;

# 3. Проанализировать несколько запросов с помощью EXPLAIN.
explain select department, emp_count, money from DepartmentsDate;

explain select employee, max_salary from EmloyeerMaxSalary;

explain select * from DepartmentsSalary;