-- Title: Frequently Purchased Pairs
-- Company: Walmart
-- Difficulty: Medium
-- Access: Premium
-- Pattern: self-join pairs + aggregation
-- Summary: Generate item pairs from the same order/cart via self-join, then count pair frequency to find top pairs.
-- Notes: Enforce item_a < item_b to avoid duplicates; use COUNT(DISTINCT order_id) if multiple rows per order exist.
-- Dialect: PostgreSQL

WITH array_table AS (SELECT 
  transaction_id,
  ARRAY_AGG((product_id::text) ORDER BY product_id) AS combination
FROM transactions
GROUP BY transaction_id)

SELECT DISTINCT combination
FROM array_table
WHERE ARRAY_LENGTH(combination, 1) > 1
ORDER BY combination

-- , 1 specifies which dimension of the array you want the length of
-- Since this is a one dimensional array, we add , 1.
