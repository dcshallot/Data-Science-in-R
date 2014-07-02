## R programming

source("http://d396qusza40orc.cloudfront.net/rprog%2Fscripts%2Fsubmitscript3.R")

setwd("~/Desktop/datasciencecoursera/rprog-data-ProgAssignment3-data/")

outcome <- read.csv("outcome-of-care-measures.csv", header= T )


hist(outcome[,11])

state <- "TX"

best <- function( state, outcome ) {
  ## Read outcome data
  outcome[,11] <- as.numeric( outcome[,11])
  
  
  ## check the state and outcome are valid
  
  ## Return hospital name in that state with lowest 30-day death rate
  o1 <- outcome[ which(outcome$State == state), c(2, 7,11) ]
  o1 <- o1[ order(o1$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack), ]
  bh <- as.character( o1[1,1] )
}


head(outcome)
summary( outcome$State)
names( outcome )

30-day mortality rates for heart attack

