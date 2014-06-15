
corr <- function(directory, threshold = 0) { 
  setwd("~/Desktop/datasciencecoursera/specdata")
  title <- list.files(pattern = "*.csv")
  data <- read.csv(title[1])
  for (i in 2:(length(title))) {
    tb <- read.csv(title[i] ) ; data <- rbind(data, tb) 
  }  # input raw data
  data <- data[ !is.na(data$sulfate) & !is.na(data$nitrate), ] # na.rm 
  
  comp <- complete("specdata") # threshold selection
  id <- comp[ comp$nobs >= threshold ,1]
  if ( length(id) > 0 ) {
    corr <- vector( length= length(id) )
    for ( i in 1: length(id))  {
      corr[i] <- cor(  data[ data$ID == id[i], c(2,3)]) [1,2] 
    }
  } else { corr <- NA}
  return(corr)
}

