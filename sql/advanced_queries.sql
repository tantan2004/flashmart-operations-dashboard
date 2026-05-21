SELECT
    DATE_FORMAT(order_date, '%Y-%m')
    AS order_month,
    ROUND(
        SUM(order_value),
        2
    ) AS monthly_revenue
FROM orders
WHERE delivery_status = 'Delivered'
GROUP BY order_month
ORDER BY order_month;
SELECT
    order_month,
    monthly_revenue,
    ROUND(
        (
            (
                monthly_revenue -
                LAG(monthly_revenue)
                OVER (ORDER BY order_month)
            )
            /
            LAG(monthly_revenue)
            OVER (ORDER BY order_month)
        ) * 100,
        2
    ) AS revenue_growth_pct
FROM (
    SELECT
        DATE_FORMAT(order_date, '%Y-%m')
        AS order_month,
        SUM(order_value)
        AS monthly_revenue
    FROM orders
    WHERE delivery_status = 'Delivered'
    GROUP BY order_month
) AS monthly_data;
SELECT
    DATE_FORMAT(order_date, '%Y-%m')
    AS order_month,

    ROUND(
        SUM(order_value),
        2
    ) AS monthly_revenue,

    ROUND(
        SUM(
            SUM(order_value)
        ) OVER (
            ORDER BY DATE_FORMAT(order_date, '%Y-%m')
        ),
        2
    ) AS cumulative_revenue

FROM orders

WHERE delivery_status = 'Delivered'

GROUP BY order_month

ORDER BY order_month;
SELECT
    customer_id,

    ROUND(
        SUM(order_value),
        2
    ) AS total_spent,

    RANK() OVER (
        ORDER BY SUM(order_value) DESC
    ) AS customer_rank

FROM orders

WHERE delivery_status = 'Delivered'

GROUP BY customer_id

ORDER BY customer_rank

LIMIT 20;
SELECT
    city,

    ROUND(
        SUM(order_value),
        2
    ) AS revenue,

    DENSE_RANK() OVER (
        ORDER BY SUM(order_value) DESC
    ) AS dense_city_rank

FROM orders

WHERE delivery_status = 'Delivered'

GROUP BY city;
SELECT
    order_date,

    COUNT(order_id) AS daily_orders,

    ROUND(
        AVG(
            COUNT(order_id)
        ) OVER (
            ORDER BY order_date
            ROWS BETWEEN 6 PRECEDING
            AND CURRENT ROW
        ),
        2
    ) AS rolling_7_day_avg

FROM orders

GROUP BY order_date

ORDER BY order_date;
SELECT
    city,

    ROUND(
        SUM(order_value),
        2
    ) AS city_revenue,

    ROUND(
        (
            SUM(order_value) * 100.0
        ) /
        (
            SELECT
                SUM(order_value)
            FROM orders
            WHERE delivery_status = 'Delivered'
        ),
        2
    ) AS revenue_contribution_pct

FROM orders

WHERE delivery_status = 'Delivered'

GROUP BY city

ORDER BY revenue_contribution_pct DESC;
SELECT
    HOUR(order_time) AS order_hour,

    COUNT(order_id) AS total_orders

FROM orders

GROUP BY order_hour

ORDER BY total_orders DESC;