-- ============================================
-- Freight Rate Predictor - Key SQL Queries
-- ============================================

-- 1. Average freight cost by customer state
-- Reveals which states have the highest/lowest shipping costs
SELECT customers.customer_state, ROUND(AVG(order_items.freight_value), 2) AS avg_freight
FROM order_items
JOIN orders ON order_items.order_id = orders.order_id
JOIN customers ON orders.customer_id = customers.customer_id
GROUP BY customers.customer_state
ORDER BY avg_freight DESC;

-- 2. Average freight cost by product category
-- Identifies which product types are most expensive to ship
SELECT products.product_category_name, ROUND(AVG(order_items.freight_value), 2) AS avg_freight
FROM order_items
JOIN products ON order_items.product_id = products.product_id
GROUP BY products.product_category_name
ORDER BY avg_freight DESC
LIMIT 10;

-- 3. Order count by status
SELECT order_status, COUNT(*) AS num_orders
FROM orders
GROUP BY order_status;

-- 4. States with above-average freight cost (using CTE)
WITH state_freight AS (
    SELECT customers.customer_state, ROUND(AVG(order_items.freight_value), 2) AS avg_freight
    FROM order_items
    JOIN orders ON order_items.order_id = orders.order_id
    JOIN customers ON orders.customer_id = customers.customer_id
    GROUP BY customers.customer_state
)
SELECT * FROM state_freight WHERE avg_freight > 30;

-- Equivalent using HAVING instead of a CTE
SELECT customers.customer_state, ROUND(AVG(order_items.freight_value), 2) AS avg_freight
FROM order_items
JOIN orders ON order_items.order_id = orders.order_id
JOIN customers ON orders.customer_id = customers.customer_id
GROUP BY customers.customer_state
HAVING AVG(order_items.freight_value) > 30;

-- 5. Final feature table: joins all 4 tables into one row per order item
-- This is the dataset exported to Python for model training
SELECT 
    order_items.order_id,
    order_items.price,
    order_items.freight_value,
    products.product_weight_g,
    products.product_length_cm,
    products.product_height_cm,
    products.product_width_cm,
    customers.customer_state,
    customers.customer_city,
    orders.order_status
FROM order_items
JOIN orders ON order_items.order_id = orders.order_id
JOIN customers ON orders.customer_id = customers.customer_id
JOIN products ON order_items.product_id = products.product_id
WHERE orders.order_status = 'delivered';
