#!/usr/bin/python

# Quick and dirty python script that reads a webpage, then counts the occurrence of words, then sorts them

import httplib
import re
import sys

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
    data = get_webpage(sys.argv[1],"/")
    data = re.sub(r'<[^>]+>','',data)
    d = get_frequency_count(data.split(' '))
    sorted_data = sorted(d.items(), key=itemgetter(1), reverse=True)
    # Print entire list
    for word,count in sorted_data:
        print word, ":", count
    # Print the head of the list, its sorted, so this one is the top occuring word
    print "most frequent word: ", sorted_data[1]

if __name__ == "__main__":
    main()