# 레코드 수정, 삭제, 추가 함수 정의후 메인 메뉴에 
# 연결하는 퀴즈입니다. 
# 제출은 강사 메일로 꼭 수강생명을 함께 전송해주세요.
# 이메일 (coderecipe@naver.com)


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


# 책 목록 보기 함수 정의 
def showBook():
  print('='*30)
  print('책 목록 전체 보기')
  print('='*30)
  sql = 'select * from bookTbl';
  cursor.execute(sql)
  bookData = cursor.fetchall()
  for row in bookData:
    print(row)
  



# 도서정보 메뉴 
while(True) :
  print('1.목록보기 2.추가 3. 수정 4. 삭제  0. 종료')
  # 메뉴 입력받기 
  choice = input('=> ').strip()
  if choice == '1':
    #  print('목록보기 출력 예정')
    showBook()
  elif choice == '2':
    print('레코드 추가 예정')
  elif choice == '3':
    print('레코드 수정 예정')
  elif choice == '4':
    print('레코드 삭제 예정')      
  elif choice == '0':
    print('프로그램 종료')  
    break   
  else:
    print("입력 오류 발생")








