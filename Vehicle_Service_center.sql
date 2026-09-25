create table Customers(
customer_id int primary key auto_increment,
customer_name varchar(20),
phone varchar(20),
city varchar(20)
);
insert into Customers(customer_name,phone,city) values
('Rahul','9876543210','Chennai'),
('Priya','9876543211','Bangalore'),
('Arun','9876543212','Hyderabad'),
('Sneha','9876543213','Coimbatore'),
('Karthik','9876543214','Mumbai');

create table vehicles(
vehicle_id int primary key auto_increment,
    customer_id int,
    vehicle_number varchar(20),
    vehicle_model varchar(30),
    vehicle_type varchar(30),
    foreign key(customer_id)
    references Customers(customer_id)
    );
insert into vehicles(customer_id,vehicle_number,vehicle_model,vehicle_type) 
values
(1,'TN10AB1234','Hyundai i20','Car'),
(2,'KA05XY5678','Honda City','Car'),
(3,'TS08PQ4321','Royal Enfield','Bike'),
(4,'TN22KL9090','Maruti Swift','Car'),
(5,'MH12AA1111','TVS Apache','Bike');

create table mechanics(
mechanic_id int primary key auto_increment,
mechanic_name varchar(20),
specialization varchar(20),
experience int
);
insert into mechanics(mechanic_name,specialization,experience)
values
('Ramesh','Engine',10),
('Suresh','Electrical',8),
('Mahesh','General Service',6),
('Ganesh','Painting',12);
 
 create table service_records (
    service_id int primary key auto_increment,
    vehicle_id int,
    mechanic_id int,
    service_type varchar(50),
    service_date date,
    cost decimal(10,2),
    foreign key(vehicle_id)
    references Vehicles(vehicle_id),

    foreign key(mechanic_id)
    references Mechanics(mechanic_id)
);
insert into service_records(vehicle_id,mechanic_id,service_type,service_date,cost)
values
(1,1,'Engine Repair','2026-07-10',8000),
(1,2,'Electrical Repair','2026-07-20',3000),
(2,3,'General Service','2026-07-21',2500),
(3,1,'Engine Repair','2026-07-15',5000),
(4,3,'General Service','2026-07-18',2200),
(5,2,'Electrical Repair','2026-06-30',1800),
(2,4,'Painting','2026-07-25',7000),
(3,3,'General Service','2026-07-27',2000);

create table Bills (
    bill_id int primary key auto_increment,
    service_id int,
    total_amount decimal(10,2),
    payment_status varchar(20),

    foreign key(service_id)
    references Service_Records(service_id)
);


insert into Bills(service_id,total_amount,payment_status)
values
(1,8000,'Paid'),
(2,3000,'Paid'),
(3,2500,'Pending'),
(4,5000,'Paid'),
(5,2200,'Paid'),
(6,1800,'Pending'),
(7,7000,'Paid'),
(8,2000,'Pending');

-- Query 1

SELECT
    vehicle_number,
    vehicle_model,
    service_type,
    service_date
FROM Vehicles
JOIN Service_Records
ON Vehicles.vehicle_id = Service_Records.vehicle_id
WHERE service_date = CURDATE();

-- Query 2

SELECT
mechanic_name,
COUNT(service_id) AS Total_Services
FROM Mechanics
JOIN Service_Records
ON Mechanics.mechanic_id=Service_Records.mechanic_id
GROUP BY mechanic_name
ORDER BY Total_Services DESC
LIMIT 1;

-- Query 3

SELECT
customer_name,
SUM(total_amount) AS Total_Bill
FROM Customers
JOIN Vehicles
ON Customers.customer_id=Vehicles.customer_id
JOIN Service_Records
ON Vehicles.vehicle_id=Service_Records.vehicle_id
JOIN Bills
ON Service_Records.service_id=Bills.service_id
GROUP BY customer_name;

-- Query 4

SELECT
vehicle_number,
vehicle_model
FROM Vehicles
WHERE vehicle_id NOT IN
(
SELECT vehicle_id
FROM Service_Records
WHERE service_date>=DATE_SUB(CURDATE(),INTERVAL 1 YEAR)
);


-- Query 5 

SELECT
vehicle_number,
service_type,
service_date,
cost
FROM Vehicles
JOIN Service_Records
ON Vehicles.vehicle_id=Service_Records.vehicle_id
WHERE vehicle_number='TN10AB1234'
ORDER BY service_date;


-- Query 6

SELECT
service_type,
COUNT(*) AS Total
FROM Service_Records
GROUP BY service_type;

-- Query 7

SELECT
customer_name,
COUNT(service_id) AS Visits
FROM Customers
JOIN Vehicles
ON Customers.customer_id=Vehicles.customer_id
JOIN Service_Records
ON Vehicles.vehicle_id=Service_Records.vehicle_id
GROUP BY customer_name
HAVING COUNT(service_id)>3;

-- Query 8

SELECT
    customer_name,
    vehicle_number,
    total_amount
FROM Customers
JOIN Vehicles
ON Customers.customer_id = Vehicles.customer_id
JOIN Service_Records
ON Vehicles.vehicle_id = Service_Records.vehicle_id
JOIN Bills
ON Service_Records.service_id = Bills.service_id
WHERE payment_status = 'Pending';

-- Query no 9

SELECT
    service_type,
    COUNT(*) AS Frequency
FROM Service_Records
GROUP BY service_type
ORDER BY Frequency DESC
LIMIT 1;

-- Query no 10

SELECT
    MONTH(service_date) AS Month,
    SUM(total_amount) AS Revenue
FROM Service_Records
JOIN Bills
ON Service_Records.service_id = Bills.service_id
GROUP BY MONTH(service_date);

-- Query no 11

SELECT *
FROM Bills
ORDER BY total_amount DESC
LIMIT 1;

-- Query no 12

SELECT
    mechanic_name,
    SUM(total_amount) AS Revenue
FROM Mechanics
JOIN Service_Records
ON Mechanics.mechanic_id = Service_Records.mechanic_id
JOIN Bills
ON Service_Records.service_id = Bills.service_id
GROUP BY mechanic_name
ORDER BY Revenue DESC;

-- Query no 13

SELECT
    customer_name,
    COUNT(vehicle_id) AS Vehicles
FROM Customers
JOIN Vehicles
ON Customers.customer_id = Vehicles.customer_id
GROUP BY customer_name
HAVING COUNT(vehicle_id) > 1;

-- Query no 14

SELECT
    AVG(cost) AS Average_Cost
FROM Service_Records;

-- Query no 15

SELECT *
FROM Mechanics
ORDER BY experience DESC
LIMIT 1;

-- Query no 16

SELECT *
FROM Service_Records
WHERE service_type = 'Engine Repair';

-- Query no 17

SELECT *
FROM Customers
WHERE city = 'Chennai';

-- Query no 18

SELECT
    mechanic_name,
    service_type,
    service_date
FROM Mechanics
JOIN Service_Records
ON Mechanics.mechanic_id = Service_Records.mechanic_id
WHERE mechanic_name = 'Ramesh';

-- Query no 19

SELECT
    bill_id,
    customer_name,
    vehicle_number,
    service_type,
    service_date,
    total_amount
FROM Bills
JOIN Service_Records
ON Bills.service_id = Service_Records.service_id
JOIN Vehicles
ON Service_Records.vehicle_id = Vehicles.vehicle_id
JOIN Customers
ON Vehicles.customer_id = Customers.customer_id
WHERE payment_status = 'Pending';

-- Query no 20

SELECT
    mechanic_name,
    COUNT(service_id) AS Total_Services,
    RANK() OVER(ORDER BY COUNT(service_id) DESC) AS Service_Rank
FROM Mechanics
LEFT JOIN Service_Records
ON Mechanics.mechanic_id = Service_Records.mechanic_id
GROUP BY mechanic_name;