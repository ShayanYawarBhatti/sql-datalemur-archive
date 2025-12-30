-- Title: Spare Server Capacity
-- Company: Microsoft
-- Difficulty: Easy
-- Access: Premium
-- Pattern: aggregation + capacity math
-- Summary: Compute spare capacity by aggregating used resources per server and subtracting from total capacity.
-- Notes: Use COALESCE to treat missing usage as 0; ensure units match (CPU, memory, etc.).
-- Dialect: PostgreSQL

SELECT 
  centers.datacenter_id, 
  centers.monthly_capacity - SUM(demands.monthly_demand) AS spare_capacity
FROM forecasted_demand AS demands
INNER JOIN datacenters AS centers
  ON demands.datacenter_id = centers.datacenter_id
GROUP BY centers.datacenter_id, centers.monthly_capacity
ORDER BY centers.datacenter_id;