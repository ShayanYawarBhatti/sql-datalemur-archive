-- Title: Average Post Hiatus (Part 1)
-- Company: Facebook
-- Difficulty: Easy
-- Access: Free
-- Pattern: window function (LAG) + date difference
-- Summary: Compute the day gaps between consecutive posts per user using LAG, then take the average hiatus length.
-- Notes: Order strictly by post date/time; exclude the first post per user (NULL gap) from the average.
-- Dialect: PostgreSQL

SELECT 
  user_id, 
  MAX(post_date::DATE) - MIN(post_date::DATE) AS days_between
FROM posts
WHERE EXTRACT(YEAR from post_date) = '2021'
GROUP BY user_id
HAVING COUNT(post_id) > 1 -- Make sure the user has posted at least twice