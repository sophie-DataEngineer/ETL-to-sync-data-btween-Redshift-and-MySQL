create schema if not exists mysql_dwh;
create schema if not exists mysql_dwh_staging;

CREATE TABLE if not exists mysql_dwh.orders (
	order_id VARCHAR(50) , 
	order_status VARCHAR(35) , 
	customer_id VARCHAR(100) , 
	order_approved_at TIMESTAMP, 
	order_delivered_carrier_date TIMESTAMP, 
	order_delivered_customer_date TIMESTAMP, 
	order_estimated_delivery_date TIMESTAMP, 
	order_purchase_timestamp TIMESTAMP, 
	customer_city VARCHAR(50) , 
	customer_state VARCHAR(10) , 
	customer_zip_code_prefix DECIMAL
);

CREATE TABLE if not exists mysql_dwh.customers (
  customer_id VARCHAR(100),
  customer_unique_id VARCHAR(50),
  customer_zip_code_prefix DECIMAL,
  customer_city VARCHAR(50),
  customer_state VARCHAR(50)
);

CREATE TABLE if not exists mysql_dwh.order_items (
	order_id VARCHAR(100) , 
	order_item_id DECIMAL , 
	product_id VARCHAR(100) , 
	seller_id VARCHAR(100) , 
	shipping_limit_date TIMESTAMP, 
	price DECIMAL , 
	freight_value DECIMAL , 
	order_purchase_timestamp TIMESTAMP,
	product_category_name VARCHAR(255)
);

CREATE TABLE if not exists mysql_dwh.order_payments (
	order_id VARCHAR(100) , 
	payment_sequential DECIMAL , 
	payment_type VARCHAR(100) , 
	payment_installments DECIMAL ,
	payment_value DECIMAL,
	order_purchase_timestamp TIMESTAMP
);

CREATE TABLE if not exists mysql_dwh.order_reviews (
	review_id VARCHAR(100) , 
	order_id VARCHAR(100) , 
	review_score INTEGER , 
	review_comment_title VARCHAR(255) , 
	review_comment_message VARCHAR(255) ,
	review_creation_date TIMESTAMP,
	review_answer_timestamp TIMESTAMP
);

CREATE TABLE if not exists mysql_dwh.geolocation (
	geolocation_zip_code_prefix BIGINT , 
	geolocation_lat INTEGER , 
	geolocation_lng INTEGER , 
	geolocation_city VARCHAR(50) , 
	geolocation_state VARCHAR(50)
);

CREATE TABLE if not exists mysql_dwh.sellers (
	seller_id VARCHAR(255) , 
	seller_zip_code_prefix BIGINT , 
	seller_city VARCHAR(50) , 
	seller_state VARCHAR(50)
);

CREATE TABLE if not exists  mysql_dwh.products (
  product_id varchar(100),
  product_category_name varchar(255),
  product_name_lenght DECIMAL,
  product_description_lenght DECIMAL,
  product_photos_qty DECIMAL,
  product_weight_g DECIMAL,
  product_length_cm DECIMAL,
  product_height_cm DECIMAL,
  product_width_cm DECIMAL
);

CREATE TABLE if not exists mysql_dwh.product_category_name_translation (
	product_category_name VARCHAR(255) , 
	product_category_name_english VARCHAR(255)	
); 


CREATE TABLE mysql_dwh_staging.orders as select * from mysql_dwh.orders limit 1;
TRUNCATE mysql_dwh_staging.orders; 

CREATE TABLE mysql_dwh_staging.order_items as select * from mysql_dwh.order_items limit 1;
TRUNCATE mysql_dwh_staging.order_items; 

CREATE TABLE mysql_dwh_staging.order_payments as select * from mysql_dwh.order_payments limit 1;
TRUNCATE mysql_dwh_staging.order_payments; 

CREATE TABLE mysql_dwh_staging.order_reviews as select * from mysql_dwh.order_reviews limit 1;
TRUNCATE mysql_dwh_staging.order_reviews; 

CREATE TABLE mysql_dwh_staging.geolocation as select * from mysql_dwh.geolocation limit 1;
TRUNCATE mysql_dwh_staging.geolocation; 

CREATE TABLE mysql_dwh_staging.sellers as select * from mysql_dwh.sellers limit 1;
TRUNCATE mysql_dwh_staging.sellers; 

CREATE TABLE mysql_dwh_staging.products as select * from mysql_dwh.products limit 1;
TRUNCATE mysql_dwh_staging.products; 

CREATE TABLE mysql_dwh_staging.product_category_name_translation as select * from mysql_dwh.product_category_name_translation limit 1;
TRUNCATE mysql_dwh_staging.product_category_name_translation; 

CREATE TABLE mysql_dwh_staging.customers as select * from mysql_dwh.customers limit 1;
TRUNCATE mysql_dwh_staging.customers;


