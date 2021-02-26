create schema week1 authorization awsuser;

drop table bikesales
create table bikesales(OrderId varchar, 
					   CustomerAge varchar,
					   BikeValue varchar,
					   ExistingCustomer varchar,
					   datee varchar,
					   Store_Bike varchar);

select * from bikesales

copy bikesales from 's3://prepindata/2021Week-1/' 
credentials 'aws_iam_role=arn:aws:iam::563709185855:role/DataMigrationRole'
csv;
						 
drop table bikesalesnew						 
						 
create table  bikesalesnew as
select orderid::integer as orderid,
	   split_part(store_bike,'-',1) AS store,
	   split_part(store_bike,'-',2) as biketype,
	   case when extract(month from (to_date(datee,'DD-MM-YYYY'))) between 1 and 3 then 'Q1'
	        when extract(month from (to_date(datee,'DD-MM-YYYY'))) between 4 and 6 then 'Q2'
	        when extract(month from (to_date(datee,'DD-MM-YYYY'))) between 7 and 9 then 'Q3'
	        else 'Q4' end as Quarterr,
	   extract(day from (to_date(datee,'DD-MM-YYYY'))) as dayy, 
	   customerage::integer as customerage,
	   BikeValue::integer bikevalue,
	   existingcustomer::varchar existingcustomer	   
from bikesales 

s

delete from bikesalesnew

select distinct biketype from bikesalesnew

select * from bikesalesnew 

s3://prepindata/2021Week-1/

unload ('select * from bikesalesnew')
to 's3://prepindata/2021Week-1/output/partition' 
credentials 'aws_iam_role=arn:aws:iam::563709185855:role/DataMigrationRole' csv 
partition by (biketype)