
import numpy as np
from time import time
from matplotlib import pyplot as plt
from matplotlib.collections import LineCollection


from sklearn.metrics import euclidean_distances
from sklearn.decomposition import PCA
import scipy.io as sio
from matplotlib import offsetbox
from sklearn import (manifold, datasets)
import h5py
m=0
n=300


X=sio.loadmat('fe_0_20_5.mat',appendmat=False)['test_x']
y=np.squeeze(sio.loadmat('fe_0_20_5.mat',appendmat=False)['test_y']+1)

#X=sio.loadmat('fe_0_20_2.mat',appendmat=False)['fe']
#y=np.squeeze(sio.loadmat('fe_0_20_2.mat',appendmat=False)['y']+1)



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

print("Computing t-SNE embedding")
tsne = manifold.TSNE(n_components=2, init='pca', random_state=0)
t0 = time()
X_tsne = tsne.fit_transform(X)

plot_embedding(X_tsne,
               "t-SNE embedding of the digits (time %.2fs)" %
               (time() - t0))

sio.savemat('SAE_tsne_5.mat', {'tsne':X_tsne,'y':y})
