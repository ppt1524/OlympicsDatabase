
def SELECT(*args):
    if args[0] == 'coach':
        return f'''SELECT Coach_olympic_id AS "Coach ID",
                    Name "Coach",
                    Country_name AS "Country"
                    FROM (
                            Coach CC
                            JOIN Coach_from CF ON CC.Olympic_id = CF.Coach_olympic_id
                        )
                    WHERE LOWER(Country_name) = LOWER("{args[1]}");
                '''
    elif args[0] == 'contestant':
        return f'''SELECT Olympic_id AS "Contestant ID",
                    Name "Contestant",
                    Country_name AS "Country"
                    FROM (
                            Contestant C
                            JOIN Represents R ON C.Olympic_id = R.Contestant_olympic_id
                        )
                    WHERE LOWER(Country_name) = LOWER("{args[1]}");
                '''


def PROJECT(*args):
    if args[0] == 'gold':
        return f'''SELECT Contestant_olympic_id AS "Contestant ID",
                        Name,
                        Type AS "Medal"
                    FROM (
                            Contestant C
                            JOIN Medal M ON M.Contestant_olympic_id = C.Olympic_id
                        )
                    WHERE Type = "Gold";
                '''
    elif args[0] == 'match':
        return f''' select Start_time, End_time, Overseer_olympic_id, Sport_name, count(distinct(Country_name))
from Played group by Start_time, End_time, Overseer_olympic_id, Sport_name having count(distinct(Country_name)) > 2;
                '''


def SEARCH(*args):
    if args[0] == 'player':
        return f'''Select Olympic_id AS "Contestant ID", Name FROM 
                    Contestant WHERE LOWER(Name) LIKE "{args[1]}%";

                '''
    elif args[0] == 'duration2':
        return f'''SELECT Sport_name "Sport",
                        Start_time "Start Time",
                        End_time "End Time"
                    from Olympic_match
                    GROUP BY Overseer_olympic_id,
                        Start_time,
                        End_time,
                        Sport_name
                    HAVING TIMESTAMPDIFF(SQL_TSI_MINUTE, Start_time, End_time) >= 120;
                '''


def AGGREGATE(*args):
    if args[0] == 'country_medals':
        return f'''
                select Country_name AS "Country Name",
                    count(*) AS "Num of Medals won"
                from Medal
                GROUP BY Country_name;
                '''
    elif args[0] == 'maxmedals':
        return f'''select Country_name AS "Country Name", count(*) AS "Num of Medals won"
         from Medal GROUP BY Country_name ORDER BY count(*) DESC LIMIT 1;
                '''
    elif args[0] == 'player_medals':
        return f'''select Contestant_olympic_id AS "Contestant ID",
                    Name,
                    count(*) AS "Num of Medals won"
                from (
                        Medal m
                        JOIN Contestant c ON m.Contestant_olympic_id = c.Olympic_id
                    )
                GROUP BY Contestant_olympic_id;
                '''
    elif args[0] == 'num_match':
        return f'''select Sport_name AS "Sport", count(*)"Num of matches"
         from Olympic_match group by Sport_name;
                '''
    elif args[0] == 'avg_continent':
        return f'''select Country.continent, count(*) from Medal inner join Country on Medal.Country_name = Country.name group by Country.continent;
                '''


def ANALYSIS(*args):
    if args[0] == 'rankings':
        return f'''
                select RANK() OVER (ORDER BY count(*) DESC) AS "Rank",
                Country_name AS "Country Name", count(*) AS "Num of Medals won"
                from Medal GROUP BY Country_name;
                '''
    elif args[0] == 'diversity':
        return f'''(Select Country_name "Country", count(*) "Count", Sex from 
                    (Represents r JOIN Contestant c ON r.Contestant_olympic_id = c.Olympic_id) 
                    group by Country_name, Sex);
                '''
    elif args[0] == 'maxincountry':
        return f'''select Contestant_olympic_id "Contestant ID",
                    Country_name as "Country", num as "Num of medals" from
                    (select Country_name,count(Contestant_olympic_id) as num,
                    Contestant_olympic_id  from Medal group by Country_name,
                    Contestant_olympic_id) tt where tt.num=(select max(xx.num)
                    from (select Country_name,count(Contestant_olympic_id) as num,
                    Contestant_olympic_id  from Medal group by Country_name, Contestant_olympic_id) 
                    xx where xx.Country_name = tt.Country_name) order by Country_name;
                '''
    elif args[0] == 'sponsor':
        return f'''select Sponsor_name, count(*) as "Number of Medals", sum(Donation_value) from Medal inner join Sponsored on Medal.Contestant_olympic_id = Sponsored.Contestant_olympic_id inner join Sponsor on Sponsor.Name = Sponsored.Sponsor_name group by Sponsor_name;
                '''

    elif args[0] == 'continent':
        return f'''select Country.Name, Country.Continent, count(*) from Medal inner join Country on Medal.Country_name = Country.name group by Country.name, Country.continent;
                '''

    elif args[0] == 'correlation':
        return f'''select Country_name, count(*), Investment from Medal inner join Country on Medal.Country_name = Country.Name group by Country_name;
                '''


def INSERT(*args):
    if args[0] == 'coach':
        return f'''
                insert into Coach values({args[0]}, "{args[1]}", "{args[2]}") 
                '''
    elif args[0] == 'contestant':
        return f'''(Select Country_name "Country", count(*) "Count", Sex from 
                    (Represents r JOIN Contestant c ON r.Contestant_olympic_id = c.Olympic_id) 
                    group by Country_name, Sex);
                '''


def UPDATE(*args):
    if args[0] == 'overseer':
        return f'''
                select RANK() OVER (ORDER BY count(*) DESC) AS "Rank",
                Country_name AS "Country Name", count(*) AS "Num of Medals won"
                from Medal GROUP BY Country_name;
                '''
    elif args[0] == 'venue':
        return f'''(Select Country_name "Country", count(*) "Count", Sex from 
                    (Represents r JOIN Contestant c ON r.Contestant_olympic_id = c.Olympic_id) 
                    group by Country_name, Sex);
                '''
    elif args[0] == 'result':
        return f'''select Contestant_olympic_id "Contestant ID",
                    Country_name as "Country", num as "Num of medals" from
                    (select Country_name,count(Contestant_olympic_id) as num,
                    Contestant_olympic_id  from Medal group by Country_name,
                    Contestant_olympic_id) tt where tt.num=(select max(xx.num)
                    from (select Country_name,count(Contestant_olympic_id) as num,
                    Contestant_olympic_id  from Medal group by Country_name, Contestant_olympic_id) 
                    xx where xx.Country_name = tt.Country_name) order by Country_name;
                '''
