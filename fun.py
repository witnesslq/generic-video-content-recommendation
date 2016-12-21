#!/usr/bin/env python
#-*- coding: utf-8 -*-

# Author: memory-yancy    <root@memory-yancy.com>
# Date: 20161125
# Description: From DouBan-movie get data


import urllib2
import lxml
import time
import progressbar
from bs4 import BeautifulSoup


def askURL(url):
    request = urllib2.Request(url)
    try:
        response = urllib2.urlopen(request)
    except urllib2.HTTPError as e:
        if hasattr(e, "code"):
            print e.code
        if hasattr(e, "reason"):
            print e.reason
    finally:
        html = response.read()
    return html


def getData(content_val):
    flag = 0
    datalist = []
    soup = BeautifulSoup(content_val, 'lxml')

    dict_val = soup.find_all(class_='review-list chart', recursive=True)
    # 得到电影评论标题
    for eleOne in dict_val:
        comment_titleList = eleOne.find_all(class_='title-link')
        datalist_comment_title = list(
            [comment_title for comment_title in comment_titleList])
    # 得到电影标题
    for eleTwo in dict_val:
        movie_titleList = eleTwo.find_all('a', 'subject-title')
        datalist_movie_title = list(
            [movie_title for movie_title in movie_titleList])
    # 得到电影链接URL
    for eleThree in dict_val:
        movie_urlList = eleThree.find_all('a', class_='subject-title')
        datalist_movie_url = list([movie_url.attrs['href']
                                   for movie_url in movie_urlList])
    # 得到电影等级
    for eleFour in dict_val:
        movie_rankList = eleFour.find_all('span', 'main-title-rating')
        datalist_movie_rank = list(
            [movie_rank.attrs['title'] for movie_rank in movie_rankList])
    # 得到电影评论链接URL
    for eleFive in dict_val:
        movie_commentURL_List = eleFive.find_all('a', class_='title-link')
        datalist_movie_commentURl = list(
            [movie_commentURL.attrs['href'] for movie_commentURL in movie_commentURL_List])
    # 得到电影简短评论
    for eleSix in dict_val:
        movie_shortCommentList = eleSix.find_all('div', 'short-content')
        datalist_movie_shortComment = list(
            [movie_shortComment for movie_shortComment in movie_shortCommentList])
    # 得到电影的海报图片
    for eleSeven in dict_val:
        movie_imageList = eleSeven.find_all('a', class_='subject-img left')
        datalist_movie_image = list([movie_image for movie_image in movie_imageList])
    
    for flag in range(0, 10):
        result = [datalist_comment_title[flag].get_text(), '\t', datalist_movie_title[flag].get_text(), '\t', datalist_movie_url[flag], '\t', datalist_movie_rank[
            flag], '\t', unicode(datalist_movie_shortComment[flag].contents[0]).strip(), '\t', datalist_movie_commentURl[flag], '\t', 
            datalist_movie_image[flag].img["src"]]
        SQL_dataText = './getData/dataText.txt'
        try:
            files = open(SQL_dataText, 'a+')
        except IOError:
            IOError.message
        else:
            files.write(''.join(result).encode('utf-8') + '\n')
        files.close()
    print '[ 当期文件路径: ]', files.name
    print


def main():
    baseURL = 'https://movie.douban.com/review/best/?start='
    for i in range(0, 5):
        reqURL = baseURL + str(i * 20)
        print r'正在抓取第' + str(i) + '个页面，请稍等……'
        print_bar()
        result = askURL(reqURL)
        getData(result)


def print_bar():
    bar = progressbar.ProgressBar();
    for i in bar(range(100)):
        time.sleep(0.05)


if __name__ == '__main__':
    main()
