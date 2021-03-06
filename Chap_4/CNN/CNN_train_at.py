#coding=utf

from keras.utils import multi_gpu_model
import numpy as np
from keras import layers, models, optimizers,activations
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

import os
os.environ["CUDA_DEVICE_ORDER"]="PCI_BUS_ID"
#os.environ["CUDA_VISIBLE_DEVICES"]="0,1"
os.environ["CUDA_VISIBLE_DEVICES"]="0"
K.set_image_data_format('channels_last')

class SeBlock(layers.Layer):   
    def __init__(self, reduction=4,**kwargs):
        super(SeBlock,self).__init__(**kwargs)
        self.reduction = reduction
    def build(self,input_shape):#构建layer时需要实现
    	#input_shape     
    	pass
    def call(self, inputs):
        x = layers.GlobalAveragePooling2D()(inputs)
        x = layers.Dense(int(x.shape[-1]) // self.reduction, use_bias=False,activation=activations.relu)(x)
        x = layers.Dense(int(inputs.shape[-1]), use_bias=False,activation=activations.hard_sigmoid)(x)
        return layers.Multiply()([inputs,x])    #给通道加权重
        #return inputs*x  

def Build_CNN(input_shape, n_class):
    x = layers.Input(shape=input_shape)
    conv1 = layers.Conv2D(filters=64, kernel_size=(1,12), strides=(1,1), padding='same',dilation_rate = 5)(x)
    conv1 = ELU(alpha=0.5)(conv1)
    conv1 = BN()(conv1)
    conv1 = layers.Conv2D(filters=64, kernel_size=(1,12), strides=(1,2), padding='same',dilation_rate = 1)(conv1)
    conv1 = ELU(alpha=0.5)(conv1)
    conv1 = BN()(conv1)
    conv1 = layers.MaxPooling2D((1, 2), strides=(1, 2))(conv1)
    conv1 = SeBlock()(conv1)
    
    conv1 = layers.Conv2D(filters=96, kernel_size=(1,9), strides=1, padding='same',dilation_rate = 4)(conv1)
    conv1 = ELU(alpha=0.5)(conv1)
    conv1 = BN()(conv1)
    conv1 = layers.Conv2D(filters=96, kernel_size=(1,9), strides=1, padding='same',dilation_rate = 4)(conv1)
    conv1 = ELU(alpha=0.5)(conv1)
    conv1 = BN()(conv1)
    conv1 = layers.MaxPooling2D((1, 2), strides=(1, 2))(conv1)
    conv1 = SeBlock()(conv1)
    conv1 = layers.Dropout(0.2)(conv1)
    
    conv1 = layers.Conv2D(filters=128, kernel_size=(1,6), strides=1, padding='same',dilation_rate = 3)(conv1)
    conv1 = ELU(alpha=0.5)(conv1)
    conv1 = BN()(conv1)
    conv1 = layers.Conv2D(filters=128, kernel_size=(1,6), strides=1, padding='same',dilation_rate = 3)(conv1)
    conv1 = ELU(alpha=0.5)(conv1)
    conv1 = BN()(conv1)
    conv1 = layers.MaxPooling2D((1, 2), strides=(1, 2))(conv1)

    conv1 = layers.Dropout(0.2)(conv1)
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
    #conv1 = layers.Flatten()(conv1)
    output = layers.Dense(n_class, activation = 'softmax')(conv1)
    
    model = models.Model(x, output)
    return model


def train(model, data, args):
    (x_train, y_train) = data

    checkpoint = callbacks.ModelCheckpoint(monitor='val_acc', verbose=1, 
                                           filepath=args.save_file.rstrip('.h5') + '_' + 'epoch.{epoch:02d}.h5', 
                                  save_weights_only=True, mode='auto', period=1)
    lr_decay = callbacks.LearningRateScheduler(schedule=lambda epoch: args.lr * (args.lr_decay ** epoch))
    #model = multi_gpu_model(model, gpus=2) 
    if args.load == 1:
        model.load_weights(args.save_file)
        print('Loading %s' %args.save_file)  
         
    model.compile(optimizer=optimizers.Adam(lr=args.lr),
                  loss= 'categorical_crossentropy',
                  metrics=["accuracy"])

    hist = model.fit(x_train, y_train, batch_size=args.batch_size, epochs=args.epochs,
                     validation_split = 0.01, callbacks=[checkpoint, lr_decay])
    return hist.history

def get_accuracy(cm):
    return [float(cm[i,i]/np.sum(cm[i,:])) for i in range(args.num_classes)]


def save_single():
    model = Build_CNN(input_shape=x_train.shape[1:], n_class=args.num_classes)

    #p_model = multi_gpu_model(model, gpus=2)
    p_model.compile(optimizer=optimizers.Adam(lr=args.lr),
                  loss= 'categorical_crossentropy',
                  metrics={})    
    name = args.save_file.rstrip('.h5') + 'sGPU' + '.h5'
    p_model.load_weights(args.save_file)
    model.save_weights(name)



def get_cm(y,y_pred):
    cm = np.zeros([args.num_classes, args.num_classes])
    for i in range(args.num_classes):
        c = y_pred[y==i]
        for j in range(c.size):
            cm[i,c[j]]+=1
    return cm
    
    

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Capsule Network on MNIST.")
    parser.add_argument('--epochs', default=20, type=int)
    parser.add_argument('--batch_size', default=64, type=int)
    parser.add_argument('--lr', default=0.001, type=float,
                        help="初始学习率")
    parser.add_argument('--lr_decay', default=0.9, type=float,
                        help="学习率衰减")
    parser.add_argument('-sf', '--save_file', default='./weights/cnn_epoch.10.h5',
                        help="权重文件名称")
    parser.add_argument('-t', '--test', default=1,type=int,
                        help="测试模式，设为非0值激活，跳过训练")
    parser.add_argument('-l', '--load', default=1,type=int,
                        help="是否载入模型，设为1激活")
    parser.add_argument('-d', '--dataset', default='./samples/tr_0.mat',
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
            
    #x_train = x_train[0:785000, :]
    #y_train = y_train[0:785000, :]
    
    x_train = x_train.reshape(x_train.shape[0], 1, x_train.shape[1], 1)
    

    model = Build_CNN(input_shape=x_train.shape[1:], n_class=args.num_classes)

    
    
    if args.test == 0:    
        history = train(model=model, data=((x_train, y_train)), args=args)
        #save_single()
    else:
        args.epochs=0
        history = train(model=model, data=((x_train, y_train)), args=args)
        print('Loading %s' %args.save_file)
      
    print('-'*30 + 'Begin: test' + '-'*30)
    print('test_x.shape', x_train.shape)
    y_pred1 = model.predict(x_train, batch_size=args.batch_size,verbose=1)
    y=np.argmax(y_train,axis = 1)
    y_pred = np.argmax(y_pred1,axis = 1)
    
    acc_aver = np.mean(np.equal(y,y_pred))    
    idx_cm = get_cm(y,y_pred)

    acc = get_accuracy(idx_cm) 

    print('acc_aver', acc_aver)
    print('acc', acc)
    print('-' * 30 + 'End  : test' + '-' * 30)   
    
'''
    from keras.utils import plot_model
    plot_model(model, to_file='model.png',show_shapes = True)
'''