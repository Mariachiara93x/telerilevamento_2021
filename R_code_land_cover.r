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

#7 MAGGIO

library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra)
setwd("C:/lab/") 

#classificazione non supervisionata
d1c<-unsuperClass(defor1, nClasses=2) #set.seed() oer ottenere lo stesso risultato
plot(d1c$map)

defor2 <- brick("defor2.jpg")
ggRGB(defor2, r=1, g=2, b=3, stretch="lin")
d2c <-unsuperClass(defor2, nClasses=2) 
plot(d2c$map)

d2c3 <- unsuperClass(defor2, nClasses=3)
plot(d2c3$map)

#frequecies
freq(d1c$map)
#     value  count
[1,]     1  34181
[2,]     2 307111

s1<-307111 + 34181
s1

prop1 <- freq(d1c$map)/s1
prop1
#prop forest:0.8983012
#prop agriculture: 0.1016988

s2<-342726
s2
prop2 <- freq(d2c$map) / s2
prop2

#build a dataframe
cover <- c("Forest", "Agriculture")
percent_1992 <- c(89.83, 10.16)
percent_2006 <- c(52.06, 47.93)
percentages <- data.frame(cover, percent_1992, percent_2006)
percentages

#plotto il dataframe con ggplot
p1<-ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="light green")
p2<-ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="pink")

grid.arrange(p1,p2, nrow=1)
