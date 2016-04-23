#!/usr/bin/env python
# encoding: utf-8

import sys

from PyQt5.QtCore import  QUrl, QObject, pyqtSlot,QVariant,pyqtSignal
from PyQt5.QtWidgets import QApplication
from PyQt5.QtQuick import QQuickView
from PyQt5.QtQml import QJSValue,QQmlApplicationEngine
from threading import Thread

from search import *

class MyMain(QObject):
    signal_add_items = pyqtSignal(QVariant,int)

    def __init__(self):
        super(MyMain,self).__init__()
        self.btsearch = Search()


    @pyqtSlot(str,int,result = QVariant)
    def add_items(self,parm,index):
        bt_thread = Thread(target = self.thread_add_items,args = (parm,index,))
        bt_thread.start()

    @pyqtSlot(str,int,result = QVariant)
    def thread_add_items(self,parm,index):
        result = self.btsearch.search(parm)
        self.signal_add_items.emit(QVariant(result),index)


if __name__ == '__main__':
    path = 'main.qml'
    app = QApplication([])
    view = QQuickView()
    con = MyMain()
    context = view.rootContext()
    context.setContextProperty("con",con)
    view.engine().quit.connect(app.quit)
    view.setSource(QUrl(path))
    view.show()
    root = view.rootObject()
    con.signal_add_items.connect(root.slot_add_items)
    app.exec()

