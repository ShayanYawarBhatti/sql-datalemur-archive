-- Title: Pharmacy Analytics (Part 2)
-- Company: CVS Health
-- Difficulty: Easy
-- Access: Free
-- Pattern: aggregation + join
-- Summary: Join relevant tables (e.g., prescriptions, patients) then compute the requested aggregate metrics.
-- Notes: Watch for one-to-many joins that inflate counts; use DISTINCT where needed to avoid double-counting.
-- Dialect: PostgreSQL

SELECT 
  manufacturer, 
  COUNT(drug) AS drug_count,
  ABS(SUM(total_sales-cogs)) AS total_loss
FROM pharmacy_sales 
WHERE total_sales - cogs <= 0
GROUP BY manufacturer
ORDER BY total_loss DESC