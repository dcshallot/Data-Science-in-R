getting and cleaning data
================
Dingchong

WEEK 1 概述和读取数据
=====================

1.概述
------

数据获取和清洗，这个过程所费的时间精力可能会占到整个项目的80%， 有了干净的数据才有接下去才的数据分析Raw data -&gt; Processing script -&gt; tidy data

这中间有4样东西： raw data 原始数据，未经加工的，从各处拿过来的数据 tidy data set 整理好的数据集，变量名应该是人类可以读懂的，比如AgeAtDiagnosis而不是AgeDx。。。 A code book describing each variable and its values in the tidy data set. An explicit and exact recipe you used to go from 1 -&gt; 2, 3.（The instruction list）

The code book应包含的要件如下 1.tidy data 里面没有包含的变量信息 2.数据汇总的说明 3.采用的实验设计说明 4.应该是word/txt文档 5.应该说明你获取原始数据的情况 6.描述每一个变量

The instruction list应该是一个可执行的代码脚本（R，或者其他语言）， 输入是raw data，输出是tidy data，可以重复执行。

总结一下这个部分，为了做到科学严谨（在商业应用中一样有重要性）： 从raw data到tidy data的处理过程一定要记录下来，可重复执行和检查； 处理的方式和流程要有文档，越清楚越方便后面检查和优化，至于形式，自己斟酌就好，不必严格按照课程的来。

2.获取数据——internet
--------------------

download.file() 可重复执行，可下载txt,csv等格式，关键参数包括url,destfile,method。 例子：

``` r
setwd("/Users/dingchong/github/Data-Science-in-R/03.Getting and Cleaning Data")
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file( fileUrl, destfile = "./cameras.csv" ) 
# on mac, use this:  method ="curl"
list.files("./") # done 
```

    ## [1] "cameras.csv"                     "getting and cleaning data .Rmd" 
    ## [3] "getting_and_cleaning_data_.html" "getting_and_cleaning_data_.Rmd" 
    ## [5] "r with mongodb.Rmd"              "r_with_mongodb.html"

注意事项 1.http开头的，默认下载就好；https开头的在MAC下需要加method ="curl"

3.获取本地数据——read.table()
----------------------------

read.table() 最常用的函数，但是数据量受内存限制； 重要参数包括 file,文件名； header,是否包含表头； sep,间隔符号； row.names,可以定义行名，默认或者NULL则是序号； nrows，读入行数，数据量大是分批读入用； quote，指定字符引用的符号\`'"' 之类的； na.string，代表NA的字符，如果raw data是SQL出来的，这里可以指定NULL； skip，从第几行开始读； 相关read.csv(), read.csv2(), read.delim()...

4.读excel表格
-------------

read.xlsx() { xlsx package} 略

5.读取XML
---------

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

6.read JSON data
----------------

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

7.Using data.table
------------------

data.table包，由c写的所以非常快的subsetting, group, updating 但是需要稍加学习

``` r
library( data.table)
DF = data.frame( x = rnorm(9), y = rep( c("a", "b", "c"), each = 3 ), z = rnorm(9) )
head(DF)
```

    ##             x y           z
    ## 1 -1.03694098 a -0.08678198
    ## 2 -0.30490609 a  0.24895717
    ## 3 -0.17345018 a  0.17949308
    ## 4 -1.71138236 b  0.85469899
    ## 5  1.17796946 b -0.29769398
    ## 6  0.03053765 b  1.42573365

``` r
DT = data.table( x = rnorm(9), y = rep( c("a", "b", "c"), each = 3 ), z = rnorm(9) ) 
head(DT)
```

    ##             x y          z
    ## 1: -0.8928874 a -0.4984826
    ## 2: -0.4838456 a  2.1506863
    ## 3: -0.2087913 a  0.3740112
    ## 4: -0.8722219 b  0.1923494
    ## 5:  0.5366886 b  0.2515618
    ## 6: -0.7138239 b  0.6165739

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

    ##             x y        z
    ## 1: -0.4838456 a 2.150686

``` r
DT[DT$y == "a"]
```

    ##             x y          z
    ## 1: -0.8928874 a -0.4984826
    ## 2: -0.4838456 a  2.1506863
    ## 3: -0.2087913 a  0.3740112

``` r
# subsetting rows, but cannot subsetting cols like dataframe
DT[ c(2,3) ]
```

    ##             x y         z
    ## 1: -0.4838456 a 2.1506863
    ## 2: -0.2087913 a 0.3740112

``` r
# calculationi values for vars with expressions
DT[, list( mean(x), sum(z) )]
```

    ##            V1       V2
    ## 1: -0.0781481 2.890361

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

### WEEK2

1.read from APIs
----------------

``` r
# twitter
```

### WEEK2

1.reading from MySQL
--------------------

win环境下可通过RODBC连接

``` r
#
library(RMySQL)
```

    ## Warning: package 'RMySQL' was built under R version 3.2.5

    ## Loading required package: DBI

    ## Warning: package 'DBI' was built under R version 3.2.5

``` r
# 
# ucscDb = dbConnect( MySQL(), user = 'genome', host = 'genome-mysql.cse.ucsc.edu',
#                     db = 'hg19')
# tb = dbGetQuery( ucscDb, 'show databases;')
# head(tb)
# dbGetQuery(ucscDb , " select bin,matches,misMatches from hg19.affyU133Plus2 limit 5") 
# 
# dbDisconnect(ucscDb)
```

2.reading from HDF5
-------------------

科学计算用的数据格式，略

3.reading from the web
----------------------

略

4.reading from AIPs
-------------------

略

5.reading from other sources
----------------------------

library(foreign) read.arf - weka read.dta - stata read.spss - spss read.xprt - SAS RODBC RMongo

### WEEK3

1.Subsetting and Sorting
------------------------
