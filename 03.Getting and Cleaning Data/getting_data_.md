getting data
================
Dingchong

概述
====

从本地获取数据
==============

获取本地数据——read.table()
--------------------------

read.table() 最常用的函数，但是数据量受内存限制； 重要参数包括 file,文件名； header,是否包含表头； sep,间隔符号； row.names,可以定义行名，默认或者NULL则是序号； nrows，读入行数，数据量大是分批读入用； quote，指定字符引用的符号\`'"' 之类的； na.string，代表NA的字符，如果raw data是SQL出来的，这里可以指定NULL； skip，从第几行开始读； 相关read.csv(), read.csv2(), read.delim()...

read.csv('stay\_summary\_code.csv', na.strings = 'NULL', stringsAsFactors = F)

Using data.table
----------------

data.table包，由c写的所以非常快的subsetting, group, updating 但是需要稍加学习

``` r
library( data.table)
DF = data.frame( x = rnorm(9), y = rep( c("a", "b", "c"), each = 3 ), z = rnorm(9) )
head(DF)
```

    ##             x y           z
    ## 1  0.85775801 a  0.56839376
    ## 2 -1.00962707 a -0.54705963
    ## 3 -0.36458611 a -0.48482979
    ## 4 -2.73497387 b  0.02830966
    ## 5 -1.29599240 b -0.22796183
    ## 6 -0.02330375 b -0.04905951

``` r
DT = data.table( x = rnorm(9), y = rep( c("a", "b", "c"), each = 3 ), z = rnorm(9) ) 
head(DT)
```

    ##              x y           z
    ## 1: -0.39014510 a  1.56047897
    ## 2:  0.51767144 a  0.98049161
    ## 3: -0.02229916 a  0.06543966
    ## 4: -1.63221483 b  1.21509911
    ## 5: -1.93846545 b -0.02675083
    ## 6: -0.75678034 b -1.01447285

``` r
tables() # show all datatables in memory
```

    ##      NAME NROW NCOL MB COLS  KEY
    ## [1,] DT      9    3  1 x,y,z    
    ## Total: 1MB

``` r
# subsetting
DT[2, ] 
```

    ##            x y         z
    ## 1: 0.5176714 a 0.9804916

``` r
DT[DT$y == "a"]
```

    ##              x y          z
    ## 1: -0.39014510 a 1.56047897
    ## 2:  0.51767144 a 0.98049161
    ## 3: -0.02229916 a 0.06543966

``` r
# subsetting rows, but cannot subsetting cols like dataframe
DT[ c(2,3) ]
```

    ##              x y          z
    ## 1:  0.51767144 a 0.98049161
    ## 2: -0.02229916 a 0.06543966

``` r
# calculationi values for vars with expressions
DT[, list( mean(x), sum(z) )]
```

    ##           V1        V2
    ## 1: -0.409113 0.5863058

``` r
DT[, table(y)]
```

    ## y
    ## a b c 
    ## 3 3 3

``` r
# adding new columes
DT[ , w := z^2 ]

# multiple operations
DT[ , m := { tmp <- (x+z); log2(tmp+5 ) } ]

# plyr like operations
DT[, a := x >0 ]
DT[, b := mean(x+w), by = a ] # if a is ture then mean...
```

读excel表格
-----------

read.xlsx() { xlsx package} 略

读取XML
-------

&lt; section number='3'&gt; hello,world &lt; /section&gt; 不灵！

``` r
# library(XML)
# fileUrl <- "http://www.w3schools.com/xml/simple.xml"
# doc <- xmlTreeParse( fileUrl, useInternal=T)
# rootNode <- xmlRoot(doc)
# xmlName(rootNode)
# xmlValue(rootNode)
# rootNode[[1]]
# rootNode[[1]][[1]]
# xmlSApply( rootNode, xmlValue)
# xpathSApply( rootNode, "//name", xmlValue)
# xpathSApply( rootNode, "//price", xmlValue)
```

reading from other sources
--------------------------

library(foreign) read.arf - weka read.dta - stata read.spss - spss read.xprt - SAS RODBC RMongo

从互联网获取数据
================

read JSON data
--------------

``` r
# library(jsonlite)
# # read
# jsonData <- fromJSON( "https://api.github.com/users/jtleek/repos" )
# names(jsonData)
# jsonData$owner$login
# # write
# myjson <- toJSON(iris, pretty = T )
# myjson
```

获取数据——internet
------------------

download.file() 可重复执行，可下载txt,csv等格式，关键参数包括url,destfile,method。 例子：

> setwd("/Users/dingchong/github/Data-Science-in-R/03.Getting and Cleaning Data")

``` r
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file( fileUrl, destfile = "./cameras.csv" ) 
# on mac, use this:  method ="curl"
list.files("./") # done 
```

    ## [1] "cameras.csv"        "etl.Rmd"            "getting data .Rmd" 
    ## [4] "getting_data_.md"   "getting_data_.Rmd"  "r with mongodb.Rmd"

注意事项 1.http开头的，默认下载就好；https开头的在MAC下需要加method ="curl"

read from APIs
--------------

``` r
# twitter
```

从数据库获取数据
================

MySQL
-----

win环境下可通过RODBC连接

> library(RMySQL)

> ucscDb = dbConnect( MySQL(), user = 'genome', host ='genome-mysql.cse.ucsc.edu', db = 'hg19')

> tb = dbGetQuery( ucscDb, 'show databases;') head(tb)

> dbGetQuery(ucscDb , " select bin,matches,misMatches from hg19.affyU133Plus2 limit 5")

> dbDisconnect(ucscDb)

reading from HDF5
-----------------

科学计算用的数据格式，略
