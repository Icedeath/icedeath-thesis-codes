#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Fri Nov 23 17:25:51 2018

@author: icedeath
"""
import scipy.io as sio
import numpy as np

def get_accuracy(cm):
    return [float(cm[i,i]/np.sum(cm[0:8,i])) for i in xrange(num_classes)]

data = sio.loadmat('final_output_LT.mat', appendmat=False)
for i in data:
    locals()[i] = data[i]
del data
del i
num_classes = 8

def get_accuracy(cm):
    return [float(cm[i,i]/np.sum(cm[0:num_classes,i])) for i in range(num_classes)]

snr = np.linspace(0.15,0.85,71)
pff=[]
pmm=[]
accc=[]
for te in snr:
    data = sio.loadmat('final_output_2_noLT.mat', appendmat=False)
    for i in data:
        locals()[i] = data[i]
    del data
    del i
    print(te)
    y_pred = (np.sign(y_pred1-te)+1)/2
    idx_yt = np.sum(y_train, axis = 1)
    idx_yp = np.sum(y_pred, axis = 1)
    idx_cm = np.zeros([num_classes + 1, num_classes+1])
    idx = np.arange(0, num_classes)
    for i in range(y_pred.shape[0]):
        y_p = y_pred[i,:]
        y_t = y_train[i,:]
        y_ref = y_p + y_t
    
        idx1 = idx[y_ref==2]
        if idx1.shape[0]!=0:
            y_p[idx1] = 0
            y_t[idx1] = 0
            y_ref[idx1] = 0
            idx_cm[idx1, idx1] += 1
        if np.sum(y_ref)!=0:
            idx2_p = idx[y_p==1]
            idx2_t = idx[y_t==1]    
            max_tar = np.max([idx2_p.shape[0],idx2_t.shape[0]])
            re_p = np.ones(max_tar - idx2_p.shape[0],dtype = int)*num_classes
            re_t = np.ones(max_tar - idx2_t.shape[0],dtype = int)*num_classes
        
            idx2_p = np.concatenate([idx2_p, re_p])
            idx2_t = np.concatenate([idx2_t, re_t])
            
            idx_cm[idx2_p, idx2_t] += 1

    acc = get_accuracy(idx_cm) 
    pm = np.sum(idx_cm[num_classes, :])/(np.sum(
            idx_cm[0:num_classes,0:num_classes])+np.sum(idx_cm[num_classes,:]))  # Missing Alarm
    pf = np.sum(idx_cm[:, num_classes])/(np.sum(
            idx_cm[0:num_classes,0:num_classes])+np.sum(idx_cm[:,num_classes]))  #False Alarm

    print(pf)
    print(pm)
    print(np.mean(acc))
    accc.append(acc)
    pff.append(pf)
    pmm.append(pm)

sio.savemat('pfpm_snr_2_noLt.mat', {'acc':accc,'pf':pff,'pm':pmm})