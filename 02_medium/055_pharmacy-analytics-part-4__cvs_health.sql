-- Title: Pharmacy Analytics (Part 4)
-- Company: CVS Health
-- Difficulty: Medium
-- Access: Premium
-- Pattern: multi-step aggregation
-- Summary: Combine prior pharmacy metrics with additional filters/joins and compute the requested summary measures.
-- Notes: Stage logic in CTEs to avoid double-counting; apply cohort/date filters early for performance.
-- Dialect: PostgreSQL

WITH rankings AS (
  SELECT
    manufacturer, 
    drug,
    ROW_NUMBER() OVER(
      PARTITION BY manufacturer
      ORDER BY units_sold DESC) AS drug_rankings
  FROM pharmacy_sales
)

SELECT
  manufacturer,
  drug AS top_drugs
FROM rankings
WHERE drug_rankings IN (1, 2)
ORDER BY manufacturer