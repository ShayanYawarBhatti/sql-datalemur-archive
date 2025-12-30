-- Title: FAANG Stock Min-Max (Part 1)
-- Company: Bloomberg
-- Difficulty: Medium
-- Access: Free
-- Pattern: aggregation (MIN/MAX) over time
-- Summary: Compute min and max stock prices (or values) per ticker over the specified time window.
-- Notes: Filter to the correct date range first; group by ticker; ensure using the correct price column.
-- Dialect: PostgreSQL

-- Highest opening price per ticker
WITH highest_rank AS (
  SELECT
    ticker,
    TO_CHAR(date, 'Mon-YYYY') AS highest_mth,
    open AS highest_open,
    ROW_NUMBER() OVER (
      PARTITION BY ticker
      ORDER BY open DESC  -- highest open gets rank 1
    ) AS rank_high
  FROM stock_prices
),
-- Lowest opening price per ticker
lowest_rank AS (
  SELECT
    ticker,
    TO_CHAR(date, 'Mon-YYYY') AS lowest_mth,
    open AS lowest_open,
    ROW_NUMBER() OVER (
      PARTITION BY ticker
      ORDER BY open ASC -- lowest open gets rank 1
    ) AS rank_low
  FROM stock_prices
)

-- Select ONLY the highest and lowest rows
SELECT
  h.ticker,
  h.highest_mth,
  h.highest_open,
  l.lowest_mth,
  l.lowest_open
FROM highest_rank AS h
JOIN lowest_rank AS l
  ON h.ticker = l.ticker
WHERE h.rank_high = 1
  AND l.rank_low = 1
ORDER BY h.ticker;