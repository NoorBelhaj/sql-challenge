
-- Creating Tables in the right order

CREATE TABLE employees (
    emp_no int NOT NULL,
    emp_title_id varchar   NOT NULL,
    birth_date date   NOT NULL,
    first_name varchar(30)   NOT NULL,
    last_name varchar(30)   NOT NULL,
	sex varchar (1),
    hire_date date   NOT NULL,
	PRIMARY KEY (emp_no)
    -- CONSTRAINT pk_employees PRIMARY KEY (emp_no)
);

CREATE TABLE departments (
    dept_no varchar(4)   NOT NULL,
    dept_name varchar   NOT NULL,
	PRIMARY KEY (dept_no)
    -- CONSTRAINT pk_departments PRIMARY KEY (dept_no)
);

CREATE TABLE dept_emp (
    emp_no int   NOT NULL, 
    dept_no varchar(4)  NOT NULL, 
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
  	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
  	PRIMARY KEY (emp_no, dept_no)
);


-- FOREIGN KEY(dept_no) REFERENCES departments(dept_no)
CREATE TABLE dept_manager (
    dept_no varchar(4) NOT NULL , 
    emp_no int   NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
  	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
  	PRIMARY KEY (emp_no)
);

CREATE TABLE salaries (
    emp_no int   NOT NULL,
    salary dec   NOT NULL,
	PRIMARY KEY (emp_no)
    -- CONSTRAINT pk_salaries PRIMARY KEY (emp_no)
);

CREATE TABLE titles (
    title_id varchar(5) NOT NULL,
    title varchar(30)  NOT NULL,
    PRIMARY KEY (title_id)
	-- CONSTRAINT pk_titles PRIMARY KEY (title_id)
);

SELECT *
FROM salary_emp_details;

-- 1. List the employee number, last name, first name, sex, and salary of each employee.
CREATE TABLE salary_emp_details (last_name, first_name, sex, salary) AS
SELECT last_name, first_name, sex, salary
FROM employees, salaries
WHERE employees.emp_no = salaries.emp_no

-- 2. List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date >= '01/01/1986'


-- 3. List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT employees.emp_no, departments.dept_no, departments.dept_name, last_name, first_name
FROM departments
INNER JOIN dept_manager ON
departments.dept_no = dept_manager.dept_no
INNER JOIN employees ON
dept_manager.emp_no = employees.emp_no


-- 4. List the department number for each employee along with that employee’s employee number, 
-- last name, first name, and department name.

SELECT departments.dept_no, employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM departments
INNER JOIN dept_emp ON
departments.dept_no = dept_emp.dept_no
INNER JOIN employees ON
employees.emp_no = dept_emp.emp_no


-- 5. List first name, last name, and sex of each employee whose first name is Hercules and
-- whose last name begins with the letter B.

SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%'

-- 6. List each employee in the Sales department, including their employee number, last name, and first name.
SELECT employees.emp_no, employees.last_name, employees.first_name
FROM employees
INNER JOIN dept_emp ON
employees.emp_no = dept_emp.emp_no
INNER JOIN departments ON
departments.dept_no = dept_emp.dept_no
WHERE departments.dept_name = 'Sales'


-- 7.	List each employee in the Sales and Development departments, 
-- including their employee number, last name, first name, and department name.

SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
INNER JOIN dept_emp ON
employees.emp_no = dept_emp.emp_no
INNER JOIN departments ON
departments.dept_no = dept_emp.dept_no
WHERE departments.dept_name = 'Sales' OR departments.dept_name = 'Development'


-- 8. List the frequency counts, in descending order, of all the employee last names 
-- (that is, how many employees share each last name).

SELECT last_name, count(last_name)
FROM employees
GROUP BY last_name
ORDER BY count(last_name) DESC;



