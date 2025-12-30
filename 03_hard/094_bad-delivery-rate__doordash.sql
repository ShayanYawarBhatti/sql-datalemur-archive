-- Title: Bad Delivery Rate
-- Company: DoorDash
-- Difficulty: Hard
-- Access: Premium
-- Pattern: conditional aggregation (rate) + filtering
-- Summary: Compute bad delivery rate by dividing bad deliveries by total deliveries over the defined window and grouping as required.
-- Notes: Define “bad” precisely (late, canceled, wrong order, etc.); cast to numeric and use NULLIF to avoid divide-by-zero.
-- Dialect: PostgreSQL

WITH june22_cte AS (
SELECT 
  orders.order_id,
  orders.trip_id,
  orders.status
FROM customers
INNER JOIN orders
  ON customers.customer_id = orders.customer_id
WHERE EXTRACT(MONTH FROM customers.signup_timestamp) = 6
  AND EXTRACT(YEAR FROM customers.signup_timestamp) = 2022
  AND orders.order_timestamp BETWEEN customers.signup_timestamp 
    AND customers.signup_timestamp + INTERVAL '14 DAYS'
)

SELECT 
  ROUND(
    100.0 *
      COUNT(june22.order_id)
      / (SELECT COUNT(order_id) FROM june22_cte)
  ,2) AS bad_experience_pct
FROM june22_cte AS june22
INNER JOIN trips
  ON june22.trip_id = trips.trip_id
WHERE june22.status IN ('completed incorrectly', 'never received');