create database TravelOnTheGo;
use TravelOnTheGo;

# 1
create table PASSENGER
(
    Passenger_name   varchar(50),
    Category         varchar(50),
    Gender           varchar(10),
    Boarding_City    varchar(50),
    Destination_City varchar(50),
    Distance         int,
    Bus_Type         varchar(20)
);

create table PRICE
(
    Bus_Type varchar(20),
    Distance int,
    Price    int
);

-- # 2
insert into PASSENGER
VALUES ('Sejal', 'AC', 'F', 'Bengaluru', 'Chennai', 350, 'Sleeper'),
       ('Anmol', 'Non-AC', 'M', 'Mumbai', 'Hyderabad', 700, 'Sitting'),
       ('Pallavi', 'AC', 'F', 'Panaji', 'Bengaluru', 600, 'Sleeper'),
       ('Khusboo', 'AC', 'F', 'Chennai', 'Mumbai', 1500, 'Sleeper'),
       ('Udit', 'Non-AC', 'M', 'Trivandrum', 'panaji', 1000, 'Sleeper'),
       ('Ankur', 'AC', 'M', 'Nagpur', 'Hyderabad', 500, 'Sitting'),
       ('Hemant', 'Non-AC', 'M', 'panaji', 'Mumbai', 700, 'Sleeper'),
       ('Manish', 'Non-AC', 'M', 'Hyderabad', 'Bengaluru', 500, 'Sitting'),
       ('Piyush', 'AC', 'M', 'Pune', 'Nagpur', 700, 'Sitting');

insert into PRICE
VALUES ('Sleeper', 350, 770),
       ('Sleeper', 500, 1100),
       ('Sleeper', 600, 1320),
       ('Sleeper', 700, 1540),
       ('Sleeper', 1000, 2200),
       ('Sleeper', 1200, 2640),
       ('Sleeper', 1500, 2700),
       ('Sitting', 500, 620),
       ('Sitting', 600, 744),
       ('Sitting', 700, 868),
       ('Sitting', 1000, 1240),
       ('Sitting', 1200, 1488),
       ('Sitting', 1500, 1860);


-- # 3
select count(Passenger_name) as count, Gender
from PASSENGER
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
       Bus_Type,
       (select Price
        from PRICE
        where PRICE.Bus_Type = PASSENGER.Bus_Type
          and PRICE.Distance = PASSENGER.Distance) as price
from PASSENGER;

-- # 7
select Passenger_name,
       (select Price
        from PRICE
        where PRICE.Bus_Type = PASSENGER.Bus_Type
          and PRICE.Distance = PASSENGER.Distance) as price
from PASSENGER
where Distance = 1000;

-- # 8
select (select Price
        from PRICE
        where PRICE.Distance = PASSENGER.Distance
          and Price.Bus_Type = 'Sleeper') as sleeper_price,
       (select Price
        from PRICE
        where PRICE.Distance = PASSENGER.Distance
          and Price.Bus_Type = 'Sitting') as sitting_price
from PASSENGER
where Passenger_name = 'Pallavi';


-- # 9
select distinct Distance as unique_distances
from PASSENGER
order by Distance desc;

-- # 10
select Passenger_name,
       Distance / (select sum(Distance) from PASSENGER) * 100 as percentage_distance
from PASSENGER;

-- # 11
select Distance,
       Price,
       CASE
           when Price > 1000 then 'Expensive'
           when Price < 1000 and Price > 500 then 'Average Cost'
           else 'Cheap' end
from PRICE;