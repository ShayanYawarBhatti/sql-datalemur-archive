-- Title: Repeated Payments
-- Company: Stripe
-- Difficulty: Hard
-- Access: Free
-- Pattern: window function (repeat detection with LAG)
-- Summary: Identify repeated payments by comparing each payment to the previous payment for the same customer and flagging repeats per the rule.
-- Notes: Use a deterministic order (payment_date + payment_id); define “repeat” carefully (same merchant/amount within a time window); handle NULLs with care.
-- Dialect: PostgreSQL

WITH payments AS (
  SELECT 
    merchant_id, 
    EXTRACT(EPOCH FROM transaction_timestamp - 
      LAG(transaction_timestamp) OVER(
        PARTITION BY merchant_id, credit_card_id, amount 
        ORDER BY transaction_timestamp)
    )/60 AS minute_difference 
  FROM transactions) 

SELECT COUNT(merchant_id) AS payment_count
FROM payments 
WHERE minute_difference <= 10;
