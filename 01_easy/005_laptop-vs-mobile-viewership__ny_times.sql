-- Title: Laptop vs. Mobile Viewership
-- Company: NY Times
-- Difficulty: Easy
-- Access: Free
-- Pattern: conditional aggregation
-- Summary: Compute viewership counts by device type using CASE expressions and aggregate to compare laptop vs mobile.
-- Notes: Grouping is usually not needed if output is single-row totals; verify device categories (e.g., 'laptop', 'tablet', 'phone').
-- Dialect: PostgreSQL

SELECT 
  SUM(CASE WHEN device_type = 'laptop' THEN 1 ELSE 0 END) AS laptop_views,
  SUM(CASE WHEN device_type IN ('tablet','phone') THEN 1 ELSE 0 END) AS mobile_views
FROM viewership