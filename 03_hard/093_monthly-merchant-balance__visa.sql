-- Title: Monthly Merchant Balance
-- Company: Visa
-- Difficulty: Hard
-- Access: Premium
-- Pattern: time series aggregation + running balance
-- Summary: Compute each merchant’s monthly ending balance by aggregating monthly net inflow/outflow and applying a running total over months.
-- Notes: Use DATE_TRUNC('month', ...) for month buckets; use COALESCE for missing inflow/outflow; consider filling missing months if required by the output.
-- Dialect: PostgreSQL

WITH daily_balances AS (
  SELECT
    DATE_TRUNC('day', transaction_date) AS transaction_day,
    DATE_TRUNC('month', transaction_date) AS transaction_month,
    SUM(CASE WHEN type = 'deposit' THEN amount
      WHEN type = 'withdrawal' THEN -amount END) AS balance
  FROM transactions
  GROUP BY 
    DATE_TRUNC('day', transaction_date),
    DATE_TRUNC('month', transaction_date))

SELECT
  transaction_day,
  SUM(balance) OVER (
    PARTITION BY transaction_month
    ORDER BY transaction_day) AS balance
FROM daily_balances
ORDER BY transaction_day;