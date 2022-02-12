drop database if exists TravelOnTheGoNormal;
create database TravelOnTheGoNormal;
use TravelOnTheGoNormal;

-- # 1
create table PRICE
(
    id       int primary key,
    Bus_Type varchar(20),
    Distance int,
    Price    int
);
create table PASSENGER
(
    Passenger_name   varchar(50),
    Category         varchar(50),
    Gender           varchar(10),
    Boarding_City    varchar(50),
    Destination_City varchar(50),
    price_id         int,
    foreign key (price_id) references PRICE (id)
);

-- # 2
insert into PRICE
VALUES (1, 'Sleeper', 350, 770),
       (2, 'Sleeper', 500, 1100),
       (3, 'Sleeper', 600, 1320),
       (4, 'Sleeper', 700, 1540),
       (5, 'Sleeper', 1000, 2200),
       (6, 'Sleeper', 1200, 2640),
       (7, 'Sleeper', 1500, 2700),
       (8, 'Sitting', 500, 620),
       (9, 'Sitting', 600, 744),
       (10, 'Sitting', 700, 868),
       (11, 'Sitting', 1000, 1240),
       (12, 'Sitting', 1200, 1488),
       (13, 'Sitting', 1500, 1860);

insert into PASSENGER
VALUES ('Sejal', 'AC', 'F', 'Bengaluru', 'Chennai', 1),
       ('Anmol', 'Non-AC', 'M', 'Mumbai', 'Hyderabad', 10),
       ('Pallavi', 'AC', 'F', 'Panaji', 'Bengaluru', 3),
       ('Khusboo', 'AC', 'F', 'Chennai', 'Mumbai', 7),
       ('Udit', 'Non-AC', 'M', 'Trivandrum', 'panaji', 5),
       ('Ankur', 'AC', 'M', 'Nagpur', 'Hyderabad', 8),
       ('Hemant', 'Non-AC', 'M', 'panaji', 'Mumbai', 4),
       ('Manish', 'Non-AC', 'M', 'Hyderabad', 'Bengaluru', 8),
       ('Piyush', 'AC', 'M', 'Pune', 'Nagpur', 10);

-- # 3
select count(Passenger_name) as count, Gender
from PASSENGER
         inner join PRICE P on PASSENGER.price_id = P.id
where Distance >= 600
group by Gender;

-- # 4
select min(Price)
from PRICE
where Bus_Type = 'Sleeper';

-- # 5
select Passenger_name
from PASSENGER
where Passenger_name like 'S%';

-- # 6
select Passenger_name,
       Boarding_City,
       Destination_City,
       Price as price
from PASSENGER
         inner join PRICE P on PASSENGER.price_id = P.id;

-- # 7
select Passenger_name,
       Price as price
from PASSENGER
         inner join PRICE P on PASSENGER.price_id = P.id
where Distance = 1000;

-- # 8
select (select Price
        from PRICE
        where PRICE.Distance = P.Distance
          and PRICE.Bus_Type = 'Sleeper') as sleeper_price,
       (select Price
        from PRICE
        where PRICE.Distance = P.Distance
          and PRICE.Bus_Type = 'Sitting') as sitting_price
from PASSENGER
         inner join PRICE P on PASSENGER.price_id = P.id
where Passenger_name = 'Pallavi';


-- # 9
select distinct Distance as unique_distances
from PASSENGER
         left join PRICE P on PASSENGER.price_id = P.id
order by Distance desc;

-- # 10
select PASSENGER.Passenger_name,
       PRICE.Distance / (select sum(PRICE.Distance)
                         from PASSENGER
                                  inner join PRICE on PASSENGER.price_id = PRICE.id) * 100 as percentage_distance
from PASSENGER
         inner join PRICE on PASSENGER.price_id = PRICE.id;

-- # 11
select Distance,
       Price,
       CASE
           when Price > 1000 then 'Expensive'
           when Price < 1000 and Price > 500 then 'Average Cost'
           else 'Cheap' end
from PRICE;