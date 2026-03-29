-- ===============================
-- DATA CLEANING: SQL Retail Analytics
-- ===============================

-- ===============================
-- 1. CHECK NULL VALUES
-- ===============================

-- Count NULL discounts
SELECT COUNT(*) AS null_discounts
FROM sales
WHERE discount IS NULL;

-- Count NULL quantity
SELECT COUNT(*) AS null_quantity
FROM sales
WHERE quantity IS NULL;

-- Count NULL amount
SELECT COUNT(*) AS null_amount
FROM sales
WHERE amount IS NULL;


-- ===============================
-- 2. HANDLE NULL VALUES (VIEW LEVEL)
-- ===============================

-- Replace NULL discount with 0 (view purpose)
SELECT 
    sale_id,
    IFNULL(discount, 0) AS discount_cleaned
FROM sales;

-- Replace NULL quantity with 1
SELECT 
    sale_id,
    IFNULL(quantity, 1) AS quantity_cleaned
FROM sales;


-- ===============================
-- 3. DERIVED METRICS
-- ===============================

-- Calculate net revenue
SELECT 
    sale_id,
    amount,
    discount,
    amount - IFNULL(discount, 0) AS net_revenue
FROM sales;


-- ===============================
-- 4. DATA QUALITY CHECK
-- ===============================

-- Percentage of missing discount values
SELECT 
    COUNT(CASE WHEN discount IS NULL THEN 1 END) * 100.0 / COUNT(*) 
    AS pct_missing_discount
FROM sales;

-- Flag rows with missing values
SELECT 
    *,
    CASE 
        WHEN amount IS NULL OR discount IS NULL THEN 'Missing'
        ELSE 'Clean'
    END AS data_status
FROM sales;


-- ===============================
-- 5. CREATE CLEANED DATASET (VIEW)
-- ===============================

DROP VIEW IF EXISTS sales_cleaned;

CREATE VIEW sales_cleaned AS
SELECT 
    s.sale_id,
    s.customer_id,
    c.customer_name,
    s.store_id,
    st.store_name,
    s.product_id,
    p.category,
    s.sale_date,

    -- Cleaned fields
    IFNULL(s.amount, 0) AS amount,
    IFNULL(s.quantity, 1) AS quantity,
    IFNULL(s.discount, 0) AS discount,

    -- Derived column
    IFNULL(s.amount, 0) - IFNULL(s.discount, 0) AS net_revenue,

    -- Data quality flag
    CASE 
        WHEN s.amount IS NULL OR s.discount IS NULL THEN 'Missing'
        ELSE 'Clean'
    END AS data_status

FROM sales s
JOIN customers c ON s.customer_id = c.customer_id
JOIN stores st ON s.store_id = st.store_id
JOIN products p ON s.product_id = p.product_id;


-- ===============================
-- 6. VALIDATION CHECKS
-- ===============================

-- Check cleaned dataset
SELECT COUNT(*) AS total_rows FROM sales_cleaned;

-- Ensure no NULL discounts remain
SELECT COUNT(*) AS remaining_null_discount
FROM sales_cleaned
WHERE discount IS NULL;

-- Sample data preview
SELECT *
FROM sales_cleaned
LIMIT 10;
