-- Title: Data Science Skills
-- Company: LinkedIn
-- Difficulty: Easy
-- Access: Free
-- Pattern: conditional aggregation
-- Summary: Count or flag required skills per candidate using CASE expressions, then filter for those meeting the full skill set.
-- Notes: Use COUNT(DISTINCT skill) if duplicates exist; ensure case-insensitive matching if skills vary in capitalization.
-- Dialect: PostgreSQL

SELECT 
  candidate_id
FROM candidates
WHERE skill IN ('Python', 'PostgreSQL', 'Tableau')
GROUP BY candidate_id
HAVING COUNT(skill) = 3
ORDER BY candidate_id
