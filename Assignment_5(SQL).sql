CREATE TABLE departments (
    dept_id SERIAL PRIMARY KEY,
    dname VARCHAR(50) NOT NULL
);

CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    fname VARCHAR(50) NOT NULL,
    lname VARCHAR(50) NOT NULL,
    dept_id INTEGER REFERENCES departments(dept_id)
);

INSERT INTO departments (dname) VALUES
    ('Engineering'),
    ('Marketing'),
    ('Human Resources'),
    ('Sales');

INSERT INTO employees (fname, lname, dept_id) VALUES
    ('John', 'Doe', 1),
    ('Jane', 'Smith', 2),
    ('Bob', 'Johnson', 1),
    ('Alice', 'Williams', 3),
    ('Michael', 'Brown', 4);

CREATE VIEW vw_employee_details AS
SELECT 
    e.fname,
    e.lname,
    d.dname
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id;

Select * from vw_employee_details;

--task two

CREATE TABLE projects (
    project_id SERIAL PRIMARY KEY,
    pname VARCHAR(50) NOT NULL
);


CREATE TABLE work_hours (
    emp_id INTEGER REFERENCES employees(emp_id),
    project_id INTEGER REFERENCES projects(project_id),
    hours DECIMAL(5,2),
    PRIMARY KEY (emp_id, project_id)
);

INSERT INTO projects (pname) VALUES
    ('Website Redesign'),
    ('Mobile App'),
    ('Database Migration'),
    ('Cloud Integration');

INSERT INTO work_hours (emp_id, project_id, hours) VALUES
    (1, 1, 20.5),
    (1, 2, 15.0),
    (2, 1, 30.0),
    (3, 3, 25.5),
    (4, 4, 18.0);

CREATE VIEW vw_work_hrs AS
SELECT 
    e.fname,
    e.lname,
    p.pname,
    w.hours
FROM employees e
JOIN work_hours w ON e.emp_id = w.emp_id
JOIN projects p ON w.project_id = p.project_id;

CREATE OR REPLACE VIEW vw_work_hrs AS
SELECT 
    e.fname,
    e.lname,
    p.pname,
    w.hours
FROM employees e
JOIN work_hours w ON e.emp_id = w.emp_id
JOIN projects p ON w.project_id = p.project_id
WHERE e.dept_id = 5;

SELECT * FROM vw_work_hrs;

--task 3
CREATE TABLE suppliers (
    supplier_id SERIAL PRIMARY KEY,
    supplier_name VARCHAR(100) NOT NULL,
    status INTEGER CHECK (status >= 0),
    city VARCHAR(50)
);

INSERT INTO suppliers (supplier_name, status, city) VALUES
    ('Acme Corp', 20, 'New York'),
    ('Best Supplies', 25, 'Chicago'),
    ('Quality Goods', 10, 'Los Angeles'),
    ('Premium Parts', 30, 'Boston'),
    ('Standard Supply', 15, 'Detroit');

CREATE VIEW vw_high_status_suppliers AS
SELECT *
FROM suppliers
WHERE status > 15
WITH CHECK OPTION;

SELECT * FROM vw_high_status_suppliers;

INSERT INTO vw_high_status_suppliers (supplier_name, status, city)
VALUES ('Elite Supplies', 18, 'Miami');

--this query is trying to insert an invalid record (this will fail due to CHECK OPTION)
INSERT INTO vw_high_status_suppliers (supplier_name, status, city)
VALUES ('Low Grade Supplies', 12, 'Seattle');