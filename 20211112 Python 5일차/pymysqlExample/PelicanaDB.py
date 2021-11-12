import pymysql
class MyDB:
    def __init__(self):
        self.db_init()
    def db_init(self):
        self.con = pymysql.connect(
            host='127.0.0.1', user='root', 
            password='147856', db='pythondb',
            charset='utf8')

    def db_free(self):
        if self.con:
            self.con.close()

    def pelicana_crawlingInsert(self,store, sido, gungu, address, phone):
        sql = '''insert into pelicana_crawling(
                 store, sido, gungu, address, phone)
                 values(%s,%s,%s, %s,%s);
                '''
        with self.con.cursor() as cursor :
            cursor.execute(sql,(store, sido, gungu, address, phone))
        self.con.commit()

if __name__ == "__main__":
    db = MyDB()
    db.pelicana_crawlingInsert('시험지점', '우주시', '달나라군', '갤러시199','0000')
    db.db_free()