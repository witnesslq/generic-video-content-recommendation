#!/usr/bin/python
#-*- coding: utf-8 -*-

# Author: memory-yancy    <memory.yancy@gmail.com>
# Date: 20161125
# Description: From DouBan-movie get data
# Version:v0.1

import re
import sys
reload(sys)
sys.setdefaultencoding('utf8')
import urllib2
import lxml
from bs4 import BeautifulSoup


def askURL(url):
    request = urllib2.Request(url)
    try:
        response = urllib2.urlopen(request)
    except urllib2.URLError as e:
        if hasattr(e, "code"):
            print e.code
        if hasattr(e, "reason"):
            print e.reason
    finally:
        html = response.read()
    return html


def getData(content_val):
    datalist = []
    soup = BeautifulSoup(content_val, 'lxml')
    dicts = soup.find_all('div', 'main review-item', recursive=True)
    for ele in dicts:
        movie_title = ele.find('a', 'subject-title').get_text()
        movie_comment_title = ele.find('a', 'title-link').get_text()
        movie_rank = ele.find_all('span')[1].attrs['title']
        movie_comment = ele.find('div', 'short-content').get_text()
        print '<电影名>：', movie_title, '<评论标题>：', movie_comment_title, '<电影等级>：', movie_rank, '<电影简介>：', movie_comment.replace('\n', '')
        print '-' * 40


def main():
    baseURL = 'https://movie.douban.com/review/best/?start='
    for i in range(0, 5):
        reqURL = baseURL + str(i * 20)
        print r'正在抓取第' + str(i) + '个页面，请稍等……\n\n'
        result = askURL(reqURL)
        getData(result)

if __name__ == '__main__':
    main()
