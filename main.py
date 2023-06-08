from DBconnection import DBconnection
import functional_req as fr

dbms = None


def print_help():
    with open("help.txt", 'r') as f:
        print(f.read())


if __name__ == "__main__":
    print()
    print_help()

    dbms = DBconnection()
    while True:
        cmd = input("> ").strip()
        cmd_list = list(map(lambda s: s.strip(), cmd.split(' ')))
        operations = {'select': fr.select, 'project': fr.project,
                      'aggregate': fr.aggregate, 'search': fr.search,
                      'analysis': fr.analysis, 'insert': fr.insert, 'delete': fr.delete, 'update': fr.update}
        operations_num = {1: fr.select, 2: fr.select, 3: fr.project, 4: fr.project,
                          5: fr.aggregate, 6: fr.aggregate, 7: fr.aggregate,
                          8: fr.aggregate, 9: fr.aggregate, 10: fr.search, 11: fr.search,
                          12: fr.analysis, 13: fr.analysis, 14: fr.analysis, 15: fr.analysis,
                          16: fr.analysis, 17: fr.analysis, 18: fr.insert, 19: fr.insert,
                          20: fr.insert,
                          21: fr.delete, 22: fr.delete, 23: fr.delete, 24: fr.update, 25: fr.update, 26: fr.update}
        if cmd == 'q':
            break
        if cmd == 'h':
            print_help()
        elif cmd == '':
            continue
        elif cmd.isnumeric():
            if int(cmd) in operations_num:
                operations_num[int(cmd)](cmd_list, dbms, int(cmd))
        elif len(cmd_list) and cmd_list[0].lower() in operations:
            operations[cmd_list[0].lower()](cmd_list, dbms)
        else:
            print(f"{cmd_list[0]} : Invalid Command")
    dbms.close()
