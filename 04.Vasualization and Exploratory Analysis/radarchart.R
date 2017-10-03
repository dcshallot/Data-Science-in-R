
aa <- read.csv('F:/百度云同步盘/R in tencent/第四章 可视化/boardgame.csv', header=T)
head(aa)
str(aa)

library(fmsb)
library(RColorBrewer)

# radarchart(df=tcenter[,1:4],axistype=0,plty=1,maxmin = FALSE,centerzero=FALSE,
#            pcol=brewer.pal(5,"Set1"),legend=TRUE,title="重要指标雷达图",
#            vlabels=c("注册距开测时间","常规场","SNG场","MMT场"),plwd=5 )
# legend( 1.5, 1, legend= 1:5, seg.len=0.5, title="cluster", pch= 1,
#         bty="o" ,lwd=3, y.intersp=1, horiz=FALSE, col= brewer.pal(5,"Set1"))


radarchart( df= aa[,-1], axistype = 0, seg =2, plty = 1, plwd =3, 
        pcol=brewer.pal(4,"Set1") ,centerzero= F,maxmin = F )
legend(2,1, legend = aa[,1], pch=15, col=brewer.pal(4,"Set1") )

radarchart( df= aa[1:2,-1], axistype = 0, seg =2, plty = 1, plwd =3, 
            pcol=brewer.pal(4,"Set1") ,centerzero= F,maxmin = T )
legend(2,1, legend = aa[1:2,1], pch=15, col=brewer.pal(4,"Set1") )
