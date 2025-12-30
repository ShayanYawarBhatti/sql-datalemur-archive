-- Title: User Session Activity
-- Company: Twitter
-- Difficulty: Medium
-- Access: Premium
-- Pattern: sessionization (time-gap grouping)
-- Summary: Build sessions per user by grouping events where gaps exceed a threshold, then aggregate activity per session.
-- Notes: Use LAG to compute gaps and a running SUM to assign session_id; confirm session gap threshold and units.
-- Dialect: PostgreSQL

SELECT 
  user_id,
  session_type,
  DENSE_RANK() OVER(
  PARTITION BY session_type
  ORDER BY SUM(duration) DESC) AS ranking
FROM sessions 
WHERE start_date BETWEEN '2022-01-01' AND '2022-02-01'
GROUP BY user_id, session_type