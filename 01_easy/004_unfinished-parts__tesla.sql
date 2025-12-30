-- Title: Unfinished Parts
-- Company: Tesla
-- Difficulty: Easy
-- Access: Free
-- Pattern: filtering + grouping
-- Summary: Filter to incomplete/unfinished records and aggregate counts by part or process as required by the output.
-- Notes: Be explicit about what qualifies as “unfinished” (NULL, status flag, or missing timestamp) to match the definition.
-- Dialect: PostgreSQL

SELECT 
  part, 
  assembly_step
FROM parts_assembly
WHERE finish_date IS NULL
