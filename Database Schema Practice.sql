-- Create table named Student with different attributes with preferred data types

CREATE TABLE student (
    student_id INT PRIMARY KEY,
    name VARCHAR (20),
    major VARCHAR (20)
);

DESCRIBE student;

-- Insert informations into each columns

INSERT INTO student VALUES (1, 'John', 'Biology');
INSERT INTO student VALUES (2, 'Kate', 'Sociology');
INSERT INTO student VALUES (3, 'Claire', 'Sociology');
INSERT INTO student VALUES (4, 'Ron', 'Computer Science');
INSERT INTO student VALUES (5, 'Mike', 'English');

-- Example of ALTER INTO command

ALTER TABLE student ADD gpa DECIMAL (3,2);

ALTER TABLE student DROP COLUMN gpa;

-- Example of UPDATE and DELETE FROM command

UPDATE student 
SET major = 'Bio'
WHERE major = 'Biology';

UPDATE student
SET major = 'Bio CompSci'
WHERE major = 'Bio' OR major = 'Computer Science';

DELETE FROM student
WHERE student_id = 3;

DELETE FROM student
WHERE name = 'Kate' OR major = 'Bio Compsci';

DROP TABLE student;

-- Create table employee and branch with attributes and data types

CREATE TABLE employee (
  emp_id INT PRIMARY KEY,
  first_name VARCHAR(40),
  last_name VARCHAR(40),
  birth_day DATE,
  sex VARCHAR(1),
  salary INT,
  super_id INT,
  branch_id INT
);

CREATE TABLE branch (
  branch_id INT PRIMARY KEY,
  branch_name VARCHAR(40),
  mgr_id INT,
  mgr_start_date DATE,
  FOREIGN KEY(mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL
);

-- ALTER TABLE used to update foreign key 'super_id' & 'branch_id' after branch table has been constructed 

ALTER TABLE employee
ADD FOREIGN KEY (super_id)
REFERENCES employee(emp_id)
ON DELETE SET NULL;

ALTER TABLE employee
ADD FOREIGN KEY (branch_id)
REFERENCES branch(branch_id)
ON DELETE SET NULL;

-- Create table client, works_with & branch_supplier with their data types

CREATE TABLE client (
  client_id INT PRIMARY KEY,
  client_name VARCHAR(40),
  branch_id INT,
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL
);


CREATE TABLE works_with (
  emp_id INT,
  client_id INT,
  total_sales INT,
  PRIMARY KEY(emp_id, client_id),
  FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
  FOREIGN KEY(client_id) REFERENCES client(client_id) ON DELETE CASCADE
);

CREATE TABLE branch_supplier (
  branch_id INT,
  supplier_name VARCHAR(40),
  supply_type VARCHAR(40),
  PRIMARY KEY(branch_id, supplier_name),
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE
);

-- Insert information into of Corporate branch's attribute

-- Firstly, insert one info in employee table to connect foreign keys in branch table to employee table, leaving out the values of branch_id to be null
INSERT INTO employee VALUES(100, 'David', 'Wallace', '1967-11-17', 'M', 250000, NULL, NULL);

-- Then connect branch table to employee table at once by entering the value in branch table
INSERT INTO branch VALUES(1, 'Corporate', 100, '2006-02-09');

-- Update foreign key 'branch id' in employee table
UPDATE employee
SET branch_id = 1
WHERE emp_id = 100;

-- Continue to submit remaining values from 'Corporate' branch

INSERT INTO employee VALUES(101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1);

-- Repeat the same process for 'Scranton' and 'Stamford' branch

-- Scranton

INSERT INTO employee VALUES(102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, 100, NULL);

INSERT INTO branch VALUES(2, 'Scranton', 102, '1992-04-06');

UPDATE employee
SET branch_id = 2
WHERE emp_id = 102;

INSERT INTO employee VALUES(103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2);
INSERT INTO employee VALUES(104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2);
INSERT INTO employee VALUES(105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2);

-- Stamford branch
INSERT INTO employee VALUES(106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, NULL);

INSERT INTO branch VALUES(3, 'Stamford', 106, '1998-02-13');

UPDATE employee
SET branch_id = 3
WHERE emp_id = 106;

INSERT INTO employee VALUES(107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3);
INSERT INTO employee VALUES(108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);

-- Create Client table

INSERT INTO client VALUES(400, 'Dunmore Highschool', 2);
INSERT INTO client VALUES(401, 'Lackawana Country', 2);
INSERT INTO client VALUES(402, 'FedEx', 3);
INSERT INTO client VALUES(403, 'John Daly Law, LLC', 3);
INSERT INTO client VALUES(404, 'Scranton Whitepages', 2);
INSERT INTO client VALUES(405, 'Times Newspaper', 3);
INSERT INTO client VALUES(406, 'FedEx', 2);

-- Create Branch Supplier table

INSERT INTO branch_supplier VALUES(2, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Patriot Paper', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'J.T. Forms & Labels', 'Custom Forms');
INSERT INTO branch_supplier VALUES(3, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(3, 'Stamford Lables', 'Custom Forms');

-- Create Works With table

INSERT INTO works_with VALUES(105, 400, 55000);
INSERT INTO works_with VALUES(102, 401, 267000);
INSERT INTO works_with VALUES(108, 402, 22500);
INSERT INTO works_with VALUES(107, 403, 5000);
INSERT INTO works_with VALUES(108, 403, 12000);
INSERT INTO works_with VALUES(105, 404, 33000);
INSERT INTO works_with VALUES(107, 405, 26000);
INSERT INTO works_with VALUES(102, 406, 15000);
INSERT INTO works_with VALUES(105, 406, 130000);

-- More basic queries
SELECT * FROM employee;

-- ORDER BY
SELECT first_name, last_name, sex
FROM employee
ORDER BY sex DESC;

-- LIMIT
SELECT first_name, last_name, sex
FROM employee
ORDER BY sex DESC
LIMIT 5;

-- WHERE
SELECT emp_id, first_name, last_name, salary
FROM employee
WHERE salary > 50000 AND sex = 'F';

-- AS; e.g. Find forename and surname names of all employees
SELECT first_name AS Forename, last_name AS Surname
FROM employee;

SELECT CONCAT(first_name, ' ', last_name) AS Name
FROM employee;

-- DISTINCT; e.g. Find out all different product supplies 
SELECT DISTINCT supply_type
FROM branch_supplier;

-- COUNT; e.g. Find the number of female employees born after 1970
SELECT COUNT(emp_id) FROM employee
WHERE sex = 'F' AND birth_day > '1970-01-01';

-- AVG; e.g. Find the average salary of male employee's salaries
SELECT AVG(salary) FROM employee
WHERE sex = 'M';

-- GROUP BY; e.g. Find the average of male and female salaries
SELECT AVG(salary), sex FROM employee
GROUP BY sex;

-- SUM; e.g. Find the total sales of each salesman
SELECT SUM(works_with.total_sales), employee.emp_id, employee.first_name
FROM works_with, employee
GROUP BY emp_id;

-- JOIN; e.g. Find all branches and the names of their manager
SELECT employee.emp_id, employee.first_name, branch.branch_name
FROM employee 
JOIN branch
ON employee.emp_id = branch.mgr_id;

--NESTED QUERIES; e.g. Find all clients who are handled by the branch that Micahael manages
SELECT client.client_name FROM client
WHERE client.branch_id = (
    SELECT branch.branch_id 
    FROM branch
    WHERE branch.mgr_id = 102
)    ;

