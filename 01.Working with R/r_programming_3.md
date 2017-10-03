\[cousera数据科学\]R Programming 3 - 4
================
dingchong
2017/6/22

第三课 向量化运算和debug
------------------------

### 1.loop functions

lapply : 对list中的每一个element执行function sapply ： 对lapply的结果尝试简化，能输出 apply : 对数值型矩阵执行行向量或者列向量的function，仅仅代码简单，效率不高 tapply ： 对**向量**的子集执行function，多用于统计量计算 mapply ： 高维度的lapply，不明觉厉 apply族的参数function不能用多个，比如mean,sd,range这样，但是可以自定义一个组合函数,见apply例子 split : 虽然不是向量化运算，但是结合lapply会有很大用处

### 2.lapply

输入是list，如果不是，函数用as.list自动转换； 实际的循环使用C写的，所以快；

``` r
x <- list( a= 1:5, b = rnorm(10) )
lapply( x , mean)
```

    ## $a
    ## [1] 3
    ## 
    ## $b
    ## [1] -0.2749499

### 3.sapply

如果返回的每一个元素长度均为1，则整体输出一个向量 如果返回的每一个元素是长度相等的向量，则返回一个矩阵 其他，返回List

### 4.apply

less type is better！ rowSums = apply( x, 1, sum) \# 这两者实现功能一样，但是左边的更快一些！ colMeans = apply( x, 2, mean) \# 同上 apply( x , 1, median ) \# 这个就只能apply了

``` r
x <- matrix( rnorm(200), 20, 10 )
apply( x , 1, quantile , probs=c( 0.25, 0.75))
```

    ##            [,1]       [,2]       [,3]       [,4]       [,5]       [,6]
    ## 25% -0.07975834 -0.4637894 -0.7923693 -0.3174532 -0.5521619 -0.9179292
    ## 75%  0.68569748  0.3291890  0.3893095  0.7081211  1.0823940  0.6944470
    ##           [,7]       [,8]      [,9]      [,10]      [,11]      [,12]
    ## 25% -0.9437011 -0.4590218 -0.192422 -0.8381860 -0.9219011 -0.3650625
    ## 75%  0.6707444  1.1578946  1.072866  0.5426431  0.2525840  0.9127818
    ##           [,13]      [,14]      [,15]      [,16]       [,17]      [,18]
    ## 25% -1.13655106 -1.6601415 -1.2419865 -0.7296484 -0.78905182 -0.5622972
    ## 75%  0.02323661  0.1307684  0.3315092  0.9688338  0.06179325  0.1947766
    ##          [,19]      [,20]
    ## 25% -0.6888866 -0.9545746
    ## 75%  1.2941217  0.9206916

``` r
apply( x, 1, function(x) list( q= quantile , probs=c( 0.25, 0.75) ,
                               median = median(x) ,
                               r= range(x)) )
```

    ## [[1]]
    ## [[1]]$q
    ## function (x, ...) 
    ## UseMethod("quantile")
    ## <bytecode: 0x7f974df3e758>
    ## <environment: namespace:stats>
    ## 
    ## [[1]]$probs
    ## [1] 0.25 0.75
    ## 
    ## [[1]]$median
    ## [1] 0.2170116
    ## 
    ## [[1]]$r
    ## [1] -0.9713638  1.5708709
    ## 
    ## 
    ## [[2]]
    ## [[2]]$q
    ## function (x, ...) 
    ## UseMethod("quantile")
    ## <bytecode: 0x7f974df3e758>
    ## <environment: namespace:stats>
    ## 
    ## [[2]]$probs
    ## [1] 0.25 0.75
    ## 
    ## [[2]]$median
    ## [1] -0.06259113
    ## 
    ## [[2]]$r
    ## [1] -0.9907534  1.1693667
    ## 
    ## 
    ## [[3]]
    ## [[3]]$q
    ## function (x, ...) 
    ## UseMethod("quantile")
    ## <bytecode: 0x7f974df3e758>
    ## <environment: namespace:stats>
    ## 
    ## [[3]]$probs
    ## [1] 0.25 0.75
    ## 
    ## [[3]]$median
    ## [1] -0.4912875
    ## 
    ## [[3]]$r
    ## [1] -1.139995  1.441477
    ## 
    ## 
    ## [[4]]
    ## [[4]]$q
    ## function (x, ...) 
    ## UseMethod("quantile")
    ## <bytecode: 0x7f974df3e758>
    ## <environment: namespace:stats>
    ## 
    ## [[4]]$probs
    ## [1] 0.25 0.75
    ## 
    ## [[4]]$median
    ## [1] 0.2399494
    ## 
    ## [[4]]$r
    ## [1] -2.133126  1.344527
    ## 
    ## 
    ## [[5]]
    ## [[5]]$q
    ## function (x, ...) 
    ## UseMethod("quantile")
    ## <bytecode: 0x7f974df3e758>
    ## <environment: namespace:stats>
    ## 
    ## [[5]]$probs
    ## [1] 0.25 0.75
    ## 
    ## [[5]]$median
    ## [1] 0.5342412
    ## 
    ## [[5]]$r
    ## [1] -1.409446  2.022199
    ## 
    ## 
    ## [[6]]
    ## [[6]]$q
    ## function (x, ...) 
    ## UseMethod("quantile")
    ## <bytecode: 0x7f974df3e758>
    ## <environment: namespace:stats>
    ## 
    ## [[6]]$probs
    ## [1] 0.25 0.75
    ## 
    ## [[6]]$median
    ## [1] 0.2570164
    ## 
    ## [[6]]$r
    ## [1] -1.839120  1.039696
    ## 
    ## 
    ## [[7]]
    ## [[7]]$q
    ## function (x, ...) 
    ## UseMethod("quantile")
    ## <bytecode: 0x7f974df3e758>
    ## <environment: namespace:stats>
    ## 
    ## [[7]]$probs
    ## [1] 0.25 0.75
    ## 
    ## [[7]]$median
    ## [1] -0.06725578
    ## 
    ## [[7]]$r
    ## [1] -1.403075  1.710078
    ## 
    ## 
    ## [[8]]
    ## [[8]]$q
    ## function (x, ...) 
    ## UseMethod("quantile")
    ## <bytecode: 0x7f974df3e758>
    ## <environment: namespace:stats>
    ## 
    ## [[8]]$probs
    ## [1] 0.25 0.75
    ## 
    ## [[8]]$median
    ## [1] 0.08924555
    ## 
    ## [[8]]$r
    ## [1] -0.9461234  1.9758929
    ## 
    ## 
    ## [[9]]
    ## [[9]]$q
    ## function (x, ...) 
    ## UseMethod("quantile")
    ## <bytecode: 0x7f974df3e758>
    ## <environment: namespace:stats>
    ## 
    ## [[9]]$probs
    ## [1] 0.25 0.75
    ## 
    ## [[9]]$median
    ## [1] 0.4348062
    ## 
    ## [[9]]$r
    ## [1] -0.5185119  2.2018570
    ## 
    ## 
    ## [[10]]
    ## [[10]]$q
    ## function (x, ...) 
    ## UseMethod("quantile")
    ## <bytecode: 0x7f974df3e758>
    ## <environment: namespace:stats>
    ## 
    ## [[10]]$probs
    ## [1] 0.25 0.75
    ## 
    ## [[10]]$median
    ## [1] -0.05189499
    ## 
    ## [[10]]$r
    ## [1] -1.630913  1.224680
    ## 
    ## 
    ## [[11]]
    ## [[11]]$q
    ## function (x, ...) 
    ## UseMethod("quantile")
    ## <bytecode: 0x7f974df3e758>
    ## <environment: namespace:stats>
    ## 
    ## [[11]]$probs
    ## [1] 0.25 0.75
    ## 
    ## [[11]]$median
    ## [1] -0.1391525
    ## 
    ## [[11]]$r
    ## [1] -1.179656  2.471170
    ## 
    ## 
    ## [[12]]
    ## [[12]]$q
    ## function (x, ...) 
    ## UseMethod("quantile")
    ## <bytecode: 0x7f974df3e758>
    ## <environment: namespace:stats>
    ## 
    ## [[12]]$probs
    ## [1] 0.25 0.75
    ## 
    ## [[12]]$median
    ## [1] 0.09012023
    ## 
    ## [[12]]$r
    ## [1] -0.9819872  1.6660617
    ## 
    ## 
    ## [[13]]
    ## [[13]]$q
    ## function (x, ...) 
    ## UseMethod("quantile")
    ## <bytecode: 0x7f974df3e758>
    ## <environment: namespace:stats>
    ## 
    ## [[13]]$probs
    ## [1] 0.25 0.75
    ## 
    ## [[13]]$median
    ## [1] -0.6987133
    ## 
    ## [[13]]$r
    ## [1] -1.598883  1.559167
    ## 
    ## 
    ## [[14]]
    ## [[14]]$q
    ## function (x, ...) 
    ## UseMethod("quantile")
    ## <bytecode: 0x7f974df3e758>
    ## <environment: namespace:stats>
    ## 
    ## [[14]]$probs
    ## [1] 0.25 0.75
    ## 
    ## [[14]]$median
    ## [1] -0.1076484
    ## 
    ## [[14]]$r
    ## [1] -2.119008  1.512558
    ## 
    ## 
    ## [[15]]
    ## [[15]]$q
    ## function (x, ...) 
    ## UseMethod("quantile")
    ## <bytecode: 0x7f974df3e758>
    ## <environment: namespace:stats>
    ## 
    ## [[15]]$probs
    ## [1] 0.25 0.75
    ## 
    ## [[15]]$median
    ## [1] -0.3231424
    ## 
    ## [[15]]$r
    ## [1] -1.727840  1.827573
    ## 
    ## 
    ## [[16]]
    ## [[16]]$q
    ## function (x, ...) 
    ## UseMethod("quantile")
    ## <bytecode: 0x7f974df3e758>
    ## <environment: namespace:stats>
    ## 
    ## [[16]]$probs
    ## [1] 0.25 0.75
    ## 
    ## [[16]]$median
    ## [1] -0.1218474
    ## 
    ## [[16]]$r
    ## [1] -0.8418081  1.3490664
    ## 
    ## 
    ## [[17]]
    ## [[17]]$q
    ## function (x, ...) 
    ## UseMethod("quantile")
    ## <bytecode: 0x7f974df3e758>
    ## <environment: namespace:stats>
    ## 
    ## [[17]]$probs
    ## [1] 0.25 0.75
    ## 
    ## [[17]]$median
    ## [1] -0.3437351
    ## 
    ## [[17]]$r
    ## [1] -2.51578  2.17339
    ## 
    ## 
    ## [[18]]
    ## [[18]]$q
    ## function (x, ...) 
    ## UseMethod("quantile")
    ## <bytecode: 0x7f974df3e758>
    ## <environment: namespace:stats>
    ## 
    ## [[18]]$probs
    ## [1] 0.25 0.75
    ## 
    ## [[18]]$median
    ## [1] -0.1573472
    ## 
    ## [[18]]$r
    ## [1] -2.775634  1.152827
    ## 
    ## 
    ## [[19]]
    ## [[19]]$q
    ## function (x, ...) 
    ## UseMethod("quantile")
    ## <bytecode: 0x7f974df3e758>
    ## <environment: namespace:stats>
    ## 
    ## [[19]]$probs
    ## [1] 0.25 0.75
    ## 
    ## [[19]]$median
    ## [1] 0.1137486
    ## 
    ## [[19]]$r
    ## [1] -2.286550  1.808661
    ## 
    ## 
    ## [[20]]
    ## [[20]]$q
    ## function (x, ...) 
    ## UseMethod("quantile")
    ## <bytecode: 0x7f974df3e758>
    ## <environment: namespace:stats>
    ## 
    ## [[20]]$probs
    ## [1] 0.25 0.75
    ## 
    ## [[20]]$median
    ## [1] -0.340727
    ## 
    ## [[20]]$r
    ## [1] -1.638976  1.111636

### 5.tapply

与其他apply不同，它有一个index函数，指定分组用的factor或者list of factors

``` r
x <- c( rnorm(10), runif(10), rnorm(10,1) )
f <- gl(3, 10) # gl function : gnerate factor levels
tapply( x , f , mean)
```

    ##          1          2          3 
    ## -0.3595171  0.3113249  1.2572816

### 6.split

x是一个向量或list或data frame,f是一个factor或者list of factors split+ lapply/sapply比tapply在多变量场景下方便，当然更方便的是plyr包的函数

``` r
# split + apply可以用两行代码计算数据框中多个变量按分组统计的统计量
s <- split( airquality, airquality$Month)
lapply( s, function(x) colMeans( x[ , c("Ozone", "Solar.R", "Wind")]))
```

    ## $`5`
    ##    Ozone  Solar.R     Wind 
    ##       NA       NA 11.62258 
    ## 
    ## $`6`
    ##     Ozone   Solar.R      Wind 
    ##        NA 190.16667  10.26667 
    ## 
    ## $`7`
    ##      Ozone    Solar.R       Wind 
    ##         NA 216.483871   8.941935 
    ## 
    ## $`8`
    ##    Ozone  Solar.R     Wind 
    ##       NA       NA 8.793548 
    ## 
    ## $`9`
    ##    Ozone  Solar.R     Wind 
    ##       NA 167.4333  10.1800

``` r
sapply( s, function(x) colMeans( x[ , c("Ozone", "Solar.R", "Wind")]))
```

    ##                5         6          7        8        9
    ## Ozone         NA        NA         NA       NA       NA
    ## Solar.R       NA 190.16667 216.483871       NA 167.4333
    ## Wind    11.62258  10.26667   8.941935 8.793548  10.1800

``` r
sapply( s, function(x) colMeans( x[ , c("Ozone", "Solar.R", "Wind")], na.rm= T ))
```

    ##                 5         6          7          8         9
    ## Ozone    23.61538  29.44444  59.115385  59.961538  31.44828
    ## Solar.R 181.29630 190.16667 216.483871 171.857143 167.43333
    ## Wind     11.62258  10.26667   8.941935   8.793548  10.18000

``` r
# tapply针对vector所以只能一个一个来
tapply( airquality[ ,  "Ozone" ], airquality$Month, mean , na.rm=T )
```

    ##        5        6        7        8        9 
    ## 23.61538 29.44444 59.11538 59.96154 31.44828

``` r
tapply( airquality[ ,  "Solar.R" ], airquality$Month, mean , na.rm=T )
```

    ##        5        6        7        8        9 
    ## 181.2963 190.1667 216.4839 171.8571 167.4333

``` r
tapply( airquality[ ,  "Wind" ], airquality$Month, mean , na.rm=T )
```

    ##         5         6         7         8         9 
    ## 11.622581 10.266667  8.941935  8.793548 10.180000

``` r
# 关于factor和split还有
x <- rnorm(10)
f1 <- gl(2,5)
f2 <- gl(5,2)
interaction(f1, f2)
```

    ##  [1] 1.1 1.1 1.2 1.2 1.3 2.3 2.4 2.4 2.5 2.5
    ## Levels: 1.1 2.1 1.2 2.2 1.3 2.3 1.4 2.4 1.5 2.5

``` r
split( x, list(f1, f2))
```

    ## $`1.1`
    ## [1] 1.880075 1.115347
    ## 
    ## $`2.1`
    ## numeric(0)
    ## 
    ## $`1.2`
    ## [1] -0.2860646  0.4492238
    ## 
    ## $`2.2`
    ## numeric(0)
    ## 
    ## $`1.3`
    ## [1] -2.042449
    ## 
    ## $`2.3`
    ## [1] -0.01103855
    ## 
    ## $`1.4`
    ## numeric(0)
    ## 
    ## $`2.4`
    ## [1] 1.0824696 0.9273847
    ## 
    ## $`1.5`
    ## numeric(0)
    ## 
    ## $`2.5`
    ## [1] -0.5453361  0.9934202

### 7.Debug

traceback : 查看函数调用堆栈,找到最近出错的函数，在函数套函数的场合很有用 debug : debug模式提供函数详细，停在第一行供检查 browser : 扔进function，运行到此时挂起，可以检查函数运行中每一步的output trace ： 插入fuction的任意位置？？ recover ： ？？allows you to modify the error behavior so that you can browse the function call stack

``` r
lm( Sepal.Length ~ Sepal.Width ,iris)
```

    ## 
    ## Call:
    ## lm(formula = Sepal.Length ~ Sepal.Width, data = iris)
    ## 
    ## Coefficients:
    ## (Intercept)  Sepal.Width  
    ##      6.5262      -0.2234

``` r
traceback()
```

    ## No traceback available

``` r
# debug(lm)
# lm( Sepal.Length ~ Sepal.Width ,iris)
```

第四课
------

### 1.str
