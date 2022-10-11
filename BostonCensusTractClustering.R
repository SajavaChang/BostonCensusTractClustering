############################################### ��ƳB�z ###############################################

library(sf)
tract <- read_sf("C:/Users/User/Desktop/tract.gpkg")   # 181 obs.
DG <- read.csv("C:/Users/User/Desktop/DB.csv", header=T)  # 173 obs., ����8�Ӹ�Ưʥ��ϰ�
boston <- merge(DG,tract, by="NAMELSAD10", all.x=T)





############################################### ���� ###############################################

# �Ĥ@�ؤ覡: EFA + PCA (�i�H�j�P�F�ѭ������ܼƥN���N�q)

G1 <- DG[, 2:20]    # X1~X19, �P�H�������ܼ�
G2 <- DG[, 21:30]   # X20~X29�A�P���Ҭ������ܼ�

library(psych)   # for EFA
KMO(G1)
#### Overall MSA =  0.73   (�|�i�i��]�����R)
#### MSA for each item = 
####   X1   X2   X3   X4   X5   X6   X7   X8   X9  X10  X11  X12  X13  X14  X15  X16  X17  X18  X19 
#### 0.79 0.61 0.66 0.63 0.46 0.69 0.76 0.71 0.57 0.70 0.80 0.81 0.80 0.73 0.82 0.75 0.79 0.79 0.84 
KMO(G2)
#### Overall MSA =  0.53   (���A�X�i��]�����R)
#### MSA for each item = 
####  X20  X21  X22  X23  X24  X25  X26  X27  X28  X29 
#### 0.48 0.63 0.56 0.59 0.52 0.46 0.65 0.56 0.47 0.54
bartlett.test(G1)
#### Bartlett's K-squared = 66587, df = 18, p-value < 2.2e-16   # �ܼƶ��������x�}�㦳�@�P�]���s�b�A�A�XEFA
bartlett.test(G2)
#### Bartlett's K-squared = 22432, df = 9, p-value < 2.2e-16   # �ܼƶ��������x�}�㦳�@�P�]���s�b�A�A�XEFA

## ��M G1 �� G2 ��A�XEFA, �� G2 �N PCA �a



## EFA: G1

fa.parallel(cor(G1),n.obs=173,fa="both",n.iter=100,main="�~�Y��")   # �� 5 �� Factors
DR1 <- fa(cor(G1), nfactors=5 ,rotate="varimax", fm="pa") ; DR1
### rotate="varimax": ������઺�̤j�ܲ��k(����]��������--���W�n��)
### fm ="pa" : �D�b�]���k
####       PA1   PA4   PA2   PA3   PA5   h2      u2 com
#### X1  -0.17  0.20  0.50 -0.03  0.13 0.33 0.66936 1.7
#### X2   0.04  0.00  0.08  0.79 -0.11 0.64 0.36251 1.1
#### X3   0.89 -0.14 -0.12  0.17  0.14 0.88 0.11885 1.2
#### X4  -0.69  0.02  0.35 -0.62 -0.13 1.00 0.00042 2.6
#### X5   0.02  0.13 -0.45  0.80  0.03 0.86 0.14467 1.6
#### X6   0.13  0.09 -0.84  0.41  0.07 0.90 0.10141 1.6
#### X7  -0.65  0.58 -0.24 -0.12 -0.13 0.86 0.14456 2.4
#### X8   0.76 -0.47  0.10  0.17 -0.13 0.86 0.14425 1.9
#### X9  -0.46 -0.01  0.34  0.02  0.20 0.37 0.63051 2.3
#### X10 -0.04 -0.13  0.39 -0.11  0.71 0.69 0.31359 1.7
#### X11  0.30 -0.34  0.12  0.02  0.87 0.97 0.03139 1.6
#### X12 -0.67  0.65  0.09  0.07 -0.30 0.97 0.03348 2.4
#### X13  0.61 -0.61 -0.03 -0.02  0.40 0.90 0.10052 2.7
#### X14 -0.10  0.84 -0.35 -0.02 -0.18 0.87 0.12685 1.5
#### X15  0.70 -0.15 -0.20 -0.13  0.13 0.59 0.41355 1.4
#### X16 -0.01 -0.73 -0.12  0.00 -0.03 0.55 0.45295 1.1
#### X17 -0.24  0.60  0.02  0.19 -0.17 0.49 0.51432 1.7
#### X18 -0.02 -0.09  0.79  0.03  0.28 0.71 0.28606 1.3
#### X19 -0.33  0.60  0.10  0.00 -0.14 0.50 0.50421 1.8
#### PA����Loadings�A�Y�ܼƻP�]���������Y��
#### h2���ܦ@�P��(Communality)�A�ܼƥi�H�^�m��]�����{�פj�p(�V�j���V�K��)
#### u2���ܰߤ@��(uniquenesses)�A�ܲ��q���P��L�ܼƵL��������(�Y�]�~�t�]���λP���ܼƪ��S���m�ҳy��) = 1-h2
#### �ɥRh2 & u2: �]�����R�D�O�Nn���ܼƤ��Ѧ��@�P�ʦ]��(common factor)�P�W�S�ʦ]��(unique factor)���u�ʲզX���@�ؤ�k
#### com���ܽ�����(complexity)�A���h���ܼƦP�ɦb��өΦh�Ӧ]����ۡA�V���� 1 �V�n

####                        PA1  PA4  PA2  PA3  PA5
#### SS loadings           4.12 3.56 2.46 1.95 1.82   �� �t��������M�A>1 ��Factor�ȱo�O�d
#### Proportion Var        0.22 0.19 0.13 0.10 0.10   �� �ӧO�����{��
#### Cumulative Var        0.22 0.40 0.53 0.64 0.73   �� �ֿn�����{��

#### The root mean square of the residuals (RMSR) is  0.03   �� �p��0.05�A�٤���

factor.plot(DR1, labels = rownames(DR1$loadings))   # ���]�l��
fa.diagram(DR1, digits = 2)   #�@DR1$Structure or DR1$loadings �����G�A���U�R�W(���Ϲ���)
#### PA1 : ���~�H�f�y�����¤H�ϡB�Ш|�C�B���J���t����
#### PA2 : �H�f���K���B�~���A�h���α�
#### PA3 : �Ѧ~�B�k�ʤH�f������
#### PA4 : �I�ΥB�C���~�ϰ�
#### PA5 : �D�����B�^�y�{�פ���

fs <- factor.scores(G1, DR1) ; fs$scores  # ���o������s�ܼ�PA1~PA5



## PCA: G2
DR2 <- prcomp(G2, center=T, scale=T)
round((DR2$sdev)^2 / sum((DR2$sdev)^2), 2)  # 0.22 0.18 0.15 0.12 0.09 0.07 0.06 0.05 0.04 0.02 (���e 5�A�ֿn 76 %)

round(-DR2$rotation, 2)   # eigenvalue
####       PC1   PC2   PC3   PC4   PC5   PC6   PC7   PC8   PC9  PC10
#### X20 -0.52  0.09 -0.39  0.09 -0.27  0.03 -0.04 -0.04 -0.04  0.70
#### X21 -0.46 -0.09  0.29  0.16  0.28 -0.42  0.00  0.25 -0.59 -0.08
#### X22  0.12 -0.49  0.05  0.47  0.00 -0.23 -0.15 -0.66  0.00  0.09
#### X23  0.27 -0.41 -0.01  0.34 -0.43 -0.14  0.28  0.59  0.07  0.10
#### X24 -0.55  0.02 -0.05  0.20 -0.41  0.02 -0.08 -0.05  0.32 -0.61
#### X25 -0.21 -0.33  0.51 -0.09  0.17  0.25 -0.44  0.23  0.41  0.25
#### X26  0.21  0.30  0.31 -0.22 -0.56 -0.41 -0.46 -0.05 -0.12  0.08
#### X27 -0.20 -0.24  0.37 -0.49 -0.22 -0.08  0.62 -0.28  0.05  0.10
#### X28  0.00  0.49  0.25  0.35  0.23 -0.39  0.28 -0.01  0.51  0.18
#### X29  0.04  0.28  0.45  0.41 -0.22  0.60  0.14 -0.11 -0.32  0.07

t(round(cor(G2, -DR2$x[, 1:5]), 2))   # Loadings
####        X20   X21   X22   X23   X24   X25   X26   X27   X28   X29
#### PC1  -0.76 -0.67  0.18  0.39 -0.82 -0.31  0.31 -0.29 -0.01  0.05   �Фl���O�}�����ūΤ�
#### PC2   0.13 -0.12 -0.66 -0.55  0.03 -0.45  0.40 -0.32  0.67  0.38   �֤��줽�@�Ŷ��B�h�H���ؿv
#### PC3  -0.47  0.35  0.07 -0.01 -0.06  0.62  0.38  0.44  0.30  0.55   �}�񨮯��PWifi�h
#### PC4   0.09  0.18  0.51  0.37  0.22 -0.10 -0.24 -0.54  0.38  0.44   ����h�j�Ǥ�
#### PC5  -0.25  0.26  0.00 -0.41 -0.39  0.16 -0.53 -0.21  0.22 -0.21   ���p�Ǥ�



### New data set
efaR <- as.data.frame(fs$scores)
pcaR <- as.data.frame(-DR2$x[, 1:5])
N1 <- cbind(DG$NAMELSAD10, efaR, pcaR)




# �ĤG�ؤ覡: tSNE (�L�k���D�������ܼƥN���N�q)

library(Rtsne)
TSNE <- Rtsne(DG, dims=3, perplexity=40)  # �u�୰�� 2~3 ���A���N 3 ���a
N2 <- as.data.frame(TSNE$Y)
N2 <- cbind(DG$NAMELSAD10, N2)





############################################### ���s ###############################################

# Hierarchical Clustering
library(cluster)

## �ؾ�
T1 <- hclust(dist(DG[, 2:30]), method="ward.D")
plot(T1)
T2 <- hclust(dist(N1[, 2:11]), method="ward.D")
plot(T2)
T3 <- hclust(dist(N2[, 2:4]), method="ward.D")
plot(T3)


## ������ (��6�զn�F))
CT1 <- cutree(T1, k=6)
table(CT1)
####  1  2  3  4  5  6 
#### 33 33 61 24 17  5
CT2 <- cutree(T2, k=6)
table(CT2)
####  1  2  3  4  5  6 
#### 33 37 47  8 37 11
CT3 <- cutree(T3, k=6)
table(CT3)
####  1  2  3  4  5  6 
#### 33 38 19 42 24 17 


## �x�s���s���G
CC <- as.data.frame(DG$NAMELSAD10)
CC$HC1 <- CT1
CC$HC2 <- CT2
CC$HC3 <- CT3


## �p��N1���s���դ��I�A�ì����թR�W
### �]���u��N1�����s�i�H�y�L�ݥX�N�q�A��l��ƪ����s�ܼƤӦh�Ӧh�BN2���ܼƷN�q����
round(apply(N1[, 2:11], 2, function (x) tapply(x, CT2, mean)),2)
####     PA1   PA4   PA2   PA3   PA5   PC1   PC2   PC3   PC4   PC5
#### 1 -0.27  0.11  0.13 -0.89  0.62  0.30  0.04 -0.33 -0.15  0.58  : �h�D�����B���I�ΥB���p�ǱШ|�]�I��
#### 2  1.09 -0.79  0.56 -0.14 -0.31  0.14  1.18  0.44  0.58  0.35  : �¤H�h�B���~�H�f�y���B�Ш|�C���J�����B�h�H���ؿv
#### 3  0.09 -0.10 -0.84  0.26 -0.04  1.27  0.09  0.08 -0.47 -0.27  : �Фl���O�}�����ūΤ֡A�i�঳�I������
#### 4 -1.23 -0.73  1.46  1.43  0.06 -1.47 -1.45  1.57 -2.06 -0.13  : �դH�h�B�~�ָ����B���I�ΥB�}�񨮯��PWifi�h�A�i��O�����ߦ�����
#### 5 -0.42  0.99  0.23  0.21 -0.27 -1.71 -0.05 -0.88  0.02 -0.48  : �H�f���K���B�~���A�h���αڡA�Ыθ��O�K���A�i��O������
#### 6 -0.91 -0.05 -0.52  0.29  0.24  0.07 -3.25  1.01  1.94 -0.06  : �n���O���쭱�n�h���ϰ�




# K-means
KMS1 <- kmeans(DG[, 2:30], centers=6)
table(KMS1$cluster)
####   1  2  3  4  5  6 
####  13  8  5 33 54 60
KMS2 <- kmeans(N1[, 2:11], centers=6)
table(KMS2$cluster)
####   1  2  3  4  5  6 
####  45  7 36 36 32 17 
KMS3 <- kmeans(N2[, 2:4], centers=6)
table(KMS3$cluster)
####   1  2  3  4  5  6 
####  38 33 36 20 21 25 


## �x�s���s���G
CC$KMS1 <- KMS1$cluster
CC$KMS2 <- KMS2$cluster
CC$KMS3 <- KMS3$cluster


## �p��N1���s���դ��I�A�ì����թR�W
round(KMS2$centers, 2)
####     PA1   PA4   PA2   PA3   PA5   PC1   PC2   PC3   PC4   PC5
#### 1  0.05  0.51  0.11  0.16  0.64 -0.05  0.07 -0.69 -0.12  0.15 : �D�����B�^�y�{�פ��Φh�A�}�񨮯��PWifi��
#### 2 -1.22 -1.35 -1.41  0.68  0.32  1.82 -3.33 -0.03  1.84 -0.58 : �I�ΧC���~�A���Ϧ��}�񨮯��Bwifi���]�I�R��
#### 3 -0.11 -0.13 -0.87 -0.67 -0.54  1.19 -0.32 -0.31 -0.50  0.39 : �S����I�Ϊ�����H��
#### 4  0.93 -0.79  0.46 -0.13 -0.12  0.16  1.32  0.59  0.69  0.42 : ���~�H�f�y�����¤H�ϡB�Ш|�C�B���J���t�����B�֤��@�Ŷ��B�h�H���ؿv
#### 5 -0.89  0.56  0.62  0.19 -0.25 -2.35 -0.77  0.05 -0.10 -0.29 : �H�f�~�ָ����B�k�ʦh�B�ЫΡB���O�K���A���ū�
#### 6  0.31  0.11  0.01  0.64  0.03  0.93  0.51  1.16 -0.65 -1.35 : �}�񨮯��PWifi�h�����p�Ǹ���




### K-medoids
KMD1 <- pam(DG[, 2:30], k=6)
table(KMD1$clustering)
####  1  2  3  4  5  6 
#### 30 48 49 24 17  5 
KMD2 <- pam(N1[, 2:11], k=6)
table(KMD2$clustering)
####  1  2  3  4  5  6 
#### 37 25 51 10 32 18
KMD3 <- pam(N2[, 2:4], k=6)
table(KMD3$clustering)
####  1  2  3  4  5  6 
#### 33 33 26 40 22 19


## �x�s���s���G
CC$KMD1 <- KMD1$clustering
CC$KMD2 <- KMD2$clustering
CC$KMD3 <- KMD3$clustering


## �p��N1���s���դ��I (����� KMD2$medoids�A�]K-medoids�O�H�Y�Ӽ˥��������I)�A�ì����թR�W
round(apply(N1[, 2:11], 2, function (x) tapply(x, KMD2$clustering, mean)),2)
####     PA1   PA4   PA2   PA3   PA5   PC1   PC2   PC3   PC4   PC5
#### 1  0.00 -0.26 -0.31 -0.95 -0.61  0.76 -0.12 -0.33 -0.34  0.57 : �����I�Ϊ�����H�ϡA���p�ǳ]�I��
#### 2  1.02 -0.74  0.48  0.01 -0.02  0.23  1.75  1.09  0.96  0.08 : ���~�H�f�y�����¤H�ϡB�Ш|�C�B���J���t�����A�֤��@�Ŷ��B�h�H���ؿv
#### 3  0.34  0.28 -0.24  0.50  0.15  0.61  0.32 -0.20 -0.42 -0.15 : ���H�w�q��
#### 4 -1.20 -0.31  1.15  0.91 -0.23 -1.97 -1.66  2.38 -1.50 -0.16 : �񥫤��ߪ��I�H�ϡB�~�ֵ��c����
#### 5 -0.59  0.88  0.37  0.09 -0.20 -2.03 -0.36 -0.91  0.19 -0.36 : �H�f���K���B�~���A�h���αڡB���p�ǳ]�I��
#### 6 -0.65 -0.63 -0.65 -0.15  1.35  1.10 -1.53  0.03  1.03 -0.12 : �D�����B�^�y�{�פ��ΩΤ���h�j�Ǹ��ְϰ�




# DBSCAN
library(spdep)
queen_w <- poly2nb(boston$geom)
summary(queen_w)   # Average number of links: 5.271676

library(dbscan)
kNNdistplot(DG[, 2:30], k=5)
DBS1 <- dbscan(DG[, 2:30], eps=50000, minPts=3)
table(DBS1$cluster)
#### 0   1   2   3   4   5   6 
#### 2 127  19   5  11   4   5
kNNdistplot(N1[, 2:11], k=5)
DBS2 <- dbscan(N1[, 2:11], eps=2, minPts=3)
table(DBS2$cluster)
####  0   1   2   3 
#### 64 103   3   3 
kNNdistplot(N2[, 2:4], k=5)
DBS3 <- dbscan(N2[, 2:4], eps=0.8, minPts=2)
table(DBS3$cluster)
#### 0  1  2  3  4 
#### 2 32 93 41  5 


## �x�s���s���G
CC$DBS1 <- DBS1$cluster
CC$DBS2 <- DBS2$cluster
CC$DBS3 <- DBS3$cluster


## �p��N1���s���դ��I�A�ì����թR�W
round(apply(N1[, 2:11], 2, function (x) tapply(x, DBS2$cluster, mean)),2)
####     PA1   PA4   PA2   PA3   PA5   PC1   PC2   PC3   PC4   PC5
#### 0 -0.56  0.02  0.04  0.03  0.08 -0.40 -0.59  0.37  0.24 -0.31 : ���Ϫ�����դH��
#### 1  0.38 -0.02 -0.02  0.05 -0.17  0.25  0.41 -0.24 -0.20  0.18 : ���~�H�f�y�����¤H�ϡB�Ш|�C�B���J���t����
#### 2 -0.29  0.24  0.50 -1.18  3.09 -0.14  1.19 -0.51 -0.08  0.08 : �H�f���K���B�~���A�h���αڡB�h�D����
#### 3 -0.61 -0.14 -0.50 -1.19  0.96  0.30 -2.60  0.76  1.70  0.21 : �h����B�}�񨮯��PWifi�h





############################################### ��� ###############################################

par(mfcol=c(3,4))
plot(boston$geom, col=CC$HC1+1, main="��l���: HC")
legend("bottomright", legend=c(1:6), fill=c(2:7), box.col="white", cex=0.5)
plot(boston$geom, col=CC$HC2+1, main="EFA+PCA: HC", legend="topright")
legend("bottomright", legend=c(1:6), fill=c(2:7), box.col="white", cex=0.5)
plot(boston$geom, col=CC$HC3+1, main="tSNE: HC")
legend("bottomright", legend=c(1:6), fill=c(2:7), box.col="white", cex=0.5)
plot(boston$geom, col=CC$KMS1+1, main="��l���: K-means")
legend("bottomright", legend=c(1:6), fill=c(2:7), box.col="white", cex=0.5)
plot(boston$geom, col=CC$KMS2+1, main="EFA+PCA: K-means")
legend("bottomright", legend=c(1:6), fill=c(2:7), box.col="white", cex=0.5)
plot(boston$geom, col=CC$KMS3+1, main="tSNE: K-means")
legend("bottomright", legend=c(1:6), fill=c(2:7), box.col="white", cex=0.5)
plot(boston$geom, col=CC$KMD1+1, main="��l���: K-medoids")
legend("bottomright", legend=c(1:6), fill=c(2:7), box.col="white", cex=0.5)
plot(boston$geom, col=CC$KMD2+1, main="EFA+PCA: K-medoids")
legend("bottomright", legend=c(1:6), fill=c(2:7), box.col="white", cex=0.5)
plot(boston$geom, col=CC$KMD3+1, main="tSNE: K-medoids")
legend("bottomright", legend=c(1:6), fill=c(2:7), box.col="white", cex=0.5)
plot(boston$geom, col=CC$DBS1+2, main="��l���: DBSCAN")
legend("bottomright", legend=c(2:8), fill=c(2:8), box.col="white", cex=0.5)
plot(boston$geom, col=CC$DBS2+2, main="EFA+PCA: DBSCA")
legend("bottomright", legend=c(2:5), fill=c(2:5), box.col="white", cex=0.5)
plot(boston$geom, col=CC$DBS3+2, main="tSNE: DBSCA")
legend("bottomright", legend=c(2:6), fill=c(2:6), box.col="white", cex=0.5)

