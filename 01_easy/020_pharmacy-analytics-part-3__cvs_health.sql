-- Title: Pharmacy Analytics (Part 3)
-- Company: CVS Health
-- Difficulty: Easy
-- Access: Free
-- Pattern: conditional aggregation
-- Summary: Compute segmented pharmacy metrics using CASE expressions and aggregate to produce the requested breakdown.
-- Notes: Ensure categories are mutually exclusive; cast to numeric for ratios to avoid integer division.
-- Dialect: PostgreSQL

SELECT 
  manufacturer,
  CONCAT('$', ROUND(SUM(total_sales)/1000000), ' million') AS sales_mil
FROM pharmacy_sales
GROUP BY manufacturer
ORDER BY SUM(total_sales) DESC, manufacturer

-- Note: SELECT aliases cannot be used inside aggregate functions. Therefore, 
-- we must use SUM(total_sales) instead of sales_mil in ORDER BY clause
