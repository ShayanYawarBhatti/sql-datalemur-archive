-- Title: Uniquely Staffed Consultants
-- Company: Accenture
-- Difficulty: Hard
-- Access: Premium
-- Pattern: set uniqueness + aggregation
-- Summary: Identify consultants staffed in a unique way by aggregating staffing assignments and filtering to those whose assignment set is unique.
-- Notes: Build a canonical representation of assignment sets (e.g., STRING_AGG ordered) or compare counts per project; watch for duplicates.
-- Dialect: PostgreSQL

WITH single_client_consultants AS (
  SELECT employees.employee_id
  FROM employees
  INNER JOIN consulting_engagements AS engagements
    ON employees.engagement_id = engagements.engagement_id
  GROUP BY employees.employee_id
  HAVING COUNT(DISTINCT engagements.client_name) = 1
)

SELECT 
  engagements.client_name, 
  COUNT(DISTINCT employees.employee_id) AS total_consultants,
  COUNT(DISTINCT single.employee_id) AS single_client_consultants
FROM employees
INNER JOIN consulting_engagements AS engagements 
  ON employees.engagement_id = engagements.engagement_id
LEFT JOIN single_client_consultants AS single
  ON employees.employee_id = single.employee_id
GROUP BY engagements.client_name
ORDER BY engagements.client_name;