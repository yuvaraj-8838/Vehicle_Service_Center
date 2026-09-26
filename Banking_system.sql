create table customers(
customer_id int primary key auto_increment,
name varchar(20),
city varchar(20));

insert into customers(name,city) 
values 
('Janani','Chennai'),
('Arun','Coimbatore'),
('Priya','Madurai'),
('Karthik','Salem');

create table accounts(
account_id int primary key auto_increment,
customer_id int,
account_type varchar(20),
balance decimal(10,2),
foreign key (customer_id) references customers(customer_id));

INSERT INTO accounts (customer_id, account_type, balance) VALUES
(1,'Savings',50000),
(1,'Current',20000),
(2,'Savings',30000),
(3,'Savings',15000),
(4,'Current',40000);

-- Query no 1

SELECT *
FROM accounts
WHERE balance > 20000;

-- Query no 2

SELECT *
FROM customers
WHERE city = 'Chennai';

-- Query no 3

SELECT *
FROM accounts
WHERE balance BETWEEN 20000 AND 50000;

-- Query no 4 

SELECT *
FROM customers
WHERE name LIKE 'J%';

-- Query no 5

SELECT *
FROM accounts
WHERE account_type = 'Savings'
   OR account_type = 'Current';
   
-- Query no 6 

SELECT *
FROM accounts
WHERE account_type <> 'Savings';

-- Query no 7

SELECT *
FROM customers
WHERE name LIKE '%a%';

-- Query no 8

select *
from accounts
where balance <= '30000';

-- Query no 9

select *
from customers 
where city <> 'madurai';

-- Query no 10

select *
from accounts 
where balance not between 10000 and 40000;

-- Query no 11

select *
from customers 
where name like '%i';

-- Query no 12

select * 
from accounts
where balance = '50000';

-- Query no 13 

select * 
from customers
Where city IN ('chennai', 'salem');

select * 
from customers 
where city = 'chennai'
or city = 'salem';

-- Query no 14

select * 
from accounts 
where balance > '10000' and balance < '40000';

-- Query no 15 

select * 
from accounts
where account_type <> 'current';

-- Query no 16 

select * 
from accounts
order by balance desc;

-- Query no 17 

select * 
from customers 
order by name asc;

-- Query no 18

select * 
from accounts
order by account_type asc, balance desc;

-- Query no 19

select sum(balance) as total_balance
from accounts;

-- Query no 20

select avg(balance) as average_balance
from accounts;

-- Query no 21 

select max(balance) as maximum_balance
from accounts;

-- Query no 22

select min(balance) as minimum_balance
from accounts;

-- Query no 23 

select count(customer_id) as total_cutomers
from customers;

-- Query no 24

select account_type, sum(balance) as total_balance
from accounts
group by account_type;

-- Query no 25

select account_type, avg(balance) as average_balance
from accounts
group by account_type;

-- Query no 26

select account_type, avg(balance) as average_balance
from accounts
group by account_type
having average_balance > 20000;

-- Query no 27

select count(*) as total_accounts
from accounts
group by customer_id;

-- Query no 28

SELECT customer_id, COUNT(*) AS account_count
FROM accounts
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- Query no 29 

SELECT customers.name, accounts.balance
FROM customers
INNER JOIN accounts
ON customers.customer_id = accounts.customer_id;

-- Query no 30

SELECT customers.name, accounts.account_id, accounts.account_type, accounts.balance
FROM customers
LEFT JOIN accounts
ON customers.customer_id = accounts.customer_id;

-- Query no 31

SELECT accounts.account_id,
       accounts.account_type,
       accounts.balance,
       customers.name,
       customers.city
FROM accounts
INNER JOIN customers
ON accounts.customer_id = customers.customer_id;

-- Query no 32

SELECT customers.name, accounts.account_type
FROM customers
INNER JOIN accounts
ON customers.customer_id = accounts.customer_id
WHERE accounts.balance > 20000;

-- Query no 33

SELECT customers.name, SUM(accounts.balance) AS total_balance
FROM customers
INNER JOIN accounts
ON customers.customer_id = accounts.customer_id
GROUP BY customers.customer_id, customers.name;

-- Query no 34

SELECT customers.name, accounts.balance
FROM customers
INNER JOIN accounts
ON customers.customer_id = accounts.customer_id
ORDER BY accounts.balance ASC;

-- Query no 35

SELECT customers.city, COUNT(accounts.account_id) AS account_count
FROM customers
INNER JOIN accounts
ON customers.customer_id = accounts.customer_id
GROUP BY customers.city;

-- Query no 36

SELECT *
FROM accounts
WHERE balance > (
    SELECT AVG(balance)
    FROM accounts
);

-- Query no 37

SELECT *
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM accounts
);

-- Query no 38

SELECT *
FROM customers
WHERE customer_id NOT IN (
    SELECT customer_id
    FROM accounts
);

-- Query no 39

SELECT *
FROM accounts
WHERE balance = (
    SELECT MAX(balance)
    FROM accounts
);

-- Query no 40

SELECT customer_id, SUM(balance) AS total_balance
FROM accounts
GROUP BY customer_id
HAVING SUM(balance) > 40000;
