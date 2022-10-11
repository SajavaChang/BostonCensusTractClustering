############################################### 資料處理 ###############################################

library(sf)
tract <- read_sf("C:/Users/User/Desktop/tract.gpkg")   # 181 obs.
DG <- read.csv("C:/Users/User/Desktop/DB.csv", header=T)  # 173 obs., 移除8個資料缺失區域
boston <- merge(DG,tract, by="NAMELSAD10", all.x=T)





############################################### 降維 ###############################################

# 第一種方式: EFA + PCA (可以大致了解降維後變數代表意義)

G1 <- DG[, 2:20]    # X1~X19, 與人相關的變數
G2 <- DG[, 21:30]   # X20~X29，與環境相關的變數

library(psych)   # for EFA
KMO(G1)
#### Overall MSA =  0.73   (尚可進行因素分析)
#### MSA for each item = 
####   X1   X2   X3   X4   X5   X6   X7   X8   X9  X10  X11  X12  X13  X14  X15  X16  X17  X18  X19 
#### 0.79 0.61 0.66 0.63 0.46 0.69 0.76 0.71 0.57 0.70 0.80 0.81 0.80 0.73 0.82 0.75 0.79 0.79 0.84 
KMO(G2)
#### Overall MSA =  0.53   (不適合進行因素分析)
#### MSA for each item = 
####  X20  X21  X22  X23  X24  X25  X26  X27  X28  X29 
#### 0.48 0.63 0.56 0.59 0.52 0.46 0.65 0.56 0.47 0.54
bartlett.test(G1)
#### Bartlett's K-squared = 66587, df = 18, p-value < 2.2e-16   # 變數間的相關矩陣具有共同因素存在，適合EFA
bartlett.test(G2)
#### Bartlett's K-squared = 22432, df = 9, p-value < 2.2e-16   # 變數間的相關矩陣具有共同因素存在，適合EFA

## 顯然 G1 比 G2 更適合EFA, 那 G2 就 PCA 吧



## EFA: G1

fa.parallel(cor(G1),n.obs=173,fa="both",n.iter=100,main="陡坡圖")   # 選 5 個 Factors
DR1 <- fa(cor(G1), nfactors=5 ,rotate="varimax", fm="pa") ; DR1
### rotate="varimax": 正交旋轉的最大變異法(讓兩因素不相關--取名好取)
### fm ="pa" : 主軸因素法
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
#### PA表示Loadings，即變數與因素的相關係數
#### h2表示共同性(Communality)，變數可以貢獻到因素的程度大小(越大表越密切)
#### u2表示唯一性(uniquenesses)，變異量中與其他變數無關的部分(係因誤差因素及與該變數的特殊姓所造成) = 1-h2
#### 補充h2 & u2: 因素分析乃是將n個變數分解成共同性因素(common factor)與獨特性因素(unique factor)的線性組合的一種方法
#### com表示複雜度(complexity)，有多少變數同時在兩個或多個因素顯著，越接近 1 越好

####                        PA1  PA4  PA2  PA3  PA5
#### SS loadings           4.12 3.56 2.46 1.95 1.82   → 負荷的平方和，>1 表Factor值得保留
#### Proportion Var        0.22 0.19 0.13 0.10 0.10   → 個別解釋程度
#### Cumulative Var        0.22 0.40 0.53 0.64 0.73   → 累積解釋程度

#### The root mean square of the residuals (RMSR) is  0.03   → 小於0.05，還不錯

factor.plot(DR1, labels = rownames(DR1$loadings))   # 兩兩因子圖
fa.diagram(DR1, digits = 2)   #　DR1$Structure or DR1$loadings 的結果，幫助命名(的圖像化)
#### PA1 : 壯年人口流失之黑人區、教育低且收入分配不均
#### PA2 : 人口略密集且年輕，多租屋族
#### PA3 : 老年且女性人口偏高區
#### PA4 : 富裕且低失業區域
#### PA5 : 非公民且英語程度不佳

fs <- factor.scores(G1, DR1) ; fs$scores  # 取得降維後新變數PA1~PA5



## PCA: G2
DR2 <- prcomp(G2, center=T, scale=T)
round((DR2$sdev)^2 / sum((DR2$sdev)^2), 2)  # 0.22 0.18 0.15 0.12 0.09 0.07 0.06 0.05 0.04 0.02 (取前 5，累積 76 %)

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
#### PC1  -0.76 -0.67  0.18  0.39 -0.82 -0.31  0.31 -0.29 -0.01  0.05   房子路燈稀疏但空屋少
#### PC2   0.13 -0.12 -0.66 -0.55  0.03 -0.45  0.40 -0.32  0.67  0.38   少水域公共空間、多違章建築
#### PC3  -0.47  0.35  0.07 -0.01 -0.06  0.62  0.38  0.44  0.30  0.55   腳踏車站與Wifi多
#### PC4   0.09  0.18  0.51  0.37  0.22 -0.10 -0.24 -0.54  0.38  0.44   水域多大學少
#### PC5  -0.25  0.26  0.00 -0.41 -0.39  0.16 -0.53 -0.21  0.22 -0.21   中小學少



### New data set
efaR <- as.data.frame(fs$scores)
pcaR <- as.data.frame(-DR2$x[, 1:5])
N1 <- cbind(DG$NAMELSAD10, efaR, pcaR)




# 第二種方式: tSNE (無法知道降維後變數代表意義)

library(Rtsne)
TSNE <- Rtsne(DG, dims=3, perplexity=40)  # 只能降到 2~3 維，那就 3 維吧
N2 <- as.data.frame(TSNE$Y)
N2 <- cbind(DG$NAMELSAD10, N2)





############################################### 分群 ###############################################

# Hierarchical Clustering
library(cluster)

## 種樹
T1 <- hclust(dist(DG[, 2:30]), method="ward.D")
plot(T1)
T2 <- hclust(dist(N1[, 2:11]), method="ward.D")
plot(T2)
T3 <- hclust(dist(N2[, 2:4]), method="ward.D")
plot(T3)


## 砍樹分組 (切6組好了))
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


## 儲存分群結果
CC <- as.data.frame(DG$NAMELSAD10)
CC$HC1 <- CT1
CC$HC2 <- CT2
CC$HC3 <- CT3


## 計算N1分群的組中點，並為分組命名
### 因為只有N1的分群可以稍微看出意義，原始資料的分群變數太多太多、N2的變數意義不明
round(apply(N1[, 2:11], 2, function (x) tapply(x, CT2, mean)),2)
####     PA1   PA4   PA2   PA3   PA5   PC1   PC2   PC3   PC4   PC5
#### 1 -0.27  0.11  0.13 -0.89  0.62  0.30  0.04 -0.33 -0.15  0.58  : 多非公民、不富裕且中小學教育設施少
#### 2  1.09 -0.79  0.56 -0.14 -0.31  0.14  1.18  0.44  0.58  0.35  : 黑人多且壯年人口流失、教育低收入不均、多違章建築
#### 3  0.09 -0.10 -0.84  0.26 -0.04  1.27  0.09  0.08 -0.47 -0.27  : 房子路燈稀疏但空屋少，可能有點像郊區
#### 4 -1.23 -0.73  1.46  1.43  0.06 -1.47 -1.45  1.57 -2.06 -0.13  : 白人多、年齡較高、較富裕且腳踏車站與Wifi多，可能是市中心有錢區
#### 5 -0.42  0.99  0.23  0.21 -0.27 -1.71 -0.05 -0.88  0.02 -0.48  : 人口略密集且年輕，多租屋族，房屋路燈密集，可能是市中心
#### 6 -0.91 -0.05 -0.52  0.29  0.24  0.07 -3.25  1.01  1.94 -0.06  : 好像是水域面積多的區域




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


## 儲存分群結果
CC$KMS1 <- KMS1$cluster
CC$KMS2 <- KMS2$cluster
CC$KMS3 <- KMS3$cluster


## 計算N1分群的組中點，並為分組命名
round(KMS2$centers, 2)
####     PA1   PA4   PA2   PA3   PA5   PC1   PC2   PC3   PC4   PC5
#### 1  0.05  0.51  0.11  0.16  0.64 -0.05  0.07 -0.69 -0.12  0.15 : 非公民且英語程度不佳多，腳踏車站與Wifi少
#### 2 -1.22 -1.35 -1.41  0.68  0.32  1.82 -3.33 -0.03  1.84 -0.58 : 富裕低失業，郊區但腳踏車站、wifi等設施充足
#### 3 -0.11 -0.13 -0.87 -0.67 -0.54  1.19 -0.32 -0.31 -0.50  0.39 : 沒那麼富裕的本國人區
#### 4  0.93 -0.79  0.46 -0.13 -0.12  0.16  1.32  0.59  0.69  0.42 : 壯年人口流失之黑人區、教育低且收入分配不均且少公共空間、多違章建築
#### 5 -0.89  0.56  0.62  0.19 -0.25 -2.35 -0.77  0.05 -0.10 -0.29 : 人口年齡較高、女性多且房屋、路燈密集，有空屋
#### 6  0.31  0.11  0.01  0.64  0.03  0.93  0.51  1.16 -0.65 -1.35 : 腳踏車站與Wifi多但中小學較少




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


## 儲存分群結果
CC$KMD1 <- KMD1$clustering
CC$KMD2 <- KMD2$clustering
CC$KMD3 <- KMD3$clustering


## 計算N1分群的組中點 (不能用 KMD2$medoids，因K-medoids是以某個樣本為中心點)，並為分組命名
round(apply(N1[, 2:11], 2, function (x) tapply(x, KMD2$clustering, mean)),2)
####     PA1   PA4   PA2   PA3   PA5   PC1   PC2   PC3   PC4   PC5
#### 1  0.00 -0.26 -0.31 -0.95 -0.61  0.76 -0.12 -0.33 -0.34  0.57 : 較不富裕的本國人區，中小學設施少
#### 2  1.02 -0.74  0.48  0.01 -0.02  0.23  1.75  1.09  0.96  0.08 : 壯年人口流失之黑人區、教育低且收入分配不均，少公共空間、多違章建築
#### 3  0.34  0.28 -0.24  0.50  0.15  0.61  0.32 -0.20 -0.42 -0.15 : 難以定義區
#### 4 -1.20 -0.31  1.15  0.91 -0.23 -1.97 -1.66  2.38 -1.50 -0.16 : 近市中心的富人區、年齡結構較高
#### 5 -0.59  0.88  0.37  0.09 -0.20 -2.03 -0.36 -0.91  0.19 -0.36 : 人口略密集且年輕，多租屋族、中小學設施少
#### 6 -0.65 -0.63 -0.65 -0.15  1.35  1.10 -1.53  0.03  1.03 -0.12 : 非公民且英語程度不佳或水域多大學較少區域




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


## 儲存分群結果
CC$DBS1 <- DBS1$cluster
CC$DBS2 <- DBS2$cluster
CC$DBS3 <- DBS3$cluster


## 計算N1分群的組中點，並為分組命名
round(apply(N1[, 2:11], 2, function (x) tapply(x, DBS2$cluster, mean)),2)
####     PA1   PA4   PA2   PA3   PA5   PC1   PC2   PC3   PC4   PC5
#### 0 -0.56  0.02  0.04  0.03  0.08 -0.40 -0.59  0.37  0.24 -0.31 : 郊區的本國白人區
#### 1  0.38 -0.02 -0.02  0.05 -0.17  0.25  0.41 -0.24 -0.20  0.18 : 壯年人口流失之黑人區、教育低且收入分配不均
#### 2 -0.29  0.24  0.50 -1.18  3.09 -0.14  1.19 -0.51 -0.08  0.08 : 人口略密集且年輕，多租屋族、多非公民
#### 3 -0.61 -0.14 -0.50 -1.19  0.96  0.30 -2.60  0.76  1.70  0.21 : 多水域、腳踏車站與Wifi多





############################################### 比較 ###############################################

par(mfcol=c(3,4))
plot(boston$geom, col=CC$HC1+1, main="原始資料: HC")
legend("bottomright", legend=c(1:6), fill=c(2:7), box.col="white", cex=0.5)
plot(boston$geom, col=CC$HC2+1, main="EFA+PCA: HC", legend="topright")
legend("bottomright", legend=c(1:6), fill=c(2:7), box.col="white", cex=0.5)
plot(boston$geom, col=CC$HC3+1, main="tSNE: HC")
legend("bottomright", legend=c(1:6), fill=c(2:7), box.col="white", cex=0.5)
plot(boston$geom, col=CC$KMS1+1, main="原始資料: K-means")
legend("bottomright", legend=c(1:6), fill=c(2:7), box.col="white", cex=0.5)
plot(boston$geom, col=CC$KMS2+1, main="EFA+PCA: K-means")
legend("bottomright", legend=c(1:6), fill=c(2:7), box.col="white", cex=0.5)
plot(boston$geom, col=CC$KMS3+1, main="tSNE: K-means")
legend("bottomright", legend=c(1:6), fill=c(2:7), box.col="white", cex=0.5)
plot(boston$geom, col=CC$KMD1+1, main="原始資料: K-medoids")
legend("bottomright", legend=c(1:6), fill=c(2:7), box.col="white", cex=0.5)
plot(boston$geom, col=CC$KMD2+1, main="EFA+PCA: K-medoids")
legend("bottomright", legend=c(1:6), fill=c(2:7), box.col="white", cex=0.5)
plot(boston$geom, col=CC$KMD3+1, main="tSNE: K-medoids")
legend("bottomright", legend=c(1:6), fill=c(2:7), box.col="white", cex=0.5)
plot(boston$geom, col=CC$DBS1+2, main="原始資料: DBSCAN")
legend("bottomright", legend=c(2:8), fill=c(2:8), box.col="white", cex=0.5)
plot(boston$geom, col=CC$DBS2+2, main="EFA+PCA: DBSCA")
legend("bottomright", legend=c(2:5), fill=c(2:5), box.col="white", cex=0.5)
plot(boston$geom, col=CC$DBS3+2, main="tSNE: DBSCA")
legend("bottomright", legend=c(2:6), fill=c(2:6), box.col="white", cex=0.5)


