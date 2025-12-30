-- Title: Photoshop Revenue Analysis
-- Company: Adobe
-- Difficulty: Medium
-- Access: Premium
-- Pattern: aggregation + filtering by product
-- Summary: Filter revenue to Photoshop (or its SKU) and compute the requested revenue metrics by the required dimension.
-- Notes: Watch for product naming variants; if joining orders to products, avoid double-counting with DISTINCT order ids.
-- Dialect: PostgreSQL

SELECT
  customer_id,
  SUM(revenue) AS revenue
FROM adobe_transactions
WHERE customer_id IN 
  (SELECT
    customer_id
  FROM adobe_transactions
  WHERE LOWER(product) = 'photoshop') AND LOWER(product) <> 'photoshop'
GROUP BY customer_id
ORDER BY customer_id