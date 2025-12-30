-- Title: Product Line Revenue
-- Company: NVIDIA
-- Difficulty: Easy
-- Access: Premium
-- Pattern: aggregation by dimension
-- Summary: Aggregate revenue by product line using SUM and return the requested revenue breakdown.
-- Notes: Ensure revenue is computed at the correct grain (price * quantity vs precomputed revenue); watch for join inflation.
-- Dialect: PostgreSQL

SELECT
  product.product_line,
  SUM(amount) AS total_revenue
FROM transactions
INNER JOIN product_info AS product
  ON transactions.product_id = product.product_id
GROUP BY product.product_line
ORDER BY total_revenue DESC;