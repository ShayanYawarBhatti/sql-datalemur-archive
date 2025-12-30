-- Title: Page Recommendation
-- Company: Facebook
-- Difficulty: Hard
-- Access: Premium
-- Pattern: graph recommendation (friends/likes) + ranking
-- Summary: Recommend pages by leveraging user-user connections and page interactions, scoring candidate pages and ranking the top suggestions.
-- Notes: Exclude pages the user already likes; deduplicate candidates; use window ranking to return top-N per user.
-- Dialect: PostgreSQL

WITH two_way_friendship AS (
  SELECT user_id, friend_id
  FROM friendship
  UNION
  SELECT friend_id, user_id
  FROM friendship
  
), recommended_pages AS (
  SELECT
    friends.user_id,
    pages.page_id,
    COUNT(*) AS followers
  FROM two_way_friendship AS friends
  LEFT JOIN page_following AS pages
    ON friends.friend_id = pages.user_id
  WHERE NOT EXISTS (
    SELECT id
    FROM page_following AS pages_2
    WHERE friends.user_id = pages_2.user_id
      AND pages.page_id = pages_2.page_id)
  GROUP BY friends.user_id, pages.page_id
  
), top_pages AS (
  SELECT
    user_id,
    page_id,
    followers,
    DENSE_RANK() OVER (
      PARTITION BY user_id ORDER BY followers DESC) AS rnk
  FROM recommended_pages)

SELECT user_id, page_id
FROM top_pages
WHERE rnk = 1
ORDER BY user_id;