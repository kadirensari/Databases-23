create database mapdb;

create table coordinates (
    coordinate_id serial primary key,
    x1 double precision,
    y1 double precision,
    x2 double precision,
    y2 double precision
);

create or replace function distance(x1 double precision, y1 double precision, x2 double precision, y2 double precision)
returns double precision
as
$$
    begin
        return sqrt(pow(x1-x2, 2) + pow(y1-y2,2));
    end
$$ language plpgsql;