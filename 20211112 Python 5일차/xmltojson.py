import xmltodict
import json

# with open('book.xml', 'r') as f:
with open('20211112 Python 5일차/book.xml', 'r') as f:
    book_xml = f.read()

book_dict = xmltodict.parse(book_xml)

with open('20211112 Python 5일차/book.json', 'w') as f:
    book_json = json.dump(book_dict, f)
print("저장")
# book_json2 = json.loads(book_json)
# print(book_json2)
# print(book_json2['books']['book'][0]['author'])


