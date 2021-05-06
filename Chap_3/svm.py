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

nb_classes=8

def get_cm(y,y_pred,nb_classes):
    cm = np.zeros([nb_classes, nb_classes])
    for i in range(nb_classes):
        c = y_pred[y==i]
        for j in range(c.size):
            cm[i,c[j]]+=1
    return cm

def get_accuracy(cm):
    return [float(cm[i,i]/np.sum(cm[i,:])) for i in range(nb_classes)]
snr1=8

snr1='%d' %snr1

train_set='./dataset/data_fe_'+snr1+'.mat'


print('Loading data...')
train_x=sio.loadmat(train_set,appendmat=False)['train_x'][:,[7,8,10,20,23]]
train_y=np.squeeze(sio.loadmat(train_set,appendmat=False)['train_y'])
#test_x=sio.loadmat(train_set,appendmat=False)['train_x'][:,[7,8,9,13,20]]
#test_y=np.squeeze(sio.loadmat(train_set,appendmat=False)['train_y'])

svr = svm.SVC(decision_function_shape='ovo')

tuned_parameters = [{'kernel': ['rbf'], 'gamma': [1e-2,1e-1,1e-3, 1e-4],
                     'C': [1, 10, 100, 1000]},
                    {'kernel': ['linear'], 'C': [1, 10, 100, 1000]}]
     
clf = GridSearchCV(svr, tuned_parameters, n_jobs=-1)
     
print('Training SVM...')
clf.fit(train_x, train_y) 
#clf.best_params_
'''  
y_pred=np.int64(clf.predict(test_x))

cm = get_cm(test_y, y_pred, nb_classes)
accuracy = get_accuracy(cm)
accuracy_m=np.mean(accuracy)
print(accuracy)
'''
snr = np.arange(-10,21,2)
ace=[]
ace_m=[]
for i in snr:
     print(i)
     a='%d' %i
     test_set='./dataset/data_fe_'+a+'.mat'
     test_x=sio.loadmat(test_set,appendmat=False)['test_x'][:,[7,8,10,20,23]]
     test_y=np.squeeze(sio.loadmat(test_set,appendmat=False)['test_y'])
         
     
     y_pred=np.int64(clf.predict(test_x))

     cm = get_cm(test_y, y_pred, nb_classes)
     accuracy = get_accuracy(cm)
     accuracy_m=np.mean(accuracy)
     ace.append(accuracy)
     ace_m.append(accuracy_m)
     
     savedata='acc_5_'+snr1+'.mat'
sio.savemat(savedata, {'ace':ace,'ace_m':ace_m})
