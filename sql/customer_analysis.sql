
SELECT
    o.customer_id,

    c.city,

    c.loyalty_tier,

    COUNT(o.order_id) AS total_orders,

    ROUND(
        SUM(o.order_value),
        2
    ) AS total_spent

FROM orders o

JOIN customers c
ON o.customer_id = c.customer_id

WHERE o.delivery_status = 'Delivered'

GROUP BY
    o.customer_id,
    c.city,
    c.loyalty_tier

ORDER BY total_spent DESC

LIMIT 10;
SELECT
    c.loyalty_tier,

    COUNT(DISTINCT o.customer_id)
    AS unique_customers,

    COUNT(o.order_id)
    AS total_orders,

    ROUND(
        AVG(o.order_value),
        2
    ) AS avg_order_value,

    ROUND(
        SUM(o.order_value),
        2
    ) AS total_revenue

FROM orders o

JOIN customers c
ON o.customer_id = c.customer_id

WHERE o.delivery_status = 'Delivered'

GROUP BY c.loyalty_tier

ORDER BY total_revenue DESC;
SELECT
    customer_id,

    COUNT(order_id) AS total_orders

FROM orders

GROUP BY customer_id

HAVING COUNT(order_id) > 1

ORDER BY total_orders DESC

LIMIT 20;
SELECT
    city,

    COUNT(customer_id)
    AS total_customers

FROM customers

GROUP BY city

ORDER BY total_customers DESC;
SELECT
    ROUND(
        AVG(customer_total),
        2
    ) AS avg_customer_lifetime_value

FROM (

    SELECT
        customer_id,

        SUM(order_value)
        AS customer_total

    FROM orders

    WHERE delivery_status = 'Delivered'

    GROUP BY customer_id

) AS customer_spending;SELECT
    c.loyalty_tier,

    ROUND(
        SUM(o.order_value),
        2
    ) AS revenue,

    ROUND(
        (
            SUM(o.order_value) * 100.0
        ) /
        (
            SELECT
                SUM(order_value)
            FROM orders
            WHERE delivery_status = 'Delivered'
        ),
        2
    ) AS revenue_contribution_pct

FROM orders o

JOIN customers c
ON o.customer_id = c.customer_id

WHERE o.delivery_status = 'Delivered'

GROUP BY c.loyalty_tier

ORDER BY revenue_contribution_pct DESC;
SELECT

    CASE

        WHEN total_orders >= 20
        THEN 'High Frequency'

        WHEN total_orders >= 10
        THEN 'Medium Frequency'

        ELSE 'Low Frequency'

    END AS customer_segment,

    COUNT(*) AS customer_count

FROM (

    SELECT
        customer_id,
        COUNT(order_id) AS total_orders

    FROM orders

    GROUP BY customer_id

) AS customer_orders

GROUP BY customer_segment;
