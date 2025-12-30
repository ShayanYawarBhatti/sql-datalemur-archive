-- Title: Histogram of Tweets
-- Company: Twitter
-- Difficulty: Easy
-- Access: Free
-- Pattern: two-step aggregation (histogram)
-- Summary: Build a histogram by first counting tweets per user, then counting how many users fall into each tweet_count bucket.
-- Notes: Apply any date filter before the per-user aggregation; COUNT(*) vs COUNT(tweet_id) depends on nullability.
-- Dialect: PostgreSQL

WITH total_tweets AS (
  SELECT
    user_id,
    COUNT(tweet_id) AS tweet_count_per_user
  FROM tweets
  WHERE EXTRACT(YEAR FROM tweet_date) = '2022'
  GROUP BY user_id
)

SELECT 
  tweet_count_per_user AS tweet_bucket,
  COUNT(user_id) AS users_num
FROM total_tweets
GROUP BY tweet_count_per_user

-- Tweet bucket is basically # many tweets a single user has made
-- In this case, 2 users have posted 1 tweet (user id 148 & 254)
-- 1 user has posted 2 tweets (user id 111)
-- Group by basically, takes tweet_count_per_user = 1, how many users had 1 tweet
-- and counts those user_ids and stores them in user_nums, 
-- same for tweet_count_per_user = 2

