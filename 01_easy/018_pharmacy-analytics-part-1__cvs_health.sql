-- Title: Pharmacy Analytics (Part 1)
-- Company: CVS Health
-- Difficulty: Easy
-- Access: Free
-- Pattern: computed metric + top-N (ORDER BY + LIMIT)
-- Summary: Compute profit per drug as (total_sales - cogs) and return the top 3 most profitable drugs.
-- Notes: If ties must be included, use DENSE_RANK() instead of LIMIT; ensure total_sales and cogs are in the same units.
-- Dialect: PostgreSQL

SELECT 
  drug,
  total_sales - cogs AS total_profit
FROM pharmacy_sales 
ORDER BY total_profit DESC
LIMIT 3