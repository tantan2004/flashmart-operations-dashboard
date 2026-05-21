SELECT
    city,

    COUNT(order_id) AS total_orders,

    ROUND(
        SUM(order_value),
        2
    ) AS total_revenue

FROM orders

WHERE delivery_status = 'Delivered'

GROUP BY city

ORDER BY total_revenue DESC;
SELECT
    city,

    COUNT(order_id) AS total_orders,

    SUM(
        CASE
            WHEN delivery_status = 'Cancelled'
            THEN 1
            ELSE 0
        END
    ) AS cancelled_orders,

    ROUND(
        (
            SUM(
                CASE
                    WHEN delivery_status = 'Cancelled'
                    THEN 1
                    ELSE 0
                END
            ) * 100.0
        ) / COUNT(order_id),
        2
    ) AS cancellation_rate_pct

FROM orders

GROUP BY city

ORDER BY cancellation_rate_pct DESC;
SELECT
    city,

    ROUND(
        AVG(delivery_time_mins),
        2
    ) AS avg_delivery_time

FROM orders

WHERE delivery_status = 'Delivered'

GROUP BY city

ORDER BY avg_delivery_time;
SELECT
    city,

    ROUND(
        AVG(customer_rating),
        2
    ) AS avg_customer_rating

FROM orders

GROUP BY city

ORDER BY avg_customer_rating DESC;
SELECT
    city,

    ROUND(
        SUM(order_value),
        2
    ) AS total_revenue,

    RANK() OVER(
        ORDER BY SUM(order_value) DESC
    ) AS city_rank

FROM orders

WHERE delivery_status = 'Delivered'

GROUP BY city;
SELECT
    city,

    DATE_FORMAT(order_date, '%Y-%m') AS order_month,

    ROUND(
        SUM(order_value),
        2
    ) AS monthly_revenue

FROM orders

WHERE delivery_status = 'Delivered'

GROUP BY city, order_month

ORDER BY order_month;