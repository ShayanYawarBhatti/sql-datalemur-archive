-- Title: Invalid Search Results
-- Company: Google
-- Difficulty: Medium
-- Access: Premium
-- Pattern: data quality filtering
-- Summary: Identify invalid search results by applying validity rules (NULLs, mismatched ids, missing links) and returning affected queries/results.
-- Notes: Encode validation conditions explicitly; use NOT EXISTS for missing reference rows; be careful with NULL comparisons.
-- Dialect: PostgreSQL

SELECT
  country, 
  SUM(num_search) AS total_search,
  ROUND(
  SUM(num_search * invalid_result_pct)/SUM(num_search)
  , 2) AS invalid_searches_pct
FROM search_category
WHERE invalid_result_pct IS NOT NULL
GROUP BY country
ORDER BY country ASC

/*
In cases where countries have search attempts but do not have a percentage 
of invalid searches in invalid_result_pct, it should be excluded — and 
vice versa. Therefore, we do IS NOT NULL
*/