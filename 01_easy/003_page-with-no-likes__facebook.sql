-- Title: Page With No Likes
-- Company: Facebook
-- Difficulty: Easy
-- Access: Free
-- Pattern: anti-join (LEFT JOIN ... IS NULL)
-- Summary: Return page_ids from pages that have no matching rows in page_likes.
-- Notes: LEFT JOIN + WHERE page_likes.page_id IS NULL is equivalent to NOT EXISTS; use DISTINCT if pages can repeat.
-- Dialect: PostgreSQL

SELECT 
  pages.page_id
FROM pages
 LEFT JOIN page_likes
 ON pages.page_id = page_likes.page_id
WHERE page_likes.page_id IS NULL
ORDER BY page_id