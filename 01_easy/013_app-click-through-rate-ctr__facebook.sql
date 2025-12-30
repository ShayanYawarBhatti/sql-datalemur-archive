-- Title: App Click-through Rate (CTR)
-- Company: Facebook
-- Difficulty: Easy
-- Access: Free
-- Pattern: conditional aggregation (rate)
-- Summary: Compute CTR as clicks divided by impressions (or views) using conditional counts/sums and a ratio.
-- Notes: Cast to numeric to avoid integer division; protect against divide-by-zero with NULLIF.
-- Dialect: PostgreSQL

SELECT
  app_id,
  ROUND(
  100.0 * SUM(CASE WHEN event_type = 'click' THEN 1 ELSE 0 END)/ 
  SUM(CASE WHEN event_type = 'impression' THEN 1 ELSE 0 END), 2) AS ctr_rate
FROM events
WHERE EXTRACT (YEAR FROM timestamp) = '2022'
GROUP BY app_id