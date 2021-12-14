# csv=> 데이터 프레임으로 가져오기 
# 데이타베이스 접속 및 커서 생성 
import pymysql
import pandas as pd
import os

# Db연결
conn = pymysql.connect( host = 'localhost',
                        port=3306, # mysql 포트
                        user='root', # 접속 계정
                        password = '1234', # 루트계정의 본인 비번
                        db = 'testDb',  # 접속하고자 하는 데이타베이스명
                        charset = 'utf8' )

# 커서 생성
cursor = conn.cursor()
print(cursor)

#1 csv => 데이타 프레임
df =pd.read_csv('population.csv')
print(df.shape) #(51,2)

# 데이타프레임의 필드 정보 확인
print(df.info()) # 각각의 데이타 타입을 보는 명령어

#3 데이타프레임.iterrows()+for=>테이블 레코드
# epdlxkvmfpdla.iterrows()=> 각 행단위 접근
print(df.iterrows())
for row in df.iloc[:5].iterrows():
    print(row)

# 아이템. 컬럼명 사용
print('='*50)
for index, row in df.iterrows():
    print(index, row.State, row.Population)


print('='*50)
sql='''INSERT INTO population(state, population)
    VALUES(%s,%s)'''

# 데이타프레임 한행씩 가져와서 돌리기
for index, row in df.iterrows():
    cursor.execute(sql, (row.State, row.Population))
conn.commit()

conn.close()