import pandas as pd

data = pd.read_csv('20211112 Python 5일차/villains.csv')
print(data)

data.to_csv('20211112 Python 5일차/test.csv')

mylist = [10, 20, 30, 40]
yourList = ['국어', '영어', '수학', '미술']

df = pd.DataFrame({'과목':yourList, '성적':mylist})
print(df)
# df.to_csv('20211112 Python 5일차/성적.csv')
# df.to_csv('20211112 Python 5일차/성적.csv', encoding='UTF-8')
df.to_csv('20211112 Python 5일차/성적.csv', encoding='ANSI') # 엑셀파일에서 한글을 보려면ANSI로 인코딩

# score = pd.read_csv('20211112 Python 5일차/성적.csv')
score = pd.read_csv('20211112 Python 5일차/성적.csv', encoding='cp949') # read할 때 인코딩해서 변환 가능
print(score)