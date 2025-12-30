-- Title: Y-on-Y Growth Rate
-- Company: Wayfair
-- Difficulty: Hard
-- Access: Free
-- Pattern: time series growth (LAG) + percent change
-- Summary: Compute year-over-year growth by comparing each period’s metric to the same period in the prior year.
-- Notes: Aggregate to the correct grain first; use LAG(…, 12) for monthly or join on year-1; use NULLIF to avoid divide-by-zero.
-- Dialect: PostgreSQL

WITH yearly_spend_cte AS (
  SELECT 
    EXTRACT(YEAR FROM transaction_date) AS year,
    product_id,
    spend AS curr_year_spend,
    LAG(spend) OVER (
      PARTITION BY product_id 
      ORDER BY 
        product_id, 
        EXTRACT(YEAR FROM transaction_date)) AS prev_year_spend 
  FROM user_transactions
)

SELECT 
  year,
  product_id, 
  curr_year_spend, 
  prev_year_spend, 
  ROUND(100 * 
    (curr_year_spend - prev_year_spend)
    / prev_year_spend
  , 2) AS yoy_rate 
FROM yearly_spend_cte;