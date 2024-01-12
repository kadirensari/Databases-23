/*----------------------------------------------------------------------------------------------------------------------
Sample database for points. Includes coordinates table consists of coordinate values of 2D points and distance function
returns the distance between two points
-----------------------------------------------------------------------------------------------------------------------*/

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
        return sqrt(pow(x1 - x2, 2) + pow(y1 - y2, 2));
    end
$$ language plpgsql;

select x1, y1, x2, y2, distance(x1, y1, x2, y2) as distance from coordinates