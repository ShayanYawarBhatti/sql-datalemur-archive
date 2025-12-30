-- Title: LinkedIn Power Creators (Part 1)
-- Company: LinkedIn
-- Difficulty: Easy
-- Access: Premium
-- Pattern: aggregation + threshold
-- Summary: Aggregate creator activity metrics and filter to power creators who exceed a defined engagement or posting threshold.
-- Notes: Verify the metric definition (posts, reactions, followers, impressions); use COUNT(DISTINCT ...) to avoid double-counting.
-- Dialect: PostgreSQL

SELECT
  pp.profile_id
FROM personal_profiles AS pp
INNER JOIN company_pages AS cp
  ON pp.employer_id = cp.company_id
WHERE pp.followers > cp.followers
ORDER BY pp.profile_id ASC