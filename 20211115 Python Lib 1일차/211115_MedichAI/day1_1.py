# print("Hello world")
# 판다스란?
# 파이썬계의 엑셀 
# https://pandas.pydata.org/
# 시리즈(컬럼) + 데이타프레임(테이블) 

# 넘파이란?
# https://numpy.org/
# Numeric Python 
# 파이썬에서 통계, 확률, 선형대수학을 지원하는 메서드 포함 

import pandas as pd
import numpy as np
# 설치확인은? pip list
# pip install pandas
# pip install numpy
import os

# 파이썬의 데이타구조 => 리스트, 튜플, 집합, 딕셔너리 
# csv 파일 => 데이타프레임 
# 데이타프레임명 = pd.read_csv(url)
df = pd.read_csv('data/data.csv')
print(df)

# 컬럼명 확인하기 
print(df.columns)
# Index(['class', 'name', 'kor', 'eng', 'mat', 'bio'], dtype='object')
print(df.index)
# RangeIndex(start=0, stop=12, step=1)
# 전체 구조 확인하기 
print(df.shape) # (12, 6)

# print(os.getcwd()) # 현재 기준이 되는 작업폴더가 표시 

# 리스트[start:end:step]
# myList[:3]
myList = [ 10, 20, 30, 40, 50]
print(myList[0:2]) # [10, 20]

# 데이타프레임 컬럼 인덱스 
# 데이타프레임명[컬럼명]
# 데이타프레임명[[컬럼명1, 컬럼명2 ... ]]
print('='*50)
print(df['name']) # 시리즈로 반환 
print('='*50)
print(df[['name', 'class']]) # 데이타프레임으로 반환 

# 데이타프레임 행 인덱스 
# 데이타프레임.head(n) - 앞에서 특정수의 행 반환 
# 데이타프레임.tail(n) - 맨 뒷부분에서 특정수의 행 반환 
# 데이타프레임.loc[start:end] - location 행이름
# 데이타프레임.iloc[start:end] - index location 숫자인덱스
print('='*50)
print(df.head(2))
print('='*50)
print(df.tail(2))
print('='*50)
print(df.loc[4:6]) # 4, 5, 6 행 출력 
print('='*50)
print(df.iloc[4:6]) # 4, 5 행 

# 특정행의 특정열 인덱싱 
# 데이타프레임.loc[start:end, start:end] - location 행이름과 열이름
# 데이타프레임.iloc[start:end, start:end] - index location 숫자인덱스
print('='*50)
print(df.iloc[4:6]) 
# 1반의 이름과 국어 점수만 표시 
print('='*50)
print(df.loc[0:5, 'class':'kor']) 
print('='*50)
print(df.iloc[0:6, 0:3]) 

# 특정행의 특정열 
# 데이타프레임.loc[[행이름1, 행이름2 ... ], [열이름1, 열이름2 ...]] 
# 데이타프레임.iloc[[인덱스1, 인덱스2 ...], [인덱스1, 인덱스2 ...]]
# 1반의 kor, math 컬럼 
print('='*50)
print(df.loc[0:5, ['class','kor', 'mat']]) 
print('='*50)
print(df.iloc[0:6, [0, 2, 4]]) 

# csv 파일로 저장 
# 데이타프레임.to_csv(url)
# 1반의 이름, 국어, 영어, 수학 => output/data2.csv
print('='*50)
print(df.loc[0:5, 'name':'mat']) 
print('='*50)

# 현재 폴더를 기준으로 output 폴더 생성 
try:
  os.mkdir('output')
except:
  print('폴더가 이미 생성되어 있습니다.')

df2 = df.loc[0:5, 'name':'mat']
# index=False 는 행이름 저장되지 않음
df2.to_csv('output/data2.csv', index=False)  

# 퀴즈 - 
# population.csv 에서 마지막에서 10개만 잘라서 
# output/population.csv 파일로 저장 
print('='*50)
df_pop = pd.read_csv('data/population.csv')
print(df_pop.shape) # (51, 2)
# print(df_pop.head(2))
df_pop2 = df_pop.tail(10)
# df_pop2 = df_pop.loc[41:]
# df_pop2 = df_pop.iloc[41:]
print(df_pop2)
df_pop2.to_csv('output/population2.csv', index=False)  