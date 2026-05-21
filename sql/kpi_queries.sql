SELECT
    COUNT(*) AS total_orders,

    ROUND(
        SUM(
            CASE
                WHEN delivery_status = 'Delivered'
                THEN order_value
                ELSE 0
            END
        ),
        2
    ) AS total_revenue,

    ROUND(
        AVG(
            CASE
                WHEN delivery_status = 'Delivered'
                THEN order_value
            END
        ),
        2
    ) AS avg_order_value,

    ROUND(
        AVG(
            CASE
                WHEN delivery_status = 'Delivered'
                THEN delivery_time_mins
            END
        ),
        2
    ) AS avg_delivery_time,

    ROUND(
        (
            SUM(
                CASE
                    WHEN delivery_status = 'Cancelled'
                    THEN 1
                    ELSE 0
                END
            ) * 100.0
        ) / COUNT(*),
        2
    ) AS cancellation_rate_pct,

    (
        SELECT
            ROUND(
                (
                    COUNT(*) * 100.0
                ) /
                (
                    SELECT COUNT(DISTINCT customer_id)
                    FROM orders
                ),
                2
            )
        FROM (
            SELECT customer_id
            FROM orders
            GROUP BY customer_id
            HAVING COUNT(order_id) > 1
        ) AS repeat_customers
    ) AS repeat_customer_rate_pct

FROM orders;