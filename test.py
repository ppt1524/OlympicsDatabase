import pymysql
import pymysql.cursors

try:
    con = pymysql.connect(host='localhost',
                          port=30306,
                          user='root',
                          password='Password1!',
                          db='dna',
                          cursorclass=pymysql.cursors.DictCursor)

    if con:
        print("connected")

    con.cursor()
except Exception as e:
    print(e)
