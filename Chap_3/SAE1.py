#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Sun Nov 25 15:27:24 2018

@author: icedeath
"""

#coding=utf
from keras.utils import np_utils
from keras.models import Sequential
from keras.layers.core import Dense
from keras.layers import LSTM
from keras.utils import multi_gpu_model
import numpy as np
from keras import layers, models, optimizers
from keras import backend as K
from keras.layers import Lambda
import matplotlib.pyplot as plt
import tensorflow as tf
from keras import callbacks
from keras.layers.normalization import BatchNormalization as BN
import argparse
import scipy.io as sio
import h5py
from keras.layers.advanced_activations import ELU

K.set_image_data_format('channels_last')

def build_SAE(input_shape):
    x = layers.Input(shape=input_shape)
    sae1 = layers.Dense(500,activation = 'tanh')(x)
    sae1 = layers.Dense(1000,activation = 'tanh')(sae1)
    sae1 = layers.Dense(1000,activation = 'tanh')(sae1)
    sae1 = layers.Dense(500,activation = 'tanh')(sae1)
    sae1 = layers.Dense(200,activation = 'tanh')(sae1)
    output = layers.Dense(8,activation = 'softmax')(sae1)

    model = models.Model(x, output)
    return model




def train(model, data, args):
    (x_train, y_train) = data

    checkpoint = callbacks.ModelCheckpoint(args.save_file, monitor='val_acc', verbose=1, save_best_only=True, 
                                  save_weights_only=True, mode='auto', period=1)
    lr_decay = callbacks.LearningRateScheduler(schedule=lambda epoch: args.lr * (args.lr_decay ** epoch))
    #model = multi_gpu_model(model, gpus=2)
    model.compile(optimizer=optimizers.Adam(lr=args.lr),
                  loss= 'categorical_crossentropy',
                  metrics=['accuracy'])
    if args.load == 1:
        model.load_weights(args.save_file)
        print('Loading %s' %args.save_file)
    hist = model.fit(x_train, y_train, batch_size=args.batch_size, epochs=args.epochs,
                     validation_split = 0.1, callbacks=[checkpoint, lr_decay])
    return hist.history


    

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Capsule Network on MNIST.")
    parser.add_argument('--epochs', default=20, type=int,
                        help="迭代次数")
    parser.add_argument('--batch_size', default=64, type=int)
    parser.add_argument('--lr', default=0.003, type=float,
                        help="学习率")
    parser.add_argument('--lr_decay', default=0.97, type=float,
                        help="衰减")
    parser.add_argument('-sf', '--save_file', default='./weights/sae_fe.h5',
                        help="保存的权重文件")
    parser.add_argument('-t', '--test', default=0,type=int,
                        help="测试模式")
    parser.add_argument('-l', '--load', default=0,type=int,
                        help="如果需要载入模型，设为1")
    parser.add_argument('-p', '--plot', default=1,type=int,
                        help="设为1时，在训练结束后画出loss变化曲线")
    parser.add_argument('-d', '--dataset', default='./dataset/data_fe_20.mat',
                        help="数据文件")
    args = parser.parse_args()
    print(args)
    
    K.set_image_data_format('channels_last')
    
    x_train=sio.loadmat(args.dataset,appendmat=False)['train_x'][:,[8,9,13,20]]
    Y_train=np.squeeze(sio.loadmat(args.dataset,appendmat=False)['train_y'])
    x_test=sio.loadmat(args.dataset,appendmat=False)['test_x'][:,[8,9,13,20]]
    Y_test=np.squeeze(sio.loadmat(args.dataset,appendmat=False)['test_y'])
    y_train = np_utils.to_categorical(Y_train, 8)
    y_test = np_utils.to_categorical(Y_test, 8)

    model = build_SAE(input_shape = x_train.shape[1:])
    print('Training using SAE...')

        
    model.summary()

    if args.test == 0:    
        history = train(model=model, data=((x_train, y_train)), args=args)
        if args.plot == 1:    
            train_loss = np.array(history['loss'])
            val_loss = np.array(history['val_loss'])
            plt.plot(np.arange(0, args.epochs, 1),train_loss,label="train_loss",color="red",linewidth=1.5)
            plt.plot(np.arange(0, args.epochs, 1),val_loss,label="val_loss",color="blue",linewidth=1.5)
            plt.legend()
            plt.show()
            plt.savefig('loss.png')
    else:
        model.load_weights(args.save_file)
        print('Loading %s' %args.save_file)
      
    print('-'*30 + 'Begin: test' + '-'*30)
    print('Predicting final symbols...')
    y_pred=model.predict_classes(x_test,verbose=0)
    test_accuracy = np.mean(np.equal(y_test,y_pred))
    print("test accuarcy:",test_accuracy)
    print('-' * 30 + 'End: test' + '-' * 30)   
    sio.savemat('y_pred.mat', {'y_pred':y_pred})