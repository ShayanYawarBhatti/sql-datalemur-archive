-- Title: Duplicate Job Listings
-- Company: LinkedIn
-- Difficulty: Easy
-- Access: Free
-- Pattern: duplicate detection (GROUP BY + HAVING)
-- Summary: Identify duplicate job listings by grouping on the fields that define “same listing” and filtering groups with count > 1.
-- Notes: select the grouping columns (not raw rows).
-- Dialect: PostgreSQL

WITH job_count_cte AS (
  SELECT 
    company_id, 
    title, 
    description, 
    COUNT(job_id) AS job_count
  FROM job_listings
  GROUP BY company_id, title, description
)

SELECT 
  COUNT(company_id) AS duplicate_companies
FROM job_count_cte
WHERE job_count > 1