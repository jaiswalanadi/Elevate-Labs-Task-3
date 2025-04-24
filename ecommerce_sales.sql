CREATE TABLE ecommerce_sales (
  ordernumber INT,
  quantityordered INT,
  priceeach FLOAT,
  orderlinenumber INT,
  sales FLOAT,
  orderdate VARCHAR(255),
  status VARCHAR(255),
  qtr_id INT,
  month_id INT,
  year_id INT,
  productline VARCHAR(255),
  msrp INT,
  productcode VARCHAR(255),
  customername VARCHAR(255),
  phone VARCHAR(255),
  addressline1 VARCHAR(255),
  addressline2 VARCHAR(255),
  city VARCHAR(255),
  state VARCHAR(255),
  postalcode VARCHAR(255),
  country VARCHAR(255),
  territory VARCHAR(255),
  contactlastname VARCHAR(255),
  contactfirstname VARCHAR(255),
  dealsize VARCHAR(255)
);

-- 1. Top 10 highest sales orders
SELECT ordernumber, sales, orderdate, customername
FROM ecommerce_sales
ORDER BY sales DESC
LIMIT 10;

-- 2. Total sales by year
SELECT year_id, SUM(sales) AS total_sales
FROM ecommerce_sales
GROUP BY year_id
ORDER BY year_id;

-- 3. Average price and quantity by productline
SELECT productline, AVG(priceeach) AS avg_price, AVG(quantityordered) AS avg_qty
FROM ecommerce_sales
GROUP BY productline;

-- 4. Customers with sales above average
SELECT customername, SUM(sales) AS total_sales
FROM ecommerce_sales
GROUP BY customername
HAVING SUM(sales) > (
    SELECT AVG(sales) FROM ecommerce_sales
);

-- 5. View for monthly sales
CREATE VIEW monthly_sales AS
SELECT month_id, year_id, SUM(sales) AS total_sales
FROM ecommerce_sales
GROUP BY year_id, month_id;

-- 6. Index for optimization
CREATE INDEX idx_orderdate ON ecommerce_sales(orderdate);
