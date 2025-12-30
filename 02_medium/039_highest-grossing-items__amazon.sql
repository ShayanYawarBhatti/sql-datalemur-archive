-- Title: Highest-Grossing Items
-- Company: Amazon
-- Difficulty: Medium
-- Access: Free
-- Pattern: aggregation + ranking (top-N)
-- Summary: Aggregate revenue per item and return the highest-grossing items using ORDER BY with LIMIT or window ranking.
-- Notes: Revenue may require SUM(price * quantity); handle ties with DENSE_RANK if the expected output includes them.
-- Dialect: PostgreSQL

WITH ranked_spending_cte AS (
SELECT
  category, 
  product, 
  SUM(spend) AS total_spend,
  ROW_NUMBER() OVER (
  PARTITION BY category
  ORDER BY SUM(spend) DESC) AS ranking
FROM product_spend 
WHERE EXTRACT(YEAR FROM transaction_date) = '2022'
GROUP BY category, product
)

SELECT 
  category, 
  product,
  total_spend
FROM ranked_spending_cte
WHERE ranking IN (1, 2)
ORDER BY category, ranking