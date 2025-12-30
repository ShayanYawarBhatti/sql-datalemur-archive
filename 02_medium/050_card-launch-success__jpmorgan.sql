-- Title: Card Launch Success
-- Company: JPMorgan
-- Difficulty: Medium
-- Access: Free
-- Pattern: aggregation + conditional logic
-- Summary: Evaluate card launch success by aggregating performance metrics and applying the success criteria.
-- Notes: Implement criteria with CASE; ensure you’re aggregating at the correct grain (card, launch cohort, date).
-- Dialect: PostgreSQL

WITH launch_card AS (SELECT
  card_name, 
  issued_amount,
  MAKE_DATE(issue_year, issue_month, 1) AS issue_date,
  MIN(MAKE_DATE(issue_year, issue_month, 1)) OVER(
    PARTITION BY card_name) AS launch_date
FROM monthly_cards_issued)
  
SELECT
  card_name,
  issued_amount
FROM launch_card
WHERE issue_date = launch_date
ORDER BY issued_amount DESC

/* 
Since there is no day column, we use 1 as the default to set the first day of the MONTH
You almost never use ORDER BY with MIN() or MAX() in window functions.
And in most cases, ORDER BY inside MIN() / MAX() does nothing useful.
*/