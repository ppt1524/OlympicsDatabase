import pymysql
import pymysql.cursors


class DBconnection:

    # DB connection info
    username = ""
    password = ""
    db_name = ""
    host = ""
    port = 30306

    conn = None
    cursor = None
    try_to_connect = 0

    def __init__(self, host='localhost', username="root",
                 password="Password1!", db_name="olympics", port=30306):
        self.username = username
        self.password = password
        self.db_name = db_name
        self.host = host
        self.port = port
        self.connect()

    def close(self):
        if self.cursor:
            self.cursor.close()
        print()
        print("exitting...")

    def __enter__(self):
        pass

    def execute_query(self, query: str, type="non_fetch"):
        try:
            self.cursor.execute(query)
            if type == 'fetch':
                return self.cursor.fetchall()
            else:
                self.conn.commit()
                return True
        except Exception as e:
            self.conn.rollback()
            print(e)
            print("Failed to execute query....")
            return False

    def connect(self):
        self.try_to_connect += 1
        print()
        print(f'({self.try_to_connect}) Trying to connect to {self.db_name}...')

        try:
            self.conn = pymysql.connect(host=self.host,
                                        port=self.port,
                                        user=self.username,
                                        password=self.password,
                                        db=self.db_name,
                                        cursorclass=pymysql.cursors.DictCursor)

            # self.conn.open = True
            if(self.conn.open):
                print("Connected")
                print()
            else:
                raise Exception("Failed to connect")

            self.cursor = self.conn.cursor()

        except Exception as e:
            print("Error occurred")
            print(e)

        finally:
            if self.try_to_connect < 5 and self.conn == None:
                print('Trying to reconnect...')
                self.connect()
