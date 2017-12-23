library(parallel)

fun <- function(x){
  return (x+1);
}

cl <- makeCluster(getOption("cl.cores", 8));
system.time({
  res <- parLapply(cl, 1:5000000,  fun)
});


system.time({
  res <- lapply(1:5000000, fun);
});

