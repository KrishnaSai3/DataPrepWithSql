create schema week4_2019 authorization awsuser

create table week2_2019.espn(datee varchar,
						     opponent varchar,
							 resultt varchar,
							 W_L varchar,
							 HI_Points varchar,
							 HI_Rebounds varchar,
							 HI_Assists varchar)
							 
copy week2_2019.espn from 's3://prepindata/2019-Week4/'
credentials 'aws_iam_role=arn:aws:iam::563709185855:role/DataMigrationRole'
csv;

delete from week2_2019.espn where datee=' '

select * from week2_2019.espn
select split_part( split_part(datee,',',2),' ',2) from week2_2019.espn

select 2018||'-'||split_part( split_part(datee,',',2),' ',2)||'-'||split_part( split_part(datee,',',2),' ',3) from week2_2019.espn

select to_date(2018||'-'||split_part( split_part(datee,',',2),' ',2)||'-'||split_part( split_part(datee,',',2),' ',3),'YYYY-Mon-DD') as TrueDate,
       split_part(hi_points,' ',1) as Hi_Points_Name,
       split_part(hi_points,' ',2) as Hi_Points,
       split_part(hi_rebounds,' ',1) as Hi_rebounds_Name,
       split_part(hi_rebounds,' ',2) as Hi_rebounds_Name,
       split_part(hi_assists,' ',1) as Hi_assists_Name,
       split_part(hi_assists,' ',2) as Hi_assists_Name,
       case when left(resultt,1) = 'W' then 'Win'
            else 'Loss'
            end as Resultt,

from week2_2019.espn

select left('W112-108',1)



select TO_DATE('2018-Oct-12','YYYY-Mon-DD') 