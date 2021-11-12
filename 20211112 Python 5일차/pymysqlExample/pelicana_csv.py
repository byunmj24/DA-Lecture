import urllib.request
from bs4 import BeautifulSoup
from itertools import count
import pandas as pd 
import ssl 
import datetime

def get_request_url(url, enc='utf-8'):
    context = ssl._create_unverified_context()
    req = urllib.request.Request(url)
    try:
        response = urllib.request.urlopen(req, context=context)
        if response.getcode() == 200:
            print("[%s] Url Request Success " % datetime.datetime.now())
            try:
                rcv =response.read()
                ret = rcv.decode(enc)
            except UnicodeDecodeError:
                ret = rcv.decode(enc, 'replace')
            return ret
    except Exception as e:
        print(e)
        print("[%s] Error for URL " % datetime.datetime.now())


def getPelicanaAdress(result):        
    for page in count():        
        url = 'https://pelicana.co.kr/store/stroe_search.html?branch_name=&gu=&si=&page=%s'\
            %(str(page+1))
        data = get_request_url(url)
        soupData = BeautifulSoup(data, 'html.parser')
        store_table = soupData.find('table', {'class':'table mt20'})
        tbody = store_table.find('tbody')
        bEnd = True
        for store in tbody.find_all('tr'):
            bEnd = False
            tr = list(store.strings)
            store_name = tr[1]
            store_address = tr[3]
            store_phone = tr[5].strip()
            store_sido_gu = store_address.split()[0:2]
            result.append([store_name]+store_sido_gu+[store_address]+[store_phone] )
        if bEnd :
            return

if __name__ == "__main__":    
    result =[]
    print("페리카나 주소 크롤링 시작")
    getPelicanaAdress(result)
    perlicana_table = pd.DataFrame(result, columns=('store', 'sido', 'gungu', 'address', 'phone'))
    perlicana_table.to_csv('20211112 Python 5일차/pymysqlExample/perlicana.csv', encoding='cp949', index=False)
    print("페리카나 크롤링 완료")