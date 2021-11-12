import pymysql

con = pymysql.connect(host="127.0.0.1",
        user='root', passwd='147856', db='bookstore')

'''
AveragePrice Procedure
CREATE PROCEDURE `AveragePrice`(out averageVal integer)
begin
    select avg(price) into averageVal 
    from book where price is not null;
end
'''
query = "set @averageVal = 0;\
        call AveragePrice(@averageVal);\
        select @averageVal;"
try:
    with con.cursor() as cur:
        # callproc 써서 코드 수정할 것
        cur.callproc("AveragePrice", )
        cur.execute(query)
        result = cur.fetchone()
        print(result)
except:
    raise
finally:
    con.close()