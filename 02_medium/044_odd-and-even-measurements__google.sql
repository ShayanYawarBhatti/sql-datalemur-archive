-- Title: Odd and Even Measurements
-- Company: Google
-- Difficulty: Medium
-- Access: Free
-- Pattern: window function + conditional aggregation
-- Summary: Assign an order to measurements per day and sum values at odd vs even positions using window functions.
-- Notes: Use ROW_NUMBER ordered by time; then SUM with CASE for odd/even; ensure ordering is deterministic.
-- Dialect: PostgreSQL

WITH ranked_measurements AS (
SELECT
  CAST(measurement_time AS DATE) AS measurement_day,
  measurement_value,
  ROW_NUMBER() OVER (
  PARTITION BY CAST(measurement_time AS DATE)
  ORDER BY measurement_time) AS measurement_num
FROM measurements
)

SELECT
  measurement_day,
  SUM(CASE WHEN measurement_num % 2 = 0 THEN measurement_value ELSE 0 END) AS even_sum,
  SUM(CASE WHEN measurement_num % 2 != 0 THEN measurement_value ELSE 0 END) AS odd_sum
FROM ranked_measurements
GROUP BY measurement_day