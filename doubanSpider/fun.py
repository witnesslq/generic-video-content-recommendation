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
            print(e.code)
        if hasattr(e, "reason"):
            print(e.reason)
    finally:
        html = response.read()
    return html


def getData(content_val):
    list_result =[]
    soup = BeautifulSoup(content_val, 'lxml')

    dict_val = soup.find_all(class_='review-list chart', recursive=True)
    # 得到电影评论标题
    for eleOne in dict_val:
        comment_titleList = eleOne.find_all(class_='title-link')
        datalist_comment_title = list([comment_title for comment_title in comment_titleList])
    # 得到电影标题
    for eleTwo in dict_val:
        titleList = eleTwo.find_all('a', 'subject-title')
        datalist_title = list([movie_title for movie_title in titleList])
    # 得到电影链接URL
    for eleThree in dict_val:
        urlList = eleThree.find_all('a', class_='subject-title')
        datalist_url = list([movie_url.attrs['href'] for movie_url in urlList])
    # 得到电影等级
    for eleFour in dict_val:
        rankList = eleFour.find_all('span', 'main-title-rating')
        datalist_rank = list([movie_rank.attrs['title'] for movie_rank in rankList])
    # 得到电影评论链接URL
    for eleFive in dict_val:
        comment_urlList = eleFive.find_all('a', class_='title-link')
        datalist_commentURL = list([movie_commentURL.attrs['href'] for movie_commentURL in comment_urlList])
    # 得到电影简短评论
    for eleSix in dict_val:
        shortCommentList = eleSix.find_all('div', 'short-content')
        datalist_shortComment = list([movie_shortComment for movie_shortComment in shortCommentList])
    for flag in range(0, 10):
        #print(type(datalist_shortComment))  # list
        #print(type(datalist_shortComment[flag]))  # Tag
        list_result.append(datalist_shortComment[flag].contents[0].strip().encode('utf-8'))
    """由于从 https://movie.douban.com/review/best/ 获取数据时，会遇到“如果评论剧透则不会显示”从而使得获取到的值为空的情况，因此， 将其空值手动进行赋值
    图示说明：http://img.vim-cn.com/56/b8a707fb0fcc9b4bc08c738d169f57409a36ce.png
    """
    for final_flag in range(0, 10):
        if((list_result[final_flag]) == ""):
            list_result[final_flag] = "这篇影评可能有剧透， 没关系之后可以显示全文  :-)"
    # 得到电影的海报图片
    for eleSeven in dict_val:
        imageList = eleSeven.find_all('a', class_='subject-img')
        datalist_image = list([movie_image for movie_image in imageList])
    
    for flag in range(0, 10):
        """result = [type(datalist_comment_title[flag].get_text().encode('utf-8')), '\t', type(datalist_title[flag].get_text().encode('utf-8')), '\t', type(datalist_url[flag]), '\t', type(datalist_rank[flag].encode('utf-8')), '\t', type(list_result[flag]), '\t', type(datalist_commentURL[flag]), '\t', type(datalist_image[flag].img["src"])]"""
        result = [datalist_comment_title[flag].get_text().encode('utf-8'), '\t', datalist_title[flag].get_text().encode('utf-8'), '\t', datalist_url[flag], '\t', datalist_rank[flag].encode('utf-8'), '\t', list_result[flag], '\t', datalist_commentURL[flag], '\t', datalist_image[flag].img["src"]]
        SQL_dataText = './getData/dataText.txt'
        try:
            files = open(SQL_dataText, 'a+')
        except BaseException as error:
            print(error.message)
        else:
            files.write(''.join(result) + '\n')
            files.close()
        if(flag == 10):
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
