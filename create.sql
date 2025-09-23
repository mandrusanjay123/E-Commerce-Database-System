-- Drop existing tables ,if there are any, 
DROP TABLE IF EXISTS Order_Items,
Order_Payments,
Order_Reviews,
Orders, 
Customers,
Products, 
Product_Category_Name_Translation, 
Sellers, Geolocation, 
Leads_Qualified, Leads_Closed CASCADE;


-- Create Customers Table 
CREATE TABLE Customers( 
customer_id VARCHAR(50) PRIMARY KEY, 
customer_unique_id VARCHAR(50) UNIQUE NOT NULL, 
customer_zip_code_prefix VARCHAR(10), 
customer_city VARCHAR(100), 
customer_state VARCHAR(50) );


-- Create Orders Table 
CREATE TABLE Orders ( 
order_id VARCHAR(50) PRIMARY KEY, 
customer_id VARCHAR(50) REFERENCES Customers(customer_id) ON DELETE CASCADE, 
order_status VARCHAR(20), 
order_purchase_timestamp TIMESTAMP NOT NULL, 
order_approved_at TIMESTAMP, 
order_delivered_carrier_date TIMESTAMP, 
order_delivered_customer_date TIMESTAMP, 
order_estimated_delivery_date TIMESTAMP );



-- Create Product Category Name Translation Table
CREATE TABLE Product_Category_Name_Translation (
product_category_name VARCHAR(100) PRIMARY KEY, 
product_category_name_english VARCHAR(100) ); 


-- Create Products Table 
CREATE TABLE Products ( 
product_id VARCHAR(50) PRIMARY KEY, 
product_category_name VARCHAR(100) REFERENCES Product_Category_Name_Translation(product_category_name), 
product_name_length INT, 
product_description_length INT, 
product_photos_qty INT, 
product_weight_g DECIMAL(10,2), 
product_length_cm DECIMAL(10,2), 
product_height_cm DECIMAL(10,2), 
product_width_cm DECIMAL(10,2) );


-- Create Geolocation Table 
CREATE TABLE Geolocation ( 
geolocation_zip_code_prefix VARCHAR(10) PRIMARY KEY, 
geolocation_lat DECIMAL(10,6), 
geolocation_lng DECIMAL(10,6), 
geolocation_city VARCHAR(100), 
geolocation_state VARCHAR(50) );



-- Create Order Items Table 
CREATE TABLE Order_Items ( 
order_id VARCHAR(50), 
order_item_id INT, 
product_id VARCHAR(50), 
seller_id VARCHAR(50), 
shipping_limit_date TIMESTAMP, 
price DECIMAL(10,2) NOT NULL, 
freight_value DECIMAL(10,2) NOT NULL, 
PRIMARY KEY (order_id, order_item_id), 
FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE, 
FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE, 
FOREIGN KEY (seller_id) REFERENCES Sellers(seller_id) ON DELETE CASCADE );



-- Create Order Payments Table 
CREATE TABLE Order_Payments ( 
order_id VARCHAR(50), 
payment_sequential INT,
payment_type VARCHAR(50), 
payment_installments INT CHECK (payment_installments >= 1), 
payment_value DECIMAL(10,2) NOT NULL, 
PRIMARY KEY (order_id, payment_sequential), 
FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE );




-- Create Order Reviews Table 
CREATE TABLE Order_Reviews ( 
review_id VARCHAR(50) PRIMARY KEY,
order_id VARCHAR(50) UNIQUE REFERENCES Orders(order_id) ON DELETE CASCADE, 
review_score INT CHECK (review_score BETWEEN 1 AND 5), 
review_comment_title TEXT, 
review_comment_message TEXT, 
review_creation_date TIMESTAMP, 
review_answer_timestamp TIMESTAMP );



-- Create Leads Qualified Table 
CREATE TABLE Leads_Qualified (
mql_id VARCHAR(50) PRIMARY KEY, 
first_contact_date TIMESTAMP, 
landing_page_id VARCHAR(50), 
origin VARCHAR(50) );


-- Create Leads Closed Table 
CREATE TABLE Leads_Closed ( 
mql_id VARCHAR(50), 
seller_id VARCHAR(50), 
sdr_id VARCHAR(50), 
sr_id VARCHAR(50), 
won_date TIMESTAMP, 
business_segment VARCHAR(100), 
lead_type VARCHAR(50), 
lead_behaviour_profile VARCHAR(50), 
has_company BOOLEAN, 
has_gtin BOOLEAN, 
average_stock INT, 
business_type VARCHAR(50), 
declared_product_catalog_size INT, 
declared_monthly_revenue DECIMAL(12,2), 
PRIMARY KEY (mql_id, seller_id), 
FOREIGN KEY (mql_id) REFERENCES Leads_Qualified(mql_id) ON DELETE CASCADE, 
FOREIGN KEY (seller_id) REFERENCES Sellers(seller_id) ON DELETE CASCADE ); 




