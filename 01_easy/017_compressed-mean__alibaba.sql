-- Title: Compressed Mean
-- Company: Alibaba
-- Difficulty: Easy
-- Access: Free
-- Pattern: weighted aggregation
-- Summary: Compute the mean from a frequency table using SUM(value * frequency) / SUM(frequency).
-- Notes: Cast to numeric to avoid integer division; round only if your output requires it.
-- Dialect: PostgreSQL

SELECT
  ROUND(
    SUM(CAST(item_count AS decimal) * order_occurrences)/SUM(order_occurrences)
  , 1
  ) AS mean
FROM items_per_order

