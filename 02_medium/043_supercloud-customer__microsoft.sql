-- Title: Supercloud Customer
-- Company: Microsoft
-- Difficulty: Medium
-- Access: Free
-- Pattern: set logic (HAVING across categories)
-- Summary: Identify customers who purchased across all required product categories by grouping and filtering with HAVING.
-- Notes: Use COUNT(DISTINCT category) = N to enforce “all categories”; ensure category mapping matches the definition.
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
