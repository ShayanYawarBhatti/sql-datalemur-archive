-- Title: Average Review Ratings
-- Company: Amazon
-- Difficulty: Easy
-- Access: Free
-- Pattern: aggregation (AVG) + grouping
-- Summary: Compute average review rating per entity (e.g., product, merchant) using AVG and group by the required dimension.
-- Notes: Handle NULL ratings if present; round only if the expected output format requires it.
-- Dialect: PostgreSQL

SELECT 
  EXTRACT(MONTH from submit_date) AS mth,
  product_id,
  ROUND(AVG(stars),2) AS avg_stars
FROM reviews
GROUP BY EXTRACT(MONTH from submit_date), product_id
ORDER BY mth, product_id