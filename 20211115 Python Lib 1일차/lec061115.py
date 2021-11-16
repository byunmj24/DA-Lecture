# 단점은 자동으로 작동한다. 
# 대신 데이터는 잘 들어간다. 
# 데이타베이스 접속 및 커서 생성 
import pymysql
import pandas as pd
import os
import sqlalchemy

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

#(1) csv=> 데이타 프레임
df = pd.read_csv('population.csv')
print(df.shape)
print(df.info())

#(2) DB 정보 => 엔진 객체에 등록
#sqlalchemy 엔진 정보 생성
# url ='mysql+pymysql://아이디:패스워드@localhost:3306/데이타베이스명'
url = 'mysql+pymysql://root:1234@localhost:3306/testdb'
engine = sqlalchemy.create_engine(url)

print(engine)

#(3) to_sql()로 데이타베이스의 테이블로 등록
df.to_sql(name='population2',con=engine,if_exists='append',index=True)

conn.close()

