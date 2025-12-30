-- Title: Signup Activation Rate
-- Company: TikTok
-- Difficulty: Medium
-- Access: Free
-- Pattern: retention / conversion rate
-- Summary: Compute activation rate as activated users divided by signups over the cohort/time window defined in the problem.
-- Notes: Use COUNT(DISTINCT user_id); cast to numeric and use NULLIF to avoid divide-by-zero; ensure correct activation definition.
-- Dialect: PostgreSQL

SELECT
  ROUND(COUNT(texts.email_id)::DECIMAL/COUNT(DISTINCT emails.email_id),2) 
  AS activitation_rate
FROM emails 
LEFT JOIN texts 
  ON emails.email_id = texts.email_id
  AND texts.signup_action = 'Confirmed'