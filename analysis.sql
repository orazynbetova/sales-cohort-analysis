SELECT
    c.full_name,
    COUNT(o.order_id) AS orders_count
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.full_name;

SELECT
    c.full_name,
    SUM(o.price) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.full_name
ORDER BY total_spent DESC;



SELECT
    p.product_name,
    SUM(p.price * oi.quantity) AS revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY revenue DESC;


SELECT
    p1.product_name AS product_1,
    p2.product_name AS product_2,
    COUNT(*) AS times_bought_together
FROM order_items oi1
JOIN order_items oi2
    ON oi1.order_id = oi2.order_id
    AND oi1.product_id < oi2.product_id
JOIN products p1 ON oi1.product_id = p1.product_id
JOIN products p2 ON oi2.product_id = p2.product_id
GROUP BY p1.product_name, p2.product_name
ORDER BY times_bought_together DESC;


SELECT COUNT(*) AS repeat_customers
FROM (
    SELECT customer_id
    FROM orders
    GROUP BY customer_id
    HAVING COUNT(order_id) > 1
) t;

SELECT
    c.full_name,
    COUNT(o.order_id) AS orders_count
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.full_name
HAVING COUNT(o.order_id) > 1;

SELECT
    COUNT(DISTINCT CASE
        WHEN orders_count > 1 THEN customer_id
    END) * 1.0
    / COUNT(DISTINCT customer_id) AS retention_rate
FROM (
    SELECT
        customer_id,
        COUNT(order_id) AS orders_count
    FROM orders
    GROUP BY customer_id
) t;

SELECT
    customer_id,
    COUNT(order_id) AS orders_count
FROM orders
GROUP BY customer_id;

SELECT
    COUNT(*) AS one_order_customers
FROM (
    SELECT
        customer_id,
        COUNT(*) AS orders_count
    FROM orders
    GROUP BY customer_id
) t
WHERE orders_count = 1;

SELECT
    COUNT(*) AS repeat_customers
FROM (
    SELECT
        customer_id,
        COUNT(*) AS orders_count
    FROM orders
    GROUP BY customer_id
) t

SELECT
    COUNT(*) FILTER (WHERE orders_count > 1) * 1.0
    / COUNT(*) AS retention_rate
FROM (
    SELECT
        customer_id,
        COUNT(*) AS orders_count
    FROM orders
    GROUP BY customer_id
) t;

 WITH cohort_data AS (SELECT customer_id,
                            DATE_TRUNC('month', MIN(order_date) OVER (PARTITION BY customer_id)) AS cohort_month,
                            DATE_TRUNC('month', order_date) AS order_month,
                            EXTRACT(YEAR FROM AGE(order_date,MIN(order_date) OVER (PARTITION BY customer_id)))*12+
                            EXTRACT(MONTH FROM AGE(order_date, MIN(order_date) OVER (PARTITION BY customer_id))) AS month_number

                     FROM orders

),
    cohort_size AS (
        SELECT
            cohort_month,
            COUNT(DISTINCT customer_id) AS cohort_total
        FROM cohort_data
        GROUP BY cohort_month
    )
SELECT
    c.cohort_month,
    c.order_month,
    COUNT(DISTINCT c.customer_id) * 1.0 / cs.cohort_total AS retention_rate
FROM cohort_data c
JOIN cohort_size cs
ON c.cohort_month = cs.cohort_month
GROUP BY c.cohort_month, c.order_month, cs.cohort_total
ORDER BY c.cohort_month, c.order_month;