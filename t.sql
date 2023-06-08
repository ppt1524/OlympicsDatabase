DROP database if exists olympics;
create database olympics;
use olympics;
CREATE TABLE Contestant (
    Olympic_id int primary key,
    Sex char(1),
    Weight double,
    Height double,
    Name varchar(255),
    DOB date
);
CREATE TABLE Coach (
    Olympic_id int primary key,
    Name varchar(255),
    DOB date
);
CREATE TABLE Overseer (
    Olympic_id int primary key,
    Name varchar(255),
    Type varchar(255),
    DOB date
);
CREATE TABLE Country(
    Name varchar(255) primary key,
    Investment int,
    Representational_name varchar(255) NOT NULL,
    Continent varchar(255) NOT NULL,
    Previous_olympic_rank int
);
CREATE TABLE Sport (Name varchar(255) primary key);
CREATE TABLE Sponsor(
    Name varchar(255) primary key,
    Donation_value int
);
CREATE TABLE Venue (
    Name varchar(255),
    Location varchar(255),
    PRIMARY KEY(Name, Location)
);
CREATE TABLE Olympic_match (
    Sport_name varchar(255),
    Overseer_olympic_id int,
    Contestant_olympic_id int,
    Start_time timestamp,
    End_time timestamp,
    Configuration varchar(255),
    Match_specification varchar(255),
    -- text
    PRIMARY KEY (
        Sport_name,
        Overseer_olympic_id,
        Contestant_olympic_id,
        Start_time,
        End_time
    ),
    foreign key (Sport_name) REFERENCES Sport(Name),
    foreign key (Overseer_olympic_id) REFERENCES Overseer(Olympic_id),
    foreign key (Contestant_olympic_id) REFERENCES Contestant(Olympic_id)
);
CREATE TABLE Medal (
    Sport_name varchar(255),
    Overseer_olympic_id int,
    Contestant_olympic_id int,
    Match_start_time timestamp,
    Match_end_time timestamp,
    Country_name varchar(255),
    Type Varchar(255),
    Conferring_time timestamp,
    primary key (
        Country_name,
        Match_start_time,
        Match_end_time,
        type,
        Conferring_time
    ),
    foreign key (Country_name) references Country(Name),
    foreign key (
        Sport_name,
        Overseer_olympic_id,
        Contestant_olympic_id,
        Match_start_time,
        Match_end_time
    ) references Olympic_match(
        Sport_name,
        Overseer_olympic_id,
        Contestant_olympic_id,
        Start_time,
        End_time
    )
);
CREATE TABLE Contestant_career (
    Olympic_id int,
    Career int,
    primary key (Olympic_id, Career),
    foreign key (Olympic_id) references Contestant(Olympic_id)
);
CREATE TABLE Contestant_wins (
    Olympic_id int,
    Previous_wins int,
    primary key (Olympic_id, Previous_wins),
    foreign key (Olympic_id) references Contestant(Olympic_id)
);
CREATE TABLE Sport_configuration (
    Sport_name Varchar(255),
    Configuration Varchar(255),
    primary key (Sport_name, Configuration),
    foreign key (Sport_name) references Sport(Name)
);
CREATE TABLE Participation (
    Name varchar(255),
    Participation int,
    primary key (Name, Participation),
    foreign key (Name) references Country(Name)
);
CREATE TABLE Plays (
    Sport_name varchar(255),
    Olympic_id int,
    Start_time timestamp,
    End_time timestamp,
    Venue_name varchar(255),
    Location varchar(255),
    primary key (
        Olympic_id,
        Venue_name,
        Sport_name,
        Start_time,
        End_time,
        Location
    ),
    foreign key (Olympic_id) references Contestant(Olympic_id),
    foreign key (Sport_name) references Sport(Name),
    foreign key (Venue_name, Location) references Venue(Name, Location)
);
CREATE TABLE Coached(
    Contestant_olympic_id int,
    Coach_olympic_id int,
    primary key (Contestant_olympic_id, Coach_olympic_id),
    foreign key (Contestant_olympic_id) references Contestant(Olympic_id),
    foreign key (Coach_olympic_id) references Coach(Olympic_id)
);
CREATE TABLE Played(
    Country_name Varchar(255),
    Sport_name varchar(255),
    Overseer_olympic_id int,
    Contestant_olympic_id int,
    Start_time timestamp,
    End_time timestamp,
    PRIMARY KEY (
        Sport_name,
        Overseer_olympic_id,
        Contestant_olympic_id,
        Start_time,
        End_time,
        Country_name
    ),
    foreign key (
        Sport_name,
        Overseer_olympic_id,
        Contestant_olympic_id,
        Start_time,
        End_time
    ) references Olympic_match(
        Sport_name,
        Overseer_olympic_id,
        Contestant_olympic_id,
        Start_time,
        End_time
    ),
    foreign key (Country_name) references Country(Name)
);
CREATE TABLE Oversees(
    Referee_olympic_id int,
    Sport_name varchar(255),
    Overseer_olympic_id int,
    Contestant_olympic_id int,
    Start_time timestamp,
    End_time timestamp,
    PRIMARY KEY (
        Sport_name,
        Overseer_olympic_id,
        Contestant_olympic_id,
        Start_time,
        End_time,
        Referee_olympic_id
    ),
    foreign key (
        Sport_name,
        Overseer_olympic_id,
        Contestant_olympic_id,
        Start_time,
        End_time
    ) references Olympic_match(
        Sport_name,
        Overseer_olympic_id,
        Contestant_olympic_id,
        Start_time,
        End_time
    ),
    foreign key (Referee_olympic_id) references Overseer(Olympic_id)
);
CREATE TABLE Got(
    Referee_olympic_id int,
    Sport_name varchar(255),
    Overseer_olympic_id int,
    Contestant_olympic_id int,
    Start_time timestamp,
    End_time timestamp,
    Medal_type varchar(255),
    Medal_conferring_time timestamp,
    PRIMARY KEY (
        Sport_name,
        Overseer_olympic_id,
        Contestant_olympic_id,
        Start_time,
        End_time,
        Referee_olympic_id
    ),
    foreign key (
        Sport_name,
        Overseer_olympic_id,
        Contestant_olympic_id,
        Start_time,
        End_time
    ) references Olympic_match(
        Sport_name,
        Overseer_olympic_id,
        Contestant_olympic_id,
        Start_time,
        End_time
    ),
    foreign key (Referee_olympic_id) references Overseer(Olympic_id)
);
create table Represents(
    Contestant_olympic_id int,
    Country_name varchar(255),
    Primary key (Contestant_olympic_id, Country_name),
    foreign key (Contestant_olympic_id) references Contestant(Olympic_id),
    foreign key (Country_name) references Country(Name)
);
create table Coach_from(
    Coach_olympic_id int,
    Country_name varchar(255),
    Primary key (Coach_olympic_id, Country_name),
    foreign key (Coach_olympic_id) references Coach(Olympic_id),
    foreign key (Country_name) references Country(Name)
);
create table Sponsored(
    Contestant_olympic_id int,
    Sponsor_name varchar(255),
    Primary key (Contestant_olympic_id, Sponsor_name),
    foreign key (Contestant_olympic_id) references Contestant(Olympic_id),
    foreign key (Sponsor_name) references Sponsor(Name)
);
INSERT INTO Sport
values ("Gymnastics"),
    ("Track"),
    ("Swimming"),
    ("Volleyball"),
    ("Table Tennis");
INSERT INTO Sport_configuration
values ("Track", "100m male"),
    ("Track", "200m male"),
    ("Volleyball", "mixed"),
    ("Table Tennis", "female singles");
INSERT INTO Country
values (
        "Russia",
        5000000,
        "Russian Olympic Committee",
        "Europe",
        4
    ),
    ("USA", 50000000, "USA", "North America", 1),
    ("Deutschland", 10000000, "Germany", "Europe", 5),
    ("China", 35000000, "China", "Asia", 3),
    (
        "Australia",
        12000000,
        "Australia",
        "Australia",
        10
    ),
    ("Brazil", 7000000, "Brazil", "South America", 16);
INSERT INTO Contestant
values (
        101000,
        'M',
        76.7,
        147.5,
        'Chin Ling',
        '1995-02-26'
    ),
    (
        101001,
        'M',
        88.7,
        179.4,
        'JACKSON JR Edwin',
        '1996-09-22'
    ),
    (
        101002,
        'F',
        93.7,
        178.9,
        'JANG Jeongmin',
        '1996-06-23'
    ),
    (
        101003,
        'M',
        71.7,
        137.5,
        'JOPPICH Peter',
        '1995-02-24'
    ),
    (
        101004,
        'M',
        88.7,
        173.5,
        'KADDAH Hassan',
        '1994-08-25'
    ),
    (
        101005,
        'F',
        95.7,
        127.7,
        'KHOSA Fikile',
        '1996-02-26'
    ),
    (
        101006,
        'M',
        78.7,
        176.5,
        'KLECKER Joe',
        '1995-02-27'
    ),
    (
        101007,
        'M',
        83.7,
        127.5,
        'DUBOIS Albane',
        '1994-02-18'
    ),
    (
        101008,
        'F',
        67.7,
        155.1,
        'CRACKLES Fiona',
        '1995-02-13'
    ),
    (
        101009,
        'M',
        53.7,
        174.5,
        'EPITROPOV Lyubomir',
        '1998-05-16'
    ),
    (
        101010,
        'M',
        76.7,
        177.5,
        'FABBRI Leonardo',
        '1993-02-16'
    ),
    (
        101011,
        'F',
        93.7,
        187.6,
        'GEMILI Adam',
        '1992-02-21'
    ),
    (
        101012,
        'M',
        92.7,
        186.5,
        'GITTENS Tyra',
        '1996-07-16'
    ),
    (
        101013,
        'M',
        62.7,
        185.3,
        'HAEMMERLE Elisa',
        '1993-02-26'
    ),
    (
        101014,
        'F',
        88.7,
        128.5,
        'HORODYSKYY Bohdan-Ivan',
        '1996-08-23'
    ),
    (
        101015,
        'M',
        64.7,
        198.5,
        'JENNER Kate Elisabeth',
        '1998-10-16'
    ),
    (
        101016,
        'M',
        82.7,
        154.7,
        'VOLVICH Artem',
        '1993-02-24'
    ),
    (
        101017,
        'F',
        91.7,
        167.5,
        'WIEBE Erica Elizabeth',
        '1992-11-30'
    ),
    (
        101018,
        'F',
        91.7,
        167.5,
        'LOBODA Kinga',
        '1992-11-30'
    ),
    (
        101019,
        'M',
        51.3,
        133.1,
        'YANG Junxia',
        '1993-11-23'
    ),
    (
        101020,
        'M',
        23.8,
        112.7,
        'YOUNG Robyn',
        '1996-11-03'
    ),
    (
        101021,
        'F',
        56.2,
        124.2,
        'McAULEY Sarah',
        '1993-11-22'
    ),
    (
        101022,
        'M',
        93.1,
        156.8,
        'Mc CALLUM Grace',
        '1991-11-16'
    ),
    (
        101023,
        'M',
        73.1,
        146.8,
        'LISI Veronica',
        '1996-09-16'
    ),
    (
        101024,
        'M',
        91.9,
        121.5,
        'LOE Olivia',
        '1998-11-11'
    );
-- olympic id , name, dob
INSERT INTO Coach
values (101101, 'LIANG Xinping', '1976-11-12'),
    (101102, 'LEFEBVRE Helene', '1972-06-23'),
    (101103, 'KRSSAKOVA Magdalena', '1974-03-11'),
    (101104, 'KRUSE Max', '1971-01-08'),
    (101105, 'JOSEPH Gemima', '1977-11-29'),
    (101106, 'JOHANSEN Julius', '1971-12-01'),
    (101107, 'INTANON Ratchanok', '1979-01-10'),
    (101108, 'HULKKO Ida', '1971-10-14');
INSERT INTO Coach_from
values (101101, 'Russia'),
    (101102, 'USA'),
    (101103, 'China'),
    (101104, 'Australia'),
    (101105, 'Deutschland'),
    (101106, 'Brazil'),
    (101107, 'Russia'),
    (101108, 'USA');
INSERT INTO Represents
values (101000, 'Russia'),
    (101001, 'USA'),
    (101002, 'China'),
    (101003, 'Australia'),
    (101004, 'Deutschland'),
    (101005, 'Brazil'),
    (101006, 'Russia'),
    (101007, 'USA'),
    (101008, 'China'),
    (101009, 'Australia'),
    (101010, 'Deutschland'),
    (101011, 'Brazil'),
    (101012, 'Russia'),
    (101013, 'USA'),
    (101014, 'China'),
    (101015, 'Australia'),
    (101016, 'Deutschland'),
    (101017, 'Brazil'),
    (101018, 'Russia'),
    (101019, 'Russia'),
    (101020, 'USA'),
    (101021, 'China'),
    (101022, 'China'),
    (101023, 'China'),
    (101024, 'USA');
INSERT into Contestant_career
values (101000, 2016),
    (101000, 2012),
    (101002, 2012),
    (101003, 2008),
    (101003, 2012),
    (101003, 2016),
    (101004, 2016),
    (101005, 2016),
    (101005, 2012),
    (101006, 2016),
    (101008, 2016),
    (101008, 2012),
    (101008, 2008),
    (101009, 2016),
    (101010, 2016),
    (101011, 2016),
    (101011, 2012),
    (101012, 2016),
    (101015, 2016),
    (101015, 2012),
    (101015, 2008),
    (101016, 2012),
    (101017, 2016),
    (101018, 2016),
    (101019, 2016),
    (101019, 2012),
    (101020, 2016),
    (101020, 2012),
    (101020, 2008),
    (101021, 2016),
    (101022, 2016),
    (101024, 2016),
    (101024, 2012),
    (101024, 2008);
INSERT into Contestant_wins
values (101000, 2016),
    (101002, 2012),
    (101003, 2008),
    (101003, 2016),
    (101005, 2016),
    (101008, 2008),
    (101011, 2016),
    (101015, 2012),
    (101015, 2008),
    (101017, 2016),
    (101019, 2016),
    (101020, 2012),
    (101021, 2016),
    (101024, 2016),
    (101024, 2012);
insert into participation
values ('Russia', 2016),
    ('Russia', 2012),
    ('Russia', 2008),
    ('USA', 2016),
    ('USA', 2012),
    ('USA', 2008),
    ('China', 2016),
    ('China', 2012),
    ('China', 2008),
    ('Australia', 2016),
    ('Australia', 2012),
    ('Australia', 2008),
    ('Brazil', 2016),
    ('Brazil', 2012),
    ('Brazil', 2008),
    ('Deutschland', 2016),
    ('Deutschland', 2012),
    ('Deutschland', 2008);
INSERT into Overseer
values (102001, 'Sung Weng', 'Referee', '1978-01-31'),
    (
        102002,
        'Fazel Baratyan M.',
        'Referee',
        '1975-01-30'
    ),
    (
        102003,
        'Khalid Dallawer',
        'Referee',
        '1988-03-21'
    ),
    (102004, 'Kerry Skepple', 'Referee', '1982-08-21'),
    (
        102005,
        'Javier Castrilli',
        'Referee',
        '1978-12-21'
    ),
    (102006, 'Helmut Kohl', 'Referee', '1977-11-21'),
    (102007, 'Gerald Lehner', 'Referee', '1983-10-21'),
    (102008, 'Trevor Taylor', 'Judge', '1978-08-21'),
    (102009, 'Paul Allaerts', 'Judge', '1976-05-21'),
    (102010, 'John Langenus', 'Judge', '1988-08-21'),
    (102011, 'Luis Barrancos', 'Judge', '1972-02-21'),
    (102012, 'Leandro Vuaden', 'Judge', '1978-08-21'),
    (102013, 'Boureima Sanogo', 'Judge', '1997-07-21'),
    (102014, 'Vichhika Tuy', 'Judge', '1968-02-21'),
    (
        102015,
        'Therese Aimee Nteme Zoa',
        'Judge',
        '1972-07-21'
    );
insert into Sponsor
values ('AirBnb', 1000000),
    ('Aramco', 2050000),
    ('Alibaba', 3900000),
    ('Florence', 800000),
    ('Coca-Cola', 4000000),
    ('Intel', 3000000),
    ('Nike', 2000000);
insert into Venue
values ('Track', 'Stadium A'),
    ('Track', 'Stadium B'),
    ('Pool A', 'Stadium C'),
    ('Volleyball court', 'Stadium B'),
    ('Volleyball court', 'Stadium D'),
    ('Table Tennis Stadium', 'Stadium A'),
    ('Gymnastics Podium', 'Stadium C');
INSERT INTO Olympic_match
values (
        'Volleyball',
        102001,
        101000,
        '2020-08-10 14:00:00',
        '2020-08-10 15:30:00',
        'mixed',
        NULL
    ),
    (
        'Volleyball',
        102001,
        101006,
        '2020-08-10 14:00:00',
        '2020-08-10 15:30:00',
        'mixed',
        NULL
    ),
    (
        'Volleyball',
        102001,
        101018,
        '2020-08-10 14:00:00',
        '2020-08-10 15:30:00',
        'mixed',
        NULL
    ),
    (
        'Volleyball',
        102001,
        101023,
        '2020-08-10 14:00:00',
        '2020-08-10 15:30:00',
        'mixed',
        NULL
    ),
    (
        'Volleyball',
        102001,
        101008,
        '2020-08-10 14:00:00',
        '2020-08-10 15:30:00',
        'mixed',
        NULL
    ),
    (
        'Volleyball',
        102006,
        101015,
        '2020-08-10 15:00:00',
        '2020-08-10 16:30:00',
        'mixed',
        NULL
    ),
    (
        'Volleyball',
        102006,
        101009,
        '2020-08-10 15:00:00',
        '2020-08-10 16:30:00',
        'mixed',
        NULL
    ),
    (
        'Volleyball',
        102006,
        101016,
        '2020-08-10 15:00:00',
        '2020-08-10 16:30:00',
        'mixed',
        NULL
    ),
    (
        'Volleyball',
        102006,
        101010,
        '2020-08-10 15:00:00',
        '2020-08-10 16:30:00',
        'mixed',
        NULL
    ),
    (
        'Swimming',
        102013,
        101015,
        '2020-08-11 08:00:00',
        '2020-08-11 08:10:00',
        NULL,
        NULL
    ),
    (
        'Swimming',
        102013,
        101001,
        '2020-08-11 08:00:00',
        '2020-08-11 08:10:00',
        NULL,
        NULL
    ),
    (
        'Swimming',
        102013,
        101013,
        '2020-08-11 08:00:00',
        '2020-08-11 08:10:00',
        NULL,
        NULL
    ),
    (
        'Track',
        102008,
        101002,
        '2020-08-11 18:00:00',
        '2020-08-11 18:10:00',
        '100m',
        'Male'
    ),
    (
        'Track',
        102008,
        101008,
        '2020-08-11 18:00:00',
        '2020-08-11 18:10:00',
        '100m',
        'Male'
    ),
    (
        'Track',
        102008,
        101006,
        '2020-08-11 18:00:00',
        '2020-08-11 18:10:00',
        '100m',
        'Male'
    ),
    (
        'Track',
        102008,
        101002,
        '2020-08-11 19:00:00',
        '2020-08-11 19:10:00',
        '200m',
        'Male'
    ),
    (
        'Track',
        102008,
        101016,
        '2020-08-11 19:00:00',
        '2020-08-11 19:10:00',
        '200m',
        'Male'
    ),
    (
        'Track',
        102008,
        101006,
        '2020-08-11 19:00:00',
        '2020-08-11 19:10:00',
        '200m',
        'Male'
    ),
    (
        'Table Tennis',
        102007,
        101001,
        '2020-08-12 19:00:00',
        '2020-08-12 19:30:00',
        'Singles',
        'Female'
    ),
    (
        'Table Tennis',
        102007,
        101018,
        '2020-08-12 19:00:00',
        '2020-08-12 19:30:00',
        'Singles',
        'Female'
    ),
    (
        'Table Tennis',
        102007,
        101001,
        '2020-08-13 19:00:00',
        '2020-08-13 19:30:00',
        'Singles',
        'Female'
    ),
    (
        'Table Tennis',
        102007,
        101021,
        '2020-08-13 19:00:00',
        '2020-08-13 19:30:00',
        'Singles',
        'Female'
    ),
    (
        'Gymnastics',
        102015,
        101021,
        '2020-08-02 16:00:00',
        '2020-08-02 18:00:00',
        NULL,
        NULL
    ),
    (
        'Gymnastics',
        102015,
        101009,
        '2020-08-02 16:00:00',
        '2020-08-02 18:00:00',
        NULL,
        NULL
    );
;
insert into Sponsored
values (101000, 'Coca-Cola'),
    (101001, 'Aramco'),
    (101002, 'Aramco'),
    (101003, 'AirBnb'),
    (101004, 'Florence'),
    (101005, 'Florence'),
    (101006, 'AirBnb'),
    (101007, 'AirBnb'),
    (101008, 'Alibaba'),
    (101009, 'Nike'),
    (101010, 'AirBnb'),
    (101011, 'Intel'),
    (101012, 'Intel'),
    (101013, 'Coca-Cola'),
    (101014, 'Alibaba'),
    (101015, 'Nike'),
    (101016, 'AirBnb'),
    (101017, 'Aramco'),
    (101018, 'AirBnb'),
    (101019, 'Intel'),
    (101020, 'Nike'),
    (101021, 'Alibaba'),
    (101022, 'Florence'),
    (101023, 'AirBnb'),
    (101024, 'Nike');
insert into Coached
values (101000, 101101),
    -- 1
    (101001, 101108),
    -- 2
    (101002, 101102),
    -- 3
    (101003, 101104),
    -- 4
    (101004, 101106),
    -- 5
    (101005, 101105),
    (101006, 101101),
    -- 1
    (101007, 101108),
    -- 2 
    (101008, 101102),
    -- 3
    (101009, 101104),
    -- 4 
    (101010, 101106),
    -- 5
    (101011, 101105),
    (101012, 101101),
    -- 1
    (101013, 101108),
    -- 2
    (101014, 101103),
    -- 3
    (101015, 101104),
    -- 4 
    (101016, 101106),
    -- 5
    (101017, 101105),
    (101018, 101101),
    -- 1
    (101019, 101107),
    -- 1
    (101020, 101108),
    -- 2
    (101021, 101103),
    -- 3
    (101022, 101102),
    -- 3
    (101023, 101103),
    -- 3
    (101024, 101108);
insert into Medal
values (
        'Volleyball',
        102001,
        101000,
        '2020-08-10 14:00:00',
        '2020-08-10 15:30:00',
        'Russia',
        'Gold',
        '2020-08-20 15:00:00'
    ),
    (
        'Volleyball',
        102001,
        101023,
        '2020-08-10 14:00:00',
        '2020-08-10 15:30:00',
        'China',
        'Silver',
        '2020-08-20 15:10:00'
    ),
    (
        'Volleyball',
        102006,
        101015,
        '2020-08-10 15:00:00',
        '2020-08-10 16:30:00',
        'Australia',
        'Bronze',
        '2020-08-20 15:00:00'
    ),
    (
        'Swimming',
        102013,
        101015,
        '2020-08-11 08:00:00',
        '2020-08-11 08:10:00',
        'Australia',
        'Gold',
        '2020-08-20 15:12:00'
    ),
    (
        'Track',
        102008,
        101002,
        '2020-08-11 18:00:00',
        '2020-08-11 18:10:00',
        'China',
        'Gold',
        '2020-08-20 15:56:00'
    ),
    (
        'Track',
        102008,
        101008,
        '2020-08-11 18:00:00',
        '2020-08-11 18:10:00',
        'China',
        'Silver',
        '2020-08-20 16:00:00'
    ),
    (
        'Track',
        102008,
        101002,
        '2020-08-11 19:00:00',
        '2020-08-11 19:10:00',
        'China',
        'Bronze',
        '2020-08-20 12:10:00'
    ),
    (
        'Table Tennis',
        102007,
        101001,
        '2020-08-12 19:00:00',
        '2020-08-12 19:30:00',
        'USA',
        'Gold',
        '2020-08-20 14:10:00'
    ),
    (
        'Table Tennis',
        102007,
        101021,
        '2020-08-13 19:00:00',
        '2020-08-13 19:30:00',
        'China',
        'Silver',
        '2020-08-20 15:00:00'
    ),
    (
        'Gymnastics',
        102015,
        101021,
        '2020-08-02 16:00:00',
        '2020-08-02 18:00:00',
        'China',
        'Gold',
        '2020-08-20 15:00:00'
    );
insert into Plays
values (
        'Volleyball',
        101000,
        '2020-08-10 14:00:00',
        '2020-08-10 15:30:00',
        'Volleyball court',
        'Stadium B'
    ),
    (
        'Volleyball',
        101006,
        '2020-08-10 14:00:00',
        '2020-08-10 15:30:00',
        'Volleyball court',
        'Stadium D'
    ),
    (
        'Volleyball',
        101018,
        '2020-08-10 14:00:00',
        '2020-08-10 15:30:00',
        'Volleyball court',
        'Stadium B'
    ),
    (
        'Volleyball',
        101023,
        '2020-08-10 14:00:00',
        '2020-08-10 15:30:00',
        'Volleyball court',
        'Stadium D'
    ),
    (
        'Volleyball',
        101008,
        '2020-08-10 14:00:00',
        '2020-08-10 15:30:00',
        'Volleyball court',
        'Stadium B'
    ),
    (
        'Volleyball',
        101015,
        '2020-08-10 15:00:00',
        '2020-08-10 16:30:00',
        'Volleyball court',
        'Stadium D'
    ),
    (
        'Volleyball',
        101009,
        '2020-08-10 15:00:00',
        '2020-08-10 16:30:00',
        'Volleyball court',
        'Stadium B'
    ),
    (
        'Volleyball',
        101016,
        '2020-08-10 15:00:00',
        '2020-08-10 16:30:00',
        'Volleyball court',
        'Stadium D'
    ),
    (
        'Volleyball',
        101010,
        '2020-08-10 15:00:00',
        '2020-08-10 16:30:00',
        'Volleyball court',
        'Stadium B'
    ),
    (
        'Swimming',
        101015,
        '2020-08-11 08:00:00',
        '2020-08-11 08:10:00',
        'Pool A',
        'Stadium C'
    ),
    (
        'Swimming',
        101001,
        '2020-08-11 08:00:00',
        '2020-08-11 08:10:00',
        'Pool A',
        'Stadium C'
    ),
    (
        'Swimming',
        101013,
        '2020-08-11 08:00:00',
        '2020-08-11 08:10:00',
        'Pool A',
        'Stadium C'
    ),
    (
        'Track',
        101002,
        '2020-08-11 18:00:00',
        '2020-08-11 18:10:00',
        'Track',
        'Stadium A'
    ),
    (
        'Track',
        101008,
        '2020-08-11 18:00:00',
        '2020-08-11 18:10:00',
        'Track',
        'Stadium B'
    ),
    (
        'Track',
        101006,
        '2020-08-11 18:00:00',
        '2020-08-11 18:10:00',
        'Track',
        'Stadium A'
    ),
    (
        'Track',
        101002,
        '2020-08-11 19:00:00',
        '2020-08-11 19:10:00',
        'Track',
        'Stadium B'
    ),
    (
        'Track',
        101016,
        '2020-08-11 19:00:00',
        '2020-08-11 19:10:00',
        'Track',
        'Stadium A'
    ),
    (
        'Track',
        101006,
        '2020-08-11 19:00:00',
        '2020-08-11 19:10:00',
        'Track',
        'Stadium B'
    ),
    (
        'Table Tennis',
        101001,
        '2020-08-12 19:00:00',
        '2020-08-12 19:30:00',
        'Table Tennis Stadium',
        'Stadium A'
    ),
    (
        'Table Tennis',
        101018,
        '2020-08-12 19:00:00',
        '2020-08-12 19:30:00',
        'Table Tennis Stadium',
        'Stadium A'
    ),
    (
        'Table Tennis',
        101001,
        '2020-08-13 19:00:00',
        '2020-08-13 19:30:00',
        'Table Tennis Stadium',
        'Stadium A'
    ),
    (
        'Table Tennis',
        101021,
        '2020-08-13 19:00:00',
        '2020-08-13 19:30:00',
        'Table Tennis Stadium',
        'Stadium A'
    ),
    (
        'Gymnastics',
        101021,
        '2020-08-02 16:00:00',
        '2020-08-02 18:00:00',
        'Gymnastics Podium',
        'Stadium C'
    ),
    (
        'Gymnastics',
        101009,
        '2020-08-02 16:00:00',
        '2020-08-02 18:00:00',
        'Gymnastics Podium',
        'Stadium C'
    );
;
insert into Played
values (
        'Russia',
        'Volleyball',
        102001,
        101000,
        '2020-08-10 14:00:00',
        '2020-08-10 15:30:00'
    ),
    (
        'Russia',
        'Volleyball',
        102001,
        101006,
        '2020-08-10 14:00:00',
        '2020-08-10 15:30:00'
    ),
    (
        'Russia',
        'Volleyball',
        102001,
        101018,
        '2020-08-10 14:00:00',
        '2020-08-10 15:30:00'
    ),
    (
        'China',
        'Volleyball',
        102001,
        101023,
        '2020-08-10 14:00:00',
        '2020-08-10 15:30:00'
    ),
    (
        'China',
        'Volleyball',
        102001,
        101008,
        '2020-08-10 14:00:00',
        '2020-08-10 15:30:00'
    ),
    (
        'Australia',
        'Volleyball',
        102006,
        101015,
        '2020-08-10 15:00:00',
        '2020-08-10 16:30:00'
    ),
    (
        'Australia',
        'Volleyball',
        102006,
        101009,
        '2020-08-10 15:00:00',
        '2020-08-10 16:30:00'
    ),
    (
        'Deutschland',
        'Volleyball',
        102006,
        101016,
        '2020-08-10 15:00:00',
        '2020-08-10 16:30:00'
    ),
    (
        'Deutschland',
        'Volleyball',
        102006,
        101010,
        '2020-08-10 15:00:00',
        '2020-08-10 16:30:00'
    ),
    (
        'Australia',
        'Swimming',
        102013,
        101015,
        '2020-08-11 08:00:00',
        '2020-08-11 08:10:00'
    ),
    (
        'USA',
        'Swimming',
        102013,
        101001,
        '2020-08-11 08:00:00',
        '2020-08-11 08:10:00'
    ),
    (
        'USA',
        'Swimming',
        102013,
        101013,
        '2020-08-11 08:00:00',
        '2020-08-11 08:10:00'
    ),
    (
        'China',
        'Track',
        102008,
        101002,
        '2020-08-11 18:00:00',
        '2020-08-11 18:10:00'
    ),
    (
        'China',
        'Track',
        102008,
        101008,
        '2020-08-11 18:00:00',
        '2020-08-11 18:10:00'
    ),
    (
        'Russia',
        'Track',
        102008,
        101006,
        '2020-08-11 18:00:00',
        '2020-08-11 18:10:00'
    ),
    (
        'China',
        'Track',
        102008,
        101002,
        '2020-08-11 19:00:00',
        '2020-08-11 19:10:00'
    ),
    (
        'Deutschland',
        'Track',
        102008,
        101016,
        '2020-08-11 19:00:00',
        '2020-08-11 19:10:00'
    ),
    (
        'Russia',
        'Track',
        102008,
        101006,
        '2020-08-11 19:00:00',
        '2020-08-11 19:10:00'
    ),
    (
        'USA',
        'Table Tennis',
        102007,
        101001,
        '2020-08-12 19:00:00',
        '2020-08-12 19:30:00'
    ),
    (
        'Russia',
        'Table Tennis',
        102007,
        101018,
        '2020-08-12 19:00:00',
        '2020-08-12 19:30:00'
    ),
    (
        'USA',
        'Table Tennis',
        102007,
        101001,
        '2020-08-13 19:00:00',
        '2020-08-13 19:30:00'
    ),
    (
        'China',
        'Table Tennis',
        102007,
        101021,
        '2020-08-13 19:00:00',
        '2020-08-13 19:30:00'
    ),
    (
        'China',
        'Gymnastics',
        102015,
        101021,
        '2020-08-02 16:00:00',
        '2020-08-02 18:00:00'
    ),
    (
        'Australia',
        'Gymnastics',
        102015,
        101009,
        '2020-08-02 16:00:00',
        '2020-08-02 18:00:00'
    );
-- oversees and Got not needed they are redundant