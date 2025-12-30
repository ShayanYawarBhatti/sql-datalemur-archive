-- Title: Highest Number of Products
-- Company: eBay
-- Difficulty: Easy
-- Access: Premium
-- Pattern: top-1 aggregation (MAX / ORDER BY LIMIT)
-- Summary: Find the entity (e.g., seller/category) with the highest product count by aggregating and selecting the maximum.
-- Notes: If ties should be included, use RANK/DENSE_RANK instead of LIMIT 1.
-- Dialect: PostgreSQL

SELECT 
  user_id,
  COUNT(product_id) AS product_num
FROM user_transactions
GROUP BY user_id
HAVING SUM(spend) >= 1000
ORDER BY product_num DESC, SUM(spend) DESC
LIMIT 3