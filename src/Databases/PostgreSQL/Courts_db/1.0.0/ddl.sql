create table court_status (
	court_status_id serial primary key,
	description char(13) not null
)

insert into court_status (description) values ('Reserved'), ('Available'), ('Not available')


create table court_types (
	court_type_id serial primary key,
	description char(14) not null
)

insert into court_types (description) values ('Open'), ('Close'), ('Open Or Closed')


create table courts (
	court_id serial primary key,
	name varchar(100) not null,
	court_status_id int references court_status(court_status_id) not null,
	court_type_id int references court_types(court_type_id) not null
)


select c.court_id, c.name as name, cs.description as court_status, ct.description as court_type from 
courts c inner join court_status cs on c.court_status_id = cs.court_status_id
inner join court_types ct on ct.court_type_id = c.court_type_id;


