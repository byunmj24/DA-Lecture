# pymysql를 이용한 데이타베이스 연동 
# 모듈 임포트 
# pip install pymysql
import pymysql
import pandas as pd
import os

# (1) DB 연결 
conn = pymysql.connect( host = 'localhost',
                        port=3306, # mysql 포트
                        user='root', # 접속 계정
                        password = '12345678', # 루트계정의 본인 비번
                        db = 'world',  # 접속하고자 하는 데이타베이스명
                        charset = 'utf8' )

# (2) 커서 생성 
cursor = conn.cursor()
print(cursor)
# <pymysql.cursors.Cursor object at 0x000001A1DDF0B490>

# (3) 접속 데이타베이스의 테이블 정보 => 파이썬 데이타 
# 테이블 Read 
# sql = select 구문 
# cursor.execute(sql)
# 데이타변수명 = cursor.fetchall() / cursor.fetchone() / cursor.fetchmany(n)

sql = 'select * from city limit 20';
cursor.execute(sql)
cityData = cursor.fetchall() # 2차원 튜플
# cityData = cursor.fetchmany(3) # 2차원 튜플
# cityData = cursor.fetchone() # 1차원 튜플 

print(cityData)
print(len(cityData))
print(type(cityData)) # <class 'tuple'>
# print(cityData[0])
# (1, 'Kabul', 'AFG', 'Kabol', 1780000)

# (4) 파이썬 데이타:2차원 튜플 => 데이타프레임 
# 데이타프레임명 = pd.DataFrame(데이타, columns=[컬럼명1, 컬럼명2...])
df = pd.DataFrame(cityData, 
                  columns=['ID', 'Name', 'CountryCode', 'District', 'Population'])
print('='*50)
print(df.head())

# (5) csv 저장 
df.to_csv('output/city10A.csv', index=False)
df[['Name', 'Population']].to_csv('output/city10B.csv', index=False)

# 데이타베이스 닫기 
conn.close()

