about Rmarkdown
================
dingchong
2017/6/21

代码块相关
==========

##### 1.标题设置

自动获取系统日期（仅html有效）

``` r
# date: "`r format(Sys.time(), '%d %B, %Y')`" 
```

另外，Rstudio功能还在强化中，很多已可通过点选实现，包括自动生成目录

##### 2.第一个代码块：环境变量设置和数据读取，etl等

我习惯把setwd，library,read.csv等都放在这里，rmakedown相关语法如下

``` r
# ```{r setup, include=FALSE }
# setup表示这里用来设置全局变量，    
# include=FALSE 代码和执行过程都不显示
# knitr::opts_chunk$set( ..., ... )  
```

##### 3.一般代码块设置

``` r
# echo = FALSE # 代码是否打印出来，一般etl过程代码可以隐藏掉
# warning=FALSE # 报警，是否屏蔽函数报警，或者调用包时候的报警信息
# comment = NA # 去掉结果前的井号，感觉美观一些，效果如下
# results='hide'  # 不显示console里的运行结果，如summary，对图形无效
# eval   #  此块代码是否运行
```

##### 图形设置

``` r
# fig.width=12, fig.height=8, dpi=144  
# 图形大小,dpi的作用不太清楚，可以忽略

# dev.args=list(pointsize=25)  # 图形内文字大小
```

本文内容
========

##### 常用语法

标题：\# \# 一级标题 \#\# 二级标题 \#\#\# 三级标题 \#\#\#\# 四级标题

斜体： \_文字\_ A *paragraph* here. A code chunk below (remember the three backticks):

加粗： \*\*文字** You probably want to try RStudio, or at least the R package **markdown\*\*

代码： \`文字\` the function `knitr::knit2html()`.

引用： &gt;内容 &gt; Markdown is not LaTeX.

链接： \[锚文本\](链接地址 ) See [output here](https://github.com/yihui/knitr-examples/blob/master/001-minimal.md). 或者直接<http://www.baidu.com>

段落 单一段落用一个空白行 连续两个空格 会变成一个<br\>

项目符号：-

项目标题

-   任务1
-   任务2
-   任务3

特殊符号 用，表示文本中的markdown符号

其他
====

table美观的表格 knitr::kable()
