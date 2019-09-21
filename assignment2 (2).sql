CREATE DATABASE Bank;
use bank;

CREATE TABLE employee(employee_name varchar(30) PRIMARY KEY , street varchar(30), city varchar(30));
CREATE TABLE company(company_name varchar(30) PRIMARY KEY , city varchar(30));
CREATE TABLE works(employee_name varchar(30) PRIMARY KEY, company_name varchar(30), salary int(10),
									FOREIGN KEY(company_name) REFERENCES company(company_name));
CREATE TABLE manages(employee_name varchar(30) PRIMARY KEY, manager_name varchar(30));


SELECT employee.employee_name , employee.city FROM employee , works
	WHERE employee.employee_name = works.employee_name AND works.company_name = 'First Bank Corporation' ;
	
	
SELECT employee.employee_name , employee.street, employee.city FROM employee , works
	WHERE employee.employee_name = works.employee_name 
    AND works.company_name = 'First Bank Corporation'
    AND works.salary > 10000;
	

SELECT employee.employee_name FROM employee , works WHERE employee.employee_name = works.employee_name
					AND works.company_name != 'First Bank Corporation';
					
SELECT employee.employee_name FROM employee , works WHERE employee.employee_name = works.employee_name
					AND works.company_name != 'Small Bank Corporation'
					AND works.salary > ALL(SELECT works.salary 
                                          FROM works
                                          WHERE works.company_name = 'Small Bank Corporation');
										  
										  
SELECT company.company_name  FROM company
	WHERE company.company_name!='Small Bank Corporation' and company.city = some(
    SELECT company.city FROM company
        WHERE company.company_name = 'Small Bank Corporation'
    );
	

SELECT company_name FROM works Group BY company_name HAVING COUNT(DISTINCT employee_name)>=ALL ( SELECT COUNT(DISTINCT employee_name) FROM works GROUP BY company_name);
				
				
SELECT result.company_name FROM (SELECT company_name, AVG(salary) AS a_salary 
                                 FROM works GROUP BY company_name) AS result 
                                 WHERE result.a_salary>(SELECT AVG(salary) 
                                                        FROM works 
                                                        WHERE company_name = 'First Bank Corporation');