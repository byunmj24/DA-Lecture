import json

with open('book.json','r') as f:
    json_data = json.loads(f.read())
for ele in json_data['books']['book']:
    print(ele['author'], ele['price'])

json.dump
json.dumps
json.load()
json.loads