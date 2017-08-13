

#_______________________________________________
# train & test spliter with weekly adjust   
# input: dataframe with date and value
# output: list1 - train data as xts, list2 - test data , list3 - weekly adjust index for test data  
# note: week filter by train data 
#_______________________________________________

train.split <- function( idata, column, t1  ) {
		
  idata <- idata[  idata$date >= (t1-t0) & idata$date < (t1+t2) , c('date', column ) ]
  idata <- idata[ order(idata$date),]
  names(idata)[2] <-'value'
  idata$tag <- ifelse( idata$date >= t1-t0 & idata$date < t1, 0, 1) # train =0, test =1 
  
  #train <- ts( idata$value[ idata$tag ==0] ,  frequency = 7 ) 
  train <- xts( idata$value[ idata$tag ==0] , order.by = idata$date[ idata$tag ==0] ) 
  test <- xts( idata$value[ idata$tag ==1] , order.by = idata$date[ idata$tag ==1] ) 
  out =list(train, test ) 
}


pcu.test <- function( targetdate ) {
    
  # train & test
  split<- train.split( wepang , 'pcu' ,targetdate )
  train <- split[[1]]
  test <- split[[2]]
  rm(split)
  
  # modeling and forecast 
  
  ## auto.arima 
  # pred.arima <- arima1(train, t2 )
  fit <- auto.arima(  ts(train, frequency = 7 ) )
  pred.orig <- forecast(fit, h =  t2 )$upper[,1]
  
  # acu 
  fit.acu <- auto.arima(train.split( wepang, 'acu', targetdate)[[1]] )
  pred.acu <- forecast(fit.acu, h =  t2 )
  #pred.acu <- pred.acu$upper[,1] * median( wepang$pcu/wepang$acu )
  pred.acu <- pred.acu$mean * median( wepang$pcu/wepang$acu )
  
  # income 
  fit.inc <- auto.arima( train.split( wepang, 'income', targetdate)[[1]] )
  pred.inc <- forecast(fit.inc, h =  t2 )
  # pred.inc <- pred.inc$upper[,1] * median( wepang$pcu/wepang$income )
  pred.inc <- pred.inc$mean * median( wepang$pcu/wepang$income )
  
  # combine 
  pred <- ( pred.orig + pred.acu + pred.inc )/3
  error <- (max( pred )- max(test))/ max(test)
  out <- c( max(pred), max(test), error)
#  error.9 <- abs(max(pred.arima$upper[,2]*far)- max(test*far))/ max(test*far)

} 


#_______________________________________________
# compare and combine t-series 
# input : 2 t-series data  
# output : 1 zoo object
#_______________________________________________

to.zoo <-  function( ) { 
	zoo( cbind.data.frame( act = wepang$pcu[ wepang$date >= min(targetdate) & wepang$date <= max(targetdate) ],
            err = error.all),  order.by= targetdate )
}

