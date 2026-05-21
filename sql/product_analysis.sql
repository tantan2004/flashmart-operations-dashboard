SELECT
    p.category,

    COUNT(o.order_id) AS total_orders,

    ROUND(
        SUM(o.order_value),
        2
    ) AS total_revenue

FROM orders o

JOIN products p
ON o.product_id = p.product_id

WHERE o.delivery_status = 'Delivered'

GROUP BY p.category

ORDER BY total_revenue DESC;
SELECT
    p.product_name,

    p.category,

    COUNT(o.order_id) AS total_orders,

    ROUND(
        SUM(o.order_value),
        2
    ) AS revenue

FROM orders o

JOIN products p
ON o.product_id = p.product_id

WHERE o.delivery_status = 'Delivered'

GROUP BY p.product_name, p.category

ORDER BY revenue DESC

LIMIT 10;
SELECT
    p.category,

    ROUND(
        SUM(
            o.order_value -
            (p.unit_cost)
        ),
        2
    ) AS estimated_profit

FROM orders o

JOIN products p
ON o.product_id = p.product_id

WHERE o.delivery_status = 'Delivered'

GROUP BY p.category

ORDER BY estimated_profit DESC;
SELECT
    p.category,

    ROUND(
        AVG(o.order_value),
        2
    ) AS avg_order_value

FROM orders o

JOIN products p
ON o.product_id = p.product_id

WHERE o.delivery_status = 'Delivered'

GROUP BY p.category

ORDER BY avg_order_value DESC;
SELECT
    p.product_name,

    p.category,

    COUNT(o.order_id) AS total_orders

FROM orders o

JOIN products p
ON o.product_id = p.product_id

GROUP BY p.product_name, p.category

ORDER BY total_orders ASC

LIMIT 10;