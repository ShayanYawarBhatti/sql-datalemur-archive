-- Title: Compressed Median
-- Company: Alibaba
-- Difficulty: Hard
-- Access: Premium
-- Pattern: weighted median (frequency table)
-- Summary: Compute the median from a frequency table by finding the smallest value where cumulative frequency reaches 50% of total.
-- Notes: Use running SUM(frequency) over ordered values; handle even totals carefully per definition; watch off-by-one in thresholds.
-- Dialect: PostgreSQL

WITH running_orders AS (
SELECT
  *,
  SUM(order_occurrences) OVER (
    ORDER BY item_count ASC) as running_sum,
  SUM(order_occurrences) OVER () AS total_sum
FROM items_per_order
)

SELECT ROUND(AVG(item_count)::DECIMAL,1) AS median
FROM running_orders
WHERE total_sum <= 2 * running_sum
  AND total_sum >= 2 * (running_sum - order_occurrences);