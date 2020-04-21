--Get all customers and their addresses.

SELECT *
FROM customers
    JOIN addresses ON customers.id = addresses.customer_id;

--Get all orders and their line items (orders, quantity and product).

SELECT *
FROM line_items
    JOIN orders ON line_items.order_id = orders.id
    JOIN products ON line_items.product_id = products.id;

--Which warehouses have cheetos?

SELECT products.description as "product_cheetos", warehouse.warehouse
from warehouse_product
    JOIN products ON products.id = warehouse_product.product_id
    JOIN warehouse ON warehouse.id = warehouse_product.warehouse_id
WHERE products.description = 'cheetos'
GROUP BY products.description, warehouse.warehouse;

--Which warehouses have diet pepsi?

SELECT products.description as "product_diet_pepsi", warehouse.warehouse
from warehouse_product
    JOIN products ON products.id = warehouse_product.product_id
    JOIN warehouse ON warehouse.id = warehouse_product.warehouse_id
WHERE products.description = 'diet pepsi'
GROUP BY products.description, warehouse.warehouse;

--Get the number of orders for each customer. NOTE: It is OK if those without orders are not included in results.

SELECT customers.first_name, customers.last_name, count(orders.address_id) as "number_of_orders"
FROM customers
    JOIN addresses ON addresses.customer_id = customers.id
    JOIN orders ON orders.address_id = addresses.id
GROUP BY customers.first_name, customers.last_name
ORDER BY "number_of_orders" DESC;

--How many customers do we have?

SELECT count(customers) as "number_of_customers"
FROM customers;

--How many products do we carry?

SELECT count(products) as "number_of_products"
FROM products;

--What is the total available on-hand quantity of diet pepsi?

SELECT SUM(warehouse_product.on_hand) as "on_hand_diet_pepsi"
from warehouse_product
    JOIN products ON products.id = warehouse_product.product_id
WHERE products.description = 'diet pepsi';

--How much was the total cost for each order?

SELECT (SUM(line_items.quantity * products.unit_price)) as "total_cost_per_order", line_items.order_id as "orders"
FROM line_items
    JOIN products ON products.id = line_items.product_id
    JOIN orders ON orders.id = line_items.order_id
GROUP BY line_items.order_id
ORDER BY line_items.order_id ASC;

--How much has each customer spent in total?



--How much has each customer spent in total? Customers who have spent $0 should still show up in the table. It should say 0, not NULL (research coalesce).