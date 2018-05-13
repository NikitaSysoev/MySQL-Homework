# 1. Создать VIEW на основе запросов, которые вы сделали в ДЗ к уроку 3.
use geodata;

create view CityDate as
 select _cities.title as city, _regions.title as region, _countries.title as country  from _cities 
 left join _regions on region_id = _regions.id 
 left join _countries on _cities.country_id = _countries.id;
 
# получаем все данные о городе - регион, страна, используя VIEW
select * from CityDate;

# Получаем все города из Московской области, используя VIEW
select city from CityDate where region = 'Московская область';


use employees;
# создаем вид по отделам.
create view DepartmentsSalary as
select avg(salaries.salary) as salary, departments.dept_name as department from departments 
left join dept_emp on departments.dept_no = dept_emp.dept_no 
left join salaries on dept_emp.emp_no = salaries.emp_no 
where salaries.to_date > now()
group by departments.dept_no;

# получаем среднюю зарплату по отделам.
select * from DepartmentsSalary;


# создаем вид EmloyeerMaxSalary
create view EmloyeerMaxSalary as
select max(salary) as max_salary, concat(first_name, ' ', last_name) as employee, employees.emp_no as emp_number from salaries 
join employees on salaries.emp_no = employees.emp_no where salaries.to_date > now()
group by employees.emp_no order by max_salary desc;

#  Выбрать максимальную зарплату у сотрудника.
select employee, max_salary from EmloyeerMaxSalary;

# Удалить одного сотрудника, у которого максимальная зарплата.
delete from employees  where emp_no = (select emp_number from EmloyeerMaxSalary having max(max_salary));


# создаем вид DepartmentsDate
create view DepartmentsDate as
select count(dept_emp.emp_no) as emp_count, departments.dept_name as department, sum(salaries.salary) as money from dept_emp
left join departments on dept_emp.dept_no = departments.dept_no
left join salaries on salaries.emp_no = dept_emp.emp_no 
where dept_emp.to_date > now() and salaries.to_date > now()
group by dept_emp.dept_no; 

# Посчитать количество сотрудников во всех отделах.
select department, emp_count from DepartmentsDate;

# Найти количество сотрудников в отделах и посмотреть сколько всего денег получает отдел.
select department, emp_count, money from DepartmentsDate;


# 2. Создать функцию, которая найдет менеджера по имени и фамилии.
delimiter //
create function findmanager(firstName char(14), lastName char(16))
returns  varchar(14) 
begin

return ( select dept_manager.emp_no
FROM
    dept_manager
        JOIN
    employees ON dept_manager.emp_no = employees.emp_no
        JOIN
    departments ON dept_manager.dept_no = departments.dept_no
WHERE
    first_name = firstName
        AND last_name = lastName);

end//
delimiter ;

select findmanager('Rosine', 'Cools');


# 3. Создать триггер, который при добавлении нового сотрудника будет выплачивать ему вступительный бонус в таблицу salary.
alter table employees change emp_no emp_no int(11) auto_increment;

delimiter //

create procedure insert_bonus(emp int(11), bonus int(11))
begin
	insert into salaries (emp_no, salary, from_date, to_date)
    values (emp, bonus, now(), adddate(now(), interval 1 year));
end //

delimiter ;

create trigger addbonus after insert on employees
for each row call insert_bonus(NEW.emp_no, 10000);

insert into employees (birth_date, first_name, last_name, gender, hire_date) values ('1985-12-10', 'Riley', 'Ried', 'F', '1996-11-12');

select * from salaries order by from_date desc;