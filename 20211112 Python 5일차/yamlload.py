import yaml

with open('20211112 Python 5일차/mcintyre.yaml', 'rt') as fin:
    text = fin.read()

data = yaml.load(text)

print(data['dates']['birth'])
print(data['poems'][1]['title'])