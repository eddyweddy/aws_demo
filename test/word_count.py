#!/usr/bin/python

import httplib
import re

from operator import itemgetter

def get_webpage(site,page):
    conn = httplib.HTTPConnection(site, timeout=10)
    conn.request("GET", page)
    res = conn.getresponse()
    print res.status, res.reason
    return res.read()

def get_frequency_count(list):
    freqct = {}
    for elt in list:
        if elt not in freqct:
            freqct[elt]=1
        else:
            freqct[elt]+=1
    return freqct

def main():
    data = get_webpage('54.206.71.106',"/")
    data = re.sub(r'<[^>]+>','',data)
    d = get_frequency_count(data.split(' '))
    sorted_data = sorted(d.items(), key=itemgetter(1), reverse=True)
    print sorted_data
    # for word,count in sorted_data:
    #     print word, ":", count

if __name__ == "__main__":
    main()