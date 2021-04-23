#R_code_multivariate_analysis.r

library(raster)
library(RStoolbox)

setwd("C:/lab/")
p224r63_2011<- brick("p224r63_2011_masked.grd")
plot(p224r63_2011)
p224r63_2011

#plotto i valori dei pixel della banda 1 contro i valori dei pixel della banda 2
plot(p224r63_2011$B1_sre, p224r63_2011$B2_sre, col="red", pch=18, cex=2)

pairs(p224r63_2011)
