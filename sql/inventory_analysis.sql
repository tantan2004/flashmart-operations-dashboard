SELECT
    warehouse_id,

    city,

    product_id,

    stock_available,

    reorder_level

FROM inventory

WHERE stock_available < reorder_level

ORDER BY stock_available ASC;
SELECT
    city,

    COUNT(*) AS low_stock_products

FROM inventory

WHERE stock_available < reorder_level

GROUP BY city

ORDER BY low_stock_products DESC;
SELECT
    warehouse_id,

    city,

    SUM(stock_available)
    AS total_inventory_units

FROM inventory

GROUP BY warehouse_id, city

ORDER BY total_inventory_units DESC;
SELECT
    p.category,

    SUM(i.stock_available)
    AS total_stock

FROM inventory i

JOIN products p
ON i.product_id = p.product_id

GROUP BY p.category

ORDER BY total_stock DESC;
SELECT
    p.product_name,

    p.category,

    COUNT(o.order_id)
    AS total_orders

FROM orders o

JOIN products p
ON o.product_id = p.product_id

WHERE o.delivery_status = 'Delivered'

GROUP BY
    p.product_name,
    p.category

ORDER BY total_orders DESC

LIMIT 15;
SELECT
    p.category,

    ROUND(
        COUNT(o.order_id) /
        AVG(i.stock_available),
        2
    ) AS inventory_turnover_ratio

FROM orders o

JOIN products p
ON o.product_id = p.product_id

JOIN inventory i
ON p.product_id = i.product_id

WHERE o.delivery_status = 'Delivered'

GROUP BY p.category

ORDER BY inventory_turnover_ratio DESC;
SELECT
    i.product_id,

    p.product_name,

    p.category,

    i.stock_available

FROM inventory i

JOIN products p
ON i.product_id = p.product_id

WHERE i.stock_available > 900

ORDER BY i.stock_available DESC;
SELECT
    warehouse_id,

    city,

    COUNT(
        CASE
            WHEN stock_available < reorder_level
            THEN 1
        END
    ) AS risky_products

FROM inventory

GROUP BY warehouse_id, city

ORDER BY risky_products DESC;