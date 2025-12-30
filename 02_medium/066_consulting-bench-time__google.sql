-- Title: Consulting Bench Time
-- Company: Google
-- Difficulty: Medium
-- Access: Premium
-- Pattern: date range math + gaps (bench time)
-- Summary: Calculate bench time by measuring gaps between staffed project intervals per consultant and summing unassigned days.
-- Notes: Sort intervals carefully; clamp overlaps to avoid negative gaps; handle first/last interval boundaries per definition.
-- Dialect: PostgreSQL

WITH consulting_days AS (SELECT
  s.employee_id,
  SUM(e.end_date - e.start_date) AS non_bench_days,
  COUNT(s.job_id) AS inclusive_days
FROM staffing AS s 
INNER JOIN consulting_engagements AS e
  ON s.job_id = e.job_id
WHERE s.is_consultant = 'true'
GROUP BY s.employee_id)

SELECT
  employee_id,
  365 - SUM(non_bench_days) - SUM(inclusive_days) AS bench_days
FROM consulting_days
GROUP BY employee_id