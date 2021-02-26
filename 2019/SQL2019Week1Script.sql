create schema week1_2019 authorization awsuser

drop table week1_2019.carsales

create table week1_2019.carsales(dealership varchar,
								 redcars varchar,
								 silvercars varchar,
								 blackcars varchar,
								 bluecars varchar,
								 whensoldmonth varchar,
								 whensoldyear varchar)
								 
copy week1_2019.carsales from 's3://prepindata/2019-Week4/'
credentials 'aws_iam_role=arn:aws:iam::563709185855:role/DataMigrationRole'
csv;

delete from week1_2019.carsales where bluecars = 'Blue Cars'
select * from week1_2019.carsales

create table week1_2019.carsales1 as
select to_date(whensoldyear::integer||'-'||whensoldmonth::integer||'-'||01,'YYYY-MM-DD') as newdate,
	   dealership::varchar dealership,
	   redcars::integer redcars,
	   silvercars::integer silvercars,
	   bluecars::integer bluecars,
	   blackcars::integer blackcars,
	   redcars::integer+silvercars::integer+blackcars::integer+bluecars::integer as totalcarsales
from week1_2019.carsales