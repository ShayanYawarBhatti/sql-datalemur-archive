-- Title: Ad Campaign ROAS
-- Company: Google
-- Difficulty: Easy
-- Access: Premium
-- Pattern: ratio metric (conditional aggregation)
-- Summary: Compute ROAS as revenue divided by ad spend by aggregating campaign totals and calculating the ratio.
-- Notes: Cast to numeric to avoid integer division; use NULLIF to prevent divide-by-zero.
-- Dialect: PostgreSQL

SELECT
  advertiser_id,
  ROUND(SUM(revenue::decimal)/SUM(spend::DECIMAL), 2) AS ROAS
FROM ad_campaigns
GROUP BY advertiser_id
ORDER BY advertiser_id