-- Title: Cumulative Purchases by Product Type
-- Company: Amazon
-- Difficulty: Medium
-- Access: Premium
-- Pattern: window function (running total)
-- Summary: Compute running totals of purchases per product type over time using SUM(...) OVER (PARTITION BY ... ORDER BY ...).
-- Notes: Ensure correct ordering by date; choose ROWS vs RANGE depending on data grain; fill missing dates only if required.
-- Dialect: PostgreSQL

SELECT 
  order_date, 
  product_type,
  SUM(quantity) OVER(
  PARTITION BY product_type
  ORDER BY order_date ASC) AS cum_purchased
FROM total_trans
ORDER BY order_date ASC

/*
We add ORDER BY order_date again at the end because the ORDER BY inside 
the window function only controls the calculation order within each partition. 
To actually sort the entire output table by date,  we must include a 
separate ORDER BY clause at the end of the query.
*/