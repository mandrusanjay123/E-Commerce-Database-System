SELECT o.order_id, c.customer_city, o.order_purchase_timestamp, o.order_delivered_customer_date, 
       (o.order_delivered_customer_date - o.order_purchase_timestamp) AS delivery_time
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
WHERE o.order_delivered_customer_date IS NOT NULL
ORDER BY delivery_time DESC
LIMIT 5;



SELECT c.customer_unique_id, COUNT(o.order_id) AS order_count
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_unique_id
HAVING COUNT(o.order_id) > 5
ORDER BY order_count DESC;


SELECT op.payment_type, COUNT(op.order_id) AS total_payments
FROM Order_Payments op
GROUP BY op.payment_type
ORDER BY total_payments DESC;


SELECT c.customer_state, AVG(oi.price + oi.freight_value) AS avg_order_value
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN Order_Items oi ON o.order_id = oi.order_id
GROUP BY c.customer_state
ORDER BY avg_order_value DESC;



SELECT pc.product_category_name_english, orv.review_score, COUNT(orv.review_id) AS review_count
FROM Order_Reviews orv
JOIN Orders o ON orv.order_id = o.order_id
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
JOIN Product_Category_Name_Translation pc ON p.product_category_name = pc.product_category_name
GROUP BY pc.product_category_name_english, orv.review_score
ORDER BY review_count DESC
LIMIT 10;


SELECT lq.mql_id, lq.first_contact_date, lc.won_date, lc.business_segment
FROM Leads_Qualified lq
JOIN Leads_Closed lc ON lq.mql_id = lc.mql_id
ORDER BY lc.won_date DESC
LIMIT 10;




SELECT s.seller_id, s.seller_city, SUM(oi.price + oi.freight_value) AS total_revenue
FROM Sellers s
JOIN Order_Items oi ON s.seller_id = oi.seller_id
GROUP BY s.seller_id, s.seller_city
ORDER BY total_revenue DESC
LIMIT 10;


SELECT c.customer_state, AVG(o.order_delivered_customer_date - o.order_purchase_timestamp) AS avg_delivery_days
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
WHERE o.order_delivered_customer_date IS NOT NULL
GROUP BY c.customer_state
ORDER BY avg_delivery_days DESC;



SELECT s.seller_id, s.seller_city, COUNT(oi.order_id) AS total_orders, SUM(oi.price) AS revenue
FROM Sellers s
JOIN Order_Items oi ON s.seller_id = oi.seller_id
GROUP BY s.seller_id, s.seller_city
ORDER BY total_orders DESC
LIMIT 5;


SELECT COUNT(lq.mql_id) AS total_leads, COUNT(lc.mql_id) AS converted_leads, 
       (COUNT(lc.mql_id) * 100.0 / COUNT(lq.mql_id)) AS conversion_rate
FROM Leads_Qualified lq
LEFT JOIN Leads_Closed lc ON lq.mql_id = lc.mql_id;



