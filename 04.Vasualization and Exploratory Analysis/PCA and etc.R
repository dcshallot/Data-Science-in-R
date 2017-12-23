log.ir <- log(iris[, 1:4])
ir.species <- iris[, 5]
ir.pca <- prcomp(log.ir,
                 center = TRUE,
                 scale. = TRUE) 

ir.pca
