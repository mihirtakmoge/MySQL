create database company ;

use company;
-- Master Table
drop table employees;

drop table departments;

create table departments (
    id int auto_increment primary key,
    department_name varchar(50),
    location varchar(50)
);

-- Detail Table

create table employees(
    employee_id int auto_increment primary key,
    employee_name varchar(50),
    employee_contact varchar(50),
    department_id int,
    foreign key (department_id) references departments(id));

insert into departments (department_name,location) values
("Human Resources", "Pune"),
("Finance", "Mumbai"),
("IT", "Bangalore"),
("Marketing", "Delhi"),
("Operations", "Hyderabad");

select * from employees;

insert into employees (employee_name, employee_contact,department_id) values
("Rahul Patil", "9876543210",1),
("Sneha Kulkarni", "9123456789",3),
("Amit Deshmukh", "amit.d@gmail.com",2),
("Priya Sharma", "9988776655",4),
("Vikas More", "vikas.more@gmail.com",5); 

INSERT INTO employees (employee_name, employee_contact, department_id) VALUES
("Anjali Mehta", "9812345678", 1),
("Rohit Verma", "rohit.v@gmail.com", 2),
("Neha Singh", "9765432109", 3),
("Karan Shah", "karan.shah@gmail.com", 4),
("Pooja Nair", "9898989898", 5),
("Suresh Yadav", "suresh.y@gmail.com", 1),
("Meena Iyer", "9001122334", 2),
("Arjun Reddy", "arjun.r@gmail.com", 3),
("Kavita Joshi", "9112233445", 4),
("Nikhil Jain", "nikhil.j@gmail.com", 5),
("Deepak Kumar", "9223344556", 1),
("Simran Kaur", "simran.k@gmail.com", 2),
("Aditya Roy", "9334455667", 3),
("Ritika Kapoor", "ritika.k@gmail.com", 4),
("Manoj Tiwari", "9445566778", 5);

update employees set employee_name = "parikshit shelorkar" where employee_id=3;


delete from employees where employee_id=5;
use company;

select * from departments;
select * from employees;

select * from departments where department_name ="Human Resources";

update departments set location="Chennai" where id=5;
delete from departments where id=26;


SELECT d.location, COUNT(e.employee_id) AS total_employees
FROM departments d
LEFT JOIN employees e ON d.id = e.department_id
GROUP BY d.location;

show databases;
use company;
show tables;
select * from departments where department_name="IT";
delete  from departments where department_name= "IT" ;

update departments set location="Chennai" where id=28;

select * from employees;

select * from employees where department_id=(select id from departments where department_name="Human Resources");

SELECT e.employee_id, e.employee_name, e.employee_contact, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.id;

SELECT e.employee_name, d.department_name, d.location
FROM employees e
JOIN departments d ON e.department_id = d.id
WHERE d.location = 'Pune';

SELECT d.department_name
FROM departments d
LEFT JOIN employees e ON d.id = e.department_id
WHERE e.employee_id IS NULL;


SELECT COUNT(*) AS total_employees
FROM employees;

SELECT e.employee_name, d.department_name, d.location
FROM employees e
JOIN departments d ON e.department_id = d.id;


SELECT e.employee_name
FROM employees e
JOIN departments d ON e.department_id = d.id
WHERE d.department_name = 'IT';

UPDATE employees
SET employee_contact = '9876543210'
WHERE employee_id = 1;

DELETE FROM employees
WHERE employee_id = 3;

SELECT d.department_name, e.employee_name
FROM employees e
JOIN departments d ON e.department_id = d.id
ORDER BY d.department_name;

SELECT d.location, COUNT(e.employee_id) AS total_employees
FROM departments d
LEFT JOIN employees e ON d.id = e.department_id
GROUP BY d.location;


