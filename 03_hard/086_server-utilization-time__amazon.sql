-- Title: Server Utilization Time
-- Company: Amazon
-- Difficulty: Hard
-- Access: Free
-- Pattern: interval overlap + aggregation
-- Summary: Compute server utilization by merging overlapping time intervals per server and summing total utilized time.
-- Notes: Use gaps-and-islands on interval boundaries; handle overlaps/adjacent intervals; ensure consistent time units.
-- Dialect: PostgreSQL

WITH running_time 
AS (
  SELECT
    server_id,
    session_status,
    status_time AS start_time,
    LEAD(status_time) OVER (
      PARTITION BY server_id
      ORDER BY status_time) AS stop_time
  FROM server_utilization
)

SELECT
  DATE_PART('days', JUSTIFY_HOURS(SUM(stop_time - start_time))) AS total_uptime_days
FROM running_time
WHERE session_status = 'start'
  AND stop_time IS NOT NULL;