directory <- "specdata"
complete <- function(directory, id = 1:332) {
  d <- paste( "~/Desktop/datasciencecoursera/", directory,"/" ,sep="" )
  setwd( d)
  title <- list.files(pattern = "*.csv")
  data <- read.csv(title[1])
  for (i in 2:(length(title))) {
    tb <- read.csv(title[i] ) ; data <- rbind(data, tb) 
  } 
  data1 <-  data[  !is.na(data$sulfate) & !is.na(data$nitrate) , ]
  
  
  
}

#complete("specdata", 1)
#complete("specdata", c(2, 4, 8, 10, 12))
