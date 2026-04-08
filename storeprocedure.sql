create database college;
use college ;

create table students( 
 student_id int auto_increment primary key ,
 student_name varchar(50),
 student_contact varchar(50),
 student_score int );
 
 create table student_Percentage(
	student_id int ,
    student_name varchar(50),
    percentage int ,
    foreign key (student_id) references students(student_id)
    );
    select * from student_Percentage ;
    
  drop table studentpercentage ;
  
 insert into students (student_name,student_contact, student_score ) values 
 ( "sumit" , "9922", 143),
 ("ashwin" , "9420", 149),
 ("pranjal", "9168", 136);
 
create table departments(
department_id int auto_increment primary key ,
department_name varchar(50));

insert into departments (department_name) values
("computer"),
("entc");

create table student_department (
student_departmentid int auto_increment primary key ,
student_id int ,
department_id int ,
foreign key (student_id) references students(student_id),
foreign key (department_id) references departments(department_id));

insert into student_department ( student_id, department_id) values 
(1,1),
(3,2);

select * from student_department ;

select students.student_name, departments.department_name 
from student_department
join  students on students.student_id = student_department.student_id 
join departments on departments.department_id = student_department.department_id;

select students.student_name, departments.department_name 
from students
left join  student_department on students.student_id = student_department.student_id 
left join departments on departments.department_id = student_department.department_id;

SELECT students.student_name, departments.department_name 
FROM departments
RIGHT JOIN student_department 
    ON departments.department_id = student_department.department_id
RIGHT JOIN students 
    ON students.student_id = student_department.student_id;

DELIMITER $$
CREATE PROCEDURE GET_STUDENT_BY_ID (IN ID INT )
BEGIN
SELECT * FROM STUDENTS WHERE student_id = ID ;
END $$
 DELIMITER ;

CALL GET_STUDENT_BY_ID (1) ;

DELIMITER $$
CREATE PROCEDURE GET_STUDENTPERCENTAGE_BY_ID (IN ID INT )
BEGIN
SELECT  (student_score/165)* 100 as percentage from students WHERE student_id = ID ;
END $$
 DELIMITER ;
 
drop procedure GET_STUDENTPERCENTAGE_BY_ID ;

CALL GET_STUDENTPERCENTAGE_BY_ID (2) ;

DELIMITER $$
CREATE PROCEDURE store_STUDENTPERCENTAGE_BY_ID (IN ID INT )
BEGIN
insert into studentPercentage (student_id , percentage) select student_id , (student_score/165)* 100  from students WHERE student_id = ID;
END $$
 DELIMITER ;
 
 call store_STUDENTPERCENTAGE_BY_ID (2);
select * from studentPercentage ;

DELIMITER //

CREATE PROCEDURE CalculateStudentPercentage()
BEGIN

DECLARE done INT DEFAULT 0;
DECLARE sid INT;
DECLARE sname VARCHAR(100);
DECLARE smarks INT;
DECLARE spercentage DECIMAL(5,2);

DECLARE student_cursor CURSOR FOR
SELECT student_id, student_name, student_score FROM students;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

OPEN student_cursor;

read_loop: LOOP

FETCH student_cursor INTO sid, sname, smarks;

IF done = 1 THEN
LEAVE read_loop;
END IF;

SET spercentage = (smarks / 500) * 100;

INSERT INTO student_percentage(student_id,student_name,percentage)
VALUES (sid,sname,spercentage);

END LOOP;

CLOSE student_cursor;

END //

DELIMITER ;
call CalculateStudentPercentage();