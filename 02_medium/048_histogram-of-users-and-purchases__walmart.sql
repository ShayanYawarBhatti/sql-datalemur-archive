-- Title: Histogram of Users and Purchases
-- Company: Walmart
-- Difficulty: Medium
-- Access: Free
-- Pattern: two-step aggregation (histogram)
-- Summary: Aggregate purchase counts per user, then count users per purchase-count bucket to produce a histogram.
-- Notes: Use COUNT(DISTINCT order_id) if multiple rows per order exist; filter to the correct timeframe before aggregation.
-- Dialect: PostgreSQL

WITH moment_users AS (
  SELECT DISTINCT
    u.user_id
  FROM users AS u
  INNER JOIN rides AS r
    ON u.user_id = r.user_id
  WHERE u.registration_date = r.ride_date
),

rides_cte AS (SELECT
  u.user_id,
  r.ride_date, 
  ROW_NUMBER() OVER (
  PARTITION BY u.user_id
  ORDER BY r.ride_date) AS ride_num,
  LAG(r.ride_date) OVER(
    PARTITION BY u.user_id
    ORDER BY r.ride_date) AS prev_ride
FROM moment_users AS u 
LEFT JOIN rides AS r
  ON u.user_id = r.user_id)

SELECT
  ROUND(AVG(ride_date - prev_ride), 2) AS avg_delay
FROM rides_cte
WHERE ride_num = 2