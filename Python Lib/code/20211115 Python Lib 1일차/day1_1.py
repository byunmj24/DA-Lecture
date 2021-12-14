# print("Hellow world")
###################################### 개념 정리#######################################

# 판다스란? 주식을 관리하기 위해 만들어진 외부 라이브러리(노트북을 깔면 저절로 설치)
# 파이썬계의 엑셀 
# https://pandas.pydata.org/ 
# 시리즈(컬럼) + 데이타 프레임(테이블)
# 판다스 데이타 구조 => 리스트, 튜플, 집합, 딕셔너리 ( 이구조는 모두 데이터 프레임으로 바꿀 수 있다. =csv 파일)
# csv 파일 = 데이타 프레임 
# 데이타 프레임명 = pd.read_csv(url)

# 넘파이란? Numeric Python 
# 파이썬에서 통계, 확률, 선형대수학을 지원하는 메서드 포함 

import pandas as pd #(판다스 부르기)
import numpy as np #(넘파이 부르기)\
import os #(os부르기 )

# 설치 확인은? pip list 하고 체크
# pip install pandas 
# interpreter 작업환경 변경하기 ctr+p 


# 판다스 데이터 가져오기  데이타 프레임명 = pd.read_csv(url)
df=pd.read_csv('data.csv')
print(df)

# 컬러명 확인하기 
print(df.columns)
# Index(['class', 'name', 'kor', 'eng', 'mat', 'bio'], dtype='object')
print(df.index)
# RangeIndex(start=0, stop=12, step=1)
# 전체구조 확인하기
print(df.shape) #(12,6)


# 현재 기준이 되는 작업폴더 표시 
print(os.getcwd())
# C:\Users\medici\Desktop\메디치\본교육\03김미영 강사님\1115실습자료


# 리스트[start:end:step]이렇게 작성했었으나 데이터 프레임에서는 조금 다르다. 
# MyList[:3]

#예시 리스트 만들어보기
myList =[10,20,30,40,50]
print(myList[0:2]) #[10, 20]

# 데이터프레임 컬럼 인덱스
# 데이타프레임명[컬럼명]
print(df['name'])

# 데이타프레임명[[컬럼명1,컬럼명2,컬럼명3,...]]
print('='*50)
print(df['name']) # 시리즈로 반환
print('='*50)
print(df[['name','class']])  # e데이타 프레임으로 반환

# 데이타프레임 행 인덱스
# 데이타프레임.head(n) - 앞에서 특정수의 행 반환
# 데이타프레임.tail(n) - 뒤에서 특정수의 행 반환
# 데이타프레임.loc[start:end] - location 행이름
# 데이타프레임.iloc[start:end] - index location 숫자인덱스 

print('='*50)
print(df.head(5))
print('='*50)
print(df.tail(5))
print('='*50)
print(df.loc[4:6]) # 4,5,6 출력
print('='*50)
print(df.iloc[4:6]) # 마지막은 버리고 4,5 출력

# 특정행의 특정열 인덱싱
# 데이타프레임.loc[start:end, start:end]-location 행이름과 열이름
# 데이타프레임.iloc[start:end, start:end]-index location 숫자인덱스
print('='*50)
print(df.iloc[4:6])
#1반의 이름과 국어 점수만 표시
print('='*50)
print(df.loc[0:5, 'class':'kor'])
print('='*50)
print(df.iloc[0:6, 0:3])

# 특정행의 특정열 
# 데이타프레임.loc[[행이름1, 행이름2, ...],[열이름1, 열이름2...]]-location 행이름과 열이름
# 데이타프레임.iloc[[인덱스1, 인덱스2,...],[인덱스1, 인덱스2....]]-index location 숫자인덱스
# 1반의 kor, math 컬럼

print('='*50)
print(df.loc[0:5, ['class','kor','mat']])
print('='*50)
print(df.iloc[0:6, [0,2,4]])

# csv 파일로 저장
# 데이타프레임.to_csv(url)
# 1반의 이름, 국어, 영어, 수학 => output/data2.csv
print('='*50)
print(df.loc[0:5, 'name':'mat']) #원하는 데이터 불러오기 
print('='*50)
# 아웃풋 폴더 저장하기 

try : # try로 만일 미리 만들어져 있을 경우 대비 (있는 경우 문구 출력)
    os.mkdir('output') # 현재를 기준으로 폴더를 만들어주는 코드 
except:
    print("폴더가 이미 생성되어 있습니다. ")

# 이대로 저장해주는 코드 (print 삭제->.to_csv(url) )df.loc[0:5, 'name':'mat'].to_csv('output/data2.csv') 
# 복사하고 싶은 경우
df2=df.loc[0:5, 'name':'mat']
df2.to_csv('output/data2.csv',index=False) #index=false일 경우 행이름이 저장되지\\ 않음 (인덱스 넘버 삭제)


# 퀴즈 - 
# population.csv에서 마지막 10개만 잘라서 
# output/population.csv파일로 저장 
print('='*50)
popul=pd.read_csv('population.csv') 
print(popul.shape)#(51, 2)
popultail = popul.tail(10)
popultail.to_csv('output/data1.csv',index=False)