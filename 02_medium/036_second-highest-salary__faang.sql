-- Title: Second Highest Salary
-- Company: FAANG
-- Difficulty: Medium
-- Access: Free
-- Pattern: ranking (DENSE_RANK) / MAX-of-less-than
-- Summary: Find the second highest salary using DENSE_RANK over salaries or by selecting MAX(salary) below the maximum.
-- Notes: Use DISTINCT salaries to handle duplicates; decide whether to return NULL when fewer than 2 unique salaries exist.
-- Dialect: PostgreSQL

SELECT MAX(salary) AS second_highest_salary
FROM employee
WHERE salary < (SELECT 
  MAX(salary) 
FROM employee)

-- The subquery gives us the highest salary in the employee TABLE
-- We are basically just taking the second max from the table