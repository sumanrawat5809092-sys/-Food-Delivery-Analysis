===========================================================
--Important Insights
============================================================

--Query 1: Avg delivery time
select
avg(Time_taken_without_min) as Avg_delivery_time
from food_delivery_info;

--Query 2:Top 5 Fastest Delivery

select top 5 *
from food_delivery_info
order by Time_taken_without_min ;

--Query 3: Find 5 lowest delivery

select top 5 *
from food_delivery_info
order by Time_taken_without_min desc;

---Query 4: orders that took more than 30 min to deliver
select*
from food_delivery_info
where Time_taken_without_min>30;


--Query 5:Impact of weather condition on delivery time
select 
IsNull(Weather_Conditions,'Unknown') as Weather_condition,
count(*) as Number_of_deliveries,
AVG(Time_taken_without_min) as Avg_Delivery_Time
from food_delivery_info
group by Weather_Conditions
order by  Avg_Delivery_Time  desc;


---Query 5:Impact of traffic on delivery time
select   
IsNull(Road_traffic_density,'N/A') as Road_traffic_density,
AVG(Time_taken_without_min) as Avg_Delivery_time,
count(*) as Number_of_deliveries
from food_delivery_info
group by Road_traffic_density
order by Avg_Delivery_time desc;

---Query 6:Impact of high traffic on delivery time (compared to low traffic)
Select
Round(cast(( 
(select   
AVG(Time_taken_without_min) as Avg_Delivery_time
from food_delivery_info
where Road_traffic_density='High' )
- 
(select   
AVG(Time_taken_without_min) as Avg_Delivery_time
from food_delivery_info
where Road_traffic_density='Low'))*100.0/
(select   
AVG(Time_taken_without_min) as Avg_Delivery_time
from food_delivery_info
where Road_traffic_density='Low') as float),2) as Percentage_Increase;


--Query 7:Average delivery time for each city 

select 
IsNull(city,'N/A') as City ,
Avg(Time_taken_without_min)  as Avg_delivery_time
from food_delivery_info
group by City
order by Avg_delivery_time desc;

--Query 8:Which City has highest number or orders

Select
City,
count(*) as Number_of_orders
from food_delivery_info
group by City
order by Number_of_orders desc;

--Query 9:Impact of Area on delivery time (Comparison between Urban and Semi-Urban)
Select 
round(
cast(((select
avg(time_taken_without_min) as Avg_dilivery_time
from food_delivery_info
where City= 'Semi-Urban')
-
(select
avg(time_taken_without_min) as Avg_dilivery_time
from food_delivery_info
where City= 'Urban'))*100.0 / 

(select
avg(time_taken_without_min) as Avg_dilivery_time
from food_delivery_info
where City= 'Urban') as Float),2) as Percentage_Increase;

--Query 10:Which Vehicle has the highest avg delivery time

select top 1 
Type_of_Vehicle,
Avg(Time_taken_without_min) as Avg_delivery_time
from food_delivery_info
group by type_of_vehicle
order by Avg_delivery_time desc ;

--Query 11: Delivery person's age vs avg delivery time 


Select 
Delivery_Person_Age_Group,
avg(Time_taken_without_min) as avg_delivery_time
from
(select *, 
Case 
  When Delivery_person_Age between 15 and 24 then '15-24'
  When Delivery_person_Age between 25 and 34 then '26-36'
  When Delivery_person_Age between 35 and  44 then '35-44'
  Else '44+' 
  End as Delivery_Person_Age_Group 
from food_delivery_info)t
Group by Delivery_Person_Age_Group
order by avg_delivery_time desc;



--Query 12: Do Higher rated  delivery partners deliver faster?

select 
Rating_Group,
avg(time_taken_without_min) as Avg_delivery_time,
count(*) as Number_of_Orders
from(
select*, 
Case 
 When Delivery_person_Ratings is null then 'Not Available'
 When Delivery_person_Ratings between 1 and 2.5 then '1-2.5'
 When Delivery_person_Ratings between 2.6 and 3.5 then '2.6-3.5'
 when Delivery_person_Ratings between 3.6 and 4.5 then '3.6-4.5'
 When Delivery_person_Ratings between 4.6 and 5.5 then '4.6-5.5'
 Else '5.5+'
 End as Rating_Group
from food_delivery_info)t
Group by Rating_Group
order by Avg_delivery_time asc;

--Query 13: Does Festival Effects the Avg delivery time ? 

select 
isnull(Festival,'n/a') as Festival,
avg(Time_taken_without_min) as Avg_delivery_time
from food_delivery_info
Group by Festival ;

--Query 14: Impact of Festival season on avg delivery time ( Comparision between festival and non-festival)

select
	round(
	cast(((
	(select 
	avg(time_taken_without_min) as avg_delivery_time
	from food_delivery_info
	where Festival='Yes')
	-
	(select 
	avg(time_taken_without_min) as avg_delivery_time
	from food_delivery_info
	where  Festival='No'))*100.0/
	(select 
	avg(time_taken_without_min) as avg_delivery_time
	from food_delivery_info
	where  Festival='No')) as float ),2) as Percentage_increased ;


--Query 15:How much does the delivery time increase when there are multiple deliveries?

select
multiple_deliveries ,
count(*) as number_of_deliveries,
avg(time_taken_without_min) as avg_deliveries_time
from food_delivery_info
Group by multiple_deliveries
order by avg_deliveries_time desc ;

--Query 16: comparision between 3 and 0  multiple delivery 

select 
round(cast(((select 
avg(time_taken_without_min) as avg_delivery_time
from food_delivery_info
where multiple_deliveries=3)
-
(select 
avg(time_taken_without_min) as avg_delivery_time
from food_delivery_info
where multiple_deliveries=0))*100.0/
(select 
avg(time_taken_without_min) as avg_delivery_time
from food_delivery_info
where multiple_deliveries=0) as float),2)  as Percantage_Increased ;


--Query 17: Which order type takes the longest time and which order type has highest order?

select
Type_of_order,
count(ID) as number_of_orders,
avg(time_taken_without_min) as avg_delivery_time
from food_delivery_info
group by Type_of_order
order by number_of_orders desc ; 

--Query 18: Total Orders

select 
count(*) as Total_Order
from food_delivery_info;


--Query 19: Most ordered food item

select
type_of_order,
count(*) as number_of_orders
from food_delivery_info
group by type_of_order
order by number_of_orders desc;






