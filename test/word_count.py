#!/usr/bin/python
import httplib
import httplib from operator import itemgetter
import re

def get_webpage(site,page):
    conn = httplib.HTTPConnection(site)
    conn.request("GET", page)
    rd = conn.getresponse()
    print rd.status, rd.reason
    return rd.read()

def get_freqct(list):
    freqct = {}
    for s in list:
        if s not in freqct:
            freqct[s]=1
        else:
            freqct[s]+=1
    return freqct

def main():
    data = get_webpage('54.206.71.106',"/")
    data = re.sub(r'<[^>]+>','',data)
    d = get_freqct(data.split(' '))
    sol = sorted(d.items(), key=itemgetter(1))
    for word,count in sol:
        print word, ":", count

if __name__ == "__main__":
    main()