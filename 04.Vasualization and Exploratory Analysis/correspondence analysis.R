
library(ca)

data("smoke")

head(smoke)
summary(smoke)
ca(smoke)

plot( ca(smoke))


library(MASS)
data(farms)
head(farms)
str(farms)
m1 <- mjca(farms)
plot(m1)
# Joint correspondence analysis:

m2 <- mjca(farms, lambda = "JCA")
plot(m2, col = (1:ncol(farms)))

a <- iris[,1:4]
a <-lapply( a, function(x) as.integer( round(x,0)))

b <- lapply( a, function(x) as.factor( as.character(x)) )
b <- as.data.frame(b)
str(b)




aaa <- c(1,2,3,4,5,2,3,4,5,6,7)
str( cut(aaa, quantile(aaa, c(0, .33, .66 ,1 ))))

