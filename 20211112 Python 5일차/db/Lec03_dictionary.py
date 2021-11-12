import pymysql

con = pymysql.connect(host="127.0.0.1",
        user='root', passwd='147856', db='testdb', cursorclass=pymysql.cursors.DictCursor)
try:
    with con.cursor() as cur:
        cur.execute('select * from cities')
        rows = cur.fetchall()
        # print(rows)
        #print(f'{"ID"} {"NAME":14} {"POPULATION":8}')
        desc = cur.description
        print(f'{desc[0][0]:<3} {desc[1][0]:<15} {desc[2][0]:>10}')
        for row in rows:
            print(f'{row["id"]:^3} {row["name"]:15} {row["population"]:8}')
finally:
    con.close()