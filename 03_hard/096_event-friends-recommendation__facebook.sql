-- Title: Event Friends Recommendation
-- Company: Facebook
-- Difficulty: Hard
-- Access: Premium
-- Pattern: graph recommendation + filtering
-- Summary: Recommend friends for events by combining friendship edges with event participation signals and ranking candidates.
-- Notes: Exclude existing attendees/invitees per definition; avoid double-counting mutual connections; use DISTINCT on candidate pairs.
-- Dialect: PostgreSQL

WITH private_events AS (
SELECT user_id, event_id
FROM event_rsvp
WHERE attendance_status IN ('going', 'maybe')
  AND event_type = 'private'
)

SELECT 
  friends.user_a_id, 
  friends.user_b_id
FROM private_events AS events_1
INNER JOIN private_events AS events_2
  ON events_1.user_id != events_2.user_id
  AND events_1.event_id = events_2.event_id
INNER JOIN friendship_status AS friends
  ON events_1.user_id = friends.user_a_id
  AND events_2.user_id = friends.user_b_id
WHERE friends.status = 'not_friends'
GROUP BY friends.user_a_id, friends.user_b_id
HAVING COUNT(*) >= 2;