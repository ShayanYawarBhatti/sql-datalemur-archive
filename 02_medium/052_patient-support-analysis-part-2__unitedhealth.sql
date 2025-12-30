-- Title: Patient Support Analysis (Part 2)
-- Company: UnitedHealth
-- Difficulty: Medium
-- Access: Free
-- Pattern: aggregation + window / segmentation
-- Summary: Extend the patient support analysis by computing segmented metrics and returning the required breakdown.
-- Notes: Watch for one-to-many joins inflating counts; use DISTINCT where appropriate; match exact filtering criteria.
-- Dialect: PostgreSQL

WITH uncategorised_callers AS (
  SELECT 
    COUNT(case_id) AS uncategorised_calls
  FROM callers
  WHERE call_category = 'n/a' OR call_category IS NULL
)

SELECT
  ROUND(100.0 * uncategorised_calls/
  (SELECT COUNT(case_id) FROM callers), 1) AS uncategorised_call_pct
FROM uncategorised_callers;
