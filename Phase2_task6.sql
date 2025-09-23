CREATE TABLE Transaction_Log (
    id SERIAL PRIMARY KEY,
    message TEXT,
    log_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE EXTENSION IF NOT EXISTS dblink;


CREATE OR REPLACE FUNCTION log_failure(p_message TEXT)
RETURNS VOID AS $$
BEGIN
    PERFORM dblink_exec(
        'host=localhost dbname=Phase1DB user=postgres password=2742',
        'INSERT INTO Transaction_Log(message) VALUES (''' || p_message || ''')'
    );
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION create_order_transaction()
RETURNS VOID AS $$
DECLARE
    v_order_id TEXT := 'fail_order_001';
BEGIN
    BEGIN
        -- Insert into Orders
        INSERT INTO Orders (
            order_id, customer_id, order_status, order_purchase_timestamp,
            order_approved_at, order_estimated_delivery_date
        )
        VALUES (
            v_order_id, 'new_customer_001', 'processing', NOW(), NOW(), NOW() + interval '5 days'
        );

        -- Intentionally fail- Inserting with invalid product_id
        INSERT INTO Order_Items (
            order_id, order_item_id, product_id, seller_id, shipping_limit_date, price, freight_value
        )
        VALUES (
            v_order_id, 1, 'INVALID_PRODUCT', 'some_seller', NOW(), 100, 10
        );

       
    EXCEPTION
        WHEN OTHERS THEN
            PERFORM log_failure('Transaction failed: ' || SQLERRM);
            RAISE;
    END;
END;
$$ LANGUAGE plpgsql;

INSERT INTO Customers (
    customer_id, customer_unique_id, customer_zip_code_prefix, customer_city, customer_state
) VALUES (
    'new_customer_001', 'unique_abc123', 12345, 'Buffalo', 'NY'
);


SELECT create_order_transaction();

SELECT * FROM Transaction_Log ORDER BY log_time DESC;




