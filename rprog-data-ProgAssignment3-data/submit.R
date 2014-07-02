

source("http://d396qusza40orc.cloudfront.net/rprog%2Fscripts%2Fsubmitscript3.R")
setwd("~/Desktop/datasciencecoursera/rprog-data-ProgAssignment3-data/")
source("rankall.R")
submit()

N6MuZCbBFc


head( rankall("heart attack",20), 10 )
tail( rankall("pneumonia","worst"),3)
tail( rankall("heart failure"), 10 )


outcome="pneumonia"; num='worst'
i <- 50
