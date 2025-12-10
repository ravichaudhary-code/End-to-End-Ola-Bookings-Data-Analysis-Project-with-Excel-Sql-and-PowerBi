create database ola;
use ola;

CREATE TABLE booking (
    Date DATETIME,
    Time TIME,
    Booking_ID VARCHAR(20),
    Booking_Status VARCHAR(50),
    Customer_ID VARCHAR(20),
    Vehicle_Type VARCHAR(20),
    Pickup_Location VARCHAR(100),
    Drop_Location VARCHAR(100),
    V_TAT INT,
    C_TAT INT,
    Canceled_Rides_by_Customer VARCHAR(200),
    Canceled_Rides_by_Driver VARCHAR(200),
    Incomplete_Rides VARCHAR(10),
    Incomplete_Rides_Reason VARCHAR(200),
    Booking_Value INT,
    Payment_Method VARCHAR(50),
    Ride_Distance INT,
    Driver_Ratings FLOAT,
    Customer_Rating FLOAT
);

LOAD DATA LOCAL INFILE 'D:/Data Analytics project/oladata.csv'
INTO TABLE booking
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

select * from ola_booking;

#Analyzing ola data through Question

#1.Retrieve all successfull ola_booking
create view successfull_ola_booking as
select * from ola_booking
where booking_status = 'Success';

#1.retrive all successfull booking:
select * from successfull_ola_booking;

select count(*) from ola_booking
where booking_status = 'Success';

#2. Find the average ride distance for each vehicle:
create view R_d_f_e_v as
select Vehicle_Type, avg(Ride_Distance)
as asv_distance from ola_booking
group by Vehicle_Type;

#2. Find the average ride distance for each vehicle:
select * from R_d_f_e_v;

#3.Get the total number of rides cancelled by customers:
create view r_c_b_c as
select count(*) from ola_booking
where Booking_Status = 'Canceled by Customer';

#3.Get the total number of rides cancelled by customers:
select * from r_c_b_c;

#4.List the top 5 customers who booked the highest number of rides:
create view T_5_C as
select Customer_ID, count(Booking_ID) as total_rides
from ola_booking 
group by Customer_ID
order by total_rides desc limit 5;

#4.List the top 5 customers who booked the highest number of rides:
select * from T_5_C;

#5.Get the number of rides cancelled by driver due to personal and car related issues:
create view p_and_c_r_i as
select count(*) from ola_booking
where Canceled_Rides_by_Driver = 'Personal & Car related issue';

#5.Get the number of rides cancelled by driver due to personal and car related issues:
select * from  p_and_c_r_i;

#6.Find the maximum and minimum drivers ratings for Bike:
create view D_B_R as
select max(Driver_Ratings) as max_rating,
min(Driver_Ratings) as min_rating
from ola_booking where Vehicle_Type = 'Bike';

#6.Find the maximum and minimum drivers ratings for Bike:
select * from D_B_R;

CREATE TABLE clean_booking AS
SELECT DISTINCT * FROM booking;

DROP TABLE booking;

RENAME TABLE clean_booking TO ola_booking;

#7.Retrieve all rides where payment was made by UPI:
create view UPI_payment as
select * from ola_booking
where Payment_Method = 'UPI';

#7.Retrieve all rides where payment was made by UPI:
select * from UPI_payment;

#8.Find the average customer rating per vehicle type:
create view r_p_vehicle as
select Vehicle_Type , avg(Customer_Rating) as avg_customer_rating
from ola_booking
group by Vehicle_Type;

#8.Find the average customer rating per vehicle type:
select * from r_p_vehicle;

#9 Calculate total booking value of rides completed successfully:
create view rides_completed_successfully as
select sum(Booking_Value) as total_successfull_value
from ola_booking
where Booking_Status = 'Success';

#9 Calculate total booking value of rides completed successfully:
select * from rides_completed_successfully;

#10.List all incomplete rides along with the reasons:
create view incomplete_rides as
select Booking_Id, Incomplete_Rides_Reason
from ola_booking 
where Incomplete_Rides = "Yes";

#10.List all incomplete rides along with the reasons:
select * from incomplete_rides;



