-- Title: Second Day Confirmation
-- Company: TikTok
-- Difficulty: Easy
-- Access: Free
-- Pattern: retention / cohort check (self-join or date diff)
-- Summary: Identify users who returned/confirmed on day 2 by comparing event dates to the signup/initial date.
-- Notes: Use DATE + INTERVAL '1 day' or date_diff logic; ensure you’re matching the correct “day 2” definition.
-- Dialect: PostgreSQL

SELECT DISTINCT user_id
FROM emails
INNER JOIN texts
  ON emails.email_id = texts.email_id
WHERE texts.action_date = signup_date + INTERVAL '1 DAY'
  AND signup_action = 'Confirmed'

-- We used INNER JOIN because we needded informatin from both TABLES
-- We needed signup date from emails and signup_action, action_date from texts.
