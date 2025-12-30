-- Title: Compensation Outliers
-- Company: Accenture
-- Difficulty: Medium
-- Access: Premium
-- Pattern: statistical thresholds (IQR/z-score)
-- Summary: Detect compensation outliers by computing a benchmark distribution and filtering salaries outside the threshold.
-- Notes: IQR uses percentiles (PERCENTILE_CONT); ensure thresholds match definition; handle small groups carefully.
-- Dialect: PostgreSQL

WITH payouts AS (SELECT 
  employee_id,
  salary,
  title,
  AVG(salary) OVER (PARTITION BY title) * 2 AS double_average,
  AVG(salary) OVER (PARTITION BY title) / 2 AS half_average
FROM employee_pay)

SELECT 
  employee_id,
  salary,
  (CASE 
        WHEN salary > double_average THEN 'Overpaid'
        WHEN salary < half_average THEN 'Underpaid'
  END) AS outlier_status
FROM payouts
WHERE 
      salary > double_average
      OR salary < half_average