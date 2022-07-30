-- 1.
SELECT MIN(order_date) AS 'plus_vieille'
FROM orders;

-- 2.
SELECT MAX(order_date) AS 'plus_recent'
FROM orders
WHERE ship_city <> 'Salt Lake City';

-- 3.
SELECT COUNT(quantity_per_unit) AS 'nombre'
FROM products;

-- 4.
SELECT COUNT(*) AS 'nombre'
FROM products
WHERE minimum_reorder_quantity IS NULL;

-- 5.
SELECT AVG(standard_cost) AS 'moyenne'
FROM products;

-- 6.
SELECT COUNT(*) AS 'nombre'
FROM orders
WHERE customer_id = 8;

-- 7.
SELECT SUM(standard_cost) AS 'somme'
FROM products
WHERE standard_cost < 10;

-- 8.
SELECT SUM(standard_cost) AS 'somme', AVG(standard_cost) AS 'moyenne'
FROM products;

-- 9.
SELECT COUNT(*) AS 'nombre'
FROM orders
WHERE order_date BETWEEN '2006-04-01' AND '2006-04-30';

-- 10.
SELECT SUM(standard_cost) AS 'somme'
FROM products
WHERE product_name LIKE '%mix%';

-- 11.
SELECT MIN(standard_cost) AS 'minimum'
FROM products
WHERE product_name LIKE '%a';

-- 12.
SELECT SUM(quantity) AS 'nombre'
FROM order_details;

-- 13.
SELECT COUNT(*) AS NbCommande
FROM orders o
INNER JOIN employees e ON o.employee_id = e.id
WHERE e.email_address = 'nancy@northwindtraders.com';

-- 14.
SELECT city, COUNT(*) AS nbEmploye
FROM employees
GROUP BY city;

-- 15.
SELECT e.first_name, e.last_name, COUNT(*) AS nbOrders
FROM orders o
INNER JOIN employees e ON o.employee_id = e.id
GROUP BY  e.first_name, e.last_name;

-- 16.
SELECT ship_city, MAX(shipping_fee)
FROM orders
GROUP BY ship_city;

-- 17. 
SELECT category, COUNT(*) AS nbProduits
FROM products
WHERE standard_cost <= 20
GROUP BY category;

-- 18. 
SELECT order_id, SUM(quantity) AS nbProduits
FROM order_details
GROUP BY order_id
HAVING nbProduits < 100;

-- 19.
SELECT c.first_name, c.last_name, SUM(quantity) AS nbProduits
FROM orders o 
INNER JOIN customers c ON o.customer_id = c.id
INNER JOIN order_details od ON od.order_id = o.id
GROUP BY c.first_name, c.last_name
ORDER BY nbProduits DESC;

-- 20.
SELECT order_id, SUM(quantity * unit_price) AS totalCommande
FROM order_details
GROUP by order_id;

-- 21. 
SELECT e.first_name, e.last_name, SUM(od.quantity * od.unit_price) AS totalCommande
FROM orders o
INNER JOIN employees e ON o.employee_id = e.id
INNER JOIN order_details od ON od.order_id = o.id
GROUP BY o.id
ORDER BY totalCommande DESC
LIMIT 1;

-- 22.
SELECT e.first_name, e.last_name, order_id, SUM(od.quantity * (od.unit_price- p.standard_cost)) AS profit
FROM order_details od
INNER JOIN products p ON od.product_id = p.id
INNER JOIN orders o ON od.order_id = o.id
INNER JOIN employees e ON o.employee_id = e.id
GROUP BY order_id
ORDER BY profit DESC
LIMIT 5;


--Alternative
SELECT e.first_name, e.last_name, order_id, SUM(od.quantity * p.unit_price) - SUM(od.quantity * p.standard_cost) AS profit
FROM order_details od
INNER JOIN products p ON od.product_id = p.id
INNER JOIN orders o ON od.order_id = o.id
INNER JOIN employees e ON o.employee_id = e.id
GROUP BY order_id
ORDER BY profit DESC
LIMIT 5;

-- 23.
SELECT c.first_name, c.last_name, COUNT(o.id) AS nbCommande
FROM customers c
INNER JOIN orders o ON o.customer_id = c.id
GROUP BY c.id
HAVING nbCommande >= 4;
