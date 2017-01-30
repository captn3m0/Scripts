#!/usr/bin/env python

from bs4 import BeautifulSoup
try:
    with open('/tmp/lastfm.html', 'r') as myfile:
        data = myfile.read()
        soup = BeautifulSoup(data, 'html.parser')
        chartlist = soup.find(class_="chartlist-now-scrobbling").parent.parent.find(class_='chartlist-name').get_text().strip().replace('\n', '')
        print(chartlist)
except Exception as e:
    print("FAILED")
    exit(1)
