## R programming

## Ranking hospitals in all states

rankall <- function( outcome , num = "best") {
  ## Read outcome data
  setwd("~/Desktop/datasciencecoursera/rprog-data-ProgAssignment3-data/")
  data <- read.csv("outcome-of-care-measures.csv", header= T, stringsAsFactors = F )
  data[,11] <- as.numeric( data[,11])
  data[,17] <- as.numeric( data[,17])
  data[,23] <- as.numeric( data[,23])
  
  ## check the state and outcome are valid
  ot <- c("heart attack", "heart failure", "pneumonia")
  if ( outcome %in% ot) {
      
      ## For each state, find the hospital of the given rank
      o1 <- split( data[, c(2, 7,11, 17,23) ], data$State)
      out <- data.frame()
      
      ## Return a data frame with the hospital names and the
      ## (abbreviated) state name
      for ( i in 1: length(o1)) {
        o2 <- o1[[i]]
        names(o2)[3:5] <- c("heart attack", "heart failure", "pneumonia")
        o2 <- o2[ !is.na( o2[ outcome]) , ]
        o2 <- o2[ order(o2[outcome], o2["Hospital.Name"]) , ]
        num <- ifelse( num=="best", 1, num)
        num <- ifelse( num=="worst", nrow(o2), num)
        num <- as.numeric(num)
        
        bh <- o2[ num ,c(1,2)]
        # 如果num超过最大值，则该周的医院为NA
        bh[1,2] <- ifelse( num> nrow(o2), o2[1,2], bh[1,2]) 
        names(bh) <- c("hospital", "state")
        out <- rbind(out, bh)
      }
    #browser()
    return(out)      
    } else { stop( "invalid outcome")}
}

