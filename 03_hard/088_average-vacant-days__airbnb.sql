-- Title: Average Vacant Days
-- Company: Airbnb
-- Difficulty: Hard
-- Access: Premium
-- Pattern: date gaps (availability intervals)
-- Summary: Compute average vacant days by measuring gaps between booked intervals per listing and averaging vacancy durations.
-- Notes: Sort bookings per listing; clamp overlaps; decide whether to include leading/trailing vacancy based on definition.
-- Dialect: PostgreSQL

WITH listing_vacancies AS (
SELECT 
  listings.listing_id,
  365 - COALESCE(
    SUM(
      CASE WHEN checkout_date>'12/31/2021' THEN '12/31/2021' ELSE checkout_date END -
      CASE WHEN checkin_date<'01/01/2021' THEN '01/01/2021' ELSE checkin_date END 
  ),0) AS vacant_days
FROM listings 
LEFT JOIN bookings
  ON listings.listing_id = bookings.listing_id 
WHERE listings.is_active = 1
GROUP BY listings.listing_id)

SELECT ROUND(AVG(vacant_days)) 
FROM listing_vacancies;