-- Title: Compressed Mode
-- Company: Alibaba
-- Difficulty: Medium
-- Access: Free
-- Pattern: frequency ranking (mode from counts)
-- Summary: Compute the mode from a frequency table by selecting the value with the highest frequency.
-- Notes: Handle ties (return all modes vs single) using DENSE_RANK; order deterministically if only one should be returned.
-- Dialect: PostgreSQL

SELECT item_count AS mode
FROM items_per_order
WHERE order_occurrences = (
  SELECT MAX(order_occurrences) 
  FROM items_per_order 
)
ORDER BY item_count

-- Finds the mode highest occurrences.
-- Find the corresponding item_count
