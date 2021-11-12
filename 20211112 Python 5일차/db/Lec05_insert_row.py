import pymysql

con = pymysql.connect(host="127.0.0.1",
        user='root', passwd='147856', db='testdb')
myid = 4
city = ('mycity', 20000)
try:
    with con.cursor() as cur:
        cur.execute('insert into cities values (null, %s, %s)', city) #city 자리에 (city[0], city[1]) 로 써도 됨
        con.commit()

        print('new city inserted')
finally:
    con.close()