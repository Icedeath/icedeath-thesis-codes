#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Fri Jun 16 19:10:35 2017

@author: icedeath
"""

from sklearn import svm
import numpy as np
from time import time
import scipy.io as sio
from sklearn.model_selection import GridSearchCV
import warnings
warnings.filterwarnings('ignore')

nb_classes=15

def get_cm(y,y_pred,nb_classes):
    cm = np.zeros([nb_classes, nb_classes])
    for i in range(nb_classes):
        c = y_pred[y==i]
        for j in range(c.size):
            cm[i,c[j]]+=1
    return cm

def get_accuracy(cm):
    return [float(cm[i,i]/np.sum(cm[i,:])) for i in range(nb_classes)]
snr1=0

snr1='%d' %snr1

train_set='fe'+snr1+'.mat'



train_set_x=sio.loadmat(train_set,appendmat=False)['feature']
train_set_y=np.squeeze(sio.loadmat(train_set,appendmat=False)['y'])



snr = np.arange(-10,21,2)
ace=[]
ace_m=[]
for i in snr:
     print(i)
     a='%d' %i
     test_set='fe'+a+'.mat'
     test_set_x=sio.loadmat(test_set,appendmat=False)['feature']
     test_set_y=np.squeeze(sio.loadmat(test_set,appendmat=False)['y'])
     
     svr = svm.SVC(decision_function_shape='ovo')
     
     parameters = {'kernel':('linear', 'rbf'), 'C':[1, 10]}
     
     clf = GridSearchCV(svr, parameters, n_jobs=-1)
     
     clf.fit(train_set_x, train_set_y) 
     
     
     y_pred=np.int64(clf.predict(test_set_x))

     cm = get_cm(test_set_y, y_pred, nb_classes)
     accuracy = get_accuracy(cm)
     accuracy_m=np.mean(accuracy)
     ace.append(accuracy)
     ace_m.append(accuracy_m)
     
savedata='acc_lin_'+snr1+'.mat'
sio.savemat(savedata, {'ace':ace,'ace_m':ace_m})