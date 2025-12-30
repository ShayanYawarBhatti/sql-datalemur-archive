-- Title: Unique Money Transfer Relationships
-- Company: PayPal
-- Difficulty: Medium
-- Access: Premium
-- Pattern: pair normalization + distinct counting
-- Summary: Count unique transfer relationships by normalizing sender/receiver pairs and counting distinct pairs.
-- Notes: Use LEAST/GREATEST (or CASE) to make pairs order-independent; exclude self-transfers if required.
-- Dialect: PostgreSQL

WITH relationships AS (SELECT 
  payer_id,
  recipient_id
FROM payments
INTERSECT 
SELECT 
  recipient_id,
  payer_id
FROM payments)

SELECT
  COUNT(payer_id) / 2 AS unique_relationships
FROM relationships