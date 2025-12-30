-- Title: Sales Team Compensation
-- Company: Oracle
-- Difficulty: Medium
-- Access: Premium
-- Pattern: aggregation + business rules
-- Summary: Compute compensation by applying commission/bonus rules to sales aggregates and returning payout per rep.
-- Notes: Encode rules with CASE; verify tiers and thresholds; use COALESCE for missing components.
-- Dialect: PostgreSQL

WITH td AS (   -- Calculates total deals per salesperson
  SELECT 
    employee_id,
    SUM(deal_size) AS total_deals
  FROM deals
  GROUP BY employee_id
)
-- Calculates final compensation
SELECT
  e.employee_id,
  -- Base salary + commission up to quota + accelerated commission above quota
  e.base
    -- Commission on deals up to the quota (or fewer if total_deals < quota)
    + e.commission * LEAST(td.total_deals, e.quota)
    -- Accelerated commission on any deals above the quota
    -- If total_deals <= quota → GREATEST(..., 0) forces this term to become 0
    + e.commission * e.accelerator * GREATEST(td.total_deals - e.quota, 0)
    AS total_compensation
FROM employee_contract AS e
INNER JOIN td
  ON e.employee_id = td.employee_id
ORDER BY
  total_compensation DESC,
  e.employee_id ASC;

-- TIP: for the core calculation starting from e.base... give that to chatgpt
-- along with the question example, and it will explain how the core works very 
-- easily