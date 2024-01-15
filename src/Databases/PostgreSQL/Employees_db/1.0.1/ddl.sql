create table employees (
	citizen_id char(40) primary key,
	first_name varchar(100),
	middle_name varchar(100),
	last_name varchar(100),
	marital_status int
)


create or replace function get_marital_status_text(int)
returns char(13)
as
$$
	begin
		return case $1
		when 0 then 'Married'
		when 1 then 'Single'
		when 2 then 'Divorced'
		else 'Not-specified'
		end case;
	end
$$ language plpgsql;


create or replace function get_full_text(varchar, varchar, varchar)
returns varchar
as
$$
	declare
		res varchar = '';
	begin
		if $1 is not null then 
			res = $1;
		end if;
	
		if $2 is not null then
			if res <> '' then
				res = res || ' ';
			end if;
			res = res || $2;
		end if;
		
	
		if $3 is not null then
			if res <> '' then
				res = res || ' ';
			end if;
			res = res || $3;
		end if;
		return res;
	end
$$ language plpgsql;


create or replace function get_employee_by_citizen_id(cid char(40))
returns table (full_name varchar, citizen_id char(40), marital_status_text char(13))
as
$$
	begin
		return query 
		select get_full_text(e.first_name, e.middle_name, e.last_name), e.citizen_id, get_marital_status_text(e.marital_status) 
		from employees e where e.citizen_id = cid;
	end
$$ language plpgsql;


