-- Title: Top Rated Businesses
-- Company: Yelp
-- Difficulty: Easy
-- Access: Premium
-- Pattern: ranking (top-N)
-- Summary: Rank businesses by average rating (and optionally review count) and return the top results.
-- Notes: If a minimum number of reviews is required, filter with HAVING before ranking; handle ties with DENSE_RANK if needed.
-- Dialect: PostgreSQL

SELECT 
  COUNT(business_id) AS business_count,
  ROUND(100.0 * COUNT(business_id)/
    (SELECT COUNT(business_id) 
    FROM reviews)
  , 0) AS top_rated_pct
FROM reviews
WHERE review_stars IN (4, 5);