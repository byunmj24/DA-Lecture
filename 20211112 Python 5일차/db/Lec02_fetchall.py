import pymysql

con = pymysql.connect(host="127.0.0.1",
        user='root', passwd='147856', db='testdb')
try:
    with con.cursor() as cur:
        cur.execute('select * from cities')
        rows = cur.fetchall()
        # print(rows)
        for row in rows:
            print(f'{row[0]} {row[1]:14} {row[2]:8}')
finally:
    con.close()