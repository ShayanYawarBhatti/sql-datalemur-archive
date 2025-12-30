-- Title: IBM db2 Product Analytics
-- Company: IBM
-- Difficulty: Easy
-- Access: Free
-- Pattern: aggregation by dimension
-- Summary: Aggregate product usage/engagement metrics by the required dimension (e.g., user, product, date) and return the requested summary.
-- Notes: Apply the correct filters first (date range, product name, event type) before aggregating.
-- Dialect: PostgreSQL

WITH employee_queries AS (
  SELECT
    e.employee_id, 
    COALESCE(COUNT(DISTINCT q.query_id), 0) AS unique_queries
  FROM employees AS e
  LEFT JOIN queries AS q
    ON e.employee_id = q.employee_id
      AND q.query_starttime BETWEEN '2023-07-01 00:00:00' 
      AND '2023-10-1 00:00:00'
  GROUP BY e.employee_id
)

SELECT
  unique_queries,
  COUNT(employee_id) AS employee_count
FROM employee_queries
GROUP BY unique_queries
ORDER BY unique_queries