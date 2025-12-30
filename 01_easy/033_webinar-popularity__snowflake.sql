-- Title: Webinar Popularity
-- Company: Snowflake
-- Difficulty: Easy
-- Access: Premium
-- Pattern: aggregation + ranking
-- Summary: Aggregate webinar attendance/engagement metrics and rank webinars to identify the most popular ones.
-- Notes: If popularity is based on distinct attendees, use COUNT(DISTINCT user_id); include ties with DENSE_RANK if needed.
-- Dialect: PostgreSQL

SELECT 
  ROUND(100.0 * SUM(CASE WHEN event_type = 'webinar' THEN 1 ELSE 0 END)
  /COUNT(*), 2) AS webinar_pct
FROM marketing_touches
WHERE event_date >= '04/01/2022' AND event_date <= '04/30/2022'