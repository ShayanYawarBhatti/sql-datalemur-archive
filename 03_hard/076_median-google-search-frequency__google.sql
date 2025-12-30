-- Title: Median Google Search Frequency
-- Company: Google
-- Difficulty: Hard
-- Access: Free
-- Pattern: median via percentile / ranking
-- Summary: Compute the median search frequency by ordering user frequencies and applying percentile logic.
-- Notes: PostgreSQL supports PERCENTILE_CONT; if building manually, use row_number and middle-position logic; handle even counts carefully.
-- Dialect: PostgreSQL

WITH searches_expanded AS (
  SELECT searches
  FROM search_frequency
  GROUP BY 
    searches, 
    GENERATE_SERIES(1, num_users))

SELECT 
  ROUND(PERCENTILE_CONT(0.50) WITHIN GROUP (
    ORDER BY searches)::DECIMAL, 1) AS  median
FROM searches_expanded;