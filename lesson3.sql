#База данных “страны и города мира”:
use geodata;

# 1) сделать запрос в котором мы выберем все данные о городе - регион, страна.
 select _cities.title as city, _regions.title as region, _countries.title as country  from _cities 
 left join _regions on region_id = _regions.id 
 left join _countries on _cities.country_id = _countries.id;

# 2) Выбрать все города из Московской области.
select _cities.title as city from _cities where region_id = (select id  from _regions where title='Московская область');


# База данных «Сотрудники».
use employees;

#1. Выбрать среднюю зарплату по отделам.
select avg(salaries.salary) as salary, departments.dept_name as department from departments 
left join dept_emp on departments.dept_no = dept_emp.dept_no 
left join salaries on dept_emp.emp_no = salaries.emp_no
group by department;

# 2. Выбрать максимальную зарплату у сотрудника.
select max(salary) as max_salary, concat(first_name, ' ', last_name) as employee from salaries 
left join employees on salaries.emp_no = employees.emp_no
group by employees.emp_no order by max_salary desc;

#3. Удалить одного сотрудника, у которого максимальная зарплата.
delete from employees  where emp_no = (select emp_no from salaries having max(salary));

#4. Посчитать количество сотрудников во всех отделах.
select count(employees.emp_no) as emp_count, departments.dept_name as department from employees 
right join dept_emp on employees.emp_no = dept_emp.emp_no
right join departments on dept_emp.dept_no = departments.dept_no
group by department order by emp_count desc;

#5. Найти количество сотрудников в отделах и посмотреть сколько всего денег получает отдел.
select count(employees.emp_no) as emp_count, departments.dept_name as department, sum(salaries.salary) as money from employees
right join dept_emp on employees.emp_no = dept_emp.emp_no 
right join departments on dept_emp.dept_no = departments.dept_no
left join salaries on employees.emp_no = salaries.emp_no
group by department order by money desc;