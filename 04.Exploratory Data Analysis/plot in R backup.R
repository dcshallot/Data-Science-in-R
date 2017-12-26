
### 4.Plotting Systems in R

library(datasets)
data(cars)
with( cars, plot(speed, dist))

# the lattice system

library( lattice)
state = data.frame( state.x77, region = state.region)
xyplot( Life.Exp ~ Income | region , data = state , layout = c(4,1))

# ggplot2 system
library(ggplot2)
data(mpg)
qplot( displ, hwy, data =mpg)



## ���ɷַ�����ʯͼ

pca <- princomp( iris[,-5], cor = T)
summary(pca, loadings=T, cutoff= 0.01)
screeplot( pca , type="lines" )
load <- loadings(pca)
plot(load[,1:2] ); text( load[,1], load[,2], adj=c(0.01,0.01))




## spaghetti plots
```{r}
# Function interaction.plot can be used to make spaghetti plots.
# Let's use data set tolerance_pp.csv used in Applied Longitudinal Data Analysis:
# Modeling Change and Event Occurrence by Judith D. Singer and John B. Willett for our example.
# �������ض��������ͣ�����1��X�ܣ�����2����ͬ��������ֵ:Y�ᣩ��ͼ��

tolerance<-read.table("http://www.ats.ucla.edu/stat/r/faq/tolpp.csv",
                      sep=",", header=T)
head(tolerance, n=10)

interaction.plot(tolerance$time,
                 tolerance$id, tolerance$tolerance,
                 xlab="time", ylab="Tolerance", col=c(1:10), legend= T) 
```
