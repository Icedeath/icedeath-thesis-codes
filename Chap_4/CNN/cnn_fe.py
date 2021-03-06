# -*- coding: utf-8 -*-
"""
Created on Tue Oct 27 22:53:48 2020

@author: Icedeath
"""
#coding=utf

#from keras.utils import multi_gpu_model
import numpy as np
from keras import layers, models, optimizers
from keras import backend as K
from keras.layers import Lambda
#import matplotlib.pyplot as plt
import tensorflow as tf
from keras import callbacks
from keras.layers.normalization import BatchNormalization as BN
import argparse
import scipy.io as sio
import h5py
from keras.layers.advanced_activations import ELU
import keras

import os
os.environ["CUDA_DEVICE_ORDER"]="PCI_BUS_ID"
os.environ["CUDA_VISIBLE_DEVICES"]="0,1"
#os.environ["CUDA_VISIBLE_DEVICES"]="1"
K.set_image_data_format('channels_last')


def Build_CNN(input_shape, n_class):
    x = layers.Input(shape=input_shape)
    conv1 = layers.Conv2D(filters=64, kernel_size=(1,12), strides=(1,1), padding='same',dilation_rate = 5)(x)
    conv1 = ELU(alpha=0.5)(conv1)
    conv1 = BN()(conv1)
    conv1 = layers.Conv2D(filters=64, kernel_size=(1,12), strides=(1,2), padding='same',dilation_rate = 1)(conv1)
    conv1 = ELU(alpha=0.5)(conv1)
    conv1 = BN()(conv1)
    conv1 = layers.MaxPooling2D((1, 2), strides=(1, 2))(conv1)
    
    conv1 = layers.Conv2D(filters=96, kernel_size=(1,9), strides=1, padding='same',dilation_rate = 4)(conv1)
    conv1 = ELU(alpha=0.5)(conv1)
    conv1 = BN()(conv1)
    conv1 = layers.Conv2D(filters=96, kernel_size=(1,9), strides=1, padding='same',dilation_rate = 4)(conv1)
    conv1 = ELU(alpha=0.5)(conv1)
    conv1 = BN()(conv1)
    conv1 = layers.MaxPooling2D((1, 2), strides=(1, 2))(conv1)
    
    conv1 = layers.Conv2D(filters=128, kernel_size=(1,6), strides=1, padding='same',dilation_rate = 3)(conv1)
    conv1 = ELU(alpha=0.5)(conv1)
    conv1 = BN()(conv1)
    conv1 = layers.Conv2D(filters=128, kernel_size=(1,6), strides=1, padding='same',dilation_rate = 3)(conv1)
    conv1 = ELU(alpha=0.5)(conv1)
    conv1 = BN()(conv1)
    conv1 = layers.MaxPooling2D((1, 2), strides=(1, 2))(conv1)

    conv1 = layers.Conv2D(filters=192, kernel_size=(1,3), strides=1, padding='same',dilation_rate = 2)(conv1)
    conv1 = ELU(alpha=0.5)(conv1)
    conv1 = BN()(conv1)
    conv1 = layers.Conv2D(filters=192, kernel_size=(1,3), strides=1, padding='same',dilation_rate = 2)(conv1)
    conv1 = ELU(alpha=0.5)(conv1)
    conv1 = BN()(conv1)
    conv1 = layers.Conv2D(filters=192, kernel_size=(1,3), strides=1, padding='same',dilation_rate = 2)(conv1)
    conv1 = ELU(alpha=0.5)(conv1)
    conv1 = BN()(conv1)
    conv1 = layers.MaxPooling2D((1, 2), strides=(1, 2))(conv1)

    conv1 = layers.Conv2D(filters=256, kernel_size=(1,3), strides=1, padding='same',dilation_rate = 2)(conv1)
    conv1 = ELU(alpha=0.5)(conv1)
    conv1 = BN()(conv1)
    conv1 = layers.Conv2D(filters=256, kernel_size=(1,3), strides=1, padding='same',dilation_rate = 2)(conv1)
    conv1 = ELU(alpha=0.5)(conv1)
    conv1 = BN()(conv1)
    conv1 = layers.Conv2D(filters=256, kernel_size=(1,3), strides=1, padding='same',dilation_rate = 2)(conv1)
    conv1 = ELU(alpha=0.5)(conv1)
    conv1 = BN()(conv1)
    
    conv1 = layers.GlobalAveragePooling2D(data_format='channels_last')(conv1)
    #conv1 = layers.Dense(50, activation = 'tanh')(conv1)
    
    output = layers.Dense(n_class, activation = 'softmax')(conv1)
    
    model = models.Model(x, output)
    model_fe = models.Model(x,conv1)
    return model, model_fe


def train(model, data, args):
    (x_train, y_train) = data

    checkpoint = callbacks.ModelCheckpoint(monitor='val_acc', verbose=1, 
                                           filepath=args.save_file.rstrip('.h5') + '_' + 'epoch.{epoch:02d}.h5', 
                                  save_weights_only=True, mode='auto', period=1)
    lr_decay = callbacks.LearningRateScheduler(schedule=lambda epoch: args.lr * (args.lr_decay ** epoch))
    #model = multi_gpu_model(model, gpus=2) 
    '''
    if args.load == 1:
        model.load_weights(args.save_file)
        print('Loading %s' %args.save_file)  
    '''     
    model.compile(optimizer=optimizers.Adam(lr=args.lr),
                  loss= 'categorical_crossentropy',
                  metrics=["accuracy"])

    hist = model.fit(x_train, y_train, batch_size=args.batch_size, epochs=args.epochs,
                     validation_split = 0.1, callbacks=[checkpoint, lr_decay])
    return hist.history

    

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Capsule Network on MNIST.")
    parser.add_argument('--epochs', default=20, type=int)
    parser.add_argument('--batch_size', default=64, type=int)
    parser.add_argument('--lr', default=0.0035, type=float,
                        help="初始学习率")
    parser.add_argument('--lr_decay', default=0.95, type=float,
                        help="学习率衰减")
    parser.add_argument('-sf', '--save_file', default='./weights/cnn_mulsGPU.h5',
                        help="权重文件名称")
    parser.add_argument('-t', '--test', default=0,type=int,
                        help="测试模式，设为非0值激活，跳过训练")
    parser.add_argument('-l', '--load', default=1,type=int,
                        help="是否载入模型，设为1激活")
    parser.add_argument('-d', '--dataset', default='./samples/data_mul16.mat',
                        help="需要载入的数据文件，MATLAB -v7.3格式")
    parser.add_argument('-n', '--num_classes', default=15,
                        help="类别数")
    args = parser.parse_args()
    print(args)
    
    K.set_image_data_format('channels_last')
    ''' 
    data = sio.loadmat(args.dataset, appendmat=False)  #matlab 非-v7.3
    for i in data:
        locals()[i] = data[i]
    del data
    del i
    '''
    '''
    with np.load(args.dataset) as data: #npz格式
        x_train = data['x_train']
    with np.load(args.dataset) as data:
        y_train = data['y_train']
    '''
    with h5py.File(args.dataset, 'r') as data:
        for i in data:
            locals()[i] = data[i].value
            

    x_train = x_train.reshape(x_train.shape[0], 1, x_train.shape[1], 1)
    
    y_r = np.argmax(y_train,axis = 1)    

    model,model_fe = Build_CNN(input_shape=x_train.shape[1:], n_class=args.num_classes)

    model.load_weights(args.save_file)
    x = model_fe.input
    x1 = model_fe.output
    x1 = layers.Dense(4)(x1)
    x1 = ELU(alpha=0.5)(x1)
    x2 = BN()(x1)
    output = layers.Dense(args.num_classes, activation = 'softmax')(x2)
    
    model_re = models.Model(x,output)
    
    fe_out = models.Model(x,x1)
    
    for layer in model_fe.layers:  
        layer.trainable = False
    
    args.epochs=0
    history = train(model=model_re, data=((x_train, y_train)), args=args)
    
    model_re.load_weights('./weights/cnn_mulsGPU_4.h5')

    print('Predicting...')
    fe = fe_out.predict(x_train,batch_size = 64,verbose = 1)
    sio.savemat('fe_16.mat', {'fe':fe,'y':y_r})


    
    
    
    #sio.savemat('out_0_20.mat', {'vis_out':vis_out,'y':y_r})