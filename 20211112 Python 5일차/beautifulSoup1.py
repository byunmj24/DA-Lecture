from bs4 import BeautifulSoup

# with open('book.xml', 'r') as f:
with open('20211112 Python 5일차/book.xml', 'r') as f:
    book_xml = f.read()

#print(book_xml)

soup = BeautifulSoup(book_xml, 'lxml')
print(type(soup))

books = soup.find_all('author')                                                                                     
print(type(books))
print(books[0].get_text(), books[1].get_text())
