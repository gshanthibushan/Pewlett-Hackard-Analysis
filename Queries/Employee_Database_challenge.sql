-- Deliverable 1: The Number of Retiring Employees by Title

SELECT emp_no, first_name, last_name
FROM employees
SELECT title, from_date, to_date
FROM titles
INTO retirement_titles

-- Joining employees and titles tables
SELECT
	e.emp_no,
    e.first_name,
	e.last_name,
	ti.title,
    ti.from_date,
	ti.to_date
INTO retirement_titles
FROM employees AS e
	INNER JOIN titles AS ti
		ON (e.emp_no = ti.emp_no)
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no;


-- Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title
INTO Unique_Titles
FROM retirement_titles AS rt
ORDER BY emp_no ASC, to_date DESC;
SELECT * FROM Unique_Titles


-- retrieve the number of employees by their most recent job title who are about to retire.
--INTO retiring_titles
SELECT COUNT (ut.emp_no), ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY title 
ORDER BY COUNT(title) DESC;
SELECT * FROM retiring_titles




--Deliverable 2: The Employees Eligible for the Mentorship Program
-- statement to retrieve the first occurrence of the employee number for each set of rows defined by the ON () clause.
SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	ti.title
INTO mentorship_eligibilty
FROM employees AS e
	INNER JOIN dept_emp AS de
		ON (e.emp_no = de.emp_no)
	INNER JOIN titles AS ti
	ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY emp_no;