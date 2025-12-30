-- Title: Final Account Balance
-- Company: PayPal
-- Difficulty: Easy
-- Access: Free
-- Pattern: signed aggregation (credits vs debits)
-- Summary: Compute ending balances by summing transaction amounts with correct signs for inflows vs outflows.
-- Notes: Use CASE to assign +/- amounts; confirm which column indicates sender vs receiver (or transaction type).
-- Dialect: PostgreSQL

SELECT
  user_id,
  SUM(net_amount) AS final_balance
FROM (
  SELECT
    paid_by AS user_id,
    -amount AS net_amount
  FROM transactions

  UNION ALL

  SELECT
    paid_to AS user_id,
    amount AS net_amount
  FROM transactions
) AS t
GROUP BY user_id
ORDER BY user_id;

