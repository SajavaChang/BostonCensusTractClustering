# Boston Census Tract Clustering
Dimensionality reduction and clustering practice using attributes from Boston census tracts


## Research Methods
**Dimensionality Reduction**
* Exploratory Factor Analysis, EFA
* Principal Component Analysis, PCA
* T-distributed Stochastic Neighbor Embedding, t-SNE

**Clustering**
* Hierarchical Clustering
* K-means
* K-medoids
* DBSCAN

**Research Structure**
![structure](https://github.com/SajavaChang/BostonCensusTractClustering/blob/main/structure.png)


## Data Source
* [Boston Tracts](https://data.boston.gov/dataset/census-2010-tracts)

* American Community Survey 5-Year Data (2015-2019) : DP02, DP03, DP04, DP05   [ex. DP05/Census Tract 104.04](https://data.census.gov/cedsci/table?g=1400000US25025010404&tid=ACSDP5Y2019.DP05)

* OPEN SPACE, STREETLIGHT LOCATIONS, BLUE BIKE STATIONS, PUBLIC SCHOOLS, NON PUBLIC SCHOOLS, COLLEGES AND UNIVERSITIES, BUILDING AND PROPERTY VIOLATIONS, WICKED FREE WIFI LOCATIONS [Analyze Boston](https://data.boston.gov/)


## Variables Description
| No.  | Variable Name | Source | Classification |
| ------------- |:-------------:|:-------------:|:-------------:|
| X1	| Population Density | 	DP05, Boston Tracts	|	Demographics related |
| X2	| Sex Ratio | DP05 |	Demographics related |
| X3	| Percentage of minors (below 18)| DP05 |	Demographics related |
| X4	| Percentage of prime-age population (18 to 64)| DP05	|	Demographics  related	|
| X5	| Percentage of elderly population (above 65)| 	DP05	|	Demographics  related	|
| X6	| Median age| 	DP05	|	Demographics  related	|
| X7	| Percentage of whites| 	DP05	|	Demographics  related	|
| X8	| Percentage of blacks or African Americans| 	DP05	|	Demographics  related	|
| X9	| Percentage of Asians| 	DP05	|	Demographics  related	|
| X10	| Percentage of non-citizens| 	DP02, DP05	|	Demographics  related	|
| X11	| Percentage of English proficiency below "very good"| 	DP02	|	Demographics  related	|
| X12	| Percentage of college education or above| 	DP02	|	Demographics  related	|
| X13	| Percentage of education level below high school| 	DP02	|	Demographics  related	|
| X14	| Median earnings for workers| 	DP03 |	Demographics  related	|
| X15	| Median earnings for workers / Per capita income| 	DP03	|	Demographics  related	|
| X16	| Unemployed Rate| 	DP03	|	Demographics  related	|
| X17	| Median owner-occupied home price| 	DP04	|	Demographics  related	|
| X18	| Occupancy rate|	DP04: Renter-occupied / DP04	|	Demographics  related	|
| X19	| Median occupied units paying rent|	DP04	|	Demographics  related	|
| X20	| Housing Density|	DP04, Boston Tracts	|	Environment related	|
| X21	| Vacancy Rate|	DP04	|	Environment related	|
| X22	| Percentage of water area|	Boston Tracts	|	Environment related	|
| X23	| The percentage of open space | OPEN SPACE, Boston Tracts |	Environment related	|
| X24	| Street light density|	STREETLIGHT LOCATIONS, Boston Tracts	|	Environment related	|
| X25	| Number of Blue Bike stations|	BLUE BIKE STATIONS	|	Environment related	|
| X26	| Number of schools below college|	NON PUBLIC SCHOOLS + PUBLIC SCHOOLS	|	Environment related	|
| X27	| Number of colleges and universities|	COLLEGES AND UNIVERSITIES	|	Environment related	|
| X28	| Proportion of illegal buildings|	BUILDING AND PROPERTY VIOLATIONS, DP04	|	Environment related	|
| X29	| Number of free wifi|	WICKED FREE WIFI LOCATIONS	|	Environment related	|


## Research Result
* Boston Neighborhoods Introduction: [Boston government](https://www.boston.gov/neighborhoods), [Wiki](https://en.wikipedia.org/wiki/Neighborhoods_in_Boston)
1. Unlike classification, clustering is unsupervised learning, and we have no standard answer to the results of clustering.
2. The advantage of dimensionality reduction with EFA and PCA is that we can easily infer the meaning of the new variables after dimensionality reduction. Although tSNE cannot analyze the meaning of the new variables after dimensionality reduction, it retains the distance relationship between the original variables in the low dimension. Therefore, in this study, the results of clustering with the new variables of tSNE dimensionality reduction are closer to the results of clustering directly with the original data than the former.
3. Referring to the introduction to Boston neighbors provided above, seems like the results of hierarchical clustering, K-means with the original data, K-means with the EFA+PCA data set, and K-medoids with the original data are closer to the description.
4. DBSCAN is a density-based clustering method, I think it does not perform well in this study, but it is fairly accurate to distinguish between downtown, non-downtown and a few special areas. 
5. Going forward, it may be a good idea to cluster the areas after shaving the few special areas (noise) identified by DBSCAN, which may have better results.

**Comparison**
![map](https://github.com/SajavaChang/BostonCensusTractClustering/blob/main/map.png)
