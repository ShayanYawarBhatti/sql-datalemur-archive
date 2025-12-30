-- Title: ApplePay Volume
-- Company: Visa
-- Difficulty: Easy
-- Access: Premium
-- Pattern: filtered aggregation
-- Summary: Compute ApplePay transaction volume by filtering to ApplePay payments and aggregating the required metric (count or sum).
-- Notes: Use SUM(amount) for total volume or COUNT(*) for transaction count; apply date filters before aggregating if required.
-- Dialect: PostgreSQL

SELECT 
  merchant_id, 
  SUM(CASE WHEN LOWER(payment_method) = 'apple pay' THEN transaction_amount
  ELSE 0 END) AS total_transaction
FROM transactions
GROUP BY merchant_id
ORDER BY total_transaction DESC;