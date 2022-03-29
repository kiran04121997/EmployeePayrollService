---Welcome to SQL Project---
Create database Payroll_Service;
use Payroll_Service

---UC2--Create table for database---
create table employee_payroll
(
	Id int identity (1,1) primary Key,
	Name varchar(200),
	Salary float,
	StartDate date
);

---UC3-- Create employee_payroll data
insert into employee_payroll (Name, Salary, StartDate) values
('Kiran', 70000.00, '2007-02-03'),
('Vikram', 50000.00, '2010-05-04'),
('Dilip', 60000.00, '2009-06-02'),
('Suvarna', 40000.00, '2018-08-05'),
('Nikita', 500000.00, '2020-08-02');

---UC4-- Retrieve employee_payroll data--
select * from employee_payroll;
truncate table employee_payroll; 
---UC5-- Retrieve salary of particular employee and particular date range
select salary from employee_payroll where Name = 'Kiran' ;
select * from employee_payroll where StartDate between cast ('2018-01-01' as date) and GETDATE();

---UC6--Add Gender to Employee_payroll Table and update the rows to reflect the correct emp Gender
Alter table employee_payroll add Gender char(1);
update employee_payroll set Gender = 'M' where Id in (1,2,3);
update employee_payroll set Gender = 'F' where Id in (4,5);

---UC7-- find sum, average, min, max and number of male and female employees
select sum(salary) as sumsalary,Gender from employee_payroll group by Gender;
select avg(salary) as avgsalary,Gender from employee_payroll group by Gender;
select max(salary) as maxsalary,Gender from employee_payroll group by Gender;
select min(salary) as minsalary,Gender from employee_payroll group by Gender;
select count(Name) as EmployeeCount,Gender from employee_payroll group by Gender;

---UC8-- add employee phone, department(not null), address (using default values)
select * from employee_payroll;
Alter table employee_payroll add Phone bigint;
update employee_payroll set Phone = 1234567890;
update employee_payroll set Phone = 1234569876 where ID IN (2,4);
Alter table employee_payroll add Address varchar(100) not null default 'Pune';
Alter table employee_payroll add Department varchar(250) not null default 'IT';

---UC9-- Extend the table to have basic pay, taxable pay, net pay, income tax, deduction
alter table employee_payroll add Basic_Pay float not null default 0.00;
update employee_payroll set Basic_Pay=70000.00 where Id=1;
update employee_payroll set Basic_Pay=50000.00 where Id=2;
update employee_payroll set Basic_Pay=60000.00 where Id=3;
update employee_payroll set Basic_Pay=40000.00 where Id=4;
update employee_payroll set Basic_Pay=500000.00 where Id=5;
alter table employee_payroll add 
															Deduction float not null default 0.00,
															Taxable_Pay float not null default 0.00,
															Income_Tax float not null default 0.00,
															Net_Pay float not null default 0.00;
update employee_payroll set Net_Pay = (Basic_Pay-Deduction-Taxable_Pay-Income_Tax);
select * from employee_payroll;

---UC10--Two department for same employee
insert into employee_payroll (Name, salary, StartDate, Gender, Phone, Address, Department, Basic_Pay, Deduction, Taxable_Pay, Income_Tax)
							values ('Kiran', 50000, '2010-05-04', 'M', 1234569876, 'Pune', 'IT', 50000, 1000, 2000, 1500);
update employee_payroll set Net_Pay = (Basic_Pay-Deduction-Taxable_Pay-Income_Tax);
update employee_payroll set Department = 'Finance' where Id= 6; 

---ER Diagram---
create table Department
(
 Dept_Id int foreign key references employee_payroll(Id),
 Department varchar(100)
);

create table Employee_Address
(
Id int primary key,
Current_Address varchar (100),
Permanent_Address varchar(100)
);

alter table Employee_Address add foreign key (Id) references employee_Payroll (Id);
select * from employee_payroll;
select * from Department;
select * from Employee_Address;