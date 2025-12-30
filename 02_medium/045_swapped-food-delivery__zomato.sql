-- Title: Swapped Food Delivery
-- Company: Zomato
-- Difficulty: Medium
-- Access: Free
-- Pattern: self-join / pairing logic
-- Summary: Detect swapped deliveries by matching orders and deliveries across users/restaurants and flagging mismatched pairings.
-- Notes: Be careful with join keys to avoid Cartesian matches; use DISTINCT or a unique order id where available.
-- Dialect: PostgreSQL

WITH orders_count AS (
  SELECT COUNT(order_id) AS total_orders
  FROM orders
)

SELECT 
  CASE 
    WHEN order_id % 2 != 0 AND order_id != total_orders THEN order_id + 1
    WHEN order_id % 2 != 0 AND order_id = total_orders THEN order_id
    ELSE order_id - 1
  END AS corrected_order_id,
  item
FROM orders
CROSS JOIN orders_count
ORDER BY corrected_order_id;