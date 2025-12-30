-- Title: Histogram of Tweets
-- Company: Twitter
-- Difficulty: Easy
-- Access: Free
-- Pattern: two-step aggregation (histogram)
-- Summary: Build a histogram by first counting tweets per user, then counting how many users fall into each tweet_count bucket.
-- Notes: Apply any date/window filter before the per-user aggregation; COUNT(*) vs COUNT(tweet_id) depends on nullability.
-- Dialect: PostgreSQL



