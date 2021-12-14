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
  
def insertBook():
  print('='*30)
  print('책 추가하기')
  print('='*30)
  title = input(" 책 이름 => ")
  writer = input(" 저자 => ")
  page = int(input(" 페이지 수 => "))
  price = int(input(" 가격 => "))
  sql = '''
            INSERT INTO bookTBL(title, writer, page, price)
                VALUES(%s, %s, %s, %s)
          '''
          
  cursor.execute(sql, (title, writer, page, price))
  conn.commit()


def deleteBook():
  print('='*30)
  print('책 삭제하기')
  print('='*30)
  id = input(" 삭제할 책 번호는?   ")
  # 책번호 데이타 확인 
  sql = "SELECT * FROM bookTBL WHERE id = %s"
  cursor.execute(sql, (id,))
  # False 조건 => (), [], {} 
  data = cursor.fetchone()
  # print(data)
  if data:
    sql = '''
              DELETE FROM bookTBL
                  WHERE id = %s
            '''
    cursor.execute(sql, (id))
    conn.commit()
    print('데이타가 삭제되었습니다.\n')
  else:
    print('입력 데이타 오류\n')


def updateBook():
  # 수정할 책 번호는?
  # 수정할 책 정보 출력 
  # 선택? (1.책제목  2.저자  3.페이지수  4.가격 )
  # 1
  # 변경내용 => 파이썬
  # 내용이 수정되었습니다.

  print('='*30)
  print('책 정보 수정하기')
  print('='*30)
  id = input(" 수정할 책 번호는?   ")

  # 아이디값에 대한 책 조회 
  sql = '''
                SELECT * FROM bookTBL
                    WHERE id = %s
              '''
  try:
    cursor.execute(sql, (id,))
    result = cursor.fetchone()
    print('-' * 20)
    print('1.책제목 : ', result[1])
    print('2.저자 : ', result[2])
    print('3.페이지수 : ', result[3])
    print('4.가격 : ', result[4])

    print('-' * 20)
    
    id2 = input('수정 사항 선택? (1.책제목  2.저자  3.페이지수  4.가격)')
    if id2 == '1':
      target = input("책 제목을 입력하세요? ")
      sql = '''
                        UPDATE bookTBL
                            SET title = %s
                            WHERE id = %s
                      '''
      cursor.execute(sql, (target, id))
    elif id2 == '2':
      target = input("저자를 입력하세요? ")
      sql = '''
                        UPDATE bookTBL
                            SET writer = %s
                            WHERE id = %s
                      '''
      cursor.execute(sql, (target, id))
    elif id2 == '3':
      target = input("페이지수를 입력하세요? ")
      sql = '''
                        UPDATE bookTBL
                            SET page = %s
                            WHERE id = %s
                      '''
      cursor.execute(sql, (target, id))
    elif id2 == '4':
      target = input("가격을 입력하세요? ")
      sql = ''' UPDATE bookTBL
                        SET price = %s
                        WHERE id = %s
                      '''
      cursor.execute(sql, (target, id))

    print('-' * 20)
    conn.commit()
    print('데이타가 수정되었습니다.\n')
  except:
        print("입력 오류 발생")
        

# 도서정보 메뉴 
while(True) :
  print('1.목록보기 2.추가 3. 수정 4. 삭제  0. 종료')
  # 메뉴 입력받기 
  choice = input('=> ').strip()
  if choice == '1':
    showBook()
  elif choice == '2':
    insertBook()
  elif choice == '3':
    updateBook()
  elif choice == '4':
    deleteBook()    
  elif choice == '0':
    print('프로그램 종료')  
    break   
  else:
    print("입력 오류 발생")








