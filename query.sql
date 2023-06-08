SELECT Coach_olympic_id AS "Coach ID",
    Name "Coach",
    Country_name AS "Country"
FROM (
        Coach CC
        JOIN Coach_from CF ON CC.Olympic_id = CF.Coach_olympic_id
    )
WHERE LOWER(Country_name) = LOWER("china");
SELECT *
FROM (
        Contestant C
        JOIN Represents R ON C.Olympic_id = R.Contestant_olympic_id
    );
SELECT Contestant_olympic_id AS "Contestant ID",
    Name,
    Type AS "Medal"
FROM (
        Contestant C
        JOIN Medal M ON M.Contestant_olympic_id = C.Olympic_id
    )
WHERE Type = "Gold";
SELECT Sport_name "Sport",
    Start_time "Start Time",
    End_time "End Time"
from Olympic_match
GROUP BY Overseer_olympic_id,
    Start_time,
    End_time,
    Sport_name
HAVING TIMESTAMPDIFF(SQL_TSI_MINUTE, Start_time, End_time) >= 120;
select Country_name AS "Country Name",
    count(*) AS "Num of Medals won"
from Medal
GROUP BY Country_name;
select Contestant_olympic_id AS "Contestant ID",
    Name,
    count(*) AS "Num of Medals won"
from (
        Medal m
        JOIN Contestant c ON m.Contestant_olympic_id = c.Olympic_id
    )
GROUP BY Contestant_olympic_id;