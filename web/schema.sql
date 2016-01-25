create table users (
    id       integer primary key,
    username text unique,
    password text
);

create table shifts (
    id        integer primary key,
    day       text not null,
    begin     text not null,
    end       text not null,
    max_users integer
);

create table users_shifts (
    user_id  integer references users (id),
    shift_id integer references shifts (id),
    primary key (user_id, shift_id)
);

create table messages (
    from_id integer references users (id),
    to_id   integer references users (id),
    sent    integer default CURRENT_TIMESTAMP,
    message text
);

-- shifts réguliers
insert into shifts values (null, "lundi",    TIME("07:00"), TIME("15:00"), 2);
insert into shifts values (null, "lundi",    TIME("15:00"), TIME("18:00"), 2);

insert into shifts values (null, "mardi",    TIME("07:00"), TIME("15:00"), 2);
insert into shifts values (null, "mardi",    TIME("15:00"), TIME("18:00"), 2);

insert into shifts values (null, "mercredi", TIME("07:00"), TIME("15:00"), 2);
insert into shifts values (null, "mercredi", TIME("15:00"), TIME("18:00"), 2);

insert into shifts values (null, "jeudi",    TIME("07:00"), TIME("15:00"), 2);
insert into shifts values (null, "jeudi",    TIME("15:00"), TIME("18:00"), 2);

insert into shifts values (null, "vendredi", TIME("07:00"), TIME("15:00"), 2);
insert into shifts values (null, "vendredi", TIME("15:00"), TIME("18:00"), 2);

-- heures de pointe
insert into shifts values (null, "lundi",    TIME("08:00"), TIME("12:00"), 1);
insert into shifts values (null, "mardi",    TIME("08:00"), TIME("12:00"), 1);
insert into shifts values (null, "mercredi", TIME("08:00"), TIME("12:00"), 1);
insert into shifts values (null, "jeudi",    TIME("07:00"), TIME("11:00"), 1);
insert into shifts values (null, "vendredi", TIME("07:00"), TIME("11:00"), 1);

