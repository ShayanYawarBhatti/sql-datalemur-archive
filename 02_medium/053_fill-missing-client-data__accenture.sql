-- Title: Fill Missing Client Data
-- Company: Accenture
-- Difficulty: Medium
-- Access: Premium
-- Pattern: data imputation (window fill / self-join)
-- Summary: Fill missing client fields by carrying forward/backward known values within each client using window functions or joins.
-- Notes: Define fill direction explicitly (last known vs next known); be careful not to mix clients; COALESCE is typically used.
-- Dialect: PostgreSQL

WITH filled_category AS (SELECT
  product_id,
  category,
  name,
  COUNT(category) OVER(
  ORDER BY product_id) AS numbered_category
FROM products)

SELECT
  product_id,
  COALESCE(
    category,
    MAX(category) OVER( 
    PARTITION BY numbered_category)
  ) AS category,
  name
FROM filled_category 

/*
How does coalesce work? Replacing values is the most common application
SELECT COALESCE(middle_name, 'N/A') AS middle_name
FROM users;
If middle_name is NULL → return 'N/A'.

We do max category, because this is what's supposed to be filled not 
numbered_category, the max(category) will give us the non null value in 
the category column, and then fill that value in all nulls.
*/