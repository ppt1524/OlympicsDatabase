import error
import DBconnection
import queries
from prettytable import PrettyTable


def pretty_print(table):
    if table and len(table):
        # print(table)
        print()
        column = []
        for x in table[0]:
            column.append(x)
        pt = PrettyTable(column)
        for i in range(0, len(table)):
            row = []
            for x in table[i]:
                row.append(table[i][x])
            pt.add_row(row)
        print(pt)
        print(len(table), "result" if len(table) == 1 else "results")
        print()
    else:
        print("No data")


def select(cmd_list: list, dbms: DBconnection, cmd_num=0):
    if not cmd_num and error.compare_list(len(cmd_list), 3, 'select'):
        return
    attr_options = ['coach', 'contestant', "table"]
    index = cmd_num - 1
    arg3 = 0
    if cmd_num:
        arg3 = input(f"Enter country name for {attr_options[index]}s : ")
    else:
        arg3 = cmd_list[2]
    cmd_list.append(attr_options[index])
    for attr in attr_options:
        if cmd_list[1].lower() == attr:
            table = None
            if attr == 'coach':
                table = dbms.execute_query(
                    queries.SELECT('coach', arg3), 'fetch')
            elif attr == 'contestant':
                table = dbms.execute_query(
                    queries.SELECT('contestant', arg3), 'fetch')
            elif attr == 'table':
                table = dbms.execute_query(f"select * from {arg3};", 'fetch')
            pretty_print(table)
            return
    error.invalid_arguments('select', 'person', attr_options)


def project(cmd_list: list, dbms, cmd_num=0):
    if not cmd_num and error.compare_list(len(cmd_list), 2, 'project'):
        return
    attr_options = ['gold', 'match']
    index = cmd_num - 3
    if cmd_num:
        cmd_list.append(attr_options[index])
    for attr in attr_options:
        if cmd_list[1].lower() == attr:
            table = None
            if attr == 'gold':
                table = dbms.execute_query(
                    queries.PROJECT('gold'), 'fetch')
            elif attr == 'match':
                table = dbms.execute_query(
                    queries.PROJECT('match'), 'fetch')
            pretty_print(table)
            return
    error.invalid_arguments('project', 'type', attr_options)


def aggregate(cmd_list: list, dbms, cmd_num=0):
    if not cmd_num and error.compare_list(len(cmd_list), 2, 'aggregate'):
        return
    attr_options = ['country_medals', 'maxmedals',
                    'player_medals', 'num_match', 'avg_continent']
    index = cmd_num - 5
    if cmd_num:
        cmd_list.append(attr_options[index])
    for attr in attr_options:
        if cmd_list[1].lower() == attr:
            table = None
            if attr == 'country_medals':
                table = dbms.execute_query(
                    queries.AGGREGATE('country_medals'), 'fetch')
            elif attr == 'maxmedals':
                table = dbms.execute_query(
                    queries.AGGREGATE('maxmedals'), 'fetch')
            elif attr == 'player_medals':
                table = dbms.execute_query(
                    queries.AGGREGATE('player_medals'), 'fetch')
            elif attr == 'num_match':
                table = dbms.execute_query(
                    queries.AGGREGATE('num_match'), 'fetch')
            elif attr == 'avg_continent':
                table = dbms.execute_query(
                    queries.AGGREGATE('avg_continent'), 'fetch')
            pretty_print(table)
            return

    error.invalid_arguments('aggregate', 'type', attr_options)


def search(cmd_list: list, dbms, cmd_num=0):
    if not cmd_num and error.compare_list(len(cmd_list), 2, 'search'):
        return
    attr_options = ['player', 'duration2']
    index = cmd_num - 10
    if cmd_num:
        cmd_list.append(attr_options[index])
    cmd_list.append("dummy")
    arg3 = 0
    if cmd_num == 10:
        arg3 = input(f"Enter str for {attr_options[index]} search : ")
    else:
        arg3 = cmd_list[2].lower()
    if cmd_num:
        cmd_list.append(attr_options[index])
    for attr in attr_options:
        if cmd_list[1].lower() == attr:
            table = None
            if attr == 'player':
                table = dbms.execute_query(
                    queries.SEARCH('player', arg3), 'fetch')
            elif attr == 'duration2':
                table = dbms.execute_query(
                    queries.SEARCH('duration2', arg3), 'fetch')
            pretty_print(table)
            return
    error.invalid_arguments('search', 'type', attr_options)


def analysis(cmd_list: list, dbms, cmd_num=0):
    if not cmd_num and error.compare_list(len(cmd_list), 2, 'analysis'):
        return
    attr_options = ['rankings', 'sponsor', 'correlation', 'diversity',
                    'continent', 'maxincountry']
    index = cmd_num - 12
    if cmd_num:
        cmd_list.append(attr_options[index])
    for attr in attr_options:
        if cmd_list[1].lower() == attr:
            table = None
            if attr == 'rankings':
                table = dbms.execute_query(
                    queries.ANALYSIS('rankings'), 'fetch')
            elif attr == 'diversity':
                table = dbms.execute_query(
                    queries.ANALYSIS('diversity'), 'fetch')
            elif attr == 'maxincountry':
                table = dbms.execute_query(
                    queries.ANALYSIS('maxincountry'), 'fetch')
            elif attr == 'sponsor':
                table = dbms.execute_query(
                    queries.ANALYSIS('sponsor'), 'fetch')
            elif attr == 'continent':
                table = dbms.execute_query(
                    queries.ANALYSIS('continent'), 'fetch')
            elif attr == 'correlation':
                table = dbms.execute_query(
                    queries.ANALYSIS('correlation'), 'fetch')
            pretty_print(table)
            return
    error.invalid_arguments('search', 'type', attr_options)


def insert(cmd_list: list, dbms, cmd_num=0):
    if not cmd_num and error.compare_list(len(cmd_list), 2, 'insert'):
        return
    attr_options = ['coach', 'contestant', 'venue']
    index = cmd_num - 18
    if cmd_num:
        cmd_list.append(attr_options[index])
    for attr in attr_options:
        if cmd_list[1].lower() == attr:
            if attr == 'coach':
                coach_id, name, dob, country = input("Enter Coach ID : "), input(
                    "Enter Coach name : "), input("Enter Coach DOB : "), input("Enter Coach Country : ")
                if not coach_id or not coach_id.isnumeric():
                    error.invalid_arguments("insert", "coach_id", ["numeric"])
                    return
                if error.check_date(dob):
                    return
                xx = (dbms.execute_query(
                    f'insert into Coach values({coach_id}, "{name}", "{dob}");'))
                # print(xx)
                if xx:
                    cc = dbms.execute_query(
                        f'insert into Coach_from values({coach_id}, "{country}");')
                    if cc:
                        print("Coach added successfully.")
            elif attr == 'contestant':
                coach_id, name, dob, country = input("Enter Contestant ID : "), input(
                    "Enter Contestant name : "), input("Enter Contestant DOB : "), input("Enter Contestant Country : ")
                sex, weight, height = input(
                    "Enter Sex (M/F): "), input("Enter weight: "), input("Enter height: ")
                if not coach_id or not coach_id.isnumeric():
                    error.invalid_arguments(
                        "insert", "contestant_id", ["numeric"])
                    return

                if not weight or not weight.isnumeric() or not weight.isdecimal():
                    error.invalid_arguments(
                        "insert", "weight", ["decimal"])
                    return
                if not height or not height.isnumeric() or not height.isdecimal():
                    error.invalid_arguments(
                        "insert", "weight", ["decimal"])
                    return
                if sex != 'M' and sex != 'F':
                    error.invalid_arguments(
                        "insert", "sex", ["M/F"])
                    return
                if error.check_date(dob):
                    return
                xx = (dbms.execute_query(
                    f'insert into Contestant values({coach_id}, "{sex}", "{weight}","{height}","{name}", "{dob}");'))
                # print(xx)
                if xx:
                    cc = dbms.execute_query(
                        f'insert into Represents values({coach_id}, "{country}");')
                    if cc:
                        print("Contestant added successfully.")
            elif attr == 'venue':
                sport, venue = input("Enter Sport : "), input(
                    "Enter Venue name : ")
                xx = (dbms.execute_query(
                    f'insert into Venue values("{sport}", "{venue}");'))
                if xx:
                    print("Venue added successfully")
                pass
            return
    error.invalid_arguments('insert', 'type', attr_options)


def delete(cmd_list: list, dbms, cmd_num=0):
    if not cmd_num and error.compare_list(len(cmd_list), 2, 'delete'):
        return
    attr_options = ['overseer', 'player', 'sponsor']
    index = cmd_num - 21
    if cmd_num:
        cmd_list.append(attr_options[index])
    for attr in attr_options:
        if cmd_list[1].lower() == attr:
            id = input("ID : ")
            if attr == 'overseer':
                xx = (dbms.execute_query(
                    f'delete from Overseer where Olympic_id = {id};'))
                if xx:
                    print("Deleted successfully")
            elif attr == 'player':
                xx = (dbms.execute_query(
                    f'delete from Contestant where Olympic_id = {id};'))
                if xx:
                    print("Deleted successfully")
            elif attr == 'sponsor':
                xx = (dbms.execute_query(
                    f'delete from Sponsor where Name = {id};'))
                if xx:
                    print("Deleted successfully")
            return
    error.invalid_arguments('insert', 'type', attr_options)


def update(cmd_list: list, dbms, cmd_num=0):
    if not cmd_num and error.compare_list(len(cmd_list), 2, 'update'):
        return
    attr_options = ['overseer', 'contestant', 'venue']
    index = cmd_num - 24
    if cmd_num:
        cmd_list.append(attr_options[index])
    for attr in attr_options:
        if cmd_list[1].lower() == attr:
            if attr == 'venue':
                coach_id, start, end, new_over, location = input("Enter ID : "), input(
                    "Enter start time : "), input("Enter end time : "), input("Enter New Venue : "), input("Enter New Location : ")

                xx = (dbms.execute_query(
                    f'UPDATE Plays SET Venue_name="{new_over}", Location="{location}" WHERE Olympic_id={coach_id} AND Start_time = "{start}" AND End_time="{end}";'))
                # print(xx)
                if xx:
                    print("Updated successfully.")
            elif attr == 'overseer':
                coach_id, start, end, new_over = input("Enter Overseer ID : "), input(
                    "Enter start time : "), input("Enter end time : "), input("Enter New OverSeer ID : ")

                xx = (dbms.execute_query(
                    f'UPDATE Olympic_match SET Overseer_olympic_id={new_over} WHERE Overseer_olympic_id={coach_id} AND Start_time = "{start}" AND End_time="{end}";'))
                # print(xx)
                if xx:
                    print("Updated successfully.")

            elif attr == 'contestant':
                coach_id, start, end, medal = input("Enter Contestant ID : "), input(
                    "Enter start time : "), input("Enter end time : "), input("Enter New Medal : ")
                if medal not in ['Gold', 'Bronze', 'Silver']:
                    error.invalid_arguments("update", "contestant.medal", [
                                            'Gold', 'Bronze', 'Silver'])
                    return

                xx = (dbms.execute_query(
                    f'UPDATE Medal SET Type="{medal}" WHERE Contestant_olympic_id={coach_id} AND Match_start_time = "{start}" AND Match_end_time="{end}";'))
                # print(xx)
                if xx:
                    print("Updated successfully.")

            return
    error.invalid_arguments('insert', 'type', attr_options)
