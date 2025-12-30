-- Title: Patient Support Analysis (Part 3)
-- Company: UnitedHealth
-- Difficulty: Hard
-- Access: Free
-- Pattern: multi-step aggregation + segmentation
-- Summary: Extend patient support analysis with advanced segmentation/window logic to compute the requested metrics and breakdowns.
-- Notes: Use CTEs to stage logic; ensure joins don’t inflate counts; match filtering criteria exactly to the definition.
-- Dialect: PostgreSQL

WITH call_history AS (
  SELECT 
    policy_holder_id,
    call_date,
    LAG(call_date) OVER (
      PARTITION BY policy_holder_id
      ORDER BY call_date
    ) AS previous_call,
    ROUND(
      EXTRACT(
        EPOCH FROM call_date 
        - LAG(call_date) OVER (
        PARTITION BY policy_holder_id
        ORDER BY call_date)
      )/(24*60*60)
    , 2
    ) AS time_diff_days
  FROM callers
)

SELECT COUNT(DISTINCT policy_holder_id) AS count_policy_holder
FROM call_history
WHERE time_diff_days <= 7;