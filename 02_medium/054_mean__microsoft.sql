-- Title: Mean, Median, Mode
-- Company: Microsoft
-- Difficulty: Medium
-- Access: Premium
-- Pattern: descriptive statistics (aggregate + percentile)
-- Summary: Compute mean/median/mode using AVG, percentile logic for median, and frequency ranking for mode.
-- Notes: Median often uses PERCENTILE_CONT; mode requires handling ties via DENSE_RANK; cast to numeric to avoid integer division.
-- Dialect: PostgreSQL

SELECT
    ROUND(AVG(email_count)) as mean,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY email_count) AS median,
    MODE() WITHIN GROUP (ORDER BY email_count) AS mode
FROM inbox_stats