#coding=utf

import keras
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
from keras.layers.advanced_activations import ELU
import tensorflow.keras.utils as np_utils

import os
#os.environ['TF_CPP_MIN_LOG_LEVEL'] = '2'
os.environ["CUDA_DEVICE_ORDER"]="PCI_BUS_ID"
os.environ["CUDA_VISIBLE_DEVICES"]="0"
#os.environ["CUDA_VISIBLE_DEVICES"]="1"
K.set_image_data_format('channels_last')


def Build_SAE(input_shape, n_class):
    x_in = layers.Input(shape=input_shape)
    x = layers.Dense(500)(x_in)
    x = ELU(alpha=0.5)(x)
    x = BN()(x)
    
    x = layers.Dense(1000)(x)
    x = ELU(alpha=0.5)(x)
    x = BN()(x)
    
    x = layers.Dense(1000)(x)
    x = ELU(alpha=0.5)(x)
    x = BN()(x)
    
    x = layers.Dense(100)(x)
    x = ELU(alpha=0.5)(x)
    x = BN()(x)
    
    x1 = layers.Dense(5)(x)
    x2 = ELU(alpha=0.5)(x1)
    x2 = BN()(x2)
    
    output = layers.Dense(n_class, activation = 'softmax')(x2)
    
    model = models.Model(x_in, output)
    model_fe = models.Model(x_in,x1)
    return model,model_fe



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
                     validation_split = 0.1, callbacks=[checkpoint, lr_decay])
    return hist.history

def get_accuracy(cm):
    return [float(cm[i,i]/np.sum(cm[i,:])) for i in range(args.num_classes)]


def save_single():
    model = Build_CNN(input_shape=x_train.shape[1:], n_class=args.num_classes)

    #p_model = multi_gpu_model(model, gpus=2)  
    p_model = model
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
    parser.add_argument('--epochs', default=50, type=int)
    parser.add_argument('--batch_size', default=32, type=int)
    parser.add_argument('--lr', default=0.001, type=float,
                        help="初始学习率")
    parser.add_argument('--lr_decay', default=0.95, type=float,
                        help="学习率衰减")
    parser.add_argument('-sf', '--save_file', default='./dataset/fe_0_20.h5',
                        help="权重文件名称")
    parser.add_argument('-t', '--test', default=0,type=int,
                        help="测试模式，设为非0值激活，跳过训练")
    parser.add_argument('-l', '--load', default=0,type=int,
                        help="是否载入模型，设为1激活")
    parser.add_argument('-d', '--dataset', default='./dataset/fe_-4_20.mat',
                        help="需要载入的数据文件，MATLAB -v7.3格式")
    parser.add_argument('-n', '--num_classes', default=8,
                        help="类别数")
    args = parser.parse_args()
    print(args)
    
    K.set_image_data_format('channels_last')

    data = sio.loadmat(args.dataset, appendmat=False)  #matlab 非-v7.3
    for i in data:
        locals()[i] = data[i]
    del data
    del i

    '''
    with np.load(args.dataset) as data: #npz格式
        x_train = data['x_train']
    with np.load(args.dataset) as data:
        y_train = data['y_train']
    '''
    '''
    with h5py.File(args.dataset, 'r') as data:
        for i in data:
            locals()[i] = data[i].value  
    '''
    x_train = train_x
    x_test = test_x
    y_test = np_utils.to_categorical(test_y, args.num_classes)
    y_train = np_utils.to_categorical(train_y, args.num_classes)
    
    model,model_fe = Build_SAE(input_shape=x_train.shape[1:], n_class=args.num_classes)

    
    
    if args.test == 0:    
        history = train(model=model, data=((x_train, y_train)), args=args)
        #save_single()
    else:
        args.epochs=0
        history = train(model=model, data=((x_train, y_train)), args=args)
        print('Loading %s' %args.save_file)

    ###########################测试用############################  
    print('-'*30 + 'Begin: test' + '-'*30)

    test_acc = []
    acc = []
    for snr in range(-4,21,2):
        fileName = './dataset/data_fe_'+str(snr)+'.mat'

        x_test=sio.loadmat(fileName,appendmat=False)['test_x']
        y_test=np.squeeze(sio.loadmat(fileName,appendmat=False)['test_y'])


        y_pred=model.predict(x_test,verbose=0)
        y_label_pred = np.argmax(y_pred, axis=1)
        #y_label = 
        test_accuracy = np.mean(np.equal(y_test,y_label_pred))
        test_acc.append(test_accuracy)
        idx_cm = get_cm(y_test,y_label_pred)
        accuracy = get_accuracy(idx_cm)
        acc.append(accuracy)
        print("test accuarcy:",test_accuracy)
        print('-' * 30 + 'End: test' + '-' * 30)   
    
    acc_aver = np.mean(test_acc)

    print('test_acc', test_accuracy)
    print('Average test_acc', acc_aver)
    print('-' * 30 + 'End  : test' + '-' * 30)   

    sio.savemat('acc.mat', {'acc':acc,'test_acc':test_acc})

    '''
    for snr in range(0,21,2):
        fileName = './dataset/data_fe_'+str(snr)+'.mat'
        file_save = 'fe_'+ str(snr)+'.mat'

        x_test=sio.loadmat(fileName,appendmat=False)['test_x']
        y_test=np.squeeze(sio.loadmat(fileName,appendmat=False)['test_y'])
        
        fe = model_fe.predict(x_test,verbose = 1)
        sio.savemat(file_save, {'fe':fe,'y':y_test})
    '''
    
'''
    from keras.utils import plot_model
    plot_model(model, to_file='model.png',show_shapes = True)
'''
