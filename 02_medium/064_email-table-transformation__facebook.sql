-- Title: Email Table Transformation
-- Company: Facebook
-- Difficulty: Medium
-- Access: Premium
-- Pattern: transformations (pivot / normalization)
-- Summary: Transform the email table into the required shape using CASE-based pivoting or conditional aggregation.
-- Notes: Use MAX(CASE...) for pivot columns; ensure one row per entity after transformation; handle NULLs with COALESCE if needed.
-- Dialect: PostgreSQL

SELECT
  user_id,
  MAX(CASE WHEN email_type = 'personal' THEN email
    ELSE NULL END) AS personal,
  MAX(CASE WHEN email_type = 'business' THEN email
    ELSE NULL END) AS business,
  MAX(CASE WHEN email_type = 'recovery' THEN email
    ELSE NULL END) AS recovery
FROM users
GROUP BY user_id
ORDER BY user_id