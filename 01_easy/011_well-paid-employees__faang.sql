-- Title: Well Paid Employees
-- Company: FAANG
-- Difficulty: Easy
-- Access: Free
-- Pattern: filtering with aggregate benchmark
-- Summary: Compare employee pay against a benchmark (e.g., department average) and return employees meeting the “well paid” condition.
-- Notes: If benchmark is per-department, compute it in a CTE/subquery then join back; ensure correct comparison operator.
-- Dialect: PostgreSQL

SELECT 
  emp.employee_id AS employee_id,
  emp.name AS employee_name
FROM employee AS emp
INNER JOIN employee AS mgr
  -- Mapping employee's manager_id → manager's employee_id
  ON emp.manager_id = mgr.employee_id
WHERE emp.salary > mgr.salary
LIMIT 5;