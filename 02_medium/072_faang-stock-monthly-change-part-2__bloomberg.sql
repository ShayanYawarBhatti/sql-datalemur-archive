-- Title: FAANG Stock Monthly Change (Part 2)
-- Company: Bloomberg
-- Difficulty: Medium
-- Access: Premium
-- Pattern: time series (LAG) + percent change
-- Summary: Compute month-over-month stock changes by comparing each month’s value to the prior month using LAG.
-- Notes: Aggregate to monthly grain first (e.g., month-end price); cast to numeric and use NULLIF to avoid divide-by-zero.
-- Dialect: PostgreSQL

WITH intermonth_prices AS (SELECT 
  ticker, 
  date,
  close, 
  LAG(close) OVER(
  PARTITION BY ticker 
  ORDER BY date) AS prev_close
FROM stock_prices
ORDER BY ticker, date)

SELECT 
  ticker,
  date,
  close,
  ROUND((100 * (close - prev_close) / prev_close), 2) AS intermth_change_pct
FROM intermonth_prices
ORDER BY ticker, date