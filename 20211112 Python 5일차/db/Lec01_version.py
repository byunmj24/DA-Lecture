import pymysql

con = pymysql.connect(host="127.0.0.1",
        user='root', passwd='147856', db='testdb')
try:
    with con.cursor() as cur:
        cur.execute('select version()')
        version = cur.fetchone()
        print(f'디비 버전 : {version[0]}')
finally:
    con.close()