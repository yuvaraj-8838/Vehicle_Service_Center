create table hotels(
hotel_id int primary key auto_increment,
hotel_name varchar(50),
city varchar(50),
star_rating int
); drop schema sys;

insert into hotels(hotel_name,city,star_rating)
values 
('Grand Palace','Chennai',5),
('Royal Inn','Bangalore',4),
('Blue Moon','Hyderabad',3);
 
 create table rooms(
 room_id int primary key auto_increment,
    hotel_id int,
    room_number varchar(10),
    room_type varchar(20),
    price decimal(10,2),
    status varchar(20));
    
    insert into rooms(hotel_id,room_number,room_type,price,status)
    values
    (1,'101','Standard',2500,'Available'),
(1,'102','Deluxe',4000,'Occupied'),
(1,'103','Suite',7000,'Occupied'),
(2,'201','Standard',2200,'Available'),
(2,'202','Deluxe',3800,'Occupied'),
(3,'301','Standard',1800,'Available'),
(3,'302','Suite',6000,'Occupied');

create table guests(
  guest_id int primary key auto_increment,
    guest_name varchar(50),
    phone varchar(15),
    city varchar(30)
);

insert into guests(guest_name,phone,city)
values
('Rahul','9876543210','Chennai'),
('Priya','9876543211','Bangalore'),
('Arun','9876543212','Hyderabad'),
('Sneha','9876543213','Coimbatore'),
('Karthik','9876543214','Mumbai');

CREATE TABLE Bookings(
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    guest_id INT,
    room_id INT,
    check_in DATE,
    check_out DATE,
    booking_status VARCHAR(20),

    FOREIGN KEY(guest_id)
    REFERENCES Guests(guest_id),

    FOREIGN KEY(room_id)
    REFERENCES Rooms(room_id)
);

INSERT INTO Bookings(guest_id,room_id,check_in,check_out,booking_status)
VALUES
(1,2,'2026-07-25','2026-07-30','Completed'),
(2,3,'2026-07-28','2026-08-02','Active'),
(3,5,'2026-07-29','2026-08-01','Active'),
(4,7,'2026-07-20','2026-07-22','Completed'),
(1,1,'2026-08-05','2026-08-08','Booked'),
(5,4,'2026-07-31','2026-08-03','Cancelled');


CREATE TABLE Payments(
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT,
    amount DECIMAL(10,2),
    payment_status VARCHAR(20),

    FOREIGN KEY(booking_id)
    REFERENCES Bookings(booking_id)
);
INSERT INTO Payments(booking_id,amount,payment_status)
VALUES
(1,20000,'Paid'),
(2,35000,'Paid'),
(3,12000,'Pending'),
(4,15000,'Paid'),
(5,7500,'Pending'),
(6,0,'Refunded');

-- Query no 1

SELECT
    room_number,
    room_type,
    price,
    hotel_name
FROM Rooms
JOIN Hotels
ON Rooms.hotel_id = Hotels.hotel_id
WHERE status = 'Available';

-- Query no 2

SELECT
    guest_name,
    hotel_name,
    room_number,
    check_in,
    check_out
FROM Guests
JOIN Bookings
ON Guests.guest_id = Bookings.guest_id
JOIN Rooms
ON Bookings.room_id = Rooms.room_id
JOIN Hotels
ON Rooms.hotel_id = Hotels.hotel_id
WHERE CURDATE() BETWEEN check_in AND check_out
AND booking_status = 'Active';

-- Query no 3

SELECT
    SUM(amount) AS Total_Revenue
FROM Payments
WHERE payment_status = 'Paid';

-- Query no 4

SELECT
    booking_id,
    guest_name,
    hotel_name,
    check_in,
    check_out
FROM Bookings
JOIN Guests
ON Bookings.guest_id = Guests.guest_id
JOIN Rooms
ON Bookings.room_id = Rooms.room_id
JOIN Hotels
ON Rooms.hotel_id = Hotels.hotel_id
WHERE check_in BETWEEN '2026-07-25' AND '2026-07-31';

-- Query no 5

SELECT
    room_type,
    COUNT(*) AS Total_Bookings
FROM Rooms
JOIN Bookings
ON Rooms.room_id = Bookings.room_id
GROUP BY room_type
ORDER BY Total_Bookings DESC
LIMIT 1;

-- Query no 6

SELECT
    ROUND(
        (
            COUNT(CASE WHEN status = 'Occupied' THEN 1 END) * 100.0
            / COUNT(*)
        ), 2
    ) AS Occupancy_Rate
FROM Rooms;

-- Query no 7

SELECT
    booking_id,
    guest_name,
    hotel_name,
    room_number
FROM Bookings
JOIN Guests
ON Bookings.guest_id = Guests.guest_id
JOIN Rooms
ON Bookings.room_id = Rooms.room_id
JOIN Hotels
ON Rooms.hotel_id = Hotels.hotel_id
WHERE booking_status = 'Cancelled';

-- Query no 8

SELECT
    guest_name,
    COUNT(booking_id) AS Total_Bookings
FROM Guests
JOIN Bookings
ON Guests.guest_id = Bookings.guest_id
GROUP BY guest_name
HAVING COUNT(*) > 1;

-- Query no 9

SELECT
    AVG(price) AS Average_Room_Price
FROM Rooms;

-- Query no 10

SELECT
    hotel_name,
    COUNT(room_id) AS Total_Rooms
FROM Hotels
JOIN Rooms
ON Hotels.hotel_id = Rooms.hotel_id
GROUP BY hotel_name
HAVING COUNT(room_id) > 100;

-- Query no 11

SELECT
    g.guest_name,
    SUM(p.amount) AS Total_Spent
FROM Guests g
JOIN Bookings b
ON g.guest_id = b.guest_id
JOIN Payments p
ON b.booking_id = p.booking_id
GROUP BY g.guest_name
ORDER BY Total_Spent DESC
LIMIT 1;

-- Query no 12

SELECT
    h.hotel_name,
    SUM(p.amount) AS Revenue
FROM Hotels h
JOIN Rooms r
ON h.hotel_id = r.hotel_id
JOIN Bookings b
ON r.room_id = b.room_id
JOIN Payments p
ON b.booking_id = p.booking_id
WHERE p.payment_status = 'Paid'
GROUP BY h.hotel_name;

-- Query no 13

SELECT
    room_number,
    room_type,
    price
FROM Rooms
ORDER BY price DESC
LIMIT 1;

-- Query no 14

SELECT
    g.guest_name
FROM Guests g
LEFT JOIN Bookings b
ON g.guest_id = b.guest_id
WHERE b.booking_id IS NULL;

-- Query no 15

SELECT
    h.hotel_name,
    SUM(p.amount) AS Revenue,
    RANK() OVER (ORDER BY SUM(p.amount) DESC) AS Revenue_Rank
FROM Hotels h
JOIN Rooms r
ON h.hotel_id = r.hotel_id
JOIN Bookings b
ON r.room_id = b.room_id
JOIN Payments p
ON b.booking_id = p.booking_id
WHERE p.payment_status = 'Paid'
GROUP BY h.hotel_name;