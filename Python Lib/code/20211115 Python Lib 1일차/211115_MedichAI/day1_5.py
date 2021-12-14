# csv => 데이타프레임 => MySQL의 등록된 테이블에 레코드로 삽입 
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

# (1) csv => 데이타프레임
df = pd.read_csv('data/population.csv')
print(df.shape) # (51, 2)
# 데이타프레임의 필드 정보 확인 
print(df.info())

# (2) 테이블 생성 
'''
USE testdb;
CREATE TABLE population (
 	id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, -- 기본키
	state VARCHAR(30) NOT NULL, -- 주 
    population VARCHAR(20) NOT NULL -- 인구 
 );
SHOW TABLES;
DESC population;
'''

# (3) 데이타프레임.iterrows() + for => 테이블 레코드 
# 데이타프레임.iterrows() => 각 행단위 접근
print(df.iterrows())
for row in df.iloc[:5].iterrows():
  print(row)
'''
(4, State         California
Population    37,254,522
Name: 4, dtype: object)
'''
# 아이템.컬럼명 사용 
print('='*50)
for index, row in df.iterrows():
  print(index, row.State, row.Population)

print('='*50)
sql = '''INSERT INTO population (state, population)
            VALUES (%s, %s) '''
# 데이타프레임 한행씩 가져와서  MySQL의 테이블에 삽입 
for index, row in df.iterrows():
  cursor.execute(sql, (row.State, row.Population))

conn.commit()

conn.close()      