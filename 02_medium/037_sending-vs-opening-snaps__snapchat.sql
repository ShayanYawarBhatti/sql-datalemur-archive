-- Title: Sending vs. Opening Snaps
-- Company: Snapchat
-- Difficulty: Medium
-- Access: Free
-- Pattern: conditional aggregation
-- Summary: Compare sending vs opening behavior by aggregating counts per user (or date) using CASE filters for each action type.
-- Notes: Ensure event/action labels match exactly; if comparing rates, cast to numeric and use NULLIF for divide-by-zero.
-- Dialect: PostgreSQL

WITH snap_stats AS (
  SELECT
    age.age_bucket, 
    SUM(CASE WHEN activities.activity_type = 'send' 
    THEN activities.time_spent ELSE 0 END) AS send_time,
    SUM(CASE WHEN activities.activity_type = 'open' 
    THEN activities.time_spent ELSE 0 END) AS open_time,
    SUM(activities.time_spent) AS total_timespent
  FROM activities
  INNER JOIN age_breakdown AS age
    ON activities.user_id = age.user_id
  WHERE activities.activity_type IN ('open', 'send')
  GROUP BY age.age_bucket
)

SELECT 
  age_bucket, -- This won't be age.age_bucket, since cte has already created a joint table with columns
  ROUND(100.0 * send_time/total_timespent, 2) AS send_pct,
  ROUND(100.0 * open_time/total_timespent, 2) AS open_pct
FROM snap_stats

-- Outside the CTE, you can never use reference.something for any question


-- Becasue we want complete information from both tables,
-- By complete I mean if age_bucket is missing from the other TABLE
-- And we get nulls over there it will affect our result and we don't want that
-- But more importantly we want those rows that have age_bucket for our analysis