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



#########################################기능 1##########################################

# 책 목록 보기 함수 정의 
def showBook():
    print('='*30)
    print('책 목록 전체 보기')
    print('='*30)
    sql='select*from bookTbl;'
    cursor.execute(sql)
    bookData=cursor.fetchall()
    for row in bookData:
        print(row)

#########################################기능 2##########################################

# 레코드 추가하기 함수 정의
def insertBook():
    print('='*30)
    print('레코드 추가하기')
    print('='*30)

# 데이터 입력 받기 
    title = input("책제목: ")
    writer = input("작가: ")
    page = input("페이지 수: ")
    price = input("가격: ")

    # 받은 데이터 적용하기 
    sql1='''INSERT INTO bookTbl (title, writer, page, price)
        VALUE(%s,%s,%s,%s)'''
    cursor.execute(sql1,(title, writer, page, price))
    conn.commit()
    print('데이터가 추가되었습니다')

#########################################기능 3##########################################

# 테이블 보기 showBook 함수 사용
# 수정할 데이터 선택
def re_Book():
    print('='*30)
    print('레코드 수정하기')
    print('='*30)
# 수정할 데이터 선정하기 
    updateBookNum = input("수정할 bookID: ")
    updateNum = int(input("수정 사항 선택? (1.책제목  2.저자  3.페이지수  4.가격) : "))

#수정 적용하기
    try:

        if updateNum == 1:
            modifiedData = input("책 제목을 입력하세요? ")    
            sql = "UPDATE bookTbl SET title = %s WHERE id = %s"
            cursor.execute(sql, (modifiedData, updateBookNum))
        
        elif updateNum == 2:
            modifiedData = input("저자를 입력하세요?")
            sql = "UPDATE bookTbl SET writer = %s WHERE id = %s"
            cursor.execute(sql, (modifiedData, updateBookNum))

        elif updateNum == 3:
            modifiedData = input("페이지수를 입력하세요?")
            sql = "UPDATE bookTbl SET page = %s WHERE id = %s"
            cursor.execute(sql, (modifiedData, updateBookNum))
        elif updateNum == 4:
            modifiedData = input("가격을 입력하세요?")
            sql = "UPDATE bookTbl SET price = %s WHERE id = %s"
            cursor.execute(sql, (modifiedData, updateBookNum))

    except :
        print("존재하지 않는 책입니다.")
# 수정하기 및 적용 


#########################################기능 4##########################################

# 레코드 삭제하기 함수 정의
def delBook():
    print('='*30)
    print('레코드 삭제하기')
    print('='*30)
# 삭제할 데이터 선정하기 
    bookID = input("삭제할 데이터 bookID: ")
# 삭제 데이터 확인하기 
    sql3="DELETE FROM bookTbl WHERE id =%s"
    cursor.execute(sql3,(bookID,))
    conn.commit


#도서정보 메뉴
while(True) :
    print('1.목록보기 2. 추가 3. 수정 4. 삭제 0. 종료')

    #메뉴 입력받기
    choice = input('=>').strip()
    if choice =='1':
        print('목록보기 출력 예정')
        showBook()
    elif choice =='2':
        print('레코드 추가 예정')
        insertBook()
    elif choice =='3':
        print('레코드 수정 예정')
        re_Book()
    elif choice =='4':
        print('레코드 삭제 예정')
        delBook()
    
    elif choice =='0':
        print('프로그램 종료')
        break
    else:
        print("입력 오류 발생")