-- Question : Spare Server Capacity

-- Solution
WITH monthly_demand_sum_list AS (

    SELECT
        datacenter_id,
        SUM(monthly_demand) AS monthly_demand_sum
    FROM forecasted_demand
    GROUP BY datacenter_id

)

SELECT
    datacenters.datacenter_id,
    (datacenters.monthly_capacity - COALESCE(monthly_demand_sum_list.monthly_demand_sum, 0)) AS spare_capacity
FROM datacenters
LEFT JOIN monthly_demand_sum_list
    ON datacenters.datacenter_id = monthly_demand_sum_list.datacenter_id
ORDER BY datacenters.datacenter_id, (datacenters.monthly_capacity - COALESCE(monthly_demand_sum_list.monthly_demand_sum, 0));