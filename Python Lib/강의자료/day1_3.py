# (1) 테스트용 샘플 DB 생성 
'''
-- 파이썬과 연동할 데이타베이스 생성 
-- 데이타베이스 생성 
CREATE DATABASE testDb;
-- 데이타베이스 목록 확인 
SHOW DATABASES;
'''
# (2) 테이블 생성 
'''
-- 데이타베이스 접속 
USE testdb;

-- testdb 접속 
-- bookTbl 테이블 생성 
-- id, title, writer, page, price
CREATE TABLE bookTbl (
	id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, -- 기본키
    title TEXT NOT NULL, -- 책제목
    writer VARCHAR(20) NOT NULL, -- 저자
    page INTEGER NOT NULL, -- 페이지수
    price INTEGER  NOT NULL -- 가격 
);
-- 테이블 목록 확인 
SHOW TABLES;
-- 테이블 정보확인 
DESC bookTbl;
'''
# 데이타베이스 접속 및 커서 생성 
import pymysql
import pandas as pd
import os
# DB 연결 
conn = pymysql.connect( host = 'localhost',
                        port=3306, # mysql 포트
                        user='root', # 접속 계정
                        password = '12345678', # 루트계정의 본인 비번
                        db = 'testdb',  # 접속하고자 하는 데이타베이스명
                        charset = 'utf8' )
cursor = conn.cursor()
print(cursor)


# (4) 레코드 삽입 
# 레코드삽입 1
# 필드값이 auto_increment 인 경우 Null 값으로 지정 
'''
sql = "INSERT INTO 테이블명 VALUES (값1, 값2 ... )"
cursor.execute(sql)
conn.commit()
'''

# sql = '''INSERT INTO bookTbl 
#             VALUES (NULL, "파이썬 완전정복", "박파이", 600, 30000)'''
# cursor.execute(sql)
# # 데이타베이스 반영 
# conn.commit()

# 레코드삽입 2 - % 사용 
'''
sql = "INSERT INTO 테이블명 (필드명1,...) VALUES (%s, %s... )"
cursor.execute(sql, (값1, 값2...))
conn.commit()
'''
# sql = '''INSERT INTO bookTbl (title, writer, page, price)
#             VALUES (%s, %s, %s, %s) '''
# cursor.execute(sql, ('이것이 MySQL이다', '박디비', 500, 35000))
# cursor.execute(sql, ('이것이 오라클이다', '박디비', 500, 23000))
# cursor.execute(sql, ('이것이 파이썬이다', '윤파이', 540, 3500))
# conn.commit()

# 레코드삽입 3 - 
'''
sql = "INSERT INTO 테이블명 (필드명1,...) VALUES (%s, %s... )"
cursor.executemany(sql, 2차원튜플)
conn.commit()
'''

# sql = '''INSERT INTO bookTbl (title, writer, page, price)
#             VALUES (%s, %s, %s, %s) '''
            
# # 2차원 튜플 형태로 삽입 레코드 정의             
# data = (    ('혼공 머신러닝','김머신',800, 70000),
#             ('데이타분석 완전정복','김데이타',800, 6000),
#             ('머신러닝 핸드북','송머신',500, 55000)  )

# cursor.executemany(sql, data)
# conn.commit()


# (5) 레코드 삭제
'''
sql = "DELETE FROM 테이블명 WHERE 필드 = %s"
cursor.execute(sql, (값1,))
conn.commit()
'''
# sql = "DELETE FROM bookTbl WHERE id = %s"
# cursor.execute(sql, (1,))
# conn.commit()


# (6) 레코드 수정
'''
sql = "UPDATE 테이블명 SET 필드1 = %s  WHERE 필드2 = %s"
cursor.execute(sql, (값1, 값2...))
conn.commit()
'''
sql = "UPDATE bookTbl SET price = %s WHERE id = %s"
cursor.execute(sql, (15000, 2))
conn.commit()



# 튜플값이 1개인 경우 (값,)
# myTuple = (100,)
# print(myTuple, type(myTuple))




# 데이타베이스 종료 
conn.close()