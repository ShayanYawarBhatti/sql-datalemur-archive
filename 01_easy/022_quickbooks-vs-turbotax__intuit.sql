-- Title: QuickBooks vs TurboTax
-- Company: Intuit
-- Difficulty: Easy
-- Access: Premium
-- Pattern: conditional aggregation (compare two products)
-- Summary: Compare metrics between QuickBooks and TurboTax by aggregating each product’s totals and presenting them side-by-side.
-- Notes: Use CASE to bucket product lines; cast to numeric for ratios/percentages; ensure product names match exactly.
-- Dialect: PostgreSQL

SELECT
  SUM(CASE WHEN LOWER(product) LIKE 'turbotax%' THEN 1 ELSE 0 END) AS turbotax_total, 
  SUM(CASE WHEN LOWER(product) LIKE 'quickbooks%' THEN 1 ELSE 0 END) AS quickbooks_total
FROM filed_taxes