-- Title: Advertiser Status
-- Company: Facebook
-- Difficulty: Hard
-- Access: Free
-- Pattern: state classification (business rules)
-- Summary: Classify advertisers into statuses based on activity thresholds and time windows using conditional logic over aggregates.
-- Notes: Encode status rules with CASE; ensure correct time filtering and distinct counts to avoid double-counting events.
-- Dialect: PostgreSQL

SELECT 
  COALESCE(advertiser.user_id, daily_pay.user_id) AS user_id,
  CASE 
    WHEN paid IS NULL THEN 'CHURN' 
    WHEN paid IS NOT NULL AND advertiser.status IN ('NEW','EXISTING','RESURRECT') THEN 'EXISTING'
    WHEN paid IS NOT NULL AND advertiser.status = 'CHURN' THEN 'RESURRECT'
    WHEN paid IS NOT NULL AND advertiser.status IS NULL THEN 'NEW'
  END AS new_status
FROM advertiser
FULL OUTER JOIN daily_pay
  ON advertiser.user_id = daily_pay.user_id
ORDER BY user_id;