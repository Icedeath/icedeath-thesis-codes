from __future__ import print_function
import numpy
numpy.random.seed(1337)  # for reproducibility

import numpy
from keras import backend as K
import scipy.io as sio 

from keras.callbacks import ModelCheckpoint
from keras.models import Sequential
from keras.layers.core import Dense, Dropout, Activation
from keras.optimizers import SGD
from keras.utils import np_utils
from keras.layers.advanced_activations import ELU
from keras.layers.normalization import BatchNormalization as BN
from keras.regularizers import l2
import matplotlib.pyplot as plt

# There are 40 different classes
nb_classes = 8
nb_epoch = 100
batch_size = 100
num_snr = 1

load = 0
loadfile = '123.h5'
savefile = '123.h5'
dataset = './dataset/data_fe_20.mat'

# input image dimensions
# number of convolutional filters to use



def Net_model(lr=0.001,decay=1e-6,momentum=0.5):
    model = Sequential()
    model.add(Dense(200, input_dim=25,W_regularizer=l2(0.000)))
    model.add(BN(epsilon=1e-06, mode=0, axis=1, momentum=momentum))
    model.add(Activation(ELU()))
    model.add(Dropout(0.0))
    
    model.add(Dense(130,W_regularizer=l2(0.000))) #Full connection
    model.add(BN(epsilon=1e-06, mode=0, axis=1, momentum=momentum))
    model.add(Activation(ELU(alpha=1.0)))
    model.add(Dropout(0.0))     
    
    model.add(Dense(80,W_regularizer=l2(0.000))) #Full connection
    model.add(BN(epsilon=1e-06, mode=0, axis=1, momentum=momentum))
    model.add(Activation(ELU(alpha=1.0)))
    model.add(Dropout(0.0))  
    
    model.add(Dense(40,W_regularizer=l2(0.000))) #Full connection
    model.add(BN(epsilon=1e-06, mode=0, axis=1, momentum=momentum))
    model.add(Activation(ELU(alpha=1.0)))
    model.add(Dropout(0.0))  

    model.add(Dense(15,W_regularizer=l2(0.002))) #Full connection
    model.add(BN(epsilon=1e-06, mode=0, axis=1, momentum=momentum))
    model.add(Activation(ELU(alpha=1.0)))
    model.add(Dropout(0.3))  

    model.add(Dense(nb_classes))
    model.add(Activation('softmax'))

    sgd = SGD(lr=lr, decay=decay, momentum=momentum, nesterov=True)
    model.compile(loss='categorical_crossentropy', optimizer=sgd ,metrics = ['accuracy'])
    return model

def train_model(model,X_train,Y_train,X_val,Y_val):
    #model.load_weights(loadfile)
    checkpointer =ModelCheckpoint(filepath=savefile, monitor='val_acc', verbose = 1,save_best_only=True)
    hist = model.fit(X_train, Y_train, batch_size=batch_size, nb_epoch=nb_epoch,
              verbose=2, validation_data=(X_val, Y_val),callbacks=[checkpointer])
    model.save_weights(savefile,overwrite=True)
    return hist.history

def test_model(model,X,Y):
	score = model.evaluate(X, Y, show_accuracy=True, verbose=0)
	return score
 
def get_fe(n,j):
    return [numpy.mean(f_out[i*num + j*stride: (i+1)*num+j*stride, n]) for i in range(nb_classes)]
    
def accuracy(j):
    return [numpy.mean(numpy.equal(test_set_y[i*num + j*stride: (i+1)*num+j*stride],classes[i*num + j*stride: (i+1)*num+j*stride])) for i in range(nb_classes)]

if __name__ == '__main__':
  
    
    train_set_x = numpy.float64(sio.loadmat(dataset,appendmat=False)['test_x'])
    train_set_y = numpy.int64(sio.loadmat(dataset,appendmat=False)['test_y'])
    train_set_y.shape = (max(train_set_y.shape),)
    
    test_set_x = numpy.float64(sio.loadmat(dataset,appendmat=False)['train_x'])
    test_set_y = numpy.int64(sio.loadmat(dataset,appendmat=False)['train_y'])
    test_set_y.shape = (max(test_set_y.shape),)
    
X_train = train_set_x.reshape(train_set_x.shape[0], train_set_x.shape[1])
X_test = test_set_x.reshape(test_set_x.shape[0], test_set_x.shape[1])
X_val = X_test

print('X_train shape:', X_train.shape)
print(X_train.shape[0], 'train samples')
print(X_val.shape[0], 'validate samples')
print(X_test.shape[0], 'test samples')

	# convert class vectors to binary class matrices
Y_train = np_utils.to_categorical(train_set_y, nb_classes)
Y_test = np_utils.to_categorical(test_set_y, nb_classes)
Y_val = Y_test
del train_set_x
del test_set_x
model=Net_model()
history = train_model(model,X_train,Y_train,X_val,Y_val)	
score=test_model(model,X_test,Y_test)

model.load_weights(savefile)
classes_tr=model.predict_classes(X_train,verbose=0)
train_accuracy = numpy.mean(numpy.equal(train_set_y,classes_tr))
print("train accuarcy:",train_accuracy)

classes=model.predict_classes(X_test,verbose=0)
test_accuracy = numpy.mean(numpy.equal(test_set_y,classes))

print("test accuarcy:",test_accuracy)

train_loss = numpy.array(history['loss'])
val_loss = numpy.array(history['val_loss'])

a=numpy.arange(0,nb_epoch,1)
plt.plot(a,train_loss,label="train_loss",color="red",linewidth=2)
plt.plot(a,val_loss,label="val_loss",color="blue",linewidth=2)
plt.legend()
plt.show()

get_3rd_layer_output =K.function([model.layers[0].input, K.learning_phase()],model.layers[18].output)  
f_out = get_3rd_layer_output([X_test,0])

num = Y_test.size/nb_classes**2/num_snr
stride = Y_test.size/num_snr/nb_classes
a=train_set_y.shape[0]/nb_classes
ac_train = [numpy.mean(numpy.equal(train_set_y[j*a:(j+1)*a],classes_tr[j*a:(j+1)*a])) for j in range(nb_classes)]
b=test_set_y.shape[0]/nb_classes
ac_test = [numpy.mean(numpy.equal(test_set_y[i*b:(i+1)*b],classes[i*b:(i+1)*b])) for i in range(nb_classes)]
ace = numpy.array([accuracy(j) for j in range(num_snr)])

sio.savemat('f_out.mat', {'f_out':f_out})