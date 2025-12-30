-- Title: Booking Referral Source
-- Company: Airbnb
-- Difficulty: Medium
-- Access: Premium
-- Pattern: attribution aggregation
-- Summary: Attribute bookings to referral sources and aggregate bookings/revenue by source.
-- Notes: If multiple touches exist, confirm whether to use first-touch/last-touch; deduplicate bookings before aggregating.
-- Dialect: PostgreSQL

WITH booking_history AS (
SELECT 
  b.user_id,
  b.booking_id,
  ba.channel,
  ROW_NUMBER() OVER(
  PARTITION BY b.user_id 
  ORDER BY b.booking_date) AS booking_num 
FROM bookings AS b
INNER JOIN booking_attribution AS ba
  ON b.booking_id = ba.booking_id
),
channel_first_booking AS (SELECT
  channel,
  COUNT(*) AS channel_booking_num
FROM booking_history
WHERE booking_num = 1
GROUP BY channel
)

SELECT
    channel,
    ROUND(100.0 * (channel_booking_num/
    (SELECT SUM(channel_booking_num) FROM channel_first_booking))
    , 0) AS first_booking_pct
FROM channel_first_booking
ORDER BY first_booking_pct DESC
LIMIT 1

/*
We do this (SELECT SUM(channel_booking) FROM first_booking))
instead of COUNT(*) because COUNT(*) only counts rows, we need sum of bookings
*/