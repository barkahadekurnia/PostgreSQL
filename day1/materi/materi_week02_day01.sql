create table regions(
	region_id serial primary key,
	region_name varchar(25)
);

create table countries(
	country_id varchar(2) primary key,
	country_name varchar(40),
	region_id integer not null,
	foreign key(region_id) references regions(region_id) on update cascade on delete cascade
)


alter table regions add column region_x integer
alter table regions rename column region_x to region_xx
alter table regions alter column region_x type varchar(30)
alter table regions drop column region_xx
alter table regions add constraint region_id_pk primary key (region_id)
alter table countries add constraint country_region_id_fk foreign key (region_id) references regions(region_id)
alter table countries drop constraint country_region_id_fk

drop table countries

select * from regions

insert into regions (region_id,region_name,region_x) values (4,'Antartic')
insert into regions (region_name,region_x) values ('Germany',now()+interval '3 year')

update regions 
set region_name = 'Arab'
where region_id = 6

delete from regions where region_id = 4