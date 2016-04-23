#!/usr/bin/env python
# encoding: utf-8

import requests
import socks
import socket
from lxml import etree

class Search:

    def __init__(self):
        socks.set_default_proxy(socks.SOCKS5,"127.0.0.1",1080)
        socket.socket = socks.socksocket

    def search(self,parm):
        url = 'http://www.btdigg.org/search?info_hash=&q='
        url += parm


        headers = {'User-Agent':'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/48.0.2564.82 Chrome/48.0.2564.82 Safari/537.36'}

        r = requests.get(url,headers = headers)

        selector = etree.HTML(r.content)
        page_num = int(selector.xpath('//*[@id="body"]/center/table[2]/tr/td[2]/text()')[0].split(r'/')[1])

        self.url_list = [url + '&p='+str(i) for i in range(1,page_num+1)]
        if len(self.url_list)>3:
            self.url_list = self.url_list[0:3]

        return self.content_parse()



    def content_parse(self):

        headers = {'User-Agent':'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/48.0.2564.82 Chrome/48.0.2564.82 Safari/537.36'}
        name_format = 'tr[{0}]/td[2]/table[1]/tr/td/a/text()'
        href_format = 'tr[{0}]/td[2]/table[2]/tr/td/a/@href'


        result = []

        try:
            for url in self.url_list:

                r = requests.get(url,headers = headers)
                selector = etree.HTML(r.content)


                info_list = selector.xpath('//*[@id="search_res"]/table')[0]

                for i in range(1,len(info_list)):

                    name = info_list.xpath(name_format.format(i))[0]
                    href = info_list.xpath(href_format.format(i))[0]
                    result.append({'name' : str(name),'url' : str(href)})
        except:
            pass


        return result





if __name__ == '__main__':
    s = Search()
    print(s.search('zzz'))

