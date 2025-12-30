-- Title: Most Expensive Purchase
-- Company: Amazon
-- Difficulty: Easy
-- Access: Premium
-- Pattern: aggregation (MAX per group)
-- Summary: Return each customer’s highest purchase amount by taking MAX(purchase_amount) over their transactions.
-- Notes: If you need the full purchase row (not just the amount) or need to handle ties, use DENSE_RANK() over purchase_amount.
-- Dialect: PostgreSQL

SELECT
  customer_id,
  MAX(purchase_amount) AS most_exp_purchase
FROM transactions
GROUP BY customer_id
ORDER BY most_exp_purchase DESC