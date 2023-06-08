from datetime import datetime


def incomplete_arguments(cmd_name: str):
    print(cmd_name+" : Incomplete Arguments")


def invalid_arguments(cmd_name: str, attr_name: str, options: list):
    print(cmd_name+":"+attr_name+" : Invalid Argument > ", options)


def compare_list(length: int, ideal: int, cmd_name: str):
    if (length < ideal):
        incomplete_arguments(cmd_name)
        return True
    return False


def check_date(dob):
    try:
        bool(datetime.strptime(dob, "%Y-%m-%d"))
    except ValueError:
        invalid_arguments(
            "insert", "coach_dob", ["YYYY-MM-DD"])
        return True
    return False
