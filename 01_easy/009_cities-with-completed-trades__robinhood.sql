-- Title: Cities With Completed Trades
-- Company: Robinhood
-- Difficulty: Easy
-- Access: Free
-- Pattern: filtering + distinct selection
-- Summary: Filter trades to completed status and return distinct cities associated with completed trades.
-- Notes: If city lives on the users table, join trades to users first; use DISTINCT to avoid duplicates.
-- Dialect: PostgreSQL

SELECT 
  users.city AS city,
  COUNT(trades.order_id) AS completed_trades
FROM trades
INNER JOIN users
  ON trades.user_id = users.user_id
WHERE status = 'Completed'
GROUP BY users.city
ORDER BY completed_trades DESC
LIMIT 3;