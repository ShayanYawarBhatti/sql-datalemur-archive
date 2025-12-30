-- Title: FAANG Underperforming Stocks (Part 3)
-- Company: Bloomberg
-- Difficulty: Hard
-- Access: Premium
-- Pattern: time series benchmark comparison
-- Summary: Identify underperforming stocks by computing returns over a period and comparing them against a benchmark/peer threshold.
-- Notes: Ensure consistent period endpoints; handle missing months/days; cast to numeric for return calculations.
-- Dialect: PostgreSQL

WITH monthly_changes AS ( -- CTE using Step 1's query
  SELECT
    TO_CHAR(date, 'Mon-YYYY') AS mth_yr,
    ticker,
    LAG(open) OVER (
      PARTITION BY ticker ORDER BY date) AS prev_open,
    open AS curr_open
  FROM stock_prices 
)
, monthly_gains AS ( -- CTE using Step 2's query
SELECT
  mth_yr,
  ticker,
  CASE WHEN curr_open > prev_open THEN 1 ELSE 0 END AS gain_count
FROM monthly_changes
)
, stock_summary AS ( -- CTE using Step 3's query
  SELECT 
    mth_yr,
    ticker,
    SUM(gain_count) OVER (PARTITION BY mth_yr) AS total_gains,
    CASE WHEN SUM(gain_count) OVER (PARTITION BY mth_yr) = 5 
      AND gain_count = 0 THEN ticker ELSE NULL 
    END AS underperforming_stock
  FROM monthly_gains
)

SELECT 
  mth_yr,
  underperforming_stock
FROM stock_summary
WHERE total_gains = 5
  AND underperforming_stock IS NOT NULL
ORDER BY mth_yr;