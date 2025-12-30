-- Title: 2nd Ride Delay
-- Company: Uber
-- Difficulty: Medium
-- Access: Premium
-- Pattern: window function (ROW_NUMBER/LAG) + time difference
-- Summary: Order rides per user and compute the time gap between the first and second ride (or isolate the 2nd ride delay).
-- Notes: Use ROW_NUMBER to pick rides 1 and 2; ensure timestamp math uses correct units; handle users with <2 rides.
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