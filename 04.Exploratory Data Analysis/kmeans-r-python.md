k-means between python and r
================

### Library and Functions

``` r
sort.center <- function(x) { x[order(x[,2]),] }
vxdscale <- read.csv('vxd_cluster_test.csv', header = T)
summary(vxdscale)
```

    ##     regdays        playerpower         fpequip         logindays      
    ##  Min.   :0.0000   Min.   :0.00000   Min.   :0.0000   Min.   :0.00000  
    ##  1st Qu.:0.1571   1st Qu.:0.03581   1st Qu.:0.1193   1st Qu.:0.03226  
    ##  Median :0.6516   Median :0.08449   Median :0.2472   Median :0.06452  
    ##  Mean   :0.5565   Mean   :0.10323   Mean   :0.2469   Mean   :0.19348  
    ##  3rd Qu.:0.9308   3rd Qu.:0.13429   3rd Qu.:0.3397   3rd Qu.:0.22581  
    ##  Max.   :1.0000   Max.   :1.00000   Max.   :1.0000   Max.   :1.00000  
    ##   ionelinetime          level        antimagicvalue      viplevel     
    ##  Min.   :0.000000   Min.   :0.0000   Min.   :0.0000   Min.   :0.0000  
    ##  1st Qu.:0.001377   1st Qu.:0.6087   1st Qu.:0.3794   1st Qu.:0.0000  
    ##  Median :0.005021   Median :0.7754   Median :0.5659   Median :0.0000  
    ##  Mean   :0.020558   Mean   :0.6387   Mean   :0.4745   Mean   :0.1093  
    ##  3rd Qu.:0.019645   3rd Qu.:0.8043   3rd Qu.:0.6732   3rd Qu.:0.1875  
    ##  Max.   :1.000000   Max.   :1.0000   Max.   :1.0000   Max.   :1.0000  
    ##    diamondnum         duelfieldwin   monthbattlewin     monthbattlelose  
    ##  Min.   :0.0000000   Min.   :0.000   Min.   :0.000000   Min.   :0.00000  
    ##  1st Qu.:0.0001233   1st Qu.:0.000   1st Qu.:0.000000   1st Qu.:0.00000  
    ##  Median :0.0035442   Median :0.000   Median :0.000000   Median :0.00000  
    ##  Mean   :0.0121660   Mean   :0.341   Mean   :0.006997   Mean   :0.01760  
    ##  3rd Qu.:0.0153804   3rd Qu.:0.640   3rd Qu.:0.009934   3rd Qu.:0.03448  
    ##  Max.   :1.0000000   Max.   :1.000   Max.   :1.000000   Max.   :1.00000  
    ##   monthfairwin     monthfairlose     monthfairwinrate  kofcpvpwinrate   
    ##  Min.   :0.00000   Min.   :0.00000   Min.   :0.00000   Min.   :0.00000  
    ##  1st Qu.:0.00000   1st Qu.:0.00000   1st Qu.:0.00000   1st Qu.:0.00000  
    ##  Median :0.00000   Median :0.00000   Median :0.00000   Median :0.00000  
    ##  Mean   :0.01205   Mean   :0.00559   Mean   :0.09724   Mean   :0.03913  
    ##  3rd Qu.:0.00000   3rd Qu.:0.00000   3rd Qu.:0.00000   3rd Qu.:0.00000  
    ##  Max.   :1.00000   Max.   :1.00000   Max.   :1.00000   Max.   :1.00000  
    ##  daycpvpwinrate    biochecpvpwinrate fivevscpvpwinrate   abilitydup      
    ##  Min.   :0.00000   Min.   :0.0000    Min.   :0.0000    Min.   :0.000000  
    ##  1st Qu.:0.00000   1st Qu.:0.0000    1st Qu.:0.0000    1st Qu.:0.000000  
    ##  Median :0.00000   Median :0.0000    Median :0.0000    Median :0.000000  
    ##  Mean   :0.03727   Mean   :0.2071    Mean   :0.0285    Mean   :0.006402  
    ##  3rd Qu.:0.00000   3rd Qu.:0.4800    3rd Qu.:0.0000    3rd Qu.:0.000000  
    ##  Max.   :1.00000   Max.   :1.0000    Max.   :1.0000    Max.   :1.000000  
    ##   activitydup         guajidup        expericedup         maintask       
    ##  Min.   :0.00000   Min.   :0.00000   Min.   :0.00000   Min.   :0.000000  
    ##  1st Qu.:0.00000   1st Qu.:0.00000   1st Qu.:0.00000   1st Qu.:0.003096  
    ##  Median :0.00000   Median :0.00000   Median :0.00000   Median :0.015480  
    ##  Mean   :0.01739   Mean   :0.01858   Mean   :0.02459   Mean   :0.075508  
    ##  3rd Qu.:0.01049   3rd Qu.:0.00000   3rd Qu.:0.03125   3rd Qu.:0.058824  
    ##  Max.   :1.00000   Max.   :1.00000   Max.   :1.00000   Max.   :1.000000  
    ##   activitytask      intimacytask      intimacyvalue     
    ##  Min.   :0.00000   Min.   :0.000000   Min.   :0.000000  
    ##  1st Qu.:0.00000   1st Qu.:0.000000   1st Qu.:0.000000  
    ##  Median :0.02151   Median :0.000000   Median :0.000000  
    ##  Mean   :0.07941   Mean   :0.007537   Mean   :0.004739  
    ##  3rd Qu.:0.07527   3rd Qu.:0.000000   3rd Qu.:0.003599  
    ##  Max.   :1.00000   Max.   :1.000000   Max.   :1.000000  
    ##  petislandtimes       expjobnum          clothnum       
    ##  Min.   :0.000000   Min.   :0.00000   Min.   :0.000000  
    ##  1st Qu.:0.000000   1st Qu.:0.00000   1st Qu.:0.000000  
    ##  Median :0.000000   Median :0.03333   Median :0.006494  
    ##  Mean   :0.010004   Mean   :0.09721   Mean   :0.036769  
    ##  3rd Qu.:0.006944   3rd Qu.:0.13333   3rd Qu.:0.045455  
    ##  Max.   :1.000000   Max.   :1.00000   Max.   :1.000000  
    ##  vxdcompetepvp       vxdenjoypvp        vxdequipdup      
    ##  Min.   :0.000000   Min.   :0.000000   Min.   :0.000000  
    ##  1st Qu.:0.000000   1st Qu.:0.000000   1st Qu.:0.000000  
    ##  Median :0.000168   Median :0.000000   Median :0.003597  
    ##  Mean   :0.005437   Mean   :0.004198   Mean   :0.026188  
    ##  3rd Qu.:0.002520   3rd Qu.:0.001429   3rd Qu.:0.021583  
    ##  Max.   :1.000000   Max.   :1.000000   Max.   :1.000000  
    ##   vxdpowersure       vxdsnstype       
    ##  Min.   :0.00000   Min.   :0.0000000  
    ##  1st Qu.:0.00000   1st Qu.:0.0000000  
    ##  Median :0.00000   Median :0.0000139  
    ##  Mean   :0.01252   Mean   :0.0047600  
    ##  3rd Qu.:0.01065   3rd Qu.:0.0036462  
    ##  Max.   :1.00000   Max.   :1.0000000

``` r
k =8
```

### Kmeans in R

###### Parameters

-   centers:设定聚类个数，则从原始样本中随机抽k个样本作为初始聚心

-   nstart:可理解为随机选择多组聚心，并返回最优的，更耗时。这是对初始聚心选择不好的修正，效果么，，有待评价

-   iter.max:迭代次数默认为10，后面会比较不同迭代次数的差异

-   algorithm
-   这里可选"Hartigan-Wong", "Lloyd", "Forgy","MacQueen"，默认第一种
-   H-W算法的终止条件是超过迭代次数，或样本的类别归属不再变化。在数据不好的情况下，样本类别可能像跷跷板一样波动，则终止条件依赖最大迭代次数的设置了。

##### Run and output

``` r
set.seed(1234)
clu <- kmeans( vxdscale ,k )
kout.0 <- sort.center( clu$centers )
fitss0 <- clu$betweenss/clu$totss 
kout.0[1:3,1:3];fitss0
```

    ##      regdays playerpower     fpequip
    ## 8 0.05199889 0.001638586 0.009799453
    ## 2 0.81201217 0.003382724 0.015505631
    ## 7 0.19030305 0.069361099 0.207207135

    ## [1] 0.6255416

### kmeans in Python

``` python
from copy import deepcopy
import numpy as np
import pandas as pd
import os  # Importing the dataset
from sklearn import preprocessing
from sklearn.cluster import KMeans
os.chdir('workdir...')
vxdscale = pd.read_csv('vxd_cluster_test.csv')
print(vxdscale.shape)

k=8
model=KMeans(n_clusters=k,random_state=1234)
model.fit(vxdscale)
center=pd.DataFrame(model.cluster_centers_)
center.to_csv( 'center_py.csv' )
```

##### parameters

-   init : {‘k-means++’(default), ‘random’ or an ndarray}
-   ‘k-means++’ : selects initial cluster centers for k-mean clustering in a smart way to speed up convergence.
-   n\_init : int, default: 10,Number of time the k-means algorithm will be run with different centroid seeds.
-   max\_iter : int, default: 300
-   tol : float, default: 1e-4. Relative tolerance with regards to inertia to declare convergence
-   n\_jobs : int. The number of jobs to use for the computation. If -1 all CPUs are used.
-   algorithm : “auto”, “full” or “elkan”, default=”auto”. K-means algorithm to use. The classical EM-style algorithm is “full”. The “elkan” variation is more efficient by using the triangle inequality, but currently doesn’t support sparse data. “auto” chooses “elkan” for dense data and “full” for sparse data.

### compare

``` r
center.py <- as.matrix(read.csv('center_py.csv')[-1])
center.py <- sort.center(center.py)

range <- abs(kout.0 - center.py)/ 
  pmax( abs(kout.0), abs(center.py) )

summary( as.numeric(range ))
```

    ##      Min.   1st Qu.    Median      Mean   3rd Qu.      Max. 
    ## 0.0002214 0.0574348 0.3418634 0.4001249 0.7673314 1.0000000

``` r
hist(range)
```

![](kmeans-r-python_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-4-1.png)

``` r
heatmap.2( range, dendrogram= 'none' , Rowv= F, trace = 'none')
```

![](kmeans-r-python_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-4-2.png)

### full power !

##### R

``` r
set.seed(1234)
clu <- kmeans( vxdscale ,k, nstart = 10, iter.max = 500 )
kout <- sort.center( clu$centers )
fitss1 <- clu$betweenss/clu$totss 
fitss1;fitss0
```

    ## [1] 0.6277366

    ## [1] 0.6255416

##### python

``` python
model=KMeans(n_clusters=k , max_iter=500, n_init=10, init='random',
    random_state=1234 )
```

##### compare2

``` r
center.py <- as.matrix(read.csv('center_py.csv')[-1])
center.py <- sort.center(center.py)

range <- abs(kout - center.py)/ 
  pmax( abs(kout), abs(center.py) )
summary( as.numeric(range ))
```

    ##      Min.   1st Qu.    Median      Mean   3rd Qu.      Max. 
    ## 0.0000000 0.0000596 0.0003904 0.0188376 0.0012405 1.0000000

``` r
hist(range)
```

![](kmeans-r-python_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-7-1.png)

``` r
heatmap.2( range, dendrogram= 'none' , Rowv= F, trace = 'none')
```

![](kmeans-r-python_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-7-2.png)

##### conclusion

more times, more accurate

### Ref

-   相关算法的讨论可以参考\[这里\]<https://datascience.stackexchange.com/questions/9858/convergence-in-hartigan-wong-k-means-method-and-other-algorithms>
-   以及\[这里\]<https://www.r-bloggers.com/k-means-clustering-from-r-in-action/>
