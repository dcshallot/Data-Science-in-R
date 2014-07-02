## R programming

## Ranking hospitals by outcome in a state

# state="NY"; outcome="heart attak"; num=7

rankhospital <- function( state, outcome , num) {
  ## Read outcome data
  setwd("~/Desktop/datasciencecoursera/rprog-data-ProgAssignment3-data/")
  data <- read.csv("outcome-of-care-measures.csv", header= T, stringsAsFactors = F )
  data[,11] <- as.numeric( data[,11])
  data[,17] <- as.numeric( data[,17])
  data[,23] <- as.numeric( data[,23])
  
  ## check the state and outcome are valid
  sta <- names( table(data$State) )
  ot <- c("heart attack", "heart failure", "pneumonia")
  if ( state %in% sta ) {
    if ( outcome %in% ot) {
      
      ## Return hospital name in that state with the given rank
      ## 30-day death rate
      o1 <- data[ which(data$State == state), c(2, 7,11, 17,23) ]
      names(o1)[3:5] <- c("heart attack", "heart failure", "pneumonia")
      o1 <- o1[ !is.na( o1[ outcome]) , ]
      #o2 <- o1[ o1[outcome] == min( o1[ outcome]), ]
      o2 <- o1[ order(o1[outcome]) , ]
      num <- ifelse( num=="worst", nrow(o2), num)
      num <- ifelse( num=="first", 1, num)
      bh <- o2[ num ,1]
      return(bh)
      
    } else { stop( "invalid outcome")}
  } else {  stop(" invalid state" )} # end of state spell check
}


#best("TX", "heart attack")
#best("TX", "heart failure")
#best("MD", "heart attack")
#best("MD", "pneumonia")
#best("BB", "pneumonia")