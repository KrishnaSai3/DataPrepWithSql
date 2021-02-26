create schema week2 authorization awsuser

drop table week2.bikesales
create table week2.bikesales(BikeType varchar,
					   store varchar,
					   OrderDate varchar,
					   Quantity varchar,
					   valueperbike varchar,
					   shippingdate varchar,
					   model varchar) 
		
copy week2.bikesales from 's3://prepindata/2021Week-2/' 
credentials 'aws_iam_role=arn:aws:iam::563709185855:role/DataMigrationRole'
csv;

drop table bikesales1;
create table week2.bikesales1 as
select biketype::varchar biketype,
	   regexp_substr(model,'[A-Z]+')  model,
	   avg(quantity)::int avg_quantity,
	   avg(valueperbike):: int value_per_bike,
	   avg(quantity::integer*valueperbike::integer) as avg_order_value  /*casting varchars to integer and creating ordervalue from quantity and valueperbik*/
from week2.bikesales
group by regexp_substr(model,'[A-Z]+'), biketype ;
	  
select * from week2.bikesales1;

unload ('select * from week2.bikesales1') 
to 's3://prepindata/2021Week-2/output/output1'
credentials 'aws_iam_role=arn:aws:iam::563709185855:role/DataMigrationRole' csv;


drop table week2.bikesales2;
create table week2.bikesales2 as
select store::varchar store,
       regexp_substr(model,'[A-Z]+')  model,
       sum(quantity::int) Total_quantity_sold,
       sum(quantity::integer*valueperbike::integer) as Total_value_sold,  /*casting varchars to integer and creating ordervalue from quantity and valueperbik*/
	   avg( to_date(shippingdate,'DD-MM-YYYY')-to_date(orderdate,'DD-MM-YYYY')) as avg_Days_to_ship
from week2.bikesales 
group by regexp_substr(model,'[A-Z]+'),store;

unload ('select * from week2.bikesales2')
to 's3://prepindata/2021Week-2/output/output2'
credentials 'aws_iam_role=arn:aws:iam::563709185855:role/DataMigrationRole' csv;