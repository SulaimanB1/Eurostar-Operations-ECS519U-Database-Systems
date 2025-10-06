-- using mysql

drop schema if exists groupak_cw3;
CREATE SCHEMA groupak_cw3;
use groupak_cw3;

/**generalisation has been used between stations and stops
a stop is a station. A stop is a weak entity that has 2 foreign keys, StationID from station and RouteID from route.
they are used together as a composite primary key for the table stops.**/

create table if not exists groupak_cw3.employee
(
    EmployeeID int auto_increment       primary key,
    JobTitle   varchar(255) null,
    FullName   varchar(255) null,
    JoinDate   date         not null
);

create table if not exists groupak_cw3.crew
(
    CrewID     int auto_increment       primary key,
    HeadOfCrew int not null
);

create table if not exists groupak_cw3.crewmember
(
    EmployeeID int not null,
    CrewID     int not null,
    primary key (EmployeeID, CrewID)
);

create table if not exists groupak_cw3.ticket
(
    TicketID     int auto_increment     primary key,
    TicketDate   datetime null,
    StartStation int      not null,
    StopStation  int      not null,
    Price        int      null
);

create table if not exists groupak_cw3.stations
(
    StationID   int auto_increment      primary key,
    StationName varchar(255) null
);

create table if not exists groupak_cw3.train
(
    TrainID     int auto_increment      primary key,
    BuildYear   date null,
    TrainStatus bit  null
);

create table if not exists groupak_cw3.journey
(
    JourneyID   int auto_increment      primary key,
    JourneyDate datetime null,
    TrainID     int      not null,
    CrewID      int      not null
);

create table if not exists groupak_cw3.route
(
    RouteID     int auto_increment      primary key,
    NewOnly     bit          null,
    RouteStatus varchar(255) null,
    JourneyTime float        null,
    JourneyID   int          not null
);

-- a stop is a station
create table if not exists groupak_cw3.stops
(
    Distance  float null,
    StationID int   not null,
    RouteID   int   not null,
    primary key (StationID, RouteID),
    foreign key (StationID) references stations(StationID),
    foreign key (RouteID) references route(RouteID)
);

ALTER TABLE groupak_cw3.crew add constraint crewToEmployee foreign key (HeadOfCrew) references groupak_cw3.employee (EmployeeID);
ALTER TABLE groupak_cw3.crewmember add constraint crewMemberToEmployee foreign key (EmployeeID) references groupak_cw3.employee (EmployeeID);
ALTER TABLE groupak_cw3.crewmember add constraint crewMemberToCrew foreign key (CrewID) references groupak_cw3.crew (CrewID);
ALTER TABLE groupak_cw3.ticket add constraint ticketToStopStation foreign key (StopStation) references groupak_cw3.stations (StationID);
ALTER TABLE groupak_cw3.ticket add constraint ticketToStartStation foreign key (StartStation) references groupak_cw3.stations (StationID);
ALTER TABLE groupak_cw3.journey add constraint journeyToTrain foreign key (TrainID) references groupak_cw3.train (TrainID);
ALTER TABLE groupak_cw3.journey add constraint journeyToCrew foreign key (CrewID) references groupak_cw3.crew (CrewID);
ALTER TABLE groupak_cw3.route add constraint routeToJourney foreign key (JourneyID) references groupak_cw3.journey (JourneyID);
ALTER TABLE groupak_cw3.stops add constraint stopsToStations foreign key (StationID) references groupak_cw3.stations (StationID);
ALTER TABLE groupak_cw3.stops add constraint stopsToRoute foreign key (RouteID) references groupak_cw3.route (RouteID);


INSERT INTO groupak_cw3.train (BuildYear, TrainStatus) VALUES
('2011-04-30', true),
('2013-07-09', true),
('2015-12-10', true),
('2016-07-22', true),
('2011-04-03', false),
('2012-02-04', true),
('2018-03-18', false),
('2011-10-28', false),
('2015-11-13', true),
('2011-05-19', true);

INSERT INTO groupak_cw3.stations (StationName) VALUES
('Paris Gare du Nord'),
('Amsterdam Central'),
('Brussels Midi'),
('London St Pancras Int'),
('London Stratford Int'),
('Ebbsfleet Int'),
('Ashford Int'),
('Rotterdam Central'),
('Lille Europe'),
('Disneyland Paris');

INSERT INTO groupak_cw3.ticket (TicketDate, StartStation, StopStation, Price) VALUES
('2019-04-10 14:15:17', 1, 2, 81),
('2022-12-03 14:16:10', 2, 3, 104),
('2020-08-03 05:45:00', 3, 9, 166),
('2015-02-05 17:30:00', 4, 6, 174),
('2022-12-05 09:16:10', 5, 9, 191),
('2019-04-10 14:15:17', 6, 1, 101),
('2022-12-03 14:16:10', 7, 4, 156),
('2020-08-03 05:45:00', 8, 1, 120),
('2015-02-05 17:30:00', 9, 4, 103),
('2021-12-01 14:16:10', 5, 7, 155),
('2021-11-01 05:45:00', 5, 10, 155);


INSERT INTO groupak_cw3.employee (JobTitle, FullName, JoinDate) VALUES
('drivers', 'Cindy Bass', '2017-06-13'),
('service team', 'Alice Mooney', '2008-02-07'),
('drivers', 'Chuck Howell', '2013-12-03'),
('service team', 'Domingo Christensen', '2005-06-27'),
('service team ', 'Adalberto Richards', '2012-04-09'),
('service team', 'Clare Hoffman', '2015-06-10'),
('conductors', 'Lindsay Sosa', '2022-05-21'),
('conductors', 'Alta Mcclain', '2018-02-20'),
('conductors', 'Francis Garner', '2014-12-04'),
('service team', 'Alva Vazquez', '2008-10-24'),
('drivers', 'Madeleine Moses', '2007-11-12'),
('security guards', 'Ivory Greene', '2014-12-20'),
('conductors', 'Vito Sweeney', '2015-01-17'),
('security guards', 'Seth Arnold', '2016-01-14'),
('service team ', 'Jodi Lawrence', '2016-06-03'),
('service team', 'Mitzi Gutierrez', '2007-12-03'),
('security guards', 'Leah Joseph', '2006-08-19'),
('service team ', 'Cornell Barry', '2017-02-02'),
('security guards', 'Keenan Waller', '2022-09-28'),
('security guards', 'Jimmy Cox', '2013-12-15'),
('security guards', 'Amy Friedman', '2021-03-23'),
('security guards', 'Susannah Ho', '2010-08-23'),
('conductors', 'Miriam Reyes', '2021-04-25'),
('conductors', 'Heather Casey', '2015-08-24'),
('conductors', 'Robyn Todd', '2018-03-25'),
('drivers', 'Barney Mcdowell', '2018-10-04'),
('service team', 'Michelle Hanna', '2004-10-16'),
('service team', 'Subhaan Avila', '2010-05-07'),
('service team', 'Roseanna Baird', '2002-11-22'),
('service team', 'Azaan Holden', '2008-10-17');

INSERT INTO groupak_cw3.crew (HeadOfCrew) VALUES (7), (8), (9), (10), (11), (12), (13), (14), (15), (16);

INSERT INTO groupak_cw3.journey (JourneyDate, TrainID, CrewID) VALUES
('2022-06-01 14:15:17', 1, 1),
('2022-07-01 14:16:10', 2, 1),
('2022-08-01 05:45:00', 3, 1),
('2022-03-01 17:30:00', 4, 5),
('2022-02-01 09:16:10', 5, 7),
('2022-01-01 14:15:17', 6, 9),
('2021-12-01 14:16:10', 7, 3),
('2021-11-01 05:45:00', 8, 3),
('2021-10-01 17:30:00', 9, 4),
('2021-09-01 09:16:10', 10, 10);

INSERT INTO groupak_cw3.route (NewOnly, RouteStatus, JourneyTime, JourneyID) VALUES
(false, 'Planned', 120, 4),
(true, 'Operational', 45, 2),
(false, 'Operational', 60, 3),
(true, 'Repairing', 83, 1),
(true, 'Operational', 104, 5),
(false, 'Operational', 134, 5),
(false, 'Operational', 123, 5),
(false, 'Operational', 254, 5),
(false, 'Operational', 503, 5),
(true, 'Operational', 255, 5);

INSERT INTO groupak_cw3.stops (Distance, StationID, RouteID) VALUES
(81, 4, 1),
(104, 5, 1),
(166, 7, 1),
(174, 3, 1),
(191, 5, 2),
(101, 1, 2),
(156, 2, 2),
(120, 3, 2),
(103, 4, 3),
(155, 5, 4),
(117, 5, 5),
(127, 5, 6),
(151, 5, 7),
(190, 5, 8),
(168, 5, 9),
(120, 5, 10);

INSERT INTO groupak_cw3.crewmember (EmployeeID, CrewID) VALUES (7, 1),
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(8, 2),
(10, 2),
(11, 2),
(12, 2),
(13, 2),
(14, 2),
(15, 2),
(9, 3),
(16, 3),
(17, 3),
(18, 3),
(19, 3),
(20, 3),
(21, 3);


/** ---------------------------------- basic queries ----------------------------------**/
SELECT AVG(JourneyTime) AS 'Average Journey Time of new only routes'
FROM route
WHERE NewOnly=1;
-- This Query calculates the average journey time of routes that only accept new trains

SELECT FullName
FROM employee
JOIN crewmember ON employee.EmployeeID=crewmember.EmployeeID WHERE crewmember.CrewID=2;
-- This Query Selects the employees full name for who has a crewID of 2

/** ---------------------------------- medium queries ----------------------------------**/
SELECT J.TrainID,E.FullName,C.CrewID,J.JourneyID, J.JourneyDate
FROM journey J, employee E,crewmember C
WHERE J.CrewID=C.CrewID
AND C.EmployeeID=E.EmployeeID
AND E.JobTitle = "drivers"
AND J.JourneyDate>'2020-01-01 00:00:00';
-- Select the Train ID, the employees full name and their CrewID, for all drivers that were starting a journey after 1st Jan 2020

SELECT e.EmployeeID, e.JobTitle, e.FullName, cm.CrewID, c.HeadOfCrew
FROM employee e INNER JOIN crewmember cm ON e.EmployeeID = cm.EmployeeID
INNER JOIN crew c ON cm.CrewID = c.CrewID
WHERE e.EmployeeID = c.HeadOfCrew;
/** This query selects the employees who are also the head of a crew and returns the employee’s ID, job title, full name, the crew ID of the crew they are a part of, 
and the head of that crew’s employee ID **/

SELECT IF(NewOnly=1, "New Train Only", "All trains") AS 'Route Type', AVG(JourneyTime) AS 'Average Journey Time'
FROM route
GROUP BY NewOnly;
-- This Query Selects the average time of routes that accepts new trains vs routes that do not

/**---------------------------------- advanced queries ----------------------------------**/

SELECT COUNT(JourneyID) AS "Number of Journeys with 'Lindsay Sosa' on crew"
FROM journey J
WHERE CrewID =
(
    SELECT CrewID
    FROM crewmember
    WHERE EmployeeID =
    (
        SELECT EmployeeID
        FROM employee
        WHERE FullName = 'Lindsay Sosa'
    )
)
AND JourneyDate > (
    SELECT employee.JoinDate
    FROM employee
    WHERE FullName = 'Lindsay Sosa'
);
-- Count how many journeys that employee Lindsay Sosa was a part of

SELECT *
FROM journey J LEFT JOIN ticket T ON J.JourneyDate = T.TicketDate
WHERE J.CrewID = 3 AND T.StartStation =
(
    SELECT StartStation
    FROM ticket
    GROUP BY StartStation
    ORDER BY COUNT(StartStation) DESC LIMIT 1
)
ORDER BY JourneyDate DESC LIMIT 1;
-- Selects the last journey where the Crew with crew ID ‘3’ has left the most popular station

SELECT T.Price,T.TicketDate,S.StationName AS Departs, S2.StationName AS Terminal
FROM ticket T ,stations S, stations S2
WHERE T.Price = (
    SELECT MAX(Price)
    FROM ticket
)
AND T.StartStation=S.StationID
AND T.StopStation=S2.StationID;
-- Selects the price, start station and stop station of the most expensive train ticket

