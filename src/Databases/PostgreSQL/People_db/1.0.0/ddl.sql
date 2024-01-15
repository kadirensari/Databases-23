create table people (
	citizen_id char(11) primary key,
	first_name varchar(100) not null,
	last_name varchar(100) not null,
	age int check(age >= 0) not null
);

create table people_younger (
	citizen_id char(11) primary key,
	first_name varchar(100) not null,
	last_name varchar(100) not null,
	age int check(age >= 0) not null
);

create table people_older (
	citizen_id char(11) primary key,
	first_name varchar(100) not null,
	last_name varchar(100) not null,
	age int check(age >= 0) not null
);

create or replace function insert_person(char(11), varchar(100), varchar(100), int)
returns void
as
$$
	begin 
		if $4 < 18 then 
			insert into people_younger (citizen_id, first_name, last_name, age) values ($1, $2, $3, $4);
		elseif $4 > 65 then
			insert into people_older (citizen_id, first_name, last_name, age) values ($1, $2, $3, $4);
		else
			insert into people (citizen_id, first_name, last_name, age) values ($1, $2, $3, $4);
		end if;
	end
$$ language plpgsql;


create or replace function get_people_by_age(int)
returns table (cid char(11), fname varchar(100), lname varchar(100))
as
$$
	begin
		if $1 < 18 then
			return query select citizen_id, first_name, last_name from people_younger where age = $1;
		end if;
	
		if $1 > 65 then
			return query select citizen_id, first_name, last_name from people_older where age = $1;
		end if;
	
		return query select citizen_id, first_name, last_name from people where age = $1;
	end
$$ language plpgsql;

