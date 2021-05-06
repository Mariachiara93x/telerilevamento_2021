#R_code_land_cover.r
library(raster)
library(RStoolbox) #classification

#installo il pacchetto ggplot2
install.packages("ggplot2")
library(ggplot2)

setwd("C:/lab/") 

defor1 <- brick("defor1.jpg")

#NIR 1, RED 2, GREEN 3
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")

#utilizzo la funzione ggR per plottare immagini ottenendo le coordinate spaziali dell'oggetto
#anzichè usare la funzione plot, uso "gg"
#uso ggRGB e creo un'immagine singola delle tre bande
#è necessario caricare la libreria RStoolbox
library(RStoolbox)
defor1 <- brick("defor1.jpg")
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
ggRGB(defor1, r=1, g=2, b=3, stretch="lin")


defor2 <- brick("defor2.jpg")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
ggRGB(defor2, r=1, g=2, b=3, stretch="lin")

par(mfrow=c(1,2))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

#per fare il multiframe con il ggplot, non uso par(mfrow)
#installo il pacchetto gridExtra
install.packages("gridExtra")
library(gridExtra)

#utilizzo la funzione grid.arrange per creare multiframe in un grafico
p1 <- ggRGB(defor1, r=1, g=2, b=3, stretch="lin")
p2 <-ggRGB(defor2, r=1, g=2, b=3, stretch="lin")
grid.arrange(p1,p2,nrow=2)
