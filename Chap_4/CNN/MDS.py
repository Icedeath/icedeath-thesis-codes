
import numpy as np
from time import time
from matplotlib import pyplot as plt
from matplotlib.collections import LineCollection


from sklearn.metrics import euclidean_distances
from sklearn.decomposition import PCA
import scipy.io as sio
from matplotlib import offsetbox
from sklearn import manifold
import h5py
m=0
n=300


X=sio.loadmat('tsne_20.mat',appendmat=False)['out']
y=np.squeeze(sio.loadmat('tsne_20.mat',appendmat=False)['y']+1)
#y=np.linspace(1,X.shape[0],X.shape[0])
#y=np.zeros([X.shape[0],],dtype='int64')
#for i in xrange (n-m):
    #y[4*i:4*(i+1)]=np.linspace(1,4,4,dtype='int64')


def plot_embedding(X, title=None):
    x_min, x_max = np.min(X, 0), np.max(X, 0)
    X = (X - x_min) / (x_max - x_min)

    plt.figure()
    ax = plt.subplot(111)
    for i in range(X.shape[0]):
        #plt.text(X[i, 0], X[i, 1], str(y[i]),
                 #color=plt.cm.Set1(y[i] / 4.),
                 #fontdict={'weight': 'bold', 'size': 9})
        plt.text(X[i, 0], X[i, 1], str(y[i]),
                 fontdict={'weight': 'bold', 'size': 9})

    plt.xticks([]), plt.yticks([])
    if title is not None:
        plt.title(title)

print("Computing MDS embedding")

mds = manifold.MDS(n_components=2,n_init=10,max_iter=500)
t0 = time()
X_MDS = mds.fit_transform(X)

plot_embedding(X_MDS,
               "MDS embedding of the digits (time %.2fs)" %
               (time() - t0))

sio.savemat('CNN_MDS_20.mat', {'MDS':X_MDS,'y':y})

