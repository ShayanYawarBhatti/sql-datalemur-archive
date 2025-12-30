-- Title: User's Third Transaction
-- Company: Uber
-- Difficulty: Medium
-- Access: Free
-- Pattern: window function (ROW_NUMBER)
-- Summary: Order transactions per user and select the third one using ROW_NUMBER (or another ranking window function).
-- Notes: Use a deterministic order (timestamp + transaction_id) to break ties; filter row_number = 3.
-- Dialect: PostgreSQL

WITH transaction_num AS (
  SELECT
    user_id, 
    spend,
    transaction_date,
    ROW_NUMBER() OVER(
    PARTITION BY user_id 
    ORDER BY transaction_date) AS rank_num
  FROM transactions
)

SELECT
  user_id, 
  spend, 
  transaction_date
FROM transaction_num
WHERE rank_num = 3

-- Use GROUP BY when you need to collapse data.
-- Use WINDOW functions when you need to augment data.