drop table if exists m024.p_trip_fact;

drop table if exists m024.p_bike_dimension;

drop table if exists m024.p_gender_dimension;

drop table if exists m024.p_station_dimension;

drop table if exists m024.p_time_dimension;

drop table if exists m024.p_user_birthyear_dimension;

drop table if exists m024.p_user_type_dimension;



create table if not exists m024.p_bike_dimension
(
    bike_id integer not null
        primary key
);

alter table m024.p_bike_dimension
    owner to ds24m006;

grant delete, insert, references, select, trigger, truncate, update on m024.p_bike_dimension to ds24m024;

grant delete, insert, references, select, trigger, truncate, update on m024.p_bike_dimension to ds24m023;

create table if not exists m024.p_gender_dimension
(
    gender_id   integer default nextval('m024.p_gender_dimension_gender_id_seq1'::regclass) not null
        primary key,
    gender_type varchar(10)                                                                 not null
        constraint unique_gender
            unique
);

alter table m024.p_gender_dimension
    owner to ds24m006;

grant delete, insert, references, select, trigger, truncate, update on m024.p_gender_dimension to ds24m024;

grant delete, insert, references, select, trigger, truncate, update on m024.p_gender_dimension to ds24m023;

create table if not exists m024.p_station_dimension
(
    station_id   integer default nextval('m024.p_station_dimension_station_id_seq'::regclass) not null
        primary key,
    station_key  integer                                                                      not null,
    station_name varchar(255)                                                                 not null,
    latitude     double precision                                                             not null,
    longitude    double precision                                                             not null,
    constraint unique_station
        unique (station_key, station_name, latitude, longitude)
);

alter table m024.p_station_dimension
    owner to ds24m006;

grant delete, insert, references, select, trigger, truncate, update on m024.p_station_dimension to ds24m024;

grant delete, insert, references, select, trigger, truncate, update on m024.p_station_dimension to ds24m023;

create table if not exists m024.p_time_dimension
(
    time_id integer default nextval('m024.p_time_dimension_time_id_seq1'::regclass) not null
        primary key,
    time    timestamp                                                               not null
        constraint unique_time
            unique,
    date    date                                                                    not null,
    year    integer                                                                 not null,
    month   integer                                                                 not null,
    day     integer                                                                 not null,
    hour    integer                                                                 not null
);

alter table m024.p_time_dimension
    owner to ds24m006;

grant delete, insert, references, select, trigger, truncate, update on m024.p_time_dimension to ds24m024;

grant delete, insert, references, select, trigger, truncate, update on m024.p_time_dimension to ds24m023;

create table if not exists m024.p_user_birthyear_dimension
(
    user_birthyear_id serial
        primary key,
    user_birthyear    integer
        constraint unique_user_birthyear
            unique
);

alter table m024.p_user_birthyear_dimension
    owner to ds24m006;

grant delete, insert, references, select, trigger, truncate, update on m024.p_user_birthyear_dimension to ds24m024;

grant delete, insert, references, select, trigger, truncate, update on m024.p_user_birthyear_dimension to ds24m023;

create table if not exists m024.p_user_type_dimension
(
    user_type_id integer default nextval('m024.p_user_type_dimension_user_type_id_seq1'::regclass) not null
        primary key,
    user_type    varchar(50)                                                                       not null
        constraint unique_user_type
            unique
);

alter table m024.p_user_type_dimension
    owner to ds24m006;

grant delete, insert, references, select, trigger, truncate, update on m024.p_user_type_dimension to ds24m024;

grant delete, insert, references, select, trigger, truncate, update on m024.p_user_type_dimension to ds24m023;

create table if not exists m024.p_trip_fact
(
    trip_id           integer default nextval('m024.p_trip_fact_trip_id_seq1'::regclass) not null
        primary key,
    duration          integer                                                            not null,
    distance          double precision,
    start_time_id     integer                                                            not null
        constraint fk_start_time
            references m024.p_time_dimension,
    end_time_id       integer                                                            not null
        constraint fk_end_time
            references m024.p_time_dimension,
    start_station_id  integer                                                            not null
        constraint fk_start_station
            references m024.p_station_dimension,
    end_station_id    integer                                                            not null
        constraint fk_end_station
            references m024.p_station_dimension,
    bike_id           integer                                                            not null
        constraint fk_bike
            references m024.p_bike_dimension,
    user_type_id      integer
        constraint fk_user_type
            references m024.p_user_type_dimension,
    gender_type_id    integer
        constraint fk_user_gender
            references m024.p_gender_dimension,
    user_birthyear_id integer
        constraint fk_user_birthyear
            references m024.p_user_birthyear_dimension,
    constraint unique_trip_details
        unique (start_time_id, end_time_id, start_station_id, end_station_id, bike_id)
);

alter table m024.p_trip_fact
    owner to ds24m006;

grant delete, insert, references, select, trigger, truncate, update on m024.p_trip_fact to ds24m024;

grant delete, insert, references, select, trigger, truncate, update on m024.p_trip_fact to ds24m023;

