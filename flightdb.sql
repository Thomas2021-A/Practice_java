create database flightdb;
use flightdb;

create table tbl_users
(
    user_id bigint primary key auto_increment,
    email varchar(100) not null unique,
    password varchar(255) not null check(length(password)>8),
    role varchar(50) not null check(role in ('user','admin'))
)auto_increment=1001;



create table tbl_flights
(
    flight_id bigint primary key auto_increment,
    flight_number varchar(50) not null unique,
    source varchar(50) not null,
    destination varchar(50) not null,
    departure_time varchar(50) not null,
    arrival_time varchar(50) not null,
    capacity int check(capacity>0),
    price_per_seat double check(price_per_seat>0)
)auto_increment=5001;


create table tbl_bookings
(
    booking_id bigint primary key auto_increment,
    booking_date date not null,
    journey_date date not null,
    seats int check(seats>0),
    total_price double check(total_price>0),
    status varchar(50) check(status in ('confirmed','cancelled')),
    flight_id bigint,
    user_id bigint
)auto_increment=90001;

create table tbl_tickets
(
    pnr_no bigint primary key auto_increment,
    passenger_name varchar(50) not null,
    gender varchar(50) check(gender in ('male','female','other')),
    age int check(age between 0 and 120),
    journey_date date not null,
    seat_no varchar(20) not null,
    booking_id bigint,
    status varchar(50) check(status in ('confirmed','cancelled'))
)auto_increment=100001;


desc tbl_users;
desc tbl_flights;

-- foreign keys and extra constraints using alter
alter table tbl_bookings
add constraint fk_booking_flight foreign key(flight_id) references tbl_flights(flight_id),
add constraint fk_booking_user foreign key(user_id) references tbl_users(user_id),
add constraint chk_journey_date check(journey_date>=booking_date);


alter table tbl_tickets
add constraint fk_ticket_booking foreign key(booking_id) references tbl_bookings(booking_id);



insert into tbl_users (email, password, role) values
('admin@flightapp.com', 'Admin@2026', 'admin'),
('ravi.kumar@example.com', 'Ravi@2026', 'user'),
('meera.nair@example.com', 'Meera@2026', 'user'),
('arjun.rao@example.com', 'Arjun@2026', 'user'),
('sneha.iyer@example.com', 'Sneha@2026', 'user'),
('kiran.das@example.com', 'Kiran@2026', 'user');


insert into tbl_flights
(flight_number, source, destination, departure_time, arrival_time, capacity, price_per_seat) values
('AI101', 'Delhi', 'Mumbai', '06:00', '08:10', 180, 4500),
('6E202', 'Mumbai', 'Bangalore', '09:30', '11:15', 150, 3800),
('SG303', 'Bangalore', 'Chennai', '14:00', '15:00', 120, 2500),
('UK404', 'Delhi', 'Kolkata', '18:45', '21:05', 160, 5200),
('AI505', 'Mumbai', 'Hyderabad', '07:15', '08:45', 140, 6100),
('6E606', 'Chennai', 'Delhi', '20:00', '22:50', 170, 5800);


insert into tbl_bookings
(booking_date, journey_date, seats, total_price, status, flight_id, user_id) values
('2026-10-20', '2026-11-15', 2, 9000, 'confirmed', 5001, 1002),
('2026-10-22', '2026-11-20', 1, 3800, 'confirmed', 5002, 1003),
('2026-10-25', '2026-12-01', 1, 2500, 'cancelled', 5003, 1002),
('2026-10-26', '2026-11-25', 3, 15600, 'confirmed', 5004, 1004),
('2026-10-27', '2026-12-10', 2, 12200, 'confirmed', 5005, 1005),
('2026-10-28', '2026-11-18', 1, 4500, 'confirmed', 5001, 1003);



insert into tbl_tickets
(passenger_name, gender, age, journey_date, seat_no, booking_id, status) values
('Ravi Kumar', 'male', 34, '2026-11-15', '12A', 90001, 'confirmed'),
('Anita Kumar', 'female', 32, '2026-11-15', '12B', 90001, 'confirmed'),
('Meera Nair', 'female', 28, '2026-11-20', '5C', 90002, 'confirmed'),
('Ravi Kumar', 'male', 34, '2026-12-01', '8D', 90003, 'cancelled'),
('Arjun Rao', 'male', 41, '2026-11-25', '3A', 90004, 'confirmed'),
('Kavya Rao', 'female', 38, '2026-11-25', '3B', 90004, 'confirmed'),
('Rohan Rao', 'male', 12, '2026-11-25', '3C', 90004, 'confirmed'),
('Sneha Iyer', 'female', 29, '2026-12-10', '14F', 90005, 'confirmed'),
('Vikram Iyer', 'male', 31, '2026-12-10', '14E', 90005, 'confirmed'),
('Meera Nair', 'female', 28, '2026-11-18', '9A', 90006, 'confirmed');


select * from tbl_users;
select * from tbl_flights;
select * from tbl_bookings;
select * from tbl_tickets;
 