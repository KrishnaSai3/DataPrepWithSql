
drop table movie_gross4

create table movie_gross( name varchar(30) primary key, gross bigint );


insert into movie_gross values ( 'Raiders of the Lost Ark', 23400000);
insert into movie_gross values ( 'Star Wars', 20000000 ); 


select * into movie_gross4 from movie_gross where name = 'R';

select * from movie_gross4

select median(gross) from movie_gross

select * from movie_gross

create table marks(first_name varchar,subject varchar,marks int)

insert into marks values('sidhu','maths',29),
				 ('sidhu','science',28),
				  ('sidhu','social',30)
			
select * from marks
				  
create or replace function replace_string (subject varchar)
returns varchar
volatile 
as 
$$
	return subject.replace('s','t') and subject.replace('i','L')
$$
language PLPYTHONU;
				  
select first_name,subject,marks,replace_string_sql(subject) from marks



create or replace function replace_string_sql (varchar)
returns varchar
volatile 
as 
$$
	select replace($1,'s','t')
$$
language sql;
