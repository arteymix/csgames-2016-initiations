
create table trips (
    tripduration            integer,
    starttime               text,
    stoptime                text,
    start_station_id        integer,
    start_station_name      text,
    start_station_latitude  real,
    start_station_longitude real,
    end_station_id          integer,
    end_station_name        text,
    end_station_latitude    real,
    end_station_longitude   real,
    bikeid                  integer,
    usertype                string,
    birth_year              integer,
    gender                  integer
);

create index ix_trips_start_station_id on trips (start_station_id);
create index ix_trips_end_station_id   on trips (end_station_id);
create index ix_trips_bikeid           on trips (bikeid);

.mode csv
.import 201409-citibike-tripdata.csv trips

.load extension-functions

.print Vélo le plus utilisé
select bikeid, count(*) as usages from trips group by bikeid order by usages desc limit 1;

.print Station la plus achalandée (départ et arrivée séparément)
select start_station_id, count(*) as usages from trips group by start_station_id order by usages desc limit 1;
select end_station_id, count(*) as usages from trips group by end_station_id order by usages desc limit 1;

.print Durée moyenne des déplacements
select avg(tripduration) from trips;

.print Durée maximale et minimale des déplacement
select min(tripduration), max(tripduration) from trips;

.print Corrélation entre la durée de déplacement et l âge
select avg((tripduration - (select avg(tripduration) from trips)) * (birth_year - (select avg(birth_year) from trips))) / (stdev(tripduration) * stdev(birth_year)) from trips;

.print Moyenne de distance par type d usager
select usertype, avg(tripduration) from trips group by usertype;

