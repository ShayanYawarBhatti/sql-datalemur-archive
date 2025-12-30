-- Title: Tweets' Rolling Averages
-- Company: Twitter
-- Difficulty: Medium
-- Access: Free
-- Pattern: window function (rolling average)
-- Summary: Compute a rolling average of tweet counts per user over a 3-day window using an ordered window frame.
-- Notes: Order by date; ensure the window frame matches the exact definition (ROWS vs RANGE); round only if required.
-- Dialect: PostgreSQL

SELECT 
  user_id, 
  tweet_date, 
  ROUND(AVG(tweet_count) OVER(
  PARTITION BY user_id 
  ORDER BY tweet_date
  ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2) AS rolling_avg_3day
FROM tweets

-- Window frame clause: ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
-- This helps us iterate over Rolling averages, Rolling sums, Moving windows, Cumulative totals, Trend analysis
-- Sort the tweets in time order for each user. We need this because rolling averages move through time.
