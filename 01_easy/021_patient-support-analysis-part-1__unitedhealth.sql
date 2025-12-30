-- Title: Patient Support Analysis (Part 1)
-- Company: UnitedHealth
-- Difficulty: Easy
-- Access: Free
-- Pattern: aggregation by category
-- Summary: Summarize patient support interactions by the requested category (e.g., issue type, patient) using GROUP BY.
-- Notes: Filter to relevant interaction types/statuses first; handle NULL categories if required by the output.
-- Dialect: PostgreSQL

SELECT 
  COUNT(policy_holder_id) AS policy_holder_count
FROM (
  SELECT 
    policy_holder_id,
    COUNT(case_id) AS call_count
  FROM callers
  GROUP BY policy_holder_id
  HAVING COUNT(case_id) >= 3
) AS call_records
