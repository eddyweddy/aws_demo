#!/usr/bin/python

# Quick and dirty python script that reads a webpage, then counts the occurrence of words, then sorts them

import httplib
import re
import sys

from operator import itemgetter

# Get a static webpage
def get_webpage(site,page):
    conn = httplib.HTTPConnection(site, timeout=10)
    conn.request("GET", page)
    res = conn.getresponse()
    print res.status, res.reason
    return res.read()

# List counter. Returns list plus counts for each
def get_frequency_count(list):
    freqct = {}
    for elt in list:
        print "counting:[",elt,"]"
        if elt not in freqct:
            freqct[elt]=1
        else:
            freqct[elt]+=1
    return freqct

# Tests if input is a empty string
def isNotBlank(teststr):
    if teststr and teststr.strip():
        return True
    return False

def main():
    data = get_webpage(sys.argv[1],"/")
    data = re.sub(r'<[^>]+>','',data)
    data = data.split(' ')
    data = filter(lambda a: isNotBlank(a), data)

    d = get_frequency_count(data)

    sorted_data = sorted(d.items(), key=itemgetter(1), reverse=False)
    # Print entire list
    for word,count in sorted_data:
        print word, ":", count
    # Print the head of the list, its sorted, so this one is the top occurring word
    print "most frequent word: ", sorted_data[0]

if __name__ == "__main__":
    main()