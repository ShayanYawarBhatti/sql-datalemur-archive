-- Title: Trade In Payouts
-- Company: Apple
-- Difficulty: Easy
-- Access: Premium
-- Pattern: conditional aggregation + grouping
-- Summary: Compute trade-in payout totals by grouping on the required dimension and summing payout amounts.
-- Notes: If payout depends on condition/grade, use CASE logic; handle NULL payouts with COALESCE if needed.
-- Dialect: PostgreSQL

SELECT 
  transactions.store_id, 
  SUM(payouts.payout_amount) AS payout_total
FROM trade_in_transactions AS transactions
INNER JOIN trade_in_payouts AS payouts
	ON transactions.model_id = payouts.model_id
GROUP BY transactions.store_id
ORDER BY payout_total DESC