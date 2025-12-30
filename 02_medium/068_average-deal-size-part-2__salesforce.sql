-- Title: Average Deal Size (Part 2)
-- Company: Salesforce
-- Difficulty: Medium
-- Access: Premium
-- Pattern: aggregation + segmented averages
-- Summary: Compute average deal size by grouping deals by stage/owner/segment and taking AVG of deal amounts.
-- Notes: Filter to closed/won as required; use AVG(amount::numeric) if needed; exclude NULL/0 deals depending on definition.
-- Dialect: PostgreSQL

WITH segment_cte AS (
    SELECT
        customer_id,
        name,
        CASE
            WHEN employee_count < 100 THEN 'smb'
            WHEN employee_count BETWEEN 100 AND 999 THEN 'mid'
            ELSE 'enterprise'
        END AS segment 
    FROM
        customers
),
revenue_cte AS (
    SELECT
        seg.segment,
        SUM(contracts.num_seats * contracts.yearly_seat_cost)
            / COUNT(DISTINCT seg.customer_id) AS revenue_per_deal
    FROM
        segment_cte AS seg
    INNER JOIN
        contracts
    ON
        seg.customer_id = contracts.customer_id
    GROUP BY
        seg.segment
)
-- Simply converting data to a different format (long to wide)
SELECT
    SUM(CASE WHEN segment = 'smb' THEN revenue_per_deal END) AS smb_avg_revenue,
    SUM(CASE WHEN segment = 'mid' THEN revenue_per_deal END) AS mid_avg_revenue,
    SUM(CASE WHEN segment = 'enterprise' THEN revenue_per_deal END) AS enterprise_avg_revenue
FROM
    revenue_cte;