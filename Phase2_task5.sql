INSERT INTO Customers (
    customer_id, customer_unique_id, customer_zip_code_prefix, customer_city, customer_state
) VALUES (
    'new_customer_001', 'unique_abc123', 12345, 'Buffalo', 'NY'
);


select * from customers where customer_id='new_customer_001';

UPDATE Customers
SET customer_city = 'Albany', customer_state = 'NY'
WHERE customer_id = 'new_customer_001';

select * from customers where customer_id='new_customer_001';

DELETE FROM Order_Reviews
WHERE review_score = 1 AND review_comment_message IS NULL;

select * from Order_Reviews


select * from orders

INSERT INTO Orders (
    order_id,
    customer_id,
    order_status,
    order_purchase_timestamp,
    order_approved_at,
    order_delivered_carrier_date,
    order_delivered_customer_date,
    order_estimated_delivery_date
) VALUES (
    'new_order_001',
    'new_customer_001',
    'processing',
    '2025-04-19 12:00:00',
    '2025-04-19 13:00:00',
    NULL,
    NULL,
    '2025-04-25 12:00:00'
);


select * from orders where order_id='new_order_001'

















select * from product_category_name_translation

INSERT INTO product_category_name_translation (
    product_category_name, product_category_name_english
) VALUES (
    'electronics', 'Electronics'
);

select * from product_category_name_translation;

select * from Products where product_id='1e9e8ef04dbcff4541ed26657ea517e5'

UPDATE Products
SET product_category_name = 'electronics',
    product_photos_qty = 5
WHERE product_id = '1e9e8ef04dbcff4541ed26657ea517e5';


select * from customers where customer_id='new_customer_001' ;


select * from orders where customer_id='new_customer_001' ;

DELETE FROM Orders WHERE customer_id = 'new_customer_001';
DELETE FROM Customers WHERE customer_id = 'new_customer_001';





select * from Products where product_id='1e9e8ef04dbcff4541ed26657ea517e5' ;


select * from Order_items where product_id='1e9e8ef04dbcff4541ed26657ea517e5' ;

DELETE FROM Products
WHERE product_id = '1e9e8ef04dbcff4541ed26657ea517e5';


DELETE FROM Order_Items
WHERE product_id = '1e9e8ef04dbcff4541ed26657ea517e5';












--Task 5 part 2 select queries----



---JOIN + ORDER BY--
SELECT o.order_id, c.customer_city, o.order_status, o.order_purchase_timestamp
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
ORDER BY o.order_purchase_timestamp DESC
LIMIT 10;




---GROUP BY + Aggregation---
SELECT c.customer_state, COUNT(o.order_id) AS total_orders
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_state
ORDER BY total_orders DESC;


---WHERE clause---
SELECT p.product_id, p.product_category_name
FROM Products p
WHERE p.product_id NOT IN (
    SELECT DISTINCT oi.product_id FROM Order_Items oi
);



---Subquery---
SELECT o.order_id,
       o.order_status,
       (SELECT COUNT(*) FROM Order_Items oi WHERE oi.order_id = o.order_id) AS item_count
FROM Orders o
ORDER BY item_count DESC
LIMIT 10;


---JOIN ----
SELECT o.order_id, c.customer_city, p.product_category_name, oi.price
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
LIMIT 20;


---GROUP BY + HAVING ----
SELECT s.seller_id, COUNT(oi.order_item_id) AS total_items_sold
FROM Sellers s
JOIN Order_Items oi ON s.seller_id = oi.seller_id
GROUP BY s.seller_id
HAVING COUNT(oi.order_item_id) > 100
ORDER BY total_items_sold DESC;


--Insert a new customer--
CREATE OR REPLACE FUNCTION insert_new_customer(
    p_customer_id TEXT,
    p_unique_id TEXT,
    p_zip_code INTEGER,
    p_city TEXT,
    p_state TEXT
)
RETURNS VOID AS $$
BEGIN
    INSERT INTO Customers (
        customer_id, customer_unique_id, customer_zip_code_prefix, customer_city, customer_state
    )
    VALUES (
        p_customer_id, p_unique_id, p_zip_code, p_city, p_state
    );
END;
$$ LANGUAGE plpgsql;


SELECT insert_new_customer('new_customer_002', 'uniq_xyz', 99999, 'Rochester', 'NY');

select * from customers where customer_id='new_customer_002'


----Update Procedure--
CREATE OR REPLACE FUNCTION insert_then_update_product(
    p_product_id TEXT,
    p_category_name TEXT,
    p_name_length NUMERIC,
    p_desc_length NUMERIC,
    p_photos_qty NUMERIC,
    p_weight NUMERIC,
    p_length NUMERIC,
    p_height NUMERIC,
    p_width NUMERIC
)
RETURNS VOID AS $$
BEGIN
    -- Insert the product
    INSERT INTO Products (
        product_id,
        product_category_name,
        product_name_lenght,
        product_description_lenght,
        product_photos_qty,
        product_weight_g,
        product_length_cm,
        product_height_cm,
        product_width_cm
    )
    VALUES (
        p_product_id,
        p_category_name,
        p_name_length,
        p_desc_length,
        p_photos_qty,
        p_weight,
        p_length,
        p_height,
        p_width
    );

   
    UPDATE Products
    SET product_category_name = p_category_name,
        product_photos_qty = p_photos_qty
    WHERE product_id = p_product_id;
END;
$$ LANGUAGE plpgsql;


SELECT insert_then_update_product(
    'new_product_001',
    'electronics',     
    25,                  
    200,                 
    3,                  
    800,                 
    20, 10, 5            
);



SELECT * FROM Products WHERE product_id = 'new_product_001';

--delete Procedure----

CREATE OR REPLACE FUNCTION delete_product_safe(p_product_id TEXT)
RETURNS TEXT AS $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM Order_Items WHERE product_id = p_product_id
    ) THEN
        RETURN 'Cannot delete: Product is referenced in Order_Items.';
    ELSE
        DELETE FROM Products WHERE product_id = p_product_id;
        IF FOUND THEN
            RETURN 'Product deleted successfully.';
        ELSE
            RETURN 'Product ID not found.';
        END IF;
    END IF;
END;
$$ LANGUAGE plpgsql;



SELECT delete_product_safe('new_product_001');

select * from products where product_id='new_product_001';



































