CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(30)
);

INSERT INTO Customers (customer_id, customer_name, city) VALUES
(1, 'Arun', 'Chennai'),
(2, 'Priya', 'Bangalore'),
(3, 'Karthik', 'Coimbatore'),
(4, 'Janani', 'Chennai'),
(5, 'Rahul', 'Madurai'),
(6, 'Meena', 'Salem'),
(7, 'Sanjay', 'Chennai'),
(8, 'Divya', 'Trichy');


CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    amount DECIMAL(10,2),
    order_date DATE,
    FOREIGN KEY(customer_id) REFERENCES Customers(customer_id)
);

INSERT INTO Orders (order_id, customer_id, amount, order_date) VALUES
(101, 1, 2500, '2026-01-10'),
(102, 1, 3000, '2026-02-15'),
(103, 1, 1800, '2026-03-20'),
(104, 1, 3500, '2026-04-05'),

(105, 2, 4000, '2026-01-12'),
(106, 2, 2500, '2026-02-18'),

(107, 3, 1500, '2026-01-20'),
(108, 3, 2200, '2026-03-10'),

(109, 4, 5000, '2026-01-25'),
(110, 4, 3500, '2026-03-15'),

(111, 5, 1200, '2026-02-05'),

(112, 6, 3000, '2026-01-30'),
(113, 6, 2800, '2026-03-25'),

(114, 7, 6000, '2026-02-10'),
(115, 7, 4500, '2026-04-12');

-- Query 16

SELECT customer_id, SUM(amount) AS total_amount
FROM Orders
GROUP BY customer_id;

-- Query 17

SELECT customer_id, COUNT(order_id) AS total_orders
FROM Orders
GROUP BY customer_id
HAVING COUNT(order_id) > 3;

-- Query 18

SELECT customer_id, AVG(amount) AS average_order_amount
FROM Orders
GROUP BY customer_id;

-- Query 19

SELECT customer_id, MAX(amount) AS highest_order_amount
FROM Orders
GROUP BY customer_id;

-- Query 20

SELECT customer_id, SUM(amount) AS total_purchase_amount
FROM Orders
GROUP BY customer_id
ORDER BY total_purchase_amount ASC;

-- Query 21

SELECT customer_id, SUM(amount) AS total_purchase_amount
FROM Orders
GROUP BY customer_id
HAVING SUM(amount) > 10000;

-- Query 22

SELECT c.customer_name, COUNT(o.order_id) AS total_orders
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

-- Query 23

SELECT c.customer_name, SUM(o.amount) AS total_purchase_amount
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_purchase_amount DESC
LIMIT 1;

-- Query 24

SELECT c.customer_name, COUNT(o.order_id) AS total_orders
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_orders DESC
LIMIT 1;

-- Query 25

SELECT c.customer_name, AVG(o.amount) AS average_order_amount
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING AVG(o.amount) > 2000;

-- Query 26

SELECT c.customer_name, SUM(o.amount) AS total_purchase_amount
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_purchase_amount DESC
LIMIT 5;

-- Query 27

SELECT customer_id, MIN(amount) AS minimum_order_amount
FROM Orders
GROUP BY customer_id;

-- Query 28

SELECT c.customer_name, SUM(o.amount) AS total_purchase_amount
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.amount) > 5000;

-- Query 29

SELECT c.customer_name,
       COUNT(o.order_id) AS total_orders,
       SUM(o.amount) AS total_purchase_amount
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

-- Query 30

SELECT c.customer_name,
       COUNT(o.order_id) AS total_orders,
       SUM(o.amount) AS total_purchase_amount
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) > 2
   AND SUM(o.amount) > 8000;