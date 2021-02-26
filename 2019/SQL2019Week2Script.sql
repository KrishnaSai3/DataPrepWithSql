create schema week2_2019 authorization awsuser

create table week2_2019.weather(city varchar,
								 metric varchar,
								 measure varchar,
								 value varchar,
								 datee varchar)
								 
copy week2_2019.weather from 's3://prepindata/2019Week-2/'
credentials 'aws_iam_role=arn:aws:iam::563709185855:role/DataMigrationRole'
csv;

select * from week2_2019.weather

update week2_2019.weather
set city = 'London'
where city in ('Londen','Lond0n','london','nodonL','Londin','Londoon')

update week2_2019.weather
set city = 'Edinburgh'
where city in ('Edinborgh','edinburgh','edinborgh','Ed1nburgh','Ed!nburgh','Edenburgh','3d!nburgh')

select distinct city from week2_2019.weather

delete from week2_2019.weather where city in (' ','City')

create table week2_2019.WeatherRefined as
select city,
	   to_date(datee,'DD-MM-YYYY') as datee,
       max(case when metric='Max Temperature' then value end) as Max_Temperature_Celsius,
       max(case when metric='Min Temperature' then value end) as Min_Temperature_Celsius,
       max(case when metric='Precipitation' then value end) as Precipitation_mm,
       max(case when metric='Wind Speed' then value end) as Wind_Speed_mph
from week2_2019.weather
group by to_date(datee,'DD-MM-YYYY'),city

select * from week2_2019.WeatherRefined