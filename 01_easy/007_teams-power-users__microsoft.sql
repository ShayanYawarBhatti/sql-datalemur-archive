-- Title: Teams Power Users
-- Company: Microsoft
-- Difficulty: Easy
-- Access: Free
-- Pattern: aggregation
-- Summary: Aggregate user activity and filter users who exceed a power-user threshold using HAVING.
-- Notes: confirm the threshold metric (messages, reactions, days active).
-- Dialect: PostgreSQL

SELECT  
  sender_id, 
  COUNT(message_id) AS count_messages
FROM messages
WHERE EXTRACT(MONTH from sent_date) = '08' AND EXTRACT(YEAR from sent_date) = '2022'
GROUP BY sender_id
ORDER BY count_messages DESC -- Column in the order by phrase will always be from SELECT column
LIMIT 2;