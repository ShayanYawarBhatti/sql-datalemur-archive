-- Title: Cards Issued Difference
-- Company: JPMorgan
-- Difficulty: Easy
-- Access: Free
-- Pattern: aggregation + difference (two groups)
-- Summary: Compute the difference in cards issued between two time periods or groups by aggregating each side and subtracting.
-- Notes: Use conditional aggregation to compute both values in one query; cast if needed to avoid integer issues.
-- Dialect: PostgreSQL

SELECT
  card_name,
  MAX(issued_amount) - MIN(issued_amount) AS difference
FROM monthly_cards_issued
GROUP BY card_name
ORDER BY difference DESC