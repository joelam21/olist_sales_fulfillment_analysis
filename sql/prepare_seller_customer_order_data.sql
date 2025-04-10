-- Preprocess summed revenue by customer_id and seller_id to create cust_rank_per_seller in main query
WITH customer_seller_revenue AS (
    SELECT 
        o.customer_id,
        oi.seller_id,
        SUM(oi.price + oi.freight_value) AS seller_revenue_by_cust
    FROM order_items AS oi
    JOIN orders AS o ON oi.order_id = o.order_id
    GROUP BY o.customer_id, oi.seller_id
)


SELECT 
    o.order_id,
    o.customer_id,
    o.order_status,
    o.order_purchase_timestamp,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date,

    oi.product_id,
    oi.seller_id,
    oi.price,
    oi.freight_value,
    (oi.price + oi.freight_value) AS item_revenue,


    -- review columns
    r.review_score,
    r.review_creation_date,
    r.review_comment_message,

    -- product/category columns
    p.product_category_name,
    ct.product_category_name_english, 
    cat.category,

    -- customer columns
    c.customer_unique_id AS cust_unique_id, 
    c.customer_zip_code_prefix AS cust_zip, 
    c.customer_city AS cust_city,
    c.customer_state AS cust_state,

    -- seller columns
    s.seller_zip_code_prefix AS seller_zip, 
    s.seller_city AS s_city, 
    s.seller_state AS s_state, 


    -- Window function: total revenue per order (in case of multiple items)
    SUM(oi.price + oi.freight_value) OVER (PARTITION BY o.order_id) AS order_total_revenue,

    -- Window function: avg review score per seller
    AVG(r.review_score) OVER (PARTITION BY oi.seller_id) AS avg_seller_review_score,

    -- Window function: rank customer orders by item_revenue for each seller
    DENSE_RANK() OVER (PARTITION BY oi.seller_id ORDER BY csr.seller_revenue_by_cust DESC) AS cust_rank_by_seller_revenue,

    -- Window function: in the rare case of multiple reviews, duplicate order_id lines will occur, 
    -- filter review_instance for 1 to eliminate duplicates
    ROW_NUMBER() OVER (PARTITION BY o.order_id ORDER BY r.review_creation_date ASC) AS review_instance 

FROM order_items AS oi
JOIN orders AS o ON oi.order_id = o.order_id
LEFT JOIN order_reviews AS r ON o.order_id = r.order_id
LEFT JOIN products AS p ON oi.product_id = p.product_id
LEFT JOIN cat_translation AS ct ON ct.product_category_name = p.product_category_name
LEFT JOIN categories AS cat ON cat.subcategory = ct.product_category_name_english
LEFT JOIN customers AS c ON c.customer_id = o.customer_id
LEFT JOIN sellers AS s ON s.seller_id = oi.seller_id
LEFT JOIN customer_seller_revenue AS csr ON csr.customer_id = o.customer_id AND csr.seller_id = s.seller_id;
