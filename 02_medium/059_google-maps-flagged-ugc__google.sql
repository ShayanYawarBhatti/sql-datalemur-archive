-- Title: Google Maps Flagged UGC
-- Company: Google
-- Difficulty: Medium
-- Access: Premium
-- Pattern: filtering + aggregation by status
-- Summary: Filter to flagged user-generated content and aggregate counts/percentages by reason/status as required.
-- Notes: Confirm what qualifies as “flagged” (boolean vs status code); use DISTINCT if joins can duplicate UGC records.
-- Dialect: PostgreSQL

WITH reviews AS (
  SELECT
    p.place_category,
    COUNT(ugc.content_id) AS content_count
  FROM place_info AS p 
  INNER JOIN maps_ugc_review AS ugc 
    ON p.place_id = ugc.place_id
  WHERE LOWER(content_tag) = 'off-topic'
  GROUP BY p.place_category
),

top_place_category AS (
  SELECT
    place_category,
    content_count,
    RANK() OVER(
    ORDER BY content_count DESC) AS top_place
  FROM reviews
) 

SELECT
  place_category
FROM top_place_category
WHERE top_place = 1