-- ===============================
-- DATA GENERATION: SQL Retail Analytics
-- ===============================

-- ===============================
-- INSERT CUSTOMERS (50 rows)
-- ===============================
INSERT INTO customers (customer_id, customer_name)
SELECT 
    t.n,
    CONCAT('Cust_', t.n)
FROM (
    SELECT @row := @row + 1 AS n
    FROM 
        (SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 
         UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) a,
        (SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4) b,
        (SELECT @row := 0) r
) t
WHERE t.n <= 50;


-- ===============================
-- INSERT STORES
-- ===============================
INSERT INTO stores (store_id, store_name) VALUES
(1, 'CMR'),
(2, 'SR'),
(3, 'Lucky');


-- ===============================
-- INSERT PRODUCTS
-- ===============================
INSERT INTO products (product_id, category) VALUES
(1, 'Electronics'),
(2, 'Fashion'),
(3, 'Grocery'),
(4, 'Home');


-- ===============================
-- INSERT SALES (1000 rows)
-- ===============================
INSERT INTO sales
SELECT 
    t.n AS sale_id,
    MOD(t.n, 50) + 1 AS customer_id,
    MOD(t.n, 3) + 1 AS store_id,
    MOD(t.n, 4) + 1 AS product_id,
    
    DATE_ADD('2025-01-01', INTERVAL MOD(t.n, 90) DAY) AS sale_date,
    
    ROUND(RAND() * 9900 + 100) AS amount,
    
    MOD(t.n, 5) + 1 AS quantity,
    
    CASE 
        WHEN MOD(t.n, 4) = 0 THEN NULL
        ELSE ROUND(RAND() * 490 + 10)
    END AS discount

FROM (
    SELECT @row2 := @row2 + 1 AS n
    FROM 
        (SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 
         UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) a,
        (SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 
         UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) b,
        (SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 
         UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) c,
        (SELECT @row2 := 0) r
) t
WHERE t.n <= 1000;
