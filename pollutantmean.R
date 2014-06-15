

pollutantmean <- function(directory, pollutant, id = 1:332) {
  d <- paste( "~/Desktop/datasciencecoursera/", directory,"/" ,sep="" )
  setwd( d)
  title <- list.files(pattern = "*.csv")
  data <- read.csv(title[1])
  for (i in 2:(length(title))) {
    tb <- read.csv(title[i] ) ; data <- rbind(data, tb) 
  } 
  v <- ifelse( pollutant =="sulfate", 2, 3)
  m <-  mean( data[ data$ID %in% id ,  v], na.rm= T )
  return(m)
}

#pollutantmean("specdata", "sulfate", 1:10)
#pollutantmean("specdata", "nitrate", 70:72)
#pollutantmean("specdata", "nitrate", 23)



