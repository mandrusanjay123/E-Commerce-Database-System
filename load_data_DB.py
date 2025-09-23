
import psycopg2
import pandas as pd

DB_NAME = "Phase1DB"
DB_USER = "postgres"
DB_PASSWORD = "2742"
DB_HOST = "localhost"
DB_PORT = "5432"

def load_data(csv_file, table_name, columns, timestamp_columns=None):
    try:
        conn = psycopg2.connect(
            dbname=DB_NAME, user=DB_USER, password=DB_PASSWORD, host=DB_HOST, port=DB_PORT
        )
        cur = conn.cursor()
        df = pd.read_csv(csv_file)
        df = df[columns]

        if timestamp_columns:
            for col in timestamp_columns:
                if col in df.columns:
                    df[col] = pd.to_datetime(df[col], errors='coerce')  
                    df[col] = df[col].astype(object) 
                    df.loc[df[col].isna(), col] = None 

        data_tuples = [tuple(row) for row in df.itertuples(index=False, name=None)]
        columns_str = ", ".join(columns)
        placeholders = ", ".join(["%s"] * len(columns))
        insert_query = f"INSERT INTO {table_name} ({columns_str}) VALUES ({placeholders})"
        cur.executemany(insert_query, data_tuples)
        conn.commit()
        cur.close()
        conn.close()

        print(f"Successfully loaded {len(df)} records into {table_name}")

    except Exception as e:
        print(f"Error loading data into {table_name}: {e}")

load_data("olist_customers_cleaned.csv", "Customers", ["customer_id", "customer_unique_id", "customer_zip_code_prefix", "customer_city", "customer_state"])
load_data("olist_orders_cleaned.csv", "Orders", ["order_id", "customer_id", "order_status", "order_purchase_timestamp", "order_approved_at", "order_delivered_carrier_date", "order_delivered_customer_date", "order_estimated_delivery_date"])
load_data("olist_products_dataset.csv", "Products", ["product_id", "product_category_name", "product_name_lenght", "product_description_lenght", "product_photos_qty", "product_weight_g", "product_length_cm", "product_height_cm", "product_width_cm"])
load_data("olist_geolocation_cleaned.csv", "Geolocation", ["geolocation_zip_code_prefix", "geolocation_lat", "geolocation_lng", "geolocation_city", "geolocation_state"])
load_data("olist_sellers_dataset.csv", "Sellers", ["seller_id", "seller_zip_code_prefix", "seller_city", "seller_state"])
load_data("olist_order_items_dataset.csv", "Order_Items", ["order_id", "order_item_id", "product_id", "seller_id", "shipping_limit_date", "price", "freight_value"])
load_data("olist_order_payments_dataset.csv", "Order_Payments", ["order_id", "payment_sequential", "payment_type", "payment_installments", "payment_value"])
load_data("olist_order_reviews_cleaned.csv", "Order_Reviews", ["review_id", "order_id", "review_score", "review_comment_message", "review_creation_date"])
load_data("olist_marketing_qualified_leads_dataset.csv", "Leads_Qualified", ["mql_id", "first_contact_date", "landing_page_id", "origin"])
load_data("olist_closed_deals_cleaned.csv", "Leads_Closed", ["mql_id", "seller_id", "sdr_id", "sr_id", "won_date", "business_segment", "lead_type", "lead_behaviour_profile", "has_company", "has_gtin", "average_stock", "business_type", "declared_product_catalog_size", "declared_monthly_revenue"])
load_data("product_category_name_translation.csv", "Product_category_name_translation", ["product_category_name","product_category_name_english"])
