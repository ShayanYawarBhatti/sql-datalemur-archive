-- Title: International Call Percentage
-- Company: Verizon
-- Difficulty: Medium
-- Access: Free
-- Pattern: conditional aggregation (percentage)
-- Summary: Compute the percentage of international calls by dividing international call counts by total calls.
-- Notes: Use NULLIF to avoid divide-by-zero; confirm what defines “international” (country codes vs boolean flag).
-- Dialect: PostgreSQL

SELECT
  SUM(CASE WHEN callers.country_id <> receiver.country_id THEN 1 ElSE NULL END) AS international_calls,
  COUNT(*) AS total_calls
FROM phone_calls AS calls
LEFT JOIN phone_info AS callers
  ON calls.caller_id = callers.caller_id
LEFT JOIN phone_info AS receiver
  ON calls.receiver_id = receiver.caller_id

/*  
<> not equal 
What defines an international call? international (caller country ≠ receiver country)
Why two joins?
phone_info contains info for any phone (by caller_id, badly named but it means “phone id”).
In each row of phone_calls, we have two different phones: caller_id and receiver_id.
We need two different country_ids from the same table:
one for caller → alias caller
one for receiver → alias receiver
That’s why we join the same table twice with different aliases.
In the second join we are basically mapping receiver ID to caller id so we can
get both caller and receivers ids and countrys in one row to then compare TO
check whether the call is internationa.
*/