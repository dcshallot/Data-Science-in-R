
library(ggplot2)
library(hexbin)

cons0 <- read.csv('D:/MyDocuments/2016H1/21.QQ飞车分析/consume.csv', header =T)

head(cons0)
names(cons0) <- c('uin','got','used', 'actday')
summary(cons0)


ggplot( cons0[cons0$got < 7000, ], aes(x=got))+
  geom_histogram(binwidth=100, fill = 'white', color ='black') + 
  ggtitle('点券获得分布')  + ylab("人数") + xlab("点券获得（100点/组）") + 
  scale_x_continuous(limits = c(0, 7000))

ggplot( cons0, aes(x=used))+
  geom_histogram(binwidth=100, fill = 'white', color ='black') + 
  ggtitle('点券消耗分布')  + ylab("人数") + xlab("消耗（100点/组）")+ 
  scale_x_continuous(limits = c(0, 7000))


cons <- cons0[ cons0$got <= 5000 , ]
cons$var <- abs(cons$got- cons$used)/cons$used
summary(cons$var)
cons$lost <- ifelse(cons$actday >0,0,1 )


my_breaks = c(1,20, 400, 8000, 50000 )
p <- ggplot( cons[ cons$actday ==0, ], aes(x = got, y = used)) + stat_binhex()
p + scale_fill_gradient(name = "count", trans = "log", limits=c(20, 100000),
  breaks = my_breaks, labels = my_breaks ) +  ggtitle( 'lost')

p <- ggplot( cons[ cons$actday > 2 , ], aes(x = got, y = used)) + stat_binhex()
p + scale_fill_gradient(name = "count", trans = "log", limits=c(20, 100000),
  breaks = my_breaks, labels = my_breaks ) +  ggtitle('stay')


mean(cons$lost[cons$var < 0.1])
length(cons$lost[cons$var < 0.1])


# cons$rate <- cons$used/cons$got
# boxplot( rate ~ ifelse( actday >0, 1,0), cons, outline =F  )
# ggplot( cons[cons$rate<2,], aes(x=rate,fill=as.factor(ifelse(actday>0,1,0)))) +
#   geom_density( alpha = 0.4 )
# nrow(cons[cons$rate >= 0.9 & cons$rate <= 1.1, ])




####################################################################

comp0 <- read.csv('D:/MyDocuments/2016H1/21.QQ飞车分析/complete.csv', header =T)
comp0$activedays[is.na(comp0$activedays)] <- 0
summary(comp0)



# activity 
ggplot( comp0[comp0$countplaytimes<20,], aes(x=countplaytimes))+
  geom_histogram(binwidth=1, fill = 'white', color ='black') + 
  ggtitle('完成率低于4%玩家一周场次分布')  +
  ylab("场次") + xlab("人数")

# split by next week activity
comp <- comp0[ comp0$countplaytimes >=2, ]
mean(ifelse(comp$activedays>0,1,0 ))
nrow(comp)/5675034

my_breaks = c(1,20, 400, 8000, 160000 )
p <- ggplot( comp[comp$activedays==0,], aes(x = countplaytimes, y = fufitpercent)) + stat_binhex()
p + scale_fill_gradient(name = "人数", trans = "log" , limits=c(20, 160000),
      breaks = my_breaks, labels = my_breaks ) + 
  ggtitle( 'lost') + scale_x_continuous(limits = c(0, 3000)) +
  ylab("完成率") + xlab("场次")

p <- ggplot( comp[comp$activedays >=2,], aes(x = countplaytimes, y = fufitpercent)) + stat_binhex()
p + scale_fill_gradient(name = "count", trans = "log" ,
      limits=c(20, 160000),  breaks = my_breaks, labels = my_breaks ) + 
  ggtitle( 'stay') + scale_x_continuous(limits = c(0, 3000))+
  ylab("完成率") + xlab("场次")



comp$cpr <- cut( comp$countplaytimes ,c(0, 5, 8, 16, 40) )
comp$cpr <- cut( comp$fufitpercent ,c(0,0.1,0.2,0.3,0.35,0.4) )
table( comp$cpr)
boxplot( countplaytimes ~cpr,data=comp,outline=F)
