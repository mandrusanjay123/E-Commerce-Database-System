EXPLAIN ANALYZE
SELECT p.product_id, p.product_category_name
FROM Products p
WHERE p.product_id NOT IN (
    SELECT product_id FROM Order_Items
);

DROP INDEX IF EXISTS idx_order_items_product_id;

CREATE INDEX idx_order_items_product_id ON Order_Items(product_id);


EXPLAIN ANALYZE
SELECT p.product_id, p.product_category_name
FROM Products p
WHERE p.product_id NOT IN (
    SELECT product_id FROM Order_Items
);



EXPLAIN ANALYZE
SELECT c.customer_state, COUNT(o.order_id) AS total_orders
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_state;

DROP INDEX IF EXISTS idx_orders_customer_id;
DROP INDEX IF EXISTS idx_customers_state ;

CREATE INDEX idx_orders_customer_id ON Orders(customer_id);
CREATE INDEX idx_customers_state ON Customers(customer_state);



EXPLAIN ANALYZE
SELECT order_id, order_status, order_purchase_timestamp
FROM Orders
WHERE order_purchase_timestamp BETWEEN '2024-01-01' AND '2024-12-31'
ORDER BY order_purchase_timestamp DESC;


DROP INDEX IF EXISTS idx_orders_purchase_ts ;

CREATE INDEX idx_orders_purchase_ts ON Orders(order_purchase_timestamp);


