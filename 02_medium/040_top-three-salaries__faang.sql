-- Title: Top Three Salaries
-- Company: FAANG
-- Difficulty: Medium
-- Access: Free
-- Pattern: window function (DENSE_RANK) / top-N
-- Summary: Return the top three distinct salaries (optionally per department) using DENSE_RANK and filtering rank <= 3.
-- Notes: Use DENSE_RANK (not ROW_NUMBER) to keep ties; clarify whether scope is company-wide or per department.
-- Dialect: PostgreSQL

WITH ranked_salary_table AS (
SELECT
  d.department_name,
  e.name,
  e.salary,
  DENSE_RANK() OVER(
  PARTITION BY d.department_name
  ORDER BY e.salary DESC) AS ranked_salary
FROM employee AS e
INNER JOIN department AS d
  ON e.department_id = d.department_id
)

SELECT 
  department_name,
  name,
  salary
FROM ranked_salary_table
WHERE ranked_salary <= 3
ORDER BY department_name ASC, salary DESC, name ASC
