-- Title: Who Made Quota?
-- Company: Oracle
-- Difficulty: Easy
-- Access: Premium
-- Pattern: aggregation + threshold (HAVING)
-- Summary: Aggregate sales per rep and filter for those who meet or exceed quota using HAVING.
-- Notes: Ensure sales are summed over the correct time period; use COALESCE if sales can be NULL.
-- Dialect: PostgreSQL

SELECT 
  deals.employee_id,
  (CASE 
    WHEN SUM(deals.deal_size) > quotas.quota THEN 'yes' 
    ELSE 'no' 
  END) AS made_quota
FROM deals
INNER JOIN sales_quotas AS quotas
  ON deals.employee_id = quotas.employee_id
GROUP BY deals.employee_id, quotas.quota
ORDER BY deals.employee_id;