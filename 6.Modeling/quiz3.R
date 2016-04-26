
## Q1
library(AppliedPredictiveModeling)
data(segmentationOriginal)
library(caret)

training <- segmentationOriginal[segmentationOriginal$Case == "Train", ]
testing <- segmentationOriginal[ segmentationOriginal$Case == "Test", ]

# CART
set.seed(125)
modFit <- train(Class ~., method="rpart", data = training[,-c(1,2)])
library(rattle);library(rpart.plot)
fancyRpartPlot( modFit$finalModel)

## Q3
library(pgmm)
data(olive)
olive = olive[,-1]
newdata = as.data.frame(t(colMeans(olive)))
summary(olive)
str(olive)
modFit <- train(Area ~., method="rpart", data = olive )
predict( modFit, newdata[-1]  )

## Q4
library(ElemStatLearn)
data(SAheart)
set.seed(8484)
train = sample(1:dim(SAheart)[1],size=dim(SAheart)[1]/2,replace=F)
trainSA = SAheart[train,]
testSA = SAheart[-train,]

set.seed(13234)
modFit <- train(chd ~., method="glm", family="binomial", 
                data = trainSA[,c(2,3,6,7,8,9,10)] )
#names(trainSA)

missClass = function(values,prediction){
  sum(((prediction > 0.5)*1) != values)/length(values)}

pred <- predict( modFit, testSA )
missClass( testSA$chd,pred )

predt <- predict( modFit, trainSA )
missClass( trainSA$chd, predt)

## Q5

library(ElemStatLearn)
data(vowel.train)
data(vowel.test) 

head(vowel.test)
vowel.test$y <- as.factor(vowel.test$y)
vowel.train$y <- as.factor(vowel.train$y)

set.seed(33833)
modFit <- train(y~., data= vowel.train, method ="rf", prox=T )
varImp( modFit)

