import pandas as pd
import numpy as np
from sklearn import tree
import graphviz

#from matplotlib import pyplot as plt
#from sklearn.cluster import OPTICS, KMeans, DBSCAN

vectorscomp = dict()
vectorsprot = dict()
dotprot = dict()
BC2 = pd.read_excel('BC2r.xlsx')
BC2WE = pd.read_csv('BC2_word_embeddings.csv')

def one_hot_encoding_of_length(length):
    out = []
    for i in range(0, length):
        vec = np.zeros(length)
        vec[i] = 1.0
        out.append(vec)
    return out

def gen_vectors_complete(protein, vector):
    vectorscomp[protein] = np.array(vector)

def gen_vectors_prot(protein, vector):
    vectorsprot[protein] = np.array(vector)

proteins = BC2['Entry'].tolist()
vectorsdp = BC2WE[BC2WE['word'].isin(proteins)]
vectorsdp = vectorsdp.fillna(0.0)

BC2WE.fillna(0.0).apply(lambda row: gen_vectors_complete(row['word'], row[1:]), raw=True, axis=1)
vectorsdp.apply(lambda row: gen_vectors_prot(row['word'], row[1:]), raw=True, axis=1)

#print(BC2WE.loc[8742]) #"Angiogenic'
#print(vectorscomp['ANGIOGENIC'])

dotprot_len = 0
for prot, vec in vectorsprot.items():
    dotprot[prot] = vec.dot(vectorscomp['ANGIOGENIC'])
    dotprot_len += 1

X = one_hot_encoding_of_length(dotprot_len)
Y = list(dotprot.values())

print(X)

angiogenesis_tree = tree.DecisionTreeRegressor()
angiogenesis_tree.fit(X, Y)


dot_data = tree.export_graphviz(angiogenesis_tree, out_file=None)
graph = graphviz.Source(dot_data)
graph.render("Angiogenesis")

# inertia = []
# for i in range(1, 11):
#     kmeans = KMeans(n_clusters=i, init='k-means++', max_iter=300, n_init=10, random_state=0)
#     kmeans.fit(list(vectorsprot.values()))
#     inertia.append(kmeans.inertia_)
# plt.plot(range(1, 11), inertia)
# plt.title('MiniBatch')
# plt.xlabel('Clusters')
# plt.ylabel('Inércia')
# plt.show()
#
# clusters = []
# noise = []
# for i in np.arange(0.2, 40.0, 5):
#     db = DBSCAN(eps=i).fit(list(vectorsprot.values()))
#     core_samples_mask = np.zeros_like(db.labels_, dtype=bool)
#     core_samples_mask[db.core_sample_indices_] = True
#     labels = db.labels_
#     n_clusters_ = len(set(labels)) - (1 if -1 in labels else 0)
#     n_noise_ = list(labels).count(-1)
#     clusters.append(n_clusters_)
#     noise.append(n_noise_)
#     #print('Estimated number of clusters: %d' % n_clusters_)
#     #print('Estimated number of noise points: %d' % n_noise_)
#
# plt.subplot(2, 1, 1)
# plt.plot(np.arange(0.2, 40.0, 5), clusters)
# plt.title('DBSCAN')
# plt.ylabel('Clusters')
#
# plt.subplot(2, 1, 2)
# plt.plot(np.arange(0.2, 40.0, 5), noise)
# plt.ylabel('Pontos ruído')
#
# plt.xlabel('Distância máxima')
# plt.show()
#
# opt = OPTICS().fit(list(vectorsprot.values()))
# print("Optics:")
# print("  - Clusters:", len(set(opt.labels_)) - (1 if -1 in opt.labels_ else 0))
# print("  - Pontos ruído:", list(opt.labels_).count(-1))