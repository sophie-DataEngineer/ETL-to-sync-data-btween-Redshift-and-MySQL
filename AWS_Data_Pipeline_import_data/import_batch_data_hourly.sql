-- import batch(30 days saying customers' orders status can't be changed after 30 days) data hourly
-- in real scenario, the where clause should be between '2018-10-17' - INTERVAL 30 DAY AND now()

-- for table order_items
select 
	a.* ,
	b.product_category_name
from 
	ecommerce_db.order_items a 
join 
	ecommerce_db.products b 
on 
	a.product_id = b.product_id
where 
	date(a.order_purchase_timestamp) BETWEEN '2018-10-17' - INTERVAL 30 DAY AND '2018-10-17';
    
-- for table order_reviews
select 
review_id,
order_id,
review_score,
review_comment_title,
review_comment_message,
case when review_creation_date like '%0000%' then NULL else review_creation_date end review_creation_date,
case when review_answer_timestamp like '%0000%' then NULL else review_answer_timestamp end review_answer_timestamp
from ecommerce_db.order_reviews 
where 
(review_creation_date BETWEEN '2018-10-17' - INTERVAL 30 DAY AND '2018-10-17');

-- for table orders
select 
	a.order_id,
	a.order_status,
	a.customer_id,
	a.order_approved_at,
	a.order_delivered_carrier_date,
	a.order_delivered_customer_date,
	a.order_estimated_delivery_date,
	a.order_purchase_timestamp,
	b.customer_city,
	b.customer_state,
	b.customer_zip_code_prefix
from 
	ecommerce_db.orders a 
join 
	ecommerce_db.customers b
on 
	a.customer_id = b.customer_id
where 
	(a.order_purchase_timestamp BETWEEN '2018-10-17' - INTERVAL 30 DAY AND '2018-10-17');
    
-- for table orders_payments
select 
	*
from 
	ecommerce_db.order_payments 
where 
	order_purchase_timestamp BETWEEN '2018-10-17' - INTERVAL 30 DAY AND '2018-10-17';