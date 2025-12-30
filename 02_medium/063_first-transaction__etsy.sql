-- Title: First Transaction
-- Company: Etsy
-- Difficulty: Medium
-- Access: Premium
-- Pattern: window function (ROW_NUMBER) / MIN per group
-- Summary: Identify each user’s first transaction by ordering transactions and selecting the earliest one.
-- Notes: Use ROW_NUMBER ordered by timestamp (plus id for tie-break); users with multiple same-time transactions need deterministic ordering.
-- Dialect: PostgreSQL

WITH ranked_table AS (SELECT
  user_id,
  spend, 
  transaction_date,
  ROW_NUMBER() OVER(
  PARTITION BY user_id
  ORDER BY transaction_date DESC) AS ranking
FROM user_transactions)

SELECT
  COUNT(DISTINCT user_id) AS users
FROM ranked_table
WHERE spend >= 50 and ranking = 1

-- WE use ROW_NUMBER because the questions says that in the case of 
-- ties we need the first transaction