-- ===============================
-- SCHEMA: SQL Retail Analytics
-- ===============================

-- Drop tables if they already exist (to avoid errors)
DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS stores;
DROP TABLE IF EXISTS products;

-- ===============================
-- CUSTOMERS TABLE
-- ===============================
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50)
);

-- ===============================
-- STORES TABLE
-- ===============================
CREATE TABLE stores (
    store_id INT PRIMARY KEY,
    store_name VARCHAR(50)
);

-- ===============================
-- PRODUCTS TABLE
-- ===============================
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    category VARCHAR(50)
);

-- ===============================
-- SALES TABLE (FACT TABLE)
-- ===============================
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    store_id INT,
    product_id INT,
    sale_date DATE,
    amount INT,
    quantity INT,
    discount INT,

    -- Foreign Keys
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (store_id) REFERENCES stores(store_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
