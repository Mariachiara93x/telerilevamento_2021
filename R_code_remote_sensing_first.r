# Il mio primo codice in R per il telerilevamento!

#install.packages ("raster")
library(raster)

setwd("C:/lab/") # Windows

#Questa funzione serve a importare un'immagine satellitare
p224r63_2011<-brick("p224r63_2011_masked.grd")
p224r63_2011

plot(p224r63_2011)


# colour change
cl <- colorRampPalette(c("black","grey","light grey")) (100)

plot(p224r63_2011, col=cl)


# colour change -> new
cl <- colorRampPalette(c("pink", "light blue", "dark green", "purple", "orange", "dark red")) (200)
plot(p224r63_2011, col=cl)



